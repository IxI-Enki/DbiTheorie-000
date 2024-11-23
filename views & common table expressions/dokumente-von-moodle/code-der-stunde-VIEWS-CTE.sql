/*  ---------- VIEWS ---------- */

-- Views sind am DB-Server gespeicherte Abfragen, die wie normale Tabellen
-- verwendet werden können (SELECT ... FROM my_view, JOIN my_view, ...)
-- Sie enthalten allerdings selbst keine Daten, bei jeder Verwendung wird
-- die dahinterstehende Query erneut ausgeführt.
-- So gesehen handelt es sich bei einem View um eine unter Namen gespeicherte Sub-Query.

-- Sie dienen:
-- Als Abstraktionsebene im 3-Ebenen Modell (externes Schema, jede Applikation sieht nur was sie darf, Änderungen am internen/konzeptionellen Schema werden über Views von der Applikation verborgen)
-- Zur Berechtigungsverwaltung, für User welche nicht alle Daten sehen dürfen gibts keine Berechtigung auf die eigentliche Tabelle, sondern nur auf den View der die "erlaubten" Daten enthält.
-- Zur Vereinfachung von komplexen oder wiederkehrenden Queries (teile und herrsche)

-- Beispiel, alle Mitarbeiter die weniger als 3000 verdienen:
CREATE /*OR REPLACE*/ VIEW emp_sal_under_3000 AS --replace ist optional, ersetzt ev. schon vorhandenen View
    SELECT * FROM emp WHERE sal < 3000

-- Per default ist ein View bei Oracle schreibbar, sofern die dahinterstehende Query einfach ist (keine Joins, keine Group-By, etc).
-- Dabei landen die Daten direkt in der dahinterliegenden Tabelle:
INSERT INTO emp_sal_under_3000 VALUES (8888, 'GEHARD', 'CLERK', NULL, NULL, 1000, NULL, 20); 
INSERT INTO emp_sal_under_3000 VALUES (6666, 'HUGO', 'CLERK', NULL, NULL, 5000, NULL, 20);
SELECT * FROM emp_sal_under_3000; -- Hugo nicht in emp_sal_under_3000, aber
SELECT * FROM emp; -- dennoch gespeichert in emp
ROLLBACK;

-- Mit WITH READ ONLY kann das unterbunden werden:
CREATE /*OR REPLACE*/ VIEW emp_sal_under_3000 AS
    SELECT * FROM emp WHERE sal < 3000
WITH READ ONLY CONSTRAINT sal_under_3000_ro; -- erzeugt einen nur-lesbaren View


--mit WITH CHECK OPTION wird das DBMS angewiesen, nur Daten einfügen zu lassen, die der WHERE-Bedingnug des Views entsprechen
CREATE /*OR REPLACE*/ VIEW emp_sal_under_3000 AS
    SELECT * FROM emp WHERE sal < 3000
WITH CHECK OPTION CONSTRAINT check_sal_lower_3000 


-- Bei Views handelt es sich um ganz normale DD-Objekte, daher können Views mit DROP wieder gelöscht werden:
DROP VIEW emp_sal_under_3000;


/*  ---------- CTEs - Common Table Expressions ---------- */
-- CTEs sind vergleichbar mit Views, sie werden allerdings nicht im DD-Objekt gespeichert
-- sondern dienen nur der Vereinfachung/Aufsplittung von komplexen Queries.
-- Eine CTE ist im Grunde eine SubQuery mit Namen, die zu Beginn angegeben wird (statt zum Zeitpunkt der Verwendung, wie bei einem normalen Sub-Query).
-- Genau wie ein View bzw. eine Sub-Query kann ein CTE ge-joined oder per FROM ausgelesen werden.

-- Alle Mitarbeiter samt dem Durchschnittsgehalt ihrer Abteilung

-- Beispiel mit "normaler" Sub-Query: 
SELECT e.* FROM emp e 
    JOIN (SELECT s.deptno, ROUND(AVG(s.sal)) FROM emp s GROUP BY s.deptno) avgsal 
    ON (e.deptno = avgsal.deptno);

-- Mit CTE:
WITH -- WITH kündigt die Verwendung von CTEs
    avgsal AS (SELECT s.deptno, ROUND(AVG(s.sal)) FROM emp s GROUP BY s.deptno) -- gefolgt von dem CTE-Namen sowie dem SQL der CTE-Subquery
SELECT e.*, avgsal.*, maxsal.* FROM emp e 
    JOIN avgsal ON (e.deptno = avgsal.deptno);

-- Auch mehrere CTEs sind möglich, dann durch Beistrich getrennt:
WITH 
    avgsal AS (SELECT s.deptno, ROUND(AVG(s.sal)) FROM emp s GROUP BY s.deptno),
    maxsal AS (SELECT s.deptno, ROUND(MAX(s.sal)) FROM emp s GROUP BY s.deptno)
SELECT e.*, avgsal.*, maxsal.* FROM emp e 
    JOIN avgsal ON (e.deptno = avgsal.deptno)
    JOIN maxsal ON (e.deptno = maxsal.deptno);


-- Hirarchische Abfragen mittels rekursiver CTEs.
-- Hirarchien mit fixer / bekannter maximal-Tiefe können mittels JOINs abgefragt werden
-- wobei jede Ebene über einen weiteren JOIN hinzugefügt wird:

--Z.b: zu jedem Mitarbeiter seinen Manager:
SELECT e.*, emgr.ename FROM emp e JOIN emp emgr ON (e.mgr = emgr.empno);

-- mitarbeiter + manager + manager von manager:
SELECT e.*, emgr.ename, emgr2.ename FROM emp e JOIN emp emgr ON (e.mgr = emgr.empno) JOIN emp emgr2 ON (emgr.mgr = emgr2.empno) ;

-- ist die Tiefe der Hirarchie allerdings nicht im Voraus bekannt, so ist die Lösung mit JOINs nicht praktikabel.
-- Stattdessen ist dieses Problem mittels rekursivem Auslesen von CTEs möglich.
-- Im Gegensatz zum üblicherweise sehr sauberen Sprachdesign von SQL, merkt man diesem Sprachkonstrukt an,
-- dass es nachträglich hinzugefügt wurde. In gewisser Weise erweitert es die deklarative Sprache SQL um ein imperatives Konstrukt.

-- Beispiel: alle Vorgesetzten von Mitarbeiter 'JAMES'.
-- emphir (empno, ename, mgr): CTE mit den Ergebnisspalten empno, ename, mgr
-- Bei Views und CTE ist die Angabe der Ergebnisspalten optional, bei rekursiven CTEs verpflichtend.
WITH emphir (empno, ename, mgr) AS (
    SELECT e.empno, e.ename, e.mgr FROM emp e WHERE e.ename='JAMES' -- 1.)
    UNION ALL
    SELECT e2.empno, e2.ename, e2.mgr FROM emp e2 JOIN emphir h ON (e2.empno = h.mgr) -- 2.)
)
SELECT * FROM emphir;

-- ad 1.) Anker-Query, diese wird als erstes ausgeführt
-- ad 2.) Query welche immer wieder rekursiv ausgeführt wird.
-- JOIN emphir h: der CTE selektiert / joined sich selbst. Dabei hat Sie über emphir Zugriff auf das Ergebnis der letzten Ausführung.
-- die Rekursion wird fortgesetzt, bis die 2. Query kein Ergebnis mehr liefert.

