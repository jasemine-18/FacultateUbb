# 🚗 Parking MVC – Laboratory 2 (Assignment A1)

## 📘 Problem statement
> Într-o parcare există mașini, motociclete și biciclete.  
> Să se afișeze toate vehiculele de culoare roșie.

Implementarea respectă **arhitectura Model–View–Controller (MVC)** și cerințele din laboratorul 2.

---

## 🧩 Project structure
src/
├── model/
│ ├── Vehicle.java
│ ├── Car.java
│ ├── Motorcycle.java
│ └── Bicycle.java
│
├── repository/
│ ├── IRepository.java
│ ├── InMemoryRepository.java
│ └── RepoException.java
│
├── controller/
│ └── Controller.java
│
└── view/
└── Main.java


---

## ⚙️ Description

### 🧱 Model
- **`Vehicle`** – interfață comună pentru toate vehiculele.  
  Definește metodele:
  ```java
  String getBrand();
  String getColor();
  String getType();
Car, Motorcycle, Bicycle – clase care implementează interfața Vehicle.
Conțin atributele brand și color și metodele specifice.
Fiecare rescrie metoda toString() pentru afișare clară.
🗃️ Repository

IRepository – interfață care definește operațiile:

add()

remove()

getAll()

getSize()

getCapacity()

InMemoryRepository – implementare în memorie cu array fix de tip Vehicle[].
Gestionează adăugarea și ștergerea vehiculelor, aruncând excepții (RepoException) în caz de erori.

RepoException – clasă de excepții pentru repository.
🧠 Controller

Controller – conține logica principală a aplicației.
Menține o referință la interfața IRepository, nu la o clasă concretă.
Metode principale:

addVehicle(Vehicle v)

removeVehicle(int index)

getVehiclesByColor(String color)

getRedVehicles()

Metoda getRedVehicles() implementează cerința principală — afișarea vehiculelor roșii.

🖥️ View

Main – punctul de pornire al aplicației.
Creează repository-ul, controllerul și vehiculele de test (fără citire de la tastatură).
Afișează rezultatele în consolă.

📄 Example output

All vehicles:
Car Toyota of color red
Car BMW of color blue
Motorcycle Yamaha of color red
Motorcycle Suzuki of color black
Bicycle Pegas of color green
Bicycle Cube of color red

Red vehicles:
Car Toyota of color red
Motorcycle Yamaha of color red
Bicycle Cube of color red

✅ Requirements checklist (Assignment A1)
No.	Requirement	Implemented
1.1	Use of interface for entities (Vehicle)	✅
1.2	In-memory repository with fixed-size array	✅
1.3	Controller holds reference to the repository interface	✅
1.4	Hardcoded examples in main, no I/O required	✅
1.5	Use of exceptions for error handling	✅
1.6	Use of separate packages (model, repository, controller, view)	✅

💬 Notes for presentation

Controller are o referință de tip IRepository, nu InMemoryRepository.
→ asta permite schimbarea ușoară a implementării repository-ului.

Metoda remove() mută elementele la stânga pentru a evita golurile.

Metoda getRedVehicles() filtrează vehiculele după culoare, fără diferență între majuscule/minuscule.

@Override este folosit pentru a indica metodele care implementează interfața sau rescriu o metodă existentă (toString()).

💻 How to run

Deschide proiectul în IntelliJ IDEA.

Asigură-te că folderul src este setat ca Sources Root.

Rulează fișierul view/Main.java.

Rezultatul va fi afișat în consola IntelliJ.

🧠 Summary

Acest proiect implementează problema „Parking” folosind arhitectura MVC în Java.
Codul respectă toate cerințele laboratorului: separarea pe pachete, utilizarea interfețelor,
array fix în repository, excepții și logica principală de filtrare în controller.
