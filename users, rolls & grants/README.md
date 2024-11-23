###### <div align="center"> Benutzer, Rollen & Berechtigungen </div>
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
