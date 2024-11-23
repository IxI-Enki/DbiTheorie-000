###### <div align="center"> Laufzeitkomplexität </div>

> [!WARNING]
> <details>
>  <summary align="center"> 👉🏼 𝕿𝔬𝖕 𝕾𝔢𝖈𝔯𝖊𝔱 👈🏼 🖱️<sup><sub color="red">click</sub></sup> </summary>
>
> .. nothing here yet ..
>
> </details>

<!-- LAUFZEIT KOMPLEXITÄT -->

# **Ⅰ** )  <p align="center"> ***Laufzeitkomplexität*** </p> 
   - *beschreibt, wie lange ein eine SQL-Abfrage im Verhältnis zur Größe der Eingabedaten läuft*  
   - *Je schneller die Laufzeit im Verhältnis zur Eingabedatenmenge wächst, desto komplexer ist der Algorithmus*

<div align="center">
  <img src="./img/komplexitätsklassen.png" align="center" height="300" width="300"> 
</div>

---    
## **Ⅰ** ***a*** ) *Warum ist Laufzeitkomplexität wichtig?*
   - **Performance**:
     > Eine Abfrage mit hoher Laufzeitkomplexität kann bei großen Datenmengen sehr lange dauern oder zu einem Absturz führen
   - **Skalierbarkeit**:
     > Wenn die Datenmenge wächst, sollten Abfrage idealerweise nicht proportional langsamer werden
   - **Ressourcenverbrauch**:
     > Langsame Abfragen verbrauchen mehr Serverressourcen (CPU, Speicher) und können andere Benutzer beeinträchtigen

---
# **Ⅱ** ) *Beispiele* von Laufzeitkomplexitäten

   - ##  <p color="#00AA49">𝒪<sub>(1)</sub> : </p>  <p align="center">  ![Static Badge](https://img.shields.io/badge/konstante_Zeit%2FKomplexit%C3%A4t_%3A-_die_Laufzeit_h%C3%A4ngt_nicht_von_der_Datenmenge_ab-%23fff?style=for-the-badge&labelColor=%23042&color=%23021)  </p> 

<!---
        <div color="#00AA49">
           
        ***konstante Zeit/Komplexität :***  *die Laufzeit hängt nicht von der Datenmenge ab* 
        </div>
-->
   - ***Beispiel 1***:
       > Eine Abfrage, die nur die erste Zeile einer Tabelle ausgibt
       > ```sql
       > SELECT * FROM customers WHERE customer_id = 123;
       > ```
   - ***Beispiel 2***:
       > Zählen aller Zeilen in einer Tabelle mit einem Index auf der gesamten Tabelle
       > ```sql
       > SELECT COUNT(*) FROM customers;
       > ```

---
   - ## <p color="#00A217">𝒪<sub>(n)</sub> : </p>   <p align="center"> ![Static Badge](https://img.shields.io/badge/lineare_Komplexit%C3%A4t_%3A-_die_Laufzeit_ist_proportional_zur_Datenmenge-%23fff?style=for-the-badge&labelColor=%23152&color=%23140) </p> 

<!---
        <div color="#00A217">
           
        ***lineare Komplexität***: die Laufzeit ist propertional zur Datenmenge
        </div>
--> 
   - ***Beispiel 1***:
     > Eine Abfrage, die jede Zeile einer Tabelle durchläuft
     > ```sql
     > SELECT * FROM orders;
     > ```
   - ***Beispiel 2***:
     > Berechnung einer Summe über alle Werte einer Spalte
     > ```sql
     > SELECT SUM(amount) FROM orders;
     > ```

---
   - ## <p color="#DFDD00">𝒪<sub>(n²)</sub> : </p>  <p align="center">  ![Static Badge](https://img.shields.io/badge/quadratische_Komplexit%C3%A4t_%3A-_die_Laufzeit_w%C3%A4chst_quadratisch_mit_der_Datenmenge-%23fff?style=for-the-badge&labelColor=%23A80&color=%23840) </p> 
<!--
       <div color="#DFDD00">
           
        ***quadratische Komplexität***: die Laufzeit wächst quadratisch mit der Datenmenge
        </div>
-->  
   - ***Beispiel 1***:
     > Verschachtelte Schleifen (vereinfacht, in der Praxis oft ineffizient)
     > ```sql
     > SELECT * FROM customers c1, customers c2
     > WHERE c1.city = c2.city;
     > ```
   - ***Beispiel 2***:
     > Berechnung aller möglichen Kombinationen ohne Indizes
     > ```sql
     > SELECT * FROM products, colors;
     > ```    	
     
---
   - ## <p color="#01EE33">𝒪<sub>(log n)</sub> : </p> <p align="center">  ![Static Badge](https://img.shields.io/badge/logarithmische_Komplexit%C3%A4t_%3A-_die_Laufzeit_w%C3%A4chst_logarithmisch_mit_der_Datenmenge-%23fff?style=for-the-badge&labelColor=%23095&color=%23053) </p> 
<!--
        <div color="#01EE33">

        ***logarithmische Komplexität***: die Laufzeit wächst logarithmisch mit der Datenmenge
        </div>
-->       
   - ***Beispiel***:
     > Binäre Suche auf einem sortierten Index (vereinfacht)
     > ```sql
     > -- Annahme: Ein Index auf customer_name ist vorhanden und sortiert
     > SELECT * FROM customers
     > WHERE customer_name >= 'Mustermann'
     > ORDER BY customer_name
     > FETCH FIRST 1 ROW ONLY;
     > ```
         
---
   - ## <p color="#AAFF00">𝒪<sub>(n log n)</sub> : </p>  <p align="center"> ![Static Badge](https://img.shields.io/badge/superlineare_Komplexit%C3%A4t_%3A-_liegt_zwischen_%F0%9D%92%AA(n)_und_%F0%9D%92%AA(n%C2%B2)-%23fff?style=for-the-badge&labelColor=%239A2&color=%23481) </p> 
   <!--
       <div color="#AAFF00">
       ***superlineare Komplexität***: *liegt zwischen 𝒪(n) und 𝒪(n²)*
       </div>
   -->       
   - ***Beispiel***:
     > Optimierte Sortieralgorithmen wie Quicksort
     > ```sql
     > SELECT * FROM customers ORDER BY last_name;
     > ```

---
   - ## <p color="#EE4400">𝒪<sub>(2ⁿ)</sub> : </p> <p align="center">  ![Static Badge](https://img.shields.io/badge/exponentielle_Komplexit%C3%A4t_%3A-_die_Laufzeit_verdoppelt_sich%2C_wenn_die_Datenmenge_um_eine_Einheit_gr%C3%B6%C3%9Fer_wird-%23fff?style=for-the-badge&labelColor=%23B10&color=%23610) </p> 
<!---
        <div color="#EE4400">
       
       ***exponentielle Komplexität***: die Laufzeit verdoppelt sich, wenn die Datenmenge um eine Einheit größer wird
        </div>
-->        
   - *Beispiel*:
     > Bilden aller Paare einer Menge, Türme von Hanoi als rekursiver Algorithmus
 
---
   - ## <p color="#990000">𝒪<sub>(n!)</sub> : </p> <p align="center"> ![Static Badge](https://img.shields.io/badge/faktorielle_Komplexit%C3%A4t_%3A-_die_Laufzeit_w%C3%A4chst_mit_der_Fakult%C3%A4t_der_Datenmenge-%23fff?style=for-the-badge&labelColor=%23500&color=%23200) </p>
<!---
        <div color="#990000">
   
       ***faktorielle Komplexität***: die Laufzeit wächst mit der Fakultät der Datenmenge
        </div> 
-->     
   - *Beispiel*:
     > Problem des Handlungsreisenden 

---

<div align="center">
<p align="center"><sup><sub> made by </sub></sup></p> 
 į̣̬̺͇̞̥̥̺̝̤̝̠̮̫͚̟̳̞̣̠͇͜͟x̢̝̗͙̖͚̣͍̹̱͍̠̥̲̭͙̬̳͎̝̞̯̣͓̼̘̜̪͟ͅi̧̧̨̢̧̨̡̢̻̥̮͇̭̗͓̻͔͇̭̜͕͕̱͖̪̣̫̥͓͕̫̝̗̬̹̯̮̟͓͓̻̱͓͈͉̳̜̳̞͚͍͢ͅ-̢̡͈̼̳͎͎̤̦̟̮̭̠̯̤̱̟͔̺̖̙͚̘̮̜̭̼͙͚̣̗̙͉͙̞͓̦̞̫͜͢ͅͅE̢̧̡̡̥͔̱̥̙͍̖͓̜̟̻͍̼̞̜͔̦̬͉̦̙͙̫̺̙̗̗͉̣̠̫͕̬̱̮͎̰̻̩̘͍̫̙͎̱͕͈͇̤̩͈̟͓͕̤̝̖͟͢n̨̧̢̧̡̡̧̦̣̬̤͕̯̼͉̦̰̭̬̜͎̬͇̦͖͔̥̞͍͔̜̫̣͍̥͇͎̼͉͍͖͙̬͎̪̮̭͕͢ͅͅk̡̡̧̢̜͚̹̩̰͍̘̝̘͎̮̭̠͖̻̖͉̫̲̗̯̜͕̙͚̞̜̮̞̰̪͖͇̯̟͍̤̪̥͈̠̗̣̝̤̜̬̻̩͖̺̣̞͟͜͢͟͢ͅi̡̭̦̣͉͔̟̱̲̤̠̱̬͎͈̪̮̗̫̻̰̥͓̭̟͜͢

</div>
