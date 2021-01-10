--------------------------------------------------funkcja agregujaca kwartyle
CREATE OR REPLACE FUNCTION r_quantile(float8[])
RETURNS float8[] AS '
quantile(arg1, probs = seq(0.25, 0.75, 0.25),
names = FALSE)
' LANGUAGE 'plr';
CREATE AGGREGATE quantile (
sfunc = plr_array_accum,
basetype = float8,
stype = float8[],
finalfunc = r_quantile
);

SELECT countriesandterritories, quantile(cases) as kwartyl_25_50_75
FROM covid
WHERE countriesandterritories = 'Poland'
GROUP BY countriesandterritories;
------------------------------------------------funkcja agregujaca srednia
CREATE OR REPLACE FUNCTION r_mean(float8[])
RETURNS float8[] AS '
mean(arg1)
' LANGUAGE 'plr';
CREATE AGGREGATE mean (
sfunc = plr_array_accum,
basetype = float8,
stype = float8[],
finalfunc = r_mean
);

SELECT countriesandterritories, mean(cases) as srednia
FROM covid
WHERE countriesandterritories = 'Poland'
GROUP BY countriesandterritories;
--------------------------------------------------funkcja agregujaca wariancja
CREATE OR REPLACE FUNCTION r_var(float8[])
RETURNS float8[] AS '
var(arg1)
' LANGUAGE 'plr';
CREATE AGGREGATE var (
sfunc = plr_array_accum,
basetype = float8,
stype = float8[],
finalfunc = r_var
);

SELECT countriesandterritories, var(cases) as wariancja
FROM covid
WHERE countriesandterritories = 'Poland'
GROUP BY countriesandterritories;
--------------------------------------------------funkcja agregujaca odchylenie standardowe
CREATE OR REPLACE FUNCTION r_sd(float8[])
RETURNS float8[] AS '
sd(arg1)
' LANGUAGE 'plr';
CREATE AGGREGATE sd (
sfunc = plr_array_accum,
basetype = float8,
stype = float8[],
finalfunc = r_sd
);

SELECT countriesandterritories, sd(cases) as odchylenie
FROM covid
WHERE countriesandterritories = 'Poland'
GROUP BY countriesandterritories;
--------------------------------------------------funkcja agregujaca mediane
CREATE OR REPLACE FUNCTION r_median(float8[])
RETURNS float8[] AS '
median(arg1)
' LANGUAGE 'plr';
CREATE AGGREGATE median (
sfunc = plr_array_accum,
basetype = float8,
stype = float8[],
finalfunc = r_median
);

SELECT countriesandterritories, median(cases) as mediana
FROM covid
WHERE countriesandterritories = 'Poland'
GROUP BY countriesandterritories;
--------------------------------------------------funkcja agregujaca minimum
CREATE OR REPLACE FUNCTION r_min(float8[])
RETURNS float8[] AS '
min(arg1)
' LANGUAGE 'plr';
CREATE AGGREGATE min (
sfunc = plr_array_accum,
basetype = float8,
stype = float8[],
finalfunc = r_min
);

SELECT countriesandterritories, min(cases) as minimum
FROM covid
WHERE countriesandterritories = 'Poland'
GROUP BY countriesandterritories;
--------------------------------------------------funkcja agregujaca maksimum
CREATE OR REPLACE FUNCTION r_max(float8[])
RETURNS float8[] AS '
max(arg1)
' LANGUAGE 'plr';
CREATE AGGREGATE max (
sfunc = plr_array_accum,
basetype = float8,
stype = float8[],
finalfunc = r_max
);

SELECT countriesandterritories, max(cases) as maksimum
FROM covid
WHERE countriesandterritories = 'Poland'
GROUP BY countriesandterritories;
--------------------------------------------------funkcja agregujaca zakres
CREATE OR REPLACE FUNCTION ranged(float8[],float8[])
RETURNS float8[] AS '
rng <- range(arg1)
zakres = rng[2] - rng[1]
zakres
' LANGUAGE 'plr';
CREATE AGGREGATE range (
sfunc = plr_array_accum,
basetype = float8,
stype = float8[],
finalfunc = r_range
);

SELECT countriesandterritories, range(cases) as zakres
FROM covid
WHERE countriesandterritories = 'Poland'
GROUP BY countriesandterritories;
--------------------------------------------------funkcja agregujaca liczba danych
CREATE OR REPLACE FUNCTION r_length(float8[])
RETURNS float8[] AS '
length(arg1)
' LANGUAGE 'plr';
CREATE AGGREGATE length (
sfunc = plr_array_accum,
basetype = float8,
stype = float8[],
finalfunc = r_length
);

SELECT countriesandterritories, length(cases) as liczba_danych
FROM covid
WHERE countriesandterritories = 'Poland'
GROUP BY countriesandterritories;
--------------------------------------------------funkcja agregujaca rozstęp międzykwartylowy
CREATE OR REPLACE FUNCTION r_iqr(float8[])
RETURNS float8[] AS '
IQR(arg1)
' LANGUAGE 'plr';
CREATE AGGREGATE iqr (
sfunc = plr_array_accum,
basetype = float8,
stype = float8[],
finalfunc = r_iqr
);

SELECT countriesandterritories, iqr(cases) as rozstęp_międzykwartylowy
FROM covid
WHERE countriesandterritories = 'Poland'
GROUP BY countriesandterritories;
--------------------------------------------------funkcja agregujaca sume
CREATE OR REPLACE FUNCTION r_sum(float8[])
RETURNS float8[] AS '
sum(arg1,na.rm=TRUE)
' LANGUAGE 'plr';
CREATE AGGREGATE sum (
sfunc = plr_array_accum,
basetype = float8,
stype = float8[],
finalfunc = r_sum
);

SELECT countriesandterritories, sum(cases) as suma
FROM covid
WHERE countriesandterritories = 'Poland'
GROUP BY countriesandterritories;
------------------------------------------------zapytania
---------------------------------zapytanie dla każdego z państw
SELECT countriesandterritories as panstwo, 
quantile(cases) as kwartyl_25_50_75, 
mean(cases) as srednia,
var(cases) as wariancja,
sd(cases) as odchylenie,
median(cases) as mediana,
min(cases) as minimum,
max(cases) as maksimum,
range(cases) as zakres_od_do,
length(cases) as liczba_danych,
iqr(cases) as rozstęp_międzykwartylowy,
sum(cases) as suma
FROM covid
GROUP BY countriesandterritories
ORDER BY countriesandterritories;
---------------------------------zapytanie dla jednego kraju 'Polska'
SELECT countriesandterritories as państwo, 
quantile(cases) as kwartyl_25_50_75, 
mean(cases) as średnia,
var(cases) as wariancja,
sd(cases) as odchylenie,
median(cases) as mediana,
min(cases) as minimum,
max(cases) as maksimum,
range(cases) as zakres,
length(cases) as liczba_danych,
iqr(cases) as rozstęp_międzykwartylowy,
sum(cases) as suma
FROM covid
WHERE countriesandterritories = 'Poland'
GROUP BY countriesandterritories;