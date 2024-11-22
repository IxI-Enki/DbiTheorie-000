<!-- SEQUENCES ERSTELLUNG -->

## 1.) Sequenzen
  - ### Erstellen:
    ```sql
    create SEQUENCE                
      allusers__u_ID        -- : name der sequenz
        start with 1          -- : startwert
        maxvalue 100000       -- : maxwert
        minvalue 0            -- : minwert
        increment by 1        -- : stepsize             /  DECREMENT
        nocache               -- :                      /  CACHE -- : 
        nocycle               -- : keine wiederholung   /  CYCLE -- : wiederholung der sequenz
    ;
    ```
    #### Wichtige *Parameter* und *Optionen*
    
    - `INCREMENT BY`:  
      > Gibt die Schrittweite an  
      > ###### Standardwert: 1 (auch negative Werte möglich)  
    - `START WITH`:  
      > Definiert den Startwert der Sequenz  
      > ###### Standardwert:  *1 ⇾ aufsteigenden* Sequenzen    
      > ###### Standardwert: *-1 ⇾ absteigenden* Sequenzen     
    - `MINVALUE` / `MAXVALUE`:  
      > Legt die minimalen und maximalen Werte fest  
      - `NOMAXVALUE`:  
        > Zähler läuft bis zum technischen Limit [10²⁷ - bei aufsteigenden Sequenzen]     
      - `NOMINVALUE`:  
        > ###### Mindestwert: *1 ⇾ aufsteigenden* Sequenzen   
        > ###### Mindestwert: *-10²⁶ ⇾ absteigende* Sequenzen       
    - `CYCLE` / `NOCYCLE`:  
      - `CYCLE`:  
        > ###### Neustart ⇾ wenn Höchstwert erreicht   
      - `NOCYCLE`:  
        > ###### Fehler ⇾ wenn Höchstwert erreicht   
    - `ORDER` / `NOORDER`:  
      - `ORDER`:  
        > ###### garantiert die Reihenfolge, jedoch keine lückenlose Nummerierung   
    - `CACHE` / `NOCACHE`:  
      - `CACHE`:  
        > ###### Generiert und speichert mehrere Nummern im Voraus (Standard: 20)   
      - `NOCACHE`:  
        > ###### Erzeugt Nummern bei Bedarf ⇾ kann bei Systemfehlern sicherer sein   

  - ### Löschen:
    ```sql
    drop SEQUENCE
      allusers__u_ID;
    ```

> - ### Anwendung:
>
>   ```sql
>   create TABLE
>     ALLUSERS     -- : Tabellen-Name
>     ( --columns--datatypes----default-values-------------------unnamed-constraints
>        u_ID      NUMBER       DEFAULT allusers__u_ID.nextval,
>        u_Name    VARCHAR(30)                                   NOT NULL,
>       --named-constraints---------------------------------------------------------
>       CONSTRAINT PK_allUsers PRIMARY KEY (u_ID)
>     );
>   ```
>   
> - #### Pseudospalten:
>   ```sql
>   seq_name.NEXTVAL: Nächster Wert der Sequenz.
>   seq_name.CURRVAL: Aktueller Wert der Sequenz.
>   ```

---

> [!WARNING]
> <details>  
>  <summary> 𝕿𝔬𝖕 𝕾𝔢𝖈𝔯𝖊𝔱 </summary>  
>  
> ![sequenzen-erstellen](./img/seq_q01.png)
> ![nextval-currval](./img/seq_q02.png)
> ![cache-option](./img/seq_q03.png)
> ![nocycle-hit-end](./img/seq_q04.png) 
> ![workaround](./img/seq_q05.png)
> 
> </details>
