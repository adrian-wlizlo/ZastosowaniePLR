--------------------------------------------------tablica summarytab
CREATE TABLE summarytab (
	panstwo varchar(100),
    srednia double precision,
    odchylenie_standardowe double precision,
    minimum double precision,
	maksimum double precision,
	zakres double precision,
	liczba_danych double precision,
	kwartyl25 double precision,
	kwartyl75 double precision
);
--------------------------------------------------tablica covid
CREATE  TABLE  covid(
	dateRep date,
	day integer,
	month integer,
	year integer,
	cases integer,
	deaths integer,
	countriesAndTerritories varchar(100),
	geoId varchar(2),
	countryterritoryCode varchar(7),
	popData2019 integer,
	continentExp varchar(50),
	Cumulative_number_for_14_days_of_COVID_19_cases_per_100000 double
);
------------------------------------------------tabela histtup
CREATE TABLE hist (
	miesiąc double precision,
    dane integer
);
------------------------------------------------tabela shapiro
create table shapiro(
w double precision,
p_value double precision
);
