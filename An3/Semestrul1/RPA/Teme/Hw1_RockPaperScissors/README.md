# 🪨📄✂️ Rock–Paper–Scissors — UiPath Project

## 🎯 Goal
This UiPath process simulates the classic **Rock–Paper–Scissors** game between a **user** and the **computer**.  
It demonstrates **basic UiPath programming concepts** (from Lecture 01–03), including variables, control flow, collections, and data handling in a fun, interactive scenario.

---

## ⚙️ Main Components
### 1. Workflow Structure
- **Main Flowchart** – controls the game logic (Start → Play → Exit)
- **PlayRound Sequence** – handles a single game round (user input, computer choice, result evaluation)
- **For Each Loop** – used to display the history of previous rounds

---

## 🧠 Logic Overview
1. The program displays an Input Dialog asking the player to type:
(Q cancels the round)
2. The computer randomly selects one of the three choices.
3. The workflow compares the two and determines the **result**:
- ROCK beats SCISSORS  
- PAPER beats ROCK  
- SCISSORS beats PAPER  
- Identical choices → DRAW
4. The result is shown in a Message Box.
5. The result, choices, and timestamp are logged in a **DataTable** (`dtLog`).
6. The game repeats until the user cancels or closes the process.
7. At the end, a “round history” is printed using a **For Each** loop.

---

## 🧩 Variables Used

| Variable | Type | Description |
|-----------|------|-------------|
| `userChoice` | String | Player’s input (ROCK / PAPER / SCISSORS / Q) |
| `compChoice` | String | Computer’s randomly generated choice |
| `choices` | List\<String> | Stores the 3 possible options |
| `rnd` | Random | Used to generate the computer’s choice |
| `roundNo` | Int32 | Counter for current round |
| `result` | String | Outcome of the round (“WIN”, “LOSS”, “DRAW”) |
| `validInput` | Boolean | Ensures input is correct before continuing |
| `historyUser` | List\<String> | Stores player’s past moves |
| `historyComp` | List\<String> | Stores computer’s past moves |
| `dtLog` | DataTable | Logs all rounds with timestamp |
| `score` | Dictionary\<String, Int32> | Tracks total Wins/Losses/Draws |

---

## 🪶 Data Table Structure (`dtLog`)

| Column Name | Type | Description |
|--------------|------|-------------|
| `RoundNo` | Int32 | Round number |
| `UserChoice` | String | Player’s choice |
| `CompChoice` | String | Computer’s choice |
| `Result` | String | Result of the round |
| `TimeStamp` | DateTime | Time when the round was played |

---

## 🔁 Control Flow Elements

- **Sequence** – for structured series of actions within a round  
- **Flowchart** – controls the overall game flow  
- **While Loop** – repeats until valid input is entered  
- **If statements** – handle decision-making for input validation and results  
- **Switch** – determines the game result (WIN, LOSS, DRAW)  
- **For Each** – prints the round history at the end  

---

## 🧮 Collections Used

| Collection | Type | Purpose |
|-------------|------|---------|
| `choices` | List\<String> | Contains possible moves: ROCK, PAPER, SCISSORS |
| `historyUser`, `historyComp` | List\<String> | Store user and computer choices for all rounds |
| `dtLog` | DataTable | Logs each round (acts as a structured collection) |

---

## 🧭 Control Flow Types Demonstrated

| Type | Example |
|-------|----------|
| **Choice 1:** `If` – checks if input is “Q” or invalid |
| **Choice 2:** `Switch` – decides WIN/LOSS/DRAW |
| **Control Flow 1:** `While` – repeat until valid input |
| **Control Flow 2:** `For Each` – display history of rounds |

---

## 💬 Example Output
You chose ROCK. Computer chose PAPER.
Result: LOSS
Score → Wins: 2 | Losses: 3 | Draws: 1

**Round history (console output):**
Round 1: You=ROCK, CPU=SCISSORS
Round 2: You=PAPER, CPU=PAPER
Round 3: You=SCISSORS, CPU=ROCK


---

## ✅ Concepts Demonstrated
- Data validation (`While`, `If`, `Trim`, `ToUpper`)
- Random generation and indexing (`rnd.Next`)
- List and DataTable manipulation
- Message Boxes and logging
- Loop control and sequential execution
- Annotations for clear documentation

---

## 🧾 Project Summary

| Requirement | Achieved |
|--------------|-----------|
| 1 Sequence + 1 Flowchart | ✅ |
| 3 Variable Types (String, Int32, Boolean, List, DataTable) | ✅ |
| 2 Choices (`If`, `Switch`) | ✅ |
| 2 Control Flows (`While`, `For Each`) | ✅ |
| 2 Collection Types (`List`, `DataTable`) | ✅ |

---

## 🏁 Conclusion
This project demonstrates the core UiPath programming concepts through a simple and interactive **Rock–Paper–Scissors** game.  
It combines logic, randomness, and data handling while maintaining clarity, modularity, and reusability.
