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

  - ### Löschen:
    ```sql
    drop SEQUENCE
      allusers__u_ID;
    ```

> - ### Anwendung:
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

---

> [!TIP]
> Beispiel-Fragen
> ![sequenzen-erstellen](./img/seg_q01.png)
> ![nextval-currval](./img/seg_q02.png)
> ![cache-option](./img/seg_q03.png)
> ![nocycle-hit-end](./img/seg_q04.png) 
> ![workaround](./img/seg_q05.png) 
