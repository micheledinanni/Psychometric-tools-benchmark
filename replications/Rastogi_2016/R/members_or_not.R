rm(list=ls())
source(file="connectTodb.R")

query="select * from cc_project_members"
prc_memb<-dbGetQuery(con,query)

query="select * from pr_project_members"
cc_memb<-dbGetQuery(con,query)


query="select * from cc_not_project_members"
prc_nm<-dbGetQuery(con,query)

query="select * from pr_not_project_members"
cc_nm<-dbGetQuery(con,query)
rm(con,query)

all_memb<-rbind(prc_memb,cc_memb)
all_n_memb<-rbind(prc_nm,cc_nm)

all_members<-aggregate(cbind(O,C,E,A,N)~user_id,data=all_memb,mean,trim=0.2)
all_not_members<-aggregate(cbind(O,C,E,A,N)~user_id,data=all_n_memb,mean,trim=0.2)

#######################
# Visualization

s_r12<-rbind(cbind(all_members,type="1"),cbind(all_not_members,type="2"))
par(mfrow=c(1,5))
boxplot(O~type,data=s_r12,notch=T,outline=F,names=c("M","NM"),xlab="O")
boxplot(C~type,data=s_r12,notch=T,outline=F,names=c("M","NM"),xlab="C")
boxplot(E~type,data=s_r12,notch=T,outline=F,names=c("M","NM"),xlab="E")
boxplot(A~type,data=s_r12,notch=T,outline=F,names=c("M","NM"),xlab="A")
boxplot(N~type,data=s_r12,notch=T,outline=F,names=c("M","NM"),xlab="N")
dev.off()

#calcolo la deviazione standard dei campioni
sd(all_members$O)
sd(all_not_members$O)
sd(all_members$C)
sd(all_not_members$C)
sd(all_members$E)
sd(all_not_members$E)
sd(all_members$A)
sd(all_not_members$A)
sd(all_members$N)
sd(all_not_members$N)

#eseguo il t-test per valori non appaiati
t.test(all_members$O,all_not_members$O)
t.test(all_members$C,all_not_members$C)
t.test(all_members$E,all_not_members$E)
t.test(all_members$A,all_not_members$A)
t.test(all_members$N,all_not_members$N)

#calcolo la d di Cohen per calcolare la differenza standardizzata fra le due medie campionarie
library(lsr)
cohensD(all_members$O,all_not_members$O)
cohensD(all_members$C,all_not_members$C)
cohensD(all_members$E,all_not_members$E)
cohensD(all_members$A,all_not_members$A)
cohensD(all_members$N,all_not_members$N)


