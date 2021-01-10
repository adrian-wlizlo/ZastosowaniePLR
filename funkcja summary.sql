-----------------------------------------------funkcja summary
create or replace function summary(text, text)
returns SETOF summarytab as '
sql<-paste("select ", arg1, " from covid where countriesandterritories=''", arg2, "''", sep="")
rs <- pg.spi.exec(sql)
rng <- range(rs[,1])

quan <-quantile(rs[,1])
names(quan) <- c()

return(data.frame(panstwo = arg2, srednia = mean(rs[,1]),
odchylenie_standardowe = sd(rs[,1]), minimum = rng[1], maksimum = rng[2],
zakres = rng[2] - rng[1], liczba_danych = length(rs[,1]), kwartyl25 = quan[2], kwartyl75 = quan[4]))
' language 'plr';

select * from summary('cases','Poland');
select * from summary('deaths','Poland');