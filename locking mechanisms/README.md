###### <div align="center"> Transaktionen, Isolationslevel & Sperrmechanismen </div>

<!-- TRANSAKTIONEN -->

# **Ⅰ** ) ***Transaktionen***  
<div align="center"> 

  Eine *Transaktion* ist eine **Folge von SQL-Anweisungen**, die **als Einheit behandelt** wird

 - ## **<div align="left"> *ACID*-Prinzip: </div>**  

  | A | **Atomicity**:   | *Alles oder nichts wird ausgeführt*                 |
  |:-:|             ---: | :--                                                 |
  | C | **Consistency**: | *Der Zustand bleibt konsistent*                     |
  | I | **Isolation**:   | *Transaktionen beeinflussen sich nicht gegenseitig* |
  | D | **Durability**:  | *Änderungen sind nach Commit dauerhaft*             |
</div>    

--- 
<div align="left">

- ### *Beispiele für Transaktionen* ( **TX** )   

 |         *Transaktionen* |  *Erklärungen*                                  |
 |                    ---: | :--                                             |
 | **`SELECT`**            | *Beginnt TX automatisch* - Wählt Daten aus      |
 | **`INSERT`**            | *Beginnt TX automatisch* - Aktualisiert Daten   |
 | **`DELETE`**            | *Beginnt TX automatisch* - Löscht aus den Daten |
 | **`BEGIN TRANSACTION`** | *Beginnt eine Transaktion explizit*             |
 | **`COMMIT`**            | *Beendet TX* - Macht Änderungen dauerhaft       |
 | **`ROLLBACK`**          | *Beendet TX* - Macht Änderungen rückgängig      |
</div>    

---

## **Ⅰ** ***a*** ) *Einführung* in ***TX***

  - ### **Multi-User-Datenbanken**:  
    Ermöglichen gleichzeitigen Zugriff durch mehrere Benutzer
    - **Lesen** ist *konfliktfrei*
    - **Schreiben** *kann Konflikte verursachen* ( zB. paralleles Ändern derselben Daten )

  - ### **Ziele von Transaktionen**:
    - Sicherstellen von Konsistenz, auch bei parallelen Zugriffen
    - Effizientes Schreiben und Lesen ohne Blockierungen

## **Ⅰ** ***b*** ) *Herausforderungen* von ***TX***
  - ### **Mehrere Operationen**:
      *Transaktionen gewährleisten, dass mehrerer Operationen* **vollständig ausgeführt** *werden* ***oder*** **keine**
  - ### **Korrekte Zwischenstände**:
      *Abfragen während einer Transaktion können* **inkorrekte Werte** *liefern*
  - ### **Maximale Parallelität**:
      **Gleichzeitiges Lesen** ***und*** **Schreiben** *ermöglichen*

---

## **Ⅰ** ***c*** ) *Transaktionssteuerung* in **SQL**

  - ### **Automatische Transaktionen**:
    - ***Standardverhalten***: *Jedes SQL-Statement* (`UPDATE`, `INSERT`, `DELETE`) *wird als Transaktion behandelt*
    - ***Fehler*** führen zu einem **automatischen Rollback**
  
  - ## **Manuelle Transaktionen**:
    - Steuerung mit `BEGIN TRANSACTION`, `COMMIT` und `ROLLBACK`

---

## **Ⅰ** ***d*** ) *Typische* ***Probleme*** *bei* ***TX***

  1) - **Lost Update**  
       > Zwei Transaktionen überschreiben sich gegenseitig  
       - **Lösung**: ***Sperren*** *oder* ***Versionierung***
  2) - **Dirty Read**  
       > Lesen von uncommitted Daten einer anderen Transaktion  
       - **Lösung**: *Verwendung strengerer* ***Isolationslevel*** (zB. `READ COMMITTED`)
  3) - **Non-Repeatable Read**  
       > Wiederholtes Lesen derselben Daten liefert unterschiedliche Ergebnisse  
       - **Lösung**: ***Repeatable Read*** *oder* ***Serializable Isolation***
  4) - **Phantom Read**  
       > Neue Datensätze erscheinen während einer Abfrage  
       - **Lösung**: ***Serializable Isolation***


