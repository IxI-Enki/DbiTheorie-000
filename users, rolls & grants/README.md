<!-- BENUTZER ERSTELLUNG -->

## 1.) Benutzer
  - ### Erstellen:
    ```sql
    create USER                 -- CREATE statement
        individualUser          -- User-Name: "individualUser"
        identified by userPw;   -- User-Passwort: "userPw"         
    ```
  - ### Löschen:
    ```sql
    drop USER                   -- DROP statement
        individualUser          -- User-Name: "individualUser"
          cascade;              -- cascade - abhängige mitlöschen
    ```

## 2.) Rollen
  - ### Erstellen:
    ```sql
    create ROLE                 -- CREATE statement  
        specialRole;            -- Rollen-Name: "specialRole"
    ```        
  - ### Löschen:
    ```sql
    drop ROLE                   -- DROP statement
        specialRole;            -- Rollen-Name: "specialRole"
    ```
  > ROLLEN KÖNNEN IHRE BERECHTIGUNGEN NICHT WEITERGEBEN!

---

## 3.) Rechte  
  - ### System-Privilegien vergeben:
    ```sql
    grant 
      connect,                -- elaubt dem user das Verbinden    
      resource,               -- SYS-privileg
      unlimited tablespace,   -- SYS-privileg
      create table            -- SYS-privileg
        to individualSysUser    -- user dem die rechte gegeben werden
           with admin option;   -- bei Systemprivilegien wird die weitergabe damit erlaubt
    ```

  - ### Objekt-Privilegien vergeben:
    ```sql
    grant 
      select,                     -- OBJ-privileg
      insert,                     -- OBJ-privileg
      update                      -- OBJ-privileg
        on ALLUSERS                 -- table auf den die rechte gegeben werden
        to individualClientUser     -- user (oder rolle) dem die rechte gegeben werden
          with grant option;        -- bei Objektprivilegien wird die weitergabe damit erlaubt
    ```

    > - "grant ALL" :
    >   ```sql
    >   grant 
    >     ALL                        -- OBJ-privileg - gleichbedeutend mit select, insert, update, merge
    >       on ALLUSERS                 -- table auf den die rechte gegeben werden
    >       to individualClientUser     -- user (oder rolle) dem die rechte gegeben werden
    >   ```

  - ### Privilegien entziehen:
    ```sql
    revoke                          -- REVOKE statement
      unlimited tablespace          -- das Recht welches entzogen werden soll
        from individualUser;        -- User oder Rolle die es verliert
    ```

