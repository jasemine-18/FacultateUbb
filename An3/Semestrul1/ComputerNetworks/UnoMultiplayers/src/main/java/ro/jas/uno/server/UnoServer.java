package ro.jas.uno.server;

import ro.jas.uno.model.UnoGame;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.util.*;

public class UnoServer {

    private final int port;
    private final int udpPort = 55555;

    private final UnoGame game = new UnoGame();

    // username -> ClientHandler
    private final Map<String, ClientHandler> clients = new HashMap<>();

    // heartbeat
    private final Map<String, Long> lastHeartbeat = new HashMap<>();

    //   MULTIPLAYER GAME STATE
    private final List<String> turnOrder = new ArrayList<>();
    private int currentTurnIndex = 0;
    private boolean gameOver = false;


    public UnoServer(int port) {
        this.port = port;
    }

    public UnoGame getGame() {
        return game;
    }

    //         REGISTER / REMOVE CLIENT
    public synchronized void registerClient(String username, ClientHandler handler) {
        clients.put(username, handler);
        game.addPlayer(username);

        System.out.println("Registered client: " + username);

        // adăugăm în ordinea rândului
        turnOrder.add(username);

        // primul jucător începe
        if (turnOrder.size() == 1) {
            currentTurnIndex = 0;
            broadcast("TURN;" + username);
        }

        broadcastGameState();
    }

    public synchronized void removeClient(String username) {
        if (username == null) return;
        clients.remove(username);
        lastHeartbeat.remove(username);

        System.out.println("Client disconnected: " + username);
    }

    //                 GAME LOGIC
    public synchronized boolean isPlayersTurn(String username) {
        if (gameOver || turnOrder.isEmpty()) return false;
        return turnOrder.get(currentTurnIndex).equals(username);
    }

    public synchronized String getCurrentPlayer() {
        if (turnOrder.isEmpty()) return null;
        return turnOrder.get(currentTurnIndex);
    }

    public synchronized void nextTurn() {
        if (gameOver || turnOrder.isEmpty()) return;

        currentTurnIndex = (currentTurnIndex + 1) % turnOrder.size();
        String current = turnOrder.get(currentTurnIndex);

        broadcast("TURN;" + current);
    }

    public synchronized boolean isGameOver() {
        return gameOver;
    }

    public synchronized void declareWinner(String winner) {
        gameOver = true;

        System.out.println("WINNER = " + winner);
        broadcast("WINNER;" + winner);
    }

    //             BROADCAST STARE JOC
    public synchronized void broadcast(String message) {
        for (ClientHandler ch : clients.values()) {
            ch.sendLine(message);
        }
    }

    public synchronized void broadcastGameState() {
        for (ClientHandler ch : clients.values()) {
            ch.sendGameState();
        }
    }

    //                UDP HEARTBEAT
    private void startUdpListener() {
        try (DatagramSocket udpSocket = new DatagramSocket(udpPort)) {

            System.out.println("UNO Server UDP listening on port " + udpPort);

            byte[] buffer = new byte[1024];

            while (true) {
                DatagramPacket packet = new DatagramPacket(buffer, buffer.length);
                udpSocket.receive(packet);

                String received = new String(packet.getData(), 0, packet.getLength());
                System.out.println("UDP received: " + received);

                if (received.startsWith("HEARTBEAT;")) {
                    String username = received.substring("HEARTBEAT;".length()).trim();

                    synchronized (lastHeartbeat) {
                        lastHeartbeat.put(username, System.currentTimeMillis());
                    }

                    String response = "HB_ACK;" + username;
                    byte[] respBytes = response.getBytes();

                    DatagramPacket respPacket = new DatagramPacket(
                            respBytes,
                            respBytes.length,
                            packet.getAddress(),
                            packet.getPort()
                    );
                    udpSocket.send(respPacket);
                }
            }
        } catch (IOException e) {
            System.out.println("UDP listener stopped: " + e.getMessage());
        }
    }

    //                 START SERVER
    public void start() throws IOException {
        try (ServerSocket serverSocket = new ServerSocket(port)) {

            System.out.println("Uno Server listening on port " + port);

            new Thread(this::startUdpListener).start();

            // Accept clients
            while (true) {
                Socket clientSocket = serverSocket.accept();
                System.out.println("New client connected: " + clientSocket);

                ClientHandler handler = new ClientHandler(clientSocket, this);
                new Thread(handler).start();
            }
        }
    }

    public static void main(String[] args) throws IOException {
        UnoServer server = new UnoServer(5000);
        server.start();
    }
}
