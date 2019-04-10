rm(list=ls())
source(file="connectTodb.R")

query="select * from members_of_project"
proj_memb<-dbGetQuery(con,query)

query="select * from not_members_of_project"
not_proj_memb<-dbGetQuery(con,query)

proj_memb$user_id=as.factor(proj_memb$user_id)
not_proj_memb$user_id=as.factor(not_proj_memb$user_id)

proj_memb$type="m"
not_proj_memb$type="nm"
rm(con,query)

par(mfrow=c(1,5))
all_role<-rbind(cbind(proj_memb,type="1"),cbind(not_proj_memb,type="2"))
boxplot(O~type,data=all_role,notch=T,outline=F,xlab="O")
boxplot(C~type,data=all_role,notch=T,outline=F,xlab="C")
boxplot(E~type,data=all_role,notch=T,outline=F,xlab="E")
boxplot(A~type,data=all_role,notch=T,outline=F,xlab="A")
boxplot(N~type,data=all_role,notch=T,outline=F,xlab="N")
dev.off()

#calcolo la media dei campioni
mean(proj_memb$O)
mean(not_proj_memb$O)
mean(proj_memb$C)
mean(not_proj_memb$C)
mean(proj_memb$E)
mean(not_proj_memb$E)
mean(proj_memb$A)
mean(not_proj_memb$A)
mean(proj_memb$N)
mean(not_proj_memb$N)

#calcolo la deviazione standard dei campioni
sd(proj_memb$O)
sd(not_proj_memb$O)
sd(proj_memb$C)
sd(not_proj_memb$C)
sd(proj_memb$E)
sd(not_proj_memb$E)
sd(proj_memb$A)
sd(not_proj_memb$A)
sd(proj_memb$N)
sd(not_proj_memb$N)

#eseguo il t-test per valori non appaiati
t.test(proj_memb$O,not_proj_memb$O,paired=F)
t.test(proj_memb$C,not_proj_memb$C,paired=F)
t.test(proj_memb$E,not_proj_memb$E,paired=F)
t.test(proj_memb$A,not_proj_memb$A,paired=F)
t.test(proj_memb$N,not_proj_memb$N,paired=F)

#calcolo la d di Cohen per calcolare la differenza standardizzata fra le due medie campionarie
library(lsr)
cohensD(proj_memb$O,not_proj_memb$O)
cohensD(proj_memb$C,not_proj_memb$C)
cohensD(proj_memb$E,not_proj_memb$E)
cohensD(proj_memb$A,not_proj_memb$A)
cohensD(proj_memb$N,not_proj_memb$N)


