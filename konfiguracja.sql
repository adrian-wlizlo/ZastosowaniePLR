---------------------------------------------------Załadowanie funkcjonalności PL/R
CREATE EXTENSION plr
---------------------------------------------------Lokalizacja zapisywania plików na serwerze
SHOW data_directory;
---------------------------------------------------Lokalizacja ścierzek języka PL/R w tym lokalizacji biblioteki
SELECT * FROM plr_environ();

---------------------------------------------------Sprawdzenie czy PL/R działa poprawnie
CREATE OR REPLACE FUNCTION plr_array (text, text)
RETURNS text[] AS '
$libdir/plr','
plr_array
' LANGUAGE C WITH (isstrict);

select plr_array('hello','world');