package ro.jas.uno.client;

import javax.swing.*;
import java.awt.*;
import java.io.*;
import java.net.*;

public class UnoGuiClient {

    private JFrame frame;
    private JLabel topCardLabel;
    private DefaultListModel<String> handModel;
    private JList<String> handList;
    private JButton drawButton;
    private JButton playButton;
    private JTextArea logArea;

    private Socket tcpSocket;
    private BufferedReader in;
    private PrintWriter out;

    private String username;

    // UDP constants
    private static final String SERVER_HOST = "172.21.96.72";
    private static final int UDP_PORT = 55555;

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            try {
                new UnoGuiClient().start();
            } catch (IOException e) {
                e.printStackTrace();
                JOptionPane.showMessageDialog(null,
                        "Failed to connect to server: " + e.getMessage(),
                        "Error", JOptionPane.ERROR_MESSAGE);
            }
        });
    }

    public void start() throws IOException {
        // get username
        username = JOptionPane.showInputDialog(null, "Enter username:", "UNO Login",
                JOptionPane.QUESTION_MESSAGE);
        if (username == null || username.isBlank()) {
            return;
        }

        // connect TCP
        //tcpSocket = new Socket("localhost", 5000);
        tcpSocket = new Socket("172.21.96.72", 5000);
        in = new BufferedReader(new InputStreamReader(tcpSocket.getInputStream()));
        out = new PrintWriter(new OutputStreamWriter(tcpSocket.getOutputStream()), true);

        // send LOGIN
        out.println("LOGIN;" + username);

        // build UI
        buildUi();

        // start listening TCP
        Thread listener = new Thread(this::listenTcp);
        listener.setDaemon(true);
        listener.start();

        // start UDP heartbeats
        startUdpHeartbeat(username);
    }

    private void buildUi() {
        frame = new JFrame("UNO Client - " + username);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(650, 420);
        frame.setLayout(new BorderLayout());

        topCardLabel = new JLabel("Top card: (unknown)", SwingConstants.CENTER);
        topCardLabel.setFont(topCardLabel.getFont().deriveFont(Font.BOLD, 16f));
        frame.add(topCardLabel, BorderLayout.NORTH);

        handModel = new DefaultListModel<>();
        handList = new JList<>(handModel);
        handList.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
        JScrollPane handScroll = new JScrollPane(handList);
        handScroll.setBorder(BorderFactory.createTitledBorder("Your hand"));
        frame.add(handScroll, BorderLayout.CENTER);

        JPanel rightPanel = new JPanel(new BorderLayout());

        JPanel buttonsPanel = new JPanel(new FlowLayout());
        drawButton = new JButton("Draw");
        playButton = new JButton("Play selected");
        buttonsPanel.add(drawButton);
        buttonsPanel.add(playButton);
        rightPanel.add(buttonsPanel, BorderLayout.NORTH);

        logArea = new JTextArea();
        logArea.setEditable(false);
        JScrollPane logScroll = new JScrollPane(logArea);
        logScroll.setBorder(BorderFactory.createTitledBorder("Messages"));
        rightPanel.add(logScroll, BorderLayout.CENTER);

        frame.add(rightPanel, BorderLayout.EAST);

        drawButton.addActionListener(e -> sendDraw());
        playButton.addActionListener(e -> sendPlay());

        frame.setLocationRelativeTo(null);
        frame.setVisible(true);
    }

    private void listenTcp() {
        try {
            String line;
            while ((line = in.readLine()) != null) {
                final String msg = line;
                SwingUtilities.invokeLater(() -> handleServerMessage(msg));
            }
        } catch (IOException e) {
            SwingUtilities.invokeLater(() -> log("Disconnected from server: " + e.getMessage()));
        }
    }

    private void handleServerMessage(String msg) {

        // === STATE UPDATE ===
        if (msg.startsWith("GAME_STATE;")) {
            String[] parts = msg.split(";", 3);
            if (parts.length >= 3) {
                String top = parts[1];
                String handStr = parts[2];

                topCardLabel.setText("Top card: " + top);

                handModel.clear();
                if (!handStr.isBlank()) {
                    for (String c : handStr.split(",")) {
                        handModel.addElement(c.trim());
                    }
                }
                log("Game state updated.");
            }
            return;
        }

        // === INVALID MOVE ===
        if (msg.startsWith("INVALID_MOVE;")) {
            String reason = msg.substring("INVALID_MOVE;".length());
            log("Invalid move: " + reason);
            JOptionPane.showMessageDialog(frame,
                    reason,
                    "Invalid move",
                    JOptionPane.WARNING_MESSAGE);
            return;
        }

        // === NOT YOUR TURN ===
        if (msg.startsWith("NOT_YOUR_TURN;")) {
            String current = msg.substring("NOT_YOUR_TURN;".length());
            JOptionPane.showMessageDialog(frame,
                    "It's not your turn!\nCurrent turn: " + current,
                    "Wait",
                    JOptionPane.INFORMATION_MESSAGE);
            log("Not your turn. Current: " + current);
            return;
        }

        // === WINNER ===
        if (msg.startsWith("WINNER;")) {
            String winner = msg.substring("WINNER;".length()).trim();

            String text = winner.equals(username)
                    ? "You WON the game!"
                    : " ! " + winner + " has won the game!";

            JOptionPane.showMessageDialog(frame,
                    text,
                    "Game over",
                    JOptionPane.INFORMATION_MESSAGE);

            // dezactivăm butoanele
            drawButton.setEnabled(false);
            playButton.setEnabled(false);

            log("Game finished. Winner: " + winner);
            return;
        }

        // === GAME OVER (server refuses commands after winner) ===
        if (msg.startsWith("GAME_OVER;")) {
            JOptionPane.showMessageDialog(frame,
                    "The game has ended.\nRestart server to play again.",
                    "Game Over",
                    JOptionPane.WARNING_MESSAGE);

            drawButton.setEnabled(false);
            playButton.setEnabled(false);
            log(msg);
            return;
        }

        // === WELCOME / ECHO / OTHER ===
        if (msg.startsWith("WELCOME;")) {
            log("Connected as " + msg.substring("WELCOME;".length()).trim());
            return;
        }

        log("Server: " + msg);
    }


    private void sendDraw() {
        if (out != null) {
            out.println("DRAW");
            log("Sent: DRAW");
        }
    }

    private void sendPlay() {
        String selected = handList.getSelectedValue();
        if (selected == null) {
            JOptionPane.showMessageDialog(frame,
                    "Please select a card to play.",
                    "No card selected",
                    JOptionPane.WARNING_MESSAGE);
            return;
        }

        out.println("PLAY;" + selected.trim());
        log("Sent: PLAY;" + selected.trim());
    }

    private void startUdpHeartbeat(String username) {
        new Thread(() -> {
            try (DatagramSocket udpSocket = new DatagramSocket()) {
                InetAddress serverAddr = InetAddress.getByName(SERVER_HOST);

                while (true) {
                    String hb = "HEARTBEAT;" + username;
                    byte[] data = hb.getBytes();

                    DatagramPacket packet = new DatagramPacket(
                            data, data.length, serverAddr, UDP_PORT
                    );
                    udpSocket.send(packet);

                    try {
                        byte[] buf = new byte[128];
                        DatagramPacket resp = new DatagramPacket(buf, buf.length);
                        udpSocket.setSoTimeout(500);
                        udpSocket.receive(resp);

                        String ack = new String(resp.getData(), 0, resp.getLength());
                        System.out.println("UDP ACK: " + ack);

                    } catch (Exception ignored) {}

                    Thread.sleep(3000);
                }
            } catch (Exception e) {
                System.out.println("UDP error: " + e.getMessage());
            }
        }).start();
    }

    private void log(String text) {
        logArea.append(text + "\n");
    }
}
