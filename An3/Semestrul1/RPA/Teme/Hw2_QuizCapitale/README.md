# QuizCapitale (UiPath)

Un quiz simplu cu capitale (Europe/Asia), cu:
- 2+ workflows invocate (`Helpers/BuildCards.xaml`, `Helpers/RunQuiz.xaml`)
- argumente In / Out / InOut
- citire din fișiere (`Data/Europe.csv`, `Data/Asia.csv`, `Config/welcome.txt`)
- scriere rezultate: CSV (`Output/session_<user>_<timestamp>.csv`) și log TXT (`Output/log.txt`)

## Structură
Helpers/
BuildCards.xaml # construiește DataTable-ul din CSV sau fallback pe dicționar
RunQuiz.xaml # rulează quiz-ul, score/total, export CSV + log
Data/
Europe.csv
Asia.csv
Config/
welcome.txt
Output/
(generat la rulare)
Main.xaml
project.json


## Cum rulezi
1. Deschide `Main.xaml` în UiPath Studio.
2. Rulează. Introdu numele, alege `Europe` sau `Asia`.
3. La final, verifică `Output/` pentru CSV și `log.txt`.

## Tehnic
- `BuildCards.xaml`
  - **In**: `in_Topic (String)`
  - **Out**: `out_SessionTable (DataTable)`
  - Citește `Data/<Topic>.csv` dacă există; altfel folosește dicționarul intern.
- `RunQuiz.xaml`
  - **In/Out**: `io_SessionTable (DataTable)`
  - **In**: `in_UserName (String)`
  - **Out**: `out_Score (Int32)`, `out_Total (Int32)`
  - Exportă `Output/session_<user>_<timestamp>.csv` + append în `Output/log.txt`

## Cerințe
- UiPath.System.Activities
- (opțional) UiPath.Excel.Activities (dacă folosești activitățile clasice)
