###### <div align="center"> Benutzer, Rollen, Berechtigungen & Synonyme </div>
>  <p align="center"> 👉🏼 𝕿𝔬𝖕 𝕾𝔢𝖈𝔯𝖊𝔱 👈🏼 <!--🖱️<sup><sub>click</sub></sup> --> </p>  

<!-- 
> [!WARNING]
> <details>  
>  <summary align="center"> 👉🏼 𝕿𝔬𝖕 𝕾𝔢𝖈𝔯𝖊𝔱 👈🏼 🖱️<sup><sub>click</sub></sup> </summary>  
>  ...
>  nothing here yet
>  ...
> </details>
-->
<!-- BENUTZER  -->

# **Ⅰ** ) <p align="center"> ***Benutzer*** </p>

## **Ⅰ** ***a*** ) *Erstellen*:
```sql
  create USER individualUser  -- User-Name: "individualUser"
      identified by userPw;   -- User-Passwort: "userPw"         
```

## **Ⅰ** ***b*** ) *Löschen*:
```sql
  drop USER individualUser    -- User-Name: "individualUser"
        cascade;              -- cascade - abhängige mitlöschen
```

---
<!-- ROLLEN -->
# **Ⅱ** ) <p align="center"> ***Rollen*** </p>
## **Ⅱ** ***a*** ) *Erstellen*:
```sql
  create ROLE specialRole;     -- Rollen-Name: "specialRole"
```
## **Ⅱ** ***b*** ) *Löschen*:
```sql
  drop ROLE specialRole;       -- Rollen-Name: "specialRole"
```
###### <p align="right"> Rollen können ihre Rechte nicht weitergeben </p>

---
# **Ⅲ** ) <p align="center"> ***Rechte*** </p> 
## **Ⅲ** ***a*** ) ***System***-*Privilegien vergeben*:
```sql
  grant 
    connect,                -- elaubt dem user das Verbinden    
    resource,               -- SYS-privileg
    unlimited tablespace,   -- SYS-privileg
    create table            -- SYS-privileg
      to individualSysUser    -- user dem die rechte gegeben werden
         with admin option;   -- bei Systemprivilegien wird die weitergabe damit erlaubt
```

## **Ⅲ** ***b*** ) ***Objekt***-*Privilegien vergeben*:
```sql
  grant 
    select,                     -- OBJ-privileg
    insert,                     -- OBJ-privileg
    update                      -- OBJ-privileg
      on ALLUSERS                 -- table auf den die rechte gegeben werden
      to individualClientUser     -- user (oder rolle) dem die rechte gegeben werden
        with grant option;        -- bei Objektprivilegien wird die weitergabe damit erlaubt
```

> #### **Ⅲ** ***c*** ) *"grant ALL"*:
> ```sql
> grant 
>   ALL                        -- OBJ-privileg - gleichbedeutend mit select, insert, update, merge
>     on ALLUSERS                 -- table auf den die rechte gegeben werden
>     to individualClientUser     -- user (oder rolle) dem die rechte gegeben werden
> ```

## **Ⅲ** ***d*** ) *Privilegien entziehen*:
```sql
  revoke                          -- REVOKE statement
    unlimited tablespace          -- das Recht welches entzogen werden soll
      from individualUser;        -- User oder Rolle die es verliert
```

---
# **Ⅳ** ) <p align="center"> ***Synonyme*** </p>  
  > - Synonyme sind Aliase für Objekte in der DB
  > - Dieses Objekte können Tabellen, Views oder andere Synonyme sein
  > - Diese Aliasa können anstelle der vollständigen Namen von Objekts verwenden werden

- ***Vorteile von Synonymen***:
  - **Vereinfachte Abfragen:** Komplexe oder lange Objektnamen können durch kürzere und aussagekräftigere Synonyme ersetzt werden
  - **Datenunabhängigkeit:** Änderungen am ursprünglichen Objektnamen haben keinen Einfluss auf Abfragen, solange das Synonym verwendet wird
  - **Zugriffsberechtigungen:** Synonyme können verwendet werden, um den Zugriff auf bestimmte Objekte zu kontrollieren (zB. öffentliche Synonyme für alle Benutzer)
  - **Verdeckung komplexer Strukturen:** Hinter einem einfachen Synonym kann sich eine komplexe View oder eine Verbindung zu einer anderen Datenbank verbergen

## **Ⅳ** ***a*** ) *Erstellen*:
```sql
CREATE
  [PUBLIC]                  -- jeder benutzer in der datenbank auf das snonym zugreifen
    SYNONYM synonym_name    -- name des synonyms
      FOR object_name       -- vollständige name des objekts, auf das das synonym verweisen soll (inklusive schema)
;
```

  > - *Beispiel:*
  >   ```sql
  >   CREATE PUBLIC SYNONYM alle_mitarbeiter FOR hr.employees;
  >   ```
  >   *Es wird ein öffentliches Synonym namens "alle_mitarbeiter" erstellt, das auf die Tabelle "employees" im Schema "hr" verweist*

## **Ⅳ** ***b*** ) *Verwendung von Synonymen*:
  - Synonyme werden in SQL-Anweisungen genauso verwendet wie die ursprünglichen Objektnamen:
    ```sql
    SELECT * FROM alle_mitarbeiter WHERE salary > 5000;
    ```

## **Ⅳ** ***c*** ) *Weitere Features und Überlegungen*:
  * **Private Synonyme:** ohne `PUBLIC` ist das Synonym nur für einen selbst sichtbar
  * **Synonyme für Objekte in anderen Schemata:** Synonyme können auch für Objekte in anderen Schemata erstellen, um den Zugriff zu vereinfachen
  * **Synonyme für Datenbanklinks:** Synonyme können verwendet werden, um auf Objekte in anderen Datenbanken zuzugreifen
  * **Synonyme und Performance:** Die Verwendung von Synonymen hat in der Regel keinen Einfluss auf die Performance der Abfragen

