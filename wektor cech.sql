create or replace function wektor_cech()
returns float8[] as '
sql<-paste("SELECT cases, deaths
FROM covid
where countriesandterritories = ''Poland''
order by cases", sep="")
rs <- pg.spi.exec(sql)
prco<-prcomp(rs, scale = FALSE)
prco[["rotation"]]
' language 'plr';

select * from wektor_cech();