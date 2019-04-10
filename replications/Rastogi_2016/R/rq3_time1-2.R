source(file="connectTodb.R")

# Import the personality score data
query="select * from year1_cc"
year1_cc<-dbGetQuery(con,query)

query="select * from year1_pr"
year1_pr<-dbGetQuery(con,query)

query="select * from year2_cc"
year2_cc<-dbGetQuery(con,query)

query="select * from year2_pr"
year2_pr<-dbGetQuery(con,query)
rm(con,query)

year1_pr$user_id=as.factor(year1_pr$user_id)
year1_cc$user_id=as.factor(year1_cc$user_id)
year2_pr$user_id=as.factor(year2_pr$user_id)
year2_cc$user_id=as.factor(year2_cc$user_id)

year1<-rbind(year1_cc,year1_pr)
year2<-rbind(year2_cc,year2_pr)

first_year<-aggregate(cbind(O,C,E,A,N)~user_id,data=year1,mean)
second_year<-aggregate(cbind(O,C,E,A,N)~user_id,data=year2,mean)
second_year<-head(second_year,374)

s_r12<-rbind(cbind(first_year,type="y1"),cbind(second_year,type="y2"))
par(mfrow=c(1,5))
boxplot(O~type,data=s_r12,notch=T,outline=F,xlab="O")
boxplot(C~type,data=s_r12,notch=T,outline=F,xlab="C")
boxplot(E~type,data=s_r12,notch=T,outline=F,xlab="E")
boxplot(A~type,data=s_r12,notch=T,outline=F,xlab="A")
boxplot(N~type,data=s_r12,notch=T,outline=F,xlab="N")

#media dei valori
mean(first_year$O)
mean(second_year$O)
mean(first_year$C)
mean(second_year$C)
mean(first_year$E)
mean(second_year$E)
mean(first_year$A)
mean(second_year$A)
mean(first_year$N)
mean(second_year$N)

#deviazione standard
sd(first_year$O)
sd(second_year$O)
sd(first_year$C)
sd(second_year$C)
sd(first_year$E)
sd(second_year$E)
sd(first_year$A)
sd(second_year$A)
sd(first_year$N)
sd(second_year$N)

t.test(first_year$O,second_year$O,paired = T)
t.test(first_year$C,second_year$C,paired = T)
t.test(first_year$E,second_year$E,paired = T)
t.test(first_year$A,second_year$A,paired = T)
t.test(first_year$N,second_year$N,paired = T)

#calcolo la d di Cohen per calcolare la differenza standardizzata fra le due medie campionarie
library(lsr)
cohensD(first_year$O,second_year$O)
cohensD(first_year$C,second_year$C)
cohensD(first_year$E,second_year$E)
cohensD(first_year$A,second_year$A)
cohensD(first_year$N,second_year$N)

