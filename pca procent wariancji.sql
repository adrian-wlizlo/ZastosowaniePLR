create or replace function procent_wariancji()
returns float8[] as '
sql<-paste("SELECT cases, deaths
FROM covid
where countriesandterritories = ''Poland''
order by cases", sep="")
rs <- pg.spi.exec(sql)
prco<-prcomp(rs, scale = FALSE)
library(factoextra)
png("procent_wariancji.png")
fviz_eig(prco)
dev.off()
' language 'plr';

select * from procent_wariancji();