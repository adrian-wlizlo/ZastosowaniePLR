------------------------------------------------histogram zapisany do png
create or replace function hist(text, text)
returns setof hist as '
sql<-paste("select sum(", arg1, "), month from covid where countriesandterritories=''", arg2, "''group by month order by month ASC", sep="")
rs <- pg.spi.exec(sql)
png("myhist.png");
barplot(rs[,1],
main = "Laczne ilosci przypadkow w miesiacach",
xlab = "Lacznie nowych przypadkow",
ylab = "miesiac",
xlim=c(0,300000),
names.arg = c("Marzec", "Kwiecien", "Maj", "Czerwiec", "Lipiec","Sierpien","Wrzesien","Pazdziernik","Listopad"),
col = "darkred",
horiz = TRUE)

dev.off()
return(data.frame(miesiac = rs[,2],dane=rs[,1]))
' language 'plr';

select * from hist('cases','Poland');
-----------------------------------------------------plot zapisany do png
CREATE OR REPLACE FUNCTION f_graph(text, text) RETURNS setof void AS
'
sql<-paste("select daterep,",arg1 ," from covid where countriesandterritories=''", arg2, "'' order by daterep ASC", sep="")
rs <- pg.spi.exec(sql)

png("myplot.png")
plot(rs[,2],xlab=arg2,ylab="nowe przypadki",type="l",col="blue")
dev.off()

'
LANGUAGE plr;

SELECT * from f_graph('cases','Poland');
-----------------------------------------------------plot zapisany do png dla miesiaca
CREATE OR REPLACE FUNCTION f_graph(text, text, text) RETURNS setof void AS
'
sql<-paste("select day,",arg1 ," from covid where countriesandterritories=''", arg3, "'' and month=''", arg2, "''order by day ASC", sep="")
rs <- pg.spi.exec(sql)
xopis<-paste("miesiac", arg2)

png("myplot2.png")
plot(rs[,1],rs[,2],xlab=xopis,ylab="nowe przypadki",type="l",col="blue")
dev.off()

'
LANGUAGE plr;

SELECT * from f_graph('cases','11','Poland');