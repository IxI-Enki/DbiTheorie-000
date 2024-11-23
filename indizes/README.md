###### <div align="center"> Indizes, Performance & Szenarien </div>
 
> [!WARNING]
> <details>  
>  <summary align="center"> 👉🏼 𝕿𝔬𝖕 𝕾𝔢𝖈𝔯𝖊𝔱 👈🏼 🖱️<sup><sub>click</sub></sup> </summary>  
> 
> </details>

<!-- INDIZES -->
# **Ⅰ** ) 
# <p align="center"> ***Indizes*** </p>

Einführung
Indizes und Performance:
Indizes beschleunigen Abfragen, z. B. bei SELECT, UPDATE, DELETE.
Ohne Index wird ein Full Table Scan durchgeführt – ineffizient für große Tabellen.
Ein Index sorgt für sortierte Datenstrukturen und schnelleres Suchen.
Beispiele:
Ein Primary Key wird immer mit einem Index versehen.
Ein Foreign Key hingegen nicht automatisch, sollte jedoch manuell indiziert werden.
---
Index: Grundlagen und Analogien
Sortiertes Inhaltsverzeichnis:
Ein Index ähnelt dem Inhaltsverzeichnis eines Buches:
Statt das gesamte Buch zu durchsuchen, gibt der Index direkt die relevante Seitennummer
an.
Vergleich:
Papier-Telefonbuch:
Sortiert nach Ort, Nachname, Vorname.
Suche nach Vorname erfordert jedoch das Durchsuchen des gesamten
Telefonbuchs.
Ein Index verbessert Performance ähnlich einem Buchindex.
---
Index-Typen
1. B-Tree Index:
Standardindex mit binärer Suche.
Balanciert, um gleich schnelle Zugriffe zu ermöglichen.
2. Bitmap Index:
Geeignet für Spalten mit wenigen unterschiedlichen Werten (z. B. Geschlecht).
Ein Index-Eintrag zeigt auf mehrere Zeilen.
3. Funktionsbasierter Index:
Index auf einer berechneten Spalte oder Funktion, z. B. ABS(column).
4. Clustered Index:
Physisch sortierte Tabellenstruktur, oft in index-organisierten Tabellen verwendet.
5. Bitmap Join Index:
Index einer Tabelle auf Spalten einer anderen Tabelle, z. B. zum Verknüpfen von Fremdschlüsseln.
---
Inserts und Constraints
Performance von Inserts mit Index:
Bei jedem INSERT prüft die Datenbank, ob ein Datensatz mit dem gleichen Primary Key
existiert.
Ohne Index muss die gesamte Tabelle durchsucht werden.
Mit Index erfolgt die Prüfung wesentlich schneller.
Strategien für große Datenimporte:
Constraints deaktivieren:
Lade alle Daten ohne Überprüfung der Constraints.
Schalte die Constraints danach wieder ein.
Dies ist effizienter, da nicht jede Zeile einzeln geprüft wird.
Index deaktivieren:
Lade die Daten in die Tabelle, ohne den Index zu aktualisieren.
Aktiviere den Index erst nach dem Laden.
---
Updates und Indizes
Effekte von Indizes bei UPDATE:
Ein Update auf einer indizierten Spalte muss sowohl die Tabelle als auch den Index aktualisieren.
Schreiboperationen auf Spalten mit vielen Indizes sind daher langsamer.
Indizes lohnen sich vor allem bei häufigen Leseoperationen.
Taktik:
Vor Datenänderungen Indizes deaktivieren und anschließend wieder aktivieren, um Performance
zu steigern.
---
Sortierung und Platz
Sortierung in Tabellen:
Ohne Index sind Tabellen unsortiert.
Ein Index sorgt für eine logische Sortierung, physisch bleibt die Tabelle unsortiert.
Speicherplatz und Fragmentierung:
Variablenlängenfelder (z. B. VARCHAR) können mehr oder weniger Platz benötigen.
Lücken entstehen durch gelöschte oder geänderte Datensätze.
Effiziente Nutzung des Speicherplatzes hängt von der Datenstruktur ab
---
Abfrageoptimierung
Effizienz durch Index Only Scan:
Manche Abfragen können direkt über den Index beantwortet werden, ohne auf die Tabelle
zuzugreifen.
Beispiel: COUNT(*) auf einer indizierten Spalte.
Funktionsbasierte Indizes:
Nützlich bei Abfragen mit Funktionen wie ABS(column):
CREATE INDEX idx_abs_value ON table (ABS(column));
Verbessern die Performance bei komplexen Abfragen.
Probleme durch Funktionen:
Funktionen wie TO_NUMBER verhindern die Nutzung eines Index.
Lösung: Einen funktionsbasierten Index erstellen oder die Abfrage umschreiben.
---
Datenbanken ohne Indizes
Vollständige Tabellenscans:
Ohne Index werden bei jeder Abfrage alle Zeilen durchsucht.
Abfrageszenarien ohne Index:
Beispiel: Abfragen mit YEAR(date_column) zwingen die Datenbank zu einem Full Table Scan.
---
Indizes in Szenarien
Beispiele:
1. Update einer Tabelle mit einem Index:
Wenn auf eine indizierte Spalte zugegriffen wird, müssen auch alle Indizes aktualisiert werden.
Beispiel:
UPDATE employees SET lastname = 'Smithson' WHERE lastname = 'Smith';
2. Hinzufügen eines Index für seltene Abfragen:
Wenn eine Tabelle selten gelesen, aber oft beschrieben wird, ist die Abwägung wichtig.
Beispiel: Jahresbilanzprüfung, wo Abfragen schnell erfolgen sollen.
3. Index auf zusammengesetzten Schlüsseln:
Beispiel: Index auf (lastname, firstname). Die Suche nach lastname ist schnell, die Suche nur
nach firstname hingegen ineffizient.
---
Quiz
1. Indexes müssen manuell erstellt werden und beschleunigen nur Abfragen. Stimmt das?
a) True
b) False
Antwort: b) False. Indexes werden auch automatisch erstellt, z. B. für Primary Keys.
2. Welche Index-Typen sind besonders effizient für Spalten mit wenigen Werten?
a) B-Tree
b) Bitmap
Antwort: b) Bitmap.
3. Wann sollte ein Index NICHT erstellt werden?
a) Wenn die Tabelle viele Schreiboperationen hat.
b) Wenn die Tabelle hauptsächlich gelesen wird.
Antwort: a) Wenn die Tabelle viele Schreiboperationen hat.
---
