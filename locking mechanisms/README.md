# Transaktionen, Isolationslevel & Sperrmechanismen

<!-- TRANSAKTIONEN -->

## 1.) Transaktionen  
<div align="center"> 

  Eine *Transaktion* ist eine **Folge von SQL-Anweisungen**, die **als Einheit behandelt** wird
</div>    

--- 

## **ACID**-Prinzip:  
  | A | **Atomicity**:   | *Alles oder nichts wird ausgeführt*                 |
  |:-:|             ---: | :--                                                 |
  | C | **Consistency**: | *Der Zustand bleibt konsistent*                     |
  | I | **Isolation**:   | *Transaktionen beeinflussen sich nicht gegenseitig* |
  | D | **Durability**:  | *Änderungen sind nach Commit dauerhaft*             |
