source(file="connectTodb.R")

# Import the personality score data
query="select * from year1_cc"
year1_cc<-dbGetQuery(con,query)

query="select * from year1_pr"
year1_pr<-dbGetQuery(con,query)

query="select * from year3_cc"
year3_cc<-dbGetQuery(con,query)

query="select * from year3_pr"
year3_pr<-dbGetQuery(con,query)
rm(con,query)

year1_pr$user_id=as.factor(year1_pr$user_id)
year1_cc$user_id=as.factor(year1_cc$user_id)
year3_pr$user_id=as.factor(year3_pr$user_id)
year3_cc$user_id=as.factor(year3_cc$user_id)

year1<-rbind(year1_cc,year1_pr)
year3<-rbind(year3_cc,year3_pr)

first_year<-aggregate(cbind(O,C,E,A,N)~user_id,data=year1,mean)
third_year<-aggregate(cbind(O,C,E,A,N)~user_id,data=year3,mean)
third_year<-head(third_year,374)

s_r13<-rbind(cbind(first_year,type="y1"),cbind(third_year,type="y3"))
par(mfrow=c(1,5))
boxplot(O~type,data=s_r13,notch=T,outline=F,xlab="O")
boxplot(C~type,data=s_r13,notch=T,outline=F,xlab="C")
boxplot(E~type,data=s_r13,notch=T,outline=F,xlab="E")
boxplot(A~type,data=s_r13,notch=T,outline=F,xlab="A")
boxplot(N~type,data=s_r13,notch=T,outline=F,xlab="N")

#media dei valori
mean(first_year$O)
mean(third_year$O)
mean(first_year$C)
mean(third_year$C)
mean(first_year$E)
mean(third_year$E)
mean(first_year$A)
mean(third_year$A)
mean(first_year$N)
mean(third_year$N)

#deviazione standard
sd(first_year$O)
sd(third_year$O)
sd(first_year$C)
sd(third_year$C)
sd(first_year$E)
sd(third_year$E)
sd(first_year$A)
sd(third_year$A)
sd(first_year$N)
sd(third_year$N)

t.test(first_year$O,third_year$O,paired = T)
t.test(first_year$C,third_year$C,paired = T)
t.test(first_year$E,third_year$E,paired = T)
t.test(first_year$A,third_year$A,paired = T)
t.test(first_year$N,third_year$N,paired = T)

#calcolo la d di Cohen per calcolare la differenza standardizzata fra le due medie campionarie
library(lsr)
cohensD(first_year$O,third_year$O)
cohensD(first_year$C,third_year$C)
cohensD(first_year$E,third_year$E)
cohensD(first_year$A,third_year$A)
cohensD(first_year$N,third_year$N)

