# 🧠 QuizCapitale (UiPath RPA Project)

> **Tema RPA – Lecture 03:**  
> Proiect care demonstrează folosirea fluxurilor multiple (`Invoke Workflow File`), argumentelor (`In`, `Out`, `In/Out`), precum și interacțiunea cu fișiere (`Read Text File`, `Write Text File`, `Read CSV`, `Write CSV`).

---

## 🎯 Scopul proiectului
Acest proiect UiPath simulează un **quiz interactiv cu capitale**, în care utilizatorul își introduce numele, alege un topic (Europa / Asia), răspunde la întrebări, primește scorul final și poate relua jocul.  
Proiectul citește și scrie fișiere CSV/TXT, folosind mai multe workflow-uri separate pentru o arhitectură modulară.

---

## 🧩 Cerința laboratorului
> „Creați un workflow în UiPath Studio care să:
> - includă **minimum 2 workflows invocate** (folosind `Invoke Workflow File`);
> - folosească **argumente cu direcții diferite** (`In`, `Out`, `In/Out`);
> - **citească și scrie date** dintr-un fișier `.csv` sau `.txt` (activitățile recomandate: `Read Text File`, `Write Text File`, `Append Line`, `Read CSV`, `Write CSV`);
> - reprezinte un proces logic cu pași clari care duc la un scop final.”

✅ **Proiectul „QuizCapitale” respectă toate aceste cerințe.**

---

## 🧱 Structura proiectului
QuizCapitale/
├── Main.xaml # fluxul principal
├── Helpers/
│ ├── BuildCards.xaml # generează DataTable-ul cu întrebările
│ └── RunQuiz.xaml # rulează quiz-ul, colectează scorul, salvează rezultatele
├── Data/
│ ├── Europe.csv # întrebări Europa (țară + capitală)
│ └── Asia.csv # întrebări Asia
├── Config/
│ └── welcome.txt # mesaj personalizat de bun venit
├── Output/
│ ├── session_<user>_<timestamp>.csv # export cu răspunsurile și rezultatele
│ └── log.txt # jurnal cu data, utilizator, scor
├── project.json
└── README.md

---

## ⚙️ Explicația logicii

### 🔸 Main.xaml
1. Cere numele utilizatorului (Input Dialog)
2. Citește mesajul din `Config/welcome.txt`
3. Afișează mesajul de bun venit
4. Alege topicul (Europe / Asia)
5. Invocă:
   - `Helpers/BuildCards.xaml` → construiește tabelul de întrebări
   - `Helpers/RunQuiz.xaml` → rulează quiz-ul, calculează scorul
6. Verifică dacă utilizatorul a trecut (scor ≥ 60%)
7. Afișează mesajul final (Bravo / Mai încearcă!)
8. Întreabă dacă vrea să rejocă (Da / Nu)
9. Dacă „Da”, se reia quiz-ul cu alt topic

---

### 🔸 BuildCards.xaml
> Primește `in_Topic` (Europe/Asia) și returnează `out_SessionTable` (DataTable)

1. Creează un DataTable `dt` cu coloane:  
   `Country`, `Capital`, `UserAnswer`, `IsCorrect`
2. În funcție de topic:
   - Dacă fișierul `Data/<Topic>.csv` **există**, citește conținutul cu `Read Text File` și convertește în DataTable (`Generate Data Table`).
   - Dacă fișierul **nu există**, folosește un dicționar intern cu aceleași date.
3. Returnează `out_SessionTable = dt`.

---

### 🔸 RunQuiz.xaml
> Rulează întrebările, calculează scorul și exportă rezultatele

1. Pentru fiecare rând din `io_SessionTable`:
   - întreabă „Care este capitala țării X?”
   - citește răspunsul
   - compară cu răspunsul corect
   - actualizează coloanele `UserAnswer` și `IsCorrect`
2. La final:
   - `out_Score` = numărul de răspunsuri corecte
   - `out_Total` = numărul total de întrebări
3. Scrie rezultatele:
   - **CSV:** `Output/session_<user>_<timestamp>.csv`
   - **Log:** `Output/log.txt` (append line cu: data, user, scor)
4. Creează automat folderul `Output/` dacă nu există.

---

## 🧠 Activități importante folosite
| Tip | Activitate | Scop |
|-----|-------------|------|
| Interacțiune utilizator | **Input Dialog**, **Message Box** | pentru întrebări și mesaje |
| Control | **FlowDecision**, **If**, **Switch** | logica decizională (topic, rejucare) |
| Date | **Build Data Table**, **For Each Row**, **Assign** | gestionarea tabelului de întrebări |
| Fișiere | **Read Text File**, **Generate Data Table**, **Output Data Table**, **Write Text File**, **Append Line**, **Create Folder** | citire/scriere CSV și TXT |
| Modularizare | **Invoke Workflow File** | separarea logicii în fișiere `Helpers` |

---

## 🔄 Argumentele folosite

### Main.xaml
| Nume | Direcție | Tip | Descriere |
|------|-----------|-----|-----------|
| `topic` | In | String | Topic-ul ales (Europe/Asia) |
| `sessionTable` | In/Out | DataTable | Tabelul cu întrebări curente |
| `score` | Out | Int32 | Scorul obținut |
| `total` | Out | Int32 | Numărul total de întrebări |
| `userName` | In | String | Numele utilizatorului |
| `welcomeText` | In | String | Textul citit din fișierul welcome |

### BuildCards.xaml
| Nume | Direcție | Tip | Descriere |
|------|-----------|-----|-----------|
| `in_Topic` | In | String | Topic-ul selectat |
| `out_SessionTable` | Out | DataTable | Tabel cu întrebări și coloane suplimentare |
| `filePath` | Intern | String | Calea către CSV |
| `exists` | Intern | Boolean | Verificare dacă fișierul există |

### RunQuiz.xaml
| Nume | Direcție | Tip | Descriere |
|------|-----------|-----|-----------|
| `io_SessionTable` | In/Out | DataTable | Întrebările și răspunsurile |
| `in_UserName` | In | String | Numele utilizatorului |
| `out_Score` | Out | Int32 | Scor final |
| `out_Total` | Out | Int32 | Număr întrebări |

---

## 🧪 Pași de rulare
1. Deschide proiectul în **UiPath Studio**.
2. Rulează `Main.xaml`.
3. Introdu numele tău.
4. Alege topicul (Europe / Asia).
5. Răspunde la întrebări.
6. Vezi mesajul final și logurile în folderul `Output/`.

---

## 📂 Fișiere generate

### `Output/session_<user>_<timestamp>.csv`
| Country | Capital | UserAnswer | IsCorrect |
|----------|----------|-------------|------------|
| Bulgaria | Sofia | Sofia | True |
| Grecia | Atena | Atena | True |
| Ungaria | Budapesta | Viena | False |

### `Output/log.txt`
[2025-10-26 22:45:15] User=Jasemine, Rows=5, Score=3/5


---

## 🧾 Concluzie
Proiectul **QuizCapitale** demonstrează:
- utilizarea activităților de citire/scriere fișiere;
- lucrul cu variabile, argumente și tipuri complexe (DataTable, Dictionary);
- modularizare cu mai multe workflows invocate;
- respectarea cerinței de laborator printr-un proces complet, logic și interactiv.




