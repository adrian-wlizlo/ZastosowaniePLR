------------------------------------------------------------test shapiro
CREATE OR REPLACE FUNCTION f_shapiro(text, text) RETURNS setof shapiro AS
'
sql<-paste("select ", arg1," from covid where countriesandterritories=''", arg2, "''", sep="")
rs <- pg.spi.exec(sql)
wartosc <- rs[,1]
wynik <- shapiro.test(wartosc)
ww<-wynik[1]
pp<-wynik[2]
return(data.frame(w = ww,p_value = pp))
'
LANGUAGE plr;

SELECT * from f_shapiro('deaths','Poland');