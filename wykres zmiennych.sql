create or replace function wykres_zmiennych()
returns float8[] as '
sql<-paste("SELECT cases, deaths 
FROM covid
where countriesandterritories = ''Poland''
order by cases", sep="")
rs <- pg.spi.exec(sql)
prco<-prcomp(rs, scale = FALSE)
library(factoextra)
png("wykres_zmiennych.png")
fviz_pca_var(prco,
col.var = "contrib",
gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
repel = TRUE
)
dev.off()
' language 'plr';

select * from wykres_zmiennych();