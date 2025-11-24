cest proiect implementează un **interpretator** complet funcțional pentru **Toy Language**, un limbaj de programare simplificat. Este structurat pe **Arhitectura Model–View–Controller (MVC)** și îndeplinește integral cerințele Temelor **A2** și **A3** de la disciplina *Paradigme de Programare*.

---

## 🏛️ Arhitectura Generală (MVC)

### 1. 💾 Model

**Modelul** definește sintaxa limbajului (Expresii, Instrucțiuni) și structurile de date de rulare (State, ADTs).

#### 🏷️ Tipuri și Valori Suportate

| Element | Tipuri (Types) | Valori (Values) |
| :--- | :--- | :--- |
| **Integrale** | `IntType` | `IntValue` |
| **Logice** | `BoolType` | `BoolValue` |
| **Șiruri (A3)** | `StringType` | `StringValue` |

#### ⚙️ Expresii (`IExp`)

Toate expresiile implementează metoda: `Value eval(MyIDictionary<String, Value> tbl) throws MyException;`

* `ValueExp`, `VarExp`
* `ArithExp` (Operații aritmetice: `+`, `-`, `*`, `/`)
* `LogicExp` (Operații logice: `AND`, `OR`, `NOT`)
* ***`RelationalExp` (A3)***: Operații de comparație (`<, <=, ==, !=, >, >=`).

#### 📝 Instrucțiuni (`IStmt`)

Toate instrucțiunile implementează metoda: `PrgState execute(PrgState state) throws MyException;`

* `VarDeclStmt`, `AssignStmt`, `PrintStmt`
* `IfStmt`, `CompStmt`, `NopStmt`
* ***Instrucțiuni Fișiere (A3)***: `OpenRFileStmt`, `ReadFileStmt`, `CloseRFileStmt`.

#### 📦 Tipuri de Date Abstracte Custom (ADTs)

Implementări custom, generice, folosite pentru a modela mediul de rulare.

* `MyIStack<T>` (Stiva de Execuție)
* `MyIDictionary<K,V>` (Tabela de Simboluri, Tabela de Fișiere)
* `MyIList<T>` (Lista de Output)

### 2. 🎮 Controller

Componenta responsabilă de gestionarea execuției și de controlul fluxului programului.

* **`void allStep()`**: Rulează programul complet.
* **`PrgState oneStep(PrgState state)`**: Execută o singură instrucțiune.
* **Jurnalizare (A3)**: Setează log-ul de execuție în fișier (Repository).
* **Display Flag (A3)**: Controlează afișarea detaliată a stării programului pe consolă.

### 3. 🖥️ View

O interfață text-based (CLI) care folosește **Design Pattern-ul Command** pentru meniul interactiv.

| Opțiune | Descriere | Tema |
| :---: | :--- | :--- |
| `0` | Exit | |
| `1`-`3` | Example Programs | A2 |
| `4` | File Example | **A3** (I/O pe fișiere) |
| `5` | Relational Example | **A3** (Comparații) |
| `6` | Toggle Display Flag | **A3** |

---

## 💻 Exemple de Programe

Exemplu care demonstrează declarații, asignări și structura compusă:

```java
// Declară 'v' de tip Int, Asignează 2 lui 'v', Afișează 'v'
IStmt example1 = new CompStmt(
    new VarDeclStmt("v", new IntType()),
    new CompStmt(
        new AssignStmt("v", new ValueExp(new IntValue(2))),
        new PrintStmt(new VarExp("v"))
    )
);
