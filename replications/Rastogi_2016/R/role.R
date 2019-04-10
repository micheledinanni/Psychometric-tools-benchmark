rm(list=ls())
source(file="connectTodb.R")

query="select * from"
cc_reviewer<-dbGetQuery(con,query)

query="select * from"
pr_reviewer<-dbGetQuery(con,query)

head(prc)
head(cc)
rm(con,query)

prc$user_id=as.factor(prc$user_id)
cc$user_id=as.factor(cc$user_id)

prc$type="prc"
cc$type="cc"

agg_prc<-aggregate(cbind(O,C,E,A,N)~user_id+type,data=prc,mean,trim=0.2)
agg_cc<-aggregate(cbind(O,C,E,A,N)~user_id+type,data=cc,mean,trim=0.2)


#boxplot######pullrequest-comments######################

par(mfrow=c(1,5))
s_r12<-rbind(cbind(agg_prc,type="1"),cbind(agg_cc,type="2"))
boxplot(O~type,data=s_r12,notch=T,outline=F,xlab="O")
boxplot(C~type,data=s_r12,notch=T,outline=F,xlab="C")
boxplot(E~type,data=s_r12,notch=T,outline=F,xlab="E")
boxplot(A~type,data=s_r12,notch=T,outline=F,xlab="A")
boxplot(N~type,data=s_r12,notch=T,outline=F,xlab="N")

#calcolo la media dei campioni
mean(agg_cc$O)
mean(agg_prc$O)
mean(agg_cc$C)
mean(agg_prc$C)
mean(agg_cc$E)
mean(agg_prc$E)
mean(agg_cc$A)
mean(agg_prc$A)
mean(agg_cc$N)
mean(agg_prc$N)

#calcolo la deviazione standard dei campioni
sd(agg_cc$O)
sd(agg_prc$O)
sd(agg_cc$C)
sd(agg_prc$C)
sd(agg_cc$E)
sd(agg_prc$E)
sd(agg_cc$A)
sd(agg_prc$A)
sd(agg_cc$N)
sd(agg_prc$N)


#eseguo il t-test per valori appaiati
t.test(agg_cc$O,agg_prc$O,paired=T)
t.test(agg_cc$C,agg_prc$C,paired=T)
t.test(agg_cc$E,agg_prc$E,paired=T)
t.test(agg_cc$A,agg_prc$A,paired=T)
t.test(agg_cc$N,agg_prc$N,paired=T)

#calcolo la d di Cohen per calcolare la differenza standardizzata fra le due medie campionarie
library(lsr)
cohensD(agg_cc$O,agg_prc$O)
cohensD(agg_cc$C,agg_prc$C)
cohensD(agg_cc$E,agg_prc$E)
cohensD(agg_cc$A,agg_prc$A)
cohensD(agg_cc$N,agg_prc$N)





