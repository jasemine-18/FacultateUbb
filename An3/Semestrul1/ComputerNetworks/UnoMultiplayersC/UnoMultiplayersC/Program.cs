using System;
using System.IO;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;

namespace UnoCSharpClient
{
    class Program
    {
        private static TcpClient _tcpClient;
        private static StreamReader _reader;
        private static StreamWriter _writer;

        private static UdpClient _udpClient;
        private static string _username = "";
        private static bool _running = true;

        // dacă serverul tău rulează pe alt IP / port, modifici aici
        private const string ServerHost = "127.0.0.1";
        private const int TcpPort = 5000;
        private const int UdpPort = 55555;

        static void Main(string[] args)
        {
            Console.OutputEncoding = Encoding.UTF8;

            Console.Write("Enter username: ");
            _username = Console.ReadLine()?.Trim() ?? "CSharpUser";
            if (string.IsNullOrWhiteSpace(_username))
            {
                _username = "CSharpUser";
            }

            try
            {
                // 1. Conectare TCP
                _tcpClient = new TcpClient();
                _tcpClient.Connect(ServerHost, TcpPort);
                Console.WriteLine($"[TCP] Connected to {ServerHost}:{TcpPort}");

                NetworkStream stream = _tcpClient.GetStream();
                var utf8NoBom = new UTF8Encoding(encoderShouldEmitUTF8Identifier: false);

                _reader = new StreamReader(stream, utf8NoBom);
                _writer = new StreamWriter(stream, utf8NoBom) { AutoFlush = true };


                // 2. Trimitem LOGIN
                _writer.WriteLine("LOGIN;" + _username);

                // 3. Pornim thread-ul pentru ascultat TCP
                Thread tcpListenerThread = new Thread(ListenTcp)
                {
                    IsBackground = true
                };
                tcpListenerThread.Start();

                

                // 5. Bucla principală: citim comenzi din consolă și le trimitem prin TCP
                Console.WriteLine("Commands:");
                Console.WriteLine("  DRAW               - draw a card");
                Console.WriteLine("  PLAY;CARD_ID       - play card (e.g., PLAY;RED-5)");
                Console.WriteLine("  EXIT               - close client");
                Console.WriteLine();

                while (_running)
                {
                    string? line = Console.ReadLine();
                    if (line == null)
                    {
                        break;
                    }

                    line = line.Trim();

                    if (line.Equals("EXIT", StringComparison.OrdinalIgnoreCase))
                    {
                        _running = false;
                        break;
                    }

                    // Trimitem comanda exact cum o scriem (DRAW / PLAY;...)
                    _writer.WriteLine(line);
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("[ERROR] " + ex.Message);
            }
            finally
            {
                Cleanup();
                Console.WriteLine("Client stopped. Press Enter to exit.");
                Console.ReadLine();
            }
        }

        /// <summary>
        /// Ascultă mesajele TCP de la server (WELCOME, GAME_STATE, INVALID_MOVE, etc.).
        /// </summary>
        private static void ListenTcp()
        {
            try
            {
                string? line;
                while (_running && (line = _reader.ReadLine()) != null)
                {
                    HandleServerMessage(line);
                }
            }
            catch (IOException)
            {
                Console.WriteLine("[TCP] Disconnected from server.");
            }
            catch (Exception ex)
            {
                Console.WriteLine("[TCP ERROR] " + ex.Message);
            }
            finally
            {
                _running = false;
            }
        }

        /// <summary>
        /// Procesează un mesaj primit de la server (protocol text).
        /// </summary>
        private static void HandleServerMessage(string msg)
        {
            if (msg.StartsWith("WELCOME;"))
            {
                string name = msg.Substring("WELCOME;".Length).Trim();
                Console.WriteLine($"[TCP] Welcome as {name}");

                // Pornim UDP heartbeat doar după ce suntem logați.
                if (_udpClient == null)
                {
                    _udpClient = new UdpClient();
                    Thread hbThread = new Thread(HeartbeatLoop)
                    {
                        IsBackground = true
                    };
                    hbThread.Start();
                }
            }
            else if (msg.StartsWith("GAME_STATE;"))
            {
                // Format: GAME_STATE;TOP;CARD1,CARD2,...
                string[] parts = msg.Split(';', 3);
                if (parts.Length >= 3)
                {
                    string topCard = parts[1];
                    string handStr = parts[2];

                    Console.WriteLine();
                    Console.WriteLine("===== GAME STATE =====");
                    Console.WriteLine("Top card: " + topCard);

                    if (string.IsNullOrWhiteSpace(handStr))
                    {
                        Console.WriteLine("Your hand: (empty)");
                    }
                    else
                    {
                        string[] cards = handStr.Split(',', StringSplitOptions.RemoveEmptyEntries);
                        Console.WriteLine("Your hand:");
                        for (int i = 0; i < cards.Length; i++)
                        {
                            Console.WriteLine($"  {i + 1}. {cards[i].Trim()}");
                        }
                    }
                    Console.WriteLine("======================");
                    Console.WriteLine();
                }
                else
                {
                    Console.WriteLine("[TCP] Malformed GAME_STATE: " + msg);
                }
            }
            else if (msg.StartsWith("INVALID_MOVE;"))
            {
                string reason = msg.Substring("INVALID_MOVE;".Length);
                Console.WriteLine("[TCP] INVALID MOVE: " + reason);
            }
            else
            {
                // orice alt mesaj (ECHO;..., etc.)
                Console.WriteLine("[TCP] " + msg);
            }
        }

        /// <summary>
        /// Trimite periodic heartbeat UDP la server și afișează ACK-urile.
        /// </summary>
        private static void HeartbeatLoop()
        {
            try
            {
                IPEndPoint serverEndPoint = new IPEndPoint(IPAddress.Parse(ServerHost), UdpPort);

                // Setăm timeout pe receive, ca să nu blocăm la infinit
                _udpClient.Client.ReceiveTimeout = 500;

                byte[] buffer = new byte[1024];

                while (_running)
                {
                    // 1. Trimitem HEARTBEAT;username
                    string hb = "HEARTBEAT;" + _username;
                    byte[] data = Encoding.UTF8.GetBytes(hb);
                    _udpClient.Send(data, data.Length, serverEndPoint);

                    try
                    {
                        // 2. Încercăm să citim un răspuns (HB_ACK)
                        IPEndPoint? remote = null;
                        byte[] resp = _udpClient.Receive(ref remote);
                        string respText = Encoding.UTF8.GetString(resp);
                        int counter = 0;
                        counter++;
                        if (counter % 5 == 0)
                        {
                            Console.WriteLine("[UDP] " + respText);
                        }

                    }
                    catch (SocketException)
                    {
                        // Timeout - nicio problemă, mergem mai departe
                    }

                    Thread.Sleep(3000); // 3 secunde între heartbeat-uri
                }
            }
            catch (SocketException ex)
            {
                Console.WriteLine("[UDP ERROR] " + ex.Message);
            }
            catch (ObjectDisposedException)
            {
                // se întâmplă dacă închidem socket-ul în Cleanup
            }
        }

        /// <summary>
        /// Curățenie la final: închidem conexiunile.
        /// </summary>
        private static void Cleanup()
        {
            try
            {
                _running = false;

                _reader?.Dispose();
                _writer?.Dispose();
                _tcpClient?.Close();

                _udpClient?.Close();
            }
            catch
            {
                // ignorăm erorile de cleanup
            }
        }
    }
}
