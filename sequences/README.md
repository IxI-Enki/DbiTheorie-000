###### <div align="center"> Sequenzen - Zahlenfolgen </div>

> [!WARNING]
> <details>  
>  <summary align="center"> 👉🏼 𝕿𝔬𝖕 𝕾𝔢𝖈𝔯𝖊𝔱 👈🏼 🖱️<sup><sub color="red">click</sub></sup> </summary>  
>  
> ![sequenzen-erstellen](./img/seq_q01.png)
> ![nextval-currval](./img/seq_q02.png)
> ![cache-option](./img/seq_q03.png)
> ![nocycle-hit-end](./img/seq_q04.png) 
> ![workaround](./img/seq_q05.png)
> 
> </details>

<!-- SEQUENCES ERSTELLUNG -->

# **Ⅰ** ) <p align="center"> ***Sequenzen*** </p>

## **Ⅰ** ***a*** ) *Erstellen*:
    
  ```sql
  create SEQUENCE allusers__u_ID   -- : name der sequenz
      START with 1                 -- : startwert
      MAXvalue 100000              -- : maxwert
      MINvalue 0                   -- : minwert
      INCREMENT by 1               -- : stepsize           
      noCACHE                      -- : erzeugt nummern bei bedarf  
      noCYCLE                      -- : keine wiederholung
  ;
  ```
    
## **Ⅰ** ***b*** ) *Löschen*:
  ```sql
  drop SEQUENCE
    allusers__u_ID;
  ```

---
## **Ⅰ** ***c*** ) *Wichtige* ***Parameter*** *und* ***Optionen***
  - ![increment](https://img.shields.io/badge/INCREMENT_by-%23030) :  
     Gibt die Schrittweite an  
     > Standardwert: 1 (auch negative Werte möglich)  
  - ![start](https://img.shields.io/badge/START_with-%23050) :  
     Definiert den Startwert der Sequenz  
     > Standardwert:  *1 ⇾ aufsteigenden* Sequenzen    
     > Standardwert: *-1 ⇾ absteigenden* Sequenzen     
  - ![min-max](https://img.shields.io/badge/MINvalue-MAXvalue-%23fff?labelColor=%23005&color=%23500) :  
     Legt die minimalen und maximalen Werte fest  
    - ![no-min](https://img.shields.io/badge/noMINvalue-%23fff?labelColor=%23005&color=%23002) :  
       > Mindestwert: *1 ⇾ aufsteigenden* Sequenzen   
       > Mindestwert: *-10²⁶ ⇾ absteigende* Sequenzen
    - ![no-max](https://img.shields.io/badge/noMAXvalue-%23fff?labelColor=%23500&color=%23200) :  
       > Zähler läuft bis zum technischen Limit [10²⁷ - bei aufsteigenden Sequenzen]            
  - ![cycle-nocycle](https://img.shields.io/badge/CYCLE-noCYCLE-%23fff?labelColor=%23050&color=%23302) :  
    - ![cycle](https://img.shields.io/badge/CYCLE-%23fff?color=%23050) :  
       > Neustart ⇾ wenn Höchstwert erreicht   
    - ![noCYCLE](https://img.shields.io/badge/noCYCLE-%23fff?labelColor=%23201&color=%23302) :  
       > Fehler ⇾ wenn Höchstwert erreicht   
  - ![ORDER / noORDER](https://img.shields.io/badge/ORDER-noORDER-%23fff?labelColor=%23FFF&color=%23111) :  
    - ![ORDER](https://img.shields.io/badge/ORDER-%23fff?color=%23FFF) :  
       > garantiert die Reihenfolge, jedoch keine lückenlose Nummerierung   
  - ![CACHE / noCACHE](https://img.shields.io/badge/CACHE-noCACHE-%23fff?labelColor=%237D0&color=%23D01) :  
    - ![CACHE](https://img.shields.io/badge/CACHE-%23fff?color=%237D0) :  
       > Generiert und speichert mehrere Nummern im Voraus (Standard: 20)   
     - ![no-cache](https://img.shields.io/badge/noCACHE-%23fff?labelColor=%23a01&color=%23D02) :  
       > Erzeugt Nummern bei Bedarf ⇾ kann bei Systemfehlern sicherer sein   

---
> - ### Anwendung:
>
> ```sql
> create TABLE
>   ALLUSERS     -- : Tabellen-Name
>   ( --columns--datatypes----default-values-------------------unnamed-constraints
>      u_ID      NUMBER       DEFAULT allusers__u_ID.nextval,
>      u_Name    VARCHAR(30)                                   NOT NULL,
>     --named-constraints---------------------------------------------------------
>     CONSTRAINT PK_allUsers PRIMARY KEY (u_ID)
>   );
>   ```
>   
> - #### Pseudospalten:
>     `seq_name.NEXTVAL` -- Nächster Wert der Sequenz  
>     `seq_name.CURRVAL` -- Aktueller Wert der Sequenz

---
