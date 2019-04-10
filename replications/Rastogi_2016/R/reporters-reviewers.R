rm(list=ls())
source(file="connectTodb.R")

query="select * from reviewers_analysis"
rev<-dbGetQuery(con,query)

query="select * from reporter_analysis"
repo<-dbGetQuery(con,query)

rm(con,query)

rev$user_id=as.factor(rev$user_id)
repo$user_id=as.factor(repo$user_id)

rev$type="rev"
repo$type="rep"

par(mfrow=c(1,5))
reporev<-rbind(cbind(rev,type="1"),cbind(repo,type="2"))
boxplot(O~type,data=reporev,notch=T,outline=F,xlab="O")
boxplot(C~type,data=reporev,notch=T,outline=F,xlab="C")
boxplot(E~type,data=reporev,notch=T,outline=F,xlab="E")
boxplot(A~type,data=reporev,notch=T,outline=F,xlab="A")
boxplot(N~type,data=reporev,notch=T,outline=F,xlab="N")

#calcolo la media dei campioni
mean(repo$O)
mean(rev$O)
mean(repo$C)
mean(rev$C)
mean(repo$E)
mean(rev$E)
mean(repo$A)
mean(rev$A)
mean(repo$N)
mean(rev$N)

#calcolo la deviazione standard dei campioni
sd(repo$O)
sd(rev$O)
sd(repo$C)
sd(rev$C)
sd(repo$E)
sd(rev$E)
sd(repo$A)
sd(rev$A)
sd(repo$N)
sd(rev$N)


#eseguo il t-test per valori appaiati
t.test(repo$O,rev$O,paired=T)
t.test(repo$C,rev$C,paired=T)
t.test(repo$E,rev$E,paired=T)
t.test(repo$A,rev$A,paired=T)
t.test(repo$N,rev$N,paired=T)

#calcolo la d di Cohen per calcolare la differenza standardizzata fra le due medie campionarie
library(lsr)
cohensD(repo$O,rev$O)
cohensD(repo$C,rev$C)
cohensD(repo$E,rev$E)
cohensD(repo$A,rev$A)
cohensD(repo$N,rev$N)

