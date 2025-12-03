using System;
using System.IO;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;
using System.Windows.Forms;

namespace UnoCSharpGui
{
    public partial class MainForm : Form
    {
        private TcpClient tcpClient;
        private StreamReader reader;
        private StreamWriter writer;

        private UdpClient udpClient;

        private readonly string username;
        private bool gameOver = false;

        public MainForm(string user)
        {
            InitializeComponent();
            username = user;

            Text = "UNO Client - " + username;
        }
        
        protected override void OnShown(EventArgs e)
        {
            base.OnShown(e);
            StartTcp();
            StartUdpHeartbeat();
        }


        private void StartTcp()
        {
            try
            {
                Log("Connecting TCP to 127.0.0.1:5000 ...");

                tcpClient = new TcpClient("172.21.96.72", 5000);

                var stream = tcpClient.GetStream();

                // UTF-8 FĂRĂ BOM
                var utf8NoBom = new UTF8Encoding(encoderShouldEmitUTF8Identifier: false);

                reader = new StreamReader(stream, utf8NoBom);
                writer = new StreamWriter(stream, utf8NoBom) { AutoFlush = true };

                Log("Sent LOGIN;" + username);
                writer.WriteLine("LOGIN;" + username);

                Thread listener = new Thread(ListenTcp)
                {
                    IsBackground = true
                };
                listener.Start();

                Log("TCP listener started.");
            }
            catch (Exception ex)
            {
                MessageBox.Show("TCP error: " + ex.Message);
                Log("TCP error: " + ex);
            }
        }

        private void ListenTcp()
        {
            try
            {
                string line;
                while ((line = reader.ReadLine()) != null)
                {
                    string msg = line;
                    Invoke(new Action(() => HandleServerMsg(msg)));
                }
            }
            catch (Exception ex)
            {
                Invoke(new Action(() => Log("TCP disconnected: " + ex.Message)));
            }
        }

        private void HandleServerMsg(string msg)
        {
            Log("[TCP] " + msg);

            // === GAME STATE ===
            if (msg.StartsWith("GAME_STATE;"))
            {
                // GAME_STATE;TOP;CARD1,CARD2,...
                string[] parts = msg.Split(';', 3);
                if (parts.Length >= 2)
                {
                    string topCard = parts[1];
                    lblTopCard.Text = "Top card: " + topCard;

                    lstHand.Items.Clear();
                    if (parts.Length == 3 && !string.IsNullOrWhiteSpace(parts[2]))
                    {
                        foreach (var c in parts[2].Split(','))
                            lstHand.Items.Add(c.Trim());
                    }
                }
                return;
            }

            // === INVALID MOVE ===
            if (msg.StartsWith("INVALID_MOVE;"))
            {
                string reason = msg.Substring("INVALID_MOVE;".Length);
                MessageBox.Show(reason, "Invalid move",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                Log("Invalid move: " + reason);
                return;
            }

            // === NOT YOUR TURN ===
            if (msg.StartsWith("NOT_YOUR_TURN;"))
            {
                string current = msg.Substring("NOT_YOUR_TURN;".Length);
                MessageBox.Show(
                    "It's not your turn!\nCurrent turn: " + current,
                    "Wait",
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Information);
                Log("Not your turn. Current: " + current);
                return;
            }

            // === WINNER ===
            if (msg.StartsWith("WINNER;"))
            {
                string winner = msg.Substring("WINNER;".Length).Trim();
                string text = winner == username
                    ? "You WON the game!"
                    : $" {winner} has won the game!";

                MessageBox.Show(text, "Game over",
                    MessageBoxButtons.OK, MessageBoxIcon.Information);

                gameOver = true;
                btnDraw.Enabled = false;
                btnPlay.Enabled = false;

                Log("Game finished. Winner: " + winner);
                return;
            }

            // === GAME OVER (după winner, server refuză mutări) ===
            if (msg.StartsWith("GAME_OVER;"))
            {
                MessageBox.Show(
                    "The game has ended.\nRestart server to play again.",
                    "Game over",
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Warning);

                gameOver = true;
                btnDraw.Enabled = false;
                btnPlay.Enabled = false;

                Log(msg);
                return;
            }

            // === WELCOME / altele ===
            if (msg.StartsWith("WELCOME;"))
            {
                Log("Connected as " + msg.Substring("WELCOME;".Length).Trim());
                return;
            }

            Log("Server: " + msg);
        }

        private void StartUdpHeartbeat()
        {
            Thread hb = new Thread(() =>
            {
                try
                {
                    udpClient = new UdpClient();
                    IPEndPoint serverEP = new IPEndPoint(IPAddress.Parse("172.21.96.72"), 55555);

                    while (true)
                    {
                        string hbMsg = "HEARTBEAT;" + username;
                        byte[] data = Encoding.UTF8.GetBytes(hbMsg);

                        udpClient.Send(data, data.Length, serverEP);

                        try
                        {
                            udpClient.Client.ReceiveTimeout = 500;
                            IPEndPoint? remote = null;
                            byte[] resp = udpClient.Receive(ref remote);
                            string respText = Encoding.UTF8.GetString(resp);

                            Invoke(new Action(() => Log("[UDP] " + respText)));
                        }
                        catch
                        {
                            // timeout – ignorăm
                        }

                        Thread.Sleep(3000);
                    }
                }
                catch (Exception ex)
                {
                    Invoke(new Action(() => Log("[UDP ERROR] " + ex.Message)));
                }
            });

            hb.IsBackground = true;
            hb.Start();
        }

        private void btnDraw_Click(object sender, EventArgs e)
        {
            if (gameOver)
            {
                MessageBox.Show("The game is over.");
                return;
            }

            if (writer == null)
            {
                MessageBox.Show("Not connected to server yet.");
                return;
            }

            writer.WriteLine("DRAW");
            Log("Sent: DRAW");
        }

        private void btnPlay_Click(object sender, EventArgs e)
        {
            if (gameOver)
            {
                MessageBox.Show("The game is over.");
                return;
            }

            if (writer == null)
            {
                MessageBox.Show("Not connected to server yet.");
                return;
            }

            if (lstHand.SelectedItem == null)
            {
                MessageBox.Show("Select a card first.");
                return;
            }

            string card = lstHand.SelectedItem.ToString();
            writer.WriteLine("PLAY;" + card);
            Log("Sent: PLAY;" + card);
        }

        private void Log(string txt)
        {
            txtLog.AppendText(txt + Environment.NewLine);
        }

        // poți lăsa handler-ele de label goale, ca să nu mai arunce excepții
        private void lblTopCard_Click(object sender, EventArgs e) { }
        private void label1_Click(object sender, EventArgs e) { }
    }
}
