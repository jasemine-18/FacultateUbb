package ro.jas.uno.server;

import ro.jas.uno.model.Card;
import ro.jas.uno.model.UnoGame;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.List;

public class ClientHandler implements Runnable {

    private final Socket socket;
    private final UnoServer server;

    private BufferedReader in;
    private PrintWriter out;

    private String username;

    public ClientHandler(Socket socket, UnoServer server) {
        this.socket = socket;
        this.server = server;
    }

    public void sendLine(String line) {
        if (out != null) {
            out.println(line);
        }
    }


    //Trimite starea jocului doar acestui jucător (mana lui + top card).
    public void sendGameState() {
        UnoGame game = server.getGame();

        Card top = game.getTopCard();
        String topStr = (top != null) ? top.toProtocolString() : "NONE";

        List<Card> hand = game.getHand(username);

        StringBuilder handStr = new StringBuilder();
        for (int i = 0; i < hand.size(); i++) {
            if (i > 0) handStr.append(",");
            handStr.append(hand.get(i).toProtocolString());
        }

        sendLine("GAME_STATE;" + topStr + ";" + handStr);
    }


     //Procesează o comandă de la client (DRAW / PLAY;...).
     //Respectă:
     //- jocul se oprește după WINNER
     //- un singur move pe tura (verificăm dacă e tura jucatorului)
    private void handleCommand(String line) {
        UnoGame game = server.getGame();

        // jocul deja s-a terminat
        if (server.isGameOver()) {
            sendLine("GAME_OVER;Game already finished.");
            return;
        }

        // verificam dacă e tura lui
        if (!server.isPlayersTurn(username)) {
            String current = server.getCurrentPlayer();
            sendLine("NOT_YOUR_TURN;" + current);
            return;
        }

        if (line.equalsIgnoreCase("DRAW")) {
            // jucatorul trage o carte
            Card newCard = game.drawCard(username);
            System.out.println(username + " drew card " + newCard);

            // daca a tras si cumva ramane fara carti
            if (game.getHand(username).isEmpty()) {
                server.broadcastGameState();
                server.declareWinner(username);
            } else {
                server.broadcastGameState(); // toți primesc update
                server.nextTurn();           // trecem la următorul
            }

        } else if (line.startsWith("PLAY;")) {
            String cardId = line.substring("PLAY;".length()).trim();
            Card wanted = Card.fromProtocolString(cardId);

            // verificăm dacă are cartea in mana
            if (!game.getHand(username).contains(wanted)) {
                sendLine("INVALID_MOVE;You don't have card " + cardId);
                return;
            }

            // incercam sa jucam cartea
            boolean ok = game.playCard(username, wanted);

            if (!ok) {
                sendLine("INVALID_MOVE;Card " + cardId
                        + " cannot be played on " + game.getTopCard());
                return;
            }

            System.out.println(username + " played " + wanted
                    + " → new top: " + game.getTopCard());

            // dupa un PLAY valid, verificam dacă a ramas fara carți
            if (game.getHand(username).isEmpty()) {
                server.broadcastGameState();
                server.declareWinner(username);   // trimite WINNER;username la toți
            } else {
                server.broadcastGameState();
                server.nextTurn();                // mutăm tura la următorul jucător
            }

        } else {
            // orice alt mesaj il echouim
            sendLine("ECHO;" + line);
        }
    }

    @Override
    public void run() {
        try {
            in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            out = new PrintWriter(new OutputStreamWriter(socket.getOutputStream()), true);

            // primul mesaj trebuie să fie LOGIN;username
            String line = in.readLine();
            if (line == null) return;

            if (line.startsWith("LOGIN;")) {
                username = line.substring("LOGIN;".length()).trim();
                System.out.println("User logged in: " + username);

                // înregistrăm clientul în server + joc
                server.registerClient(username, this);

                sendLine("WELCOME;" + username);
                // GAME_STATE inițial va veni din broadcastGameState() din registerClient

            } else {
                sendLine("ERROR;First message must be LOGIN;username");
                return;
            }

            // bucla de comenzi
            while ((line = in.readLine()) != null) {
                System.out.println("From " + username + ": " + line);
                handleCommand(line);
            }

        } catch (IOException e) {
            System.out.println("Client connection error: " + e.getMessage());
        } finally {
            try {
                socket.close();
            } catch (IOException ignored) { }
            server.removeClient(username);
        }
    }
}
