rm(list=ls())
source(file="connectTodb.R")

query="select * from high_repu"
high<-dbGetQuery(con,query)

query="select * from mid_repu"
mid<-dbGetQuery(con,query)

query="select * from low_repu"
low<-dbGetQuery(con,query)
rm(con,query)


par(mfrow=c(1,5))
level_contrib<-rbind(cbind(high,type="H"),cbind(mid,type="M"),cbind(low,type="L"))
boxplot(O~type,data=level_contrib,notch=T,outline=F,xlab="O")
boxplot(C~type,data=level_contrib,notch=T,outline=F,xlab="C")
boxplot(E~type,data=level_contrib,notch=T,outline=F,xlab="E")
boxplot(A~type,data=level_contrib,notch=T,outline=F,xlab="A")
boxplot(N~type,data=level_contrib,notch=T,outline=F,xlab="N")
dev.off()

#ANOVA for the level of contribution HIGH-MID-LOW
aov.out<-aov(O~type,data=level_contrib)
summary(aov.out)
etaSquared(aov.out)

aov.out<-aov(C~type,data=level_contrib)
summary(aov.out)
etaSquared(aov.out)

aov.out<-aov(E~type,data=level_contrib)
summary(aov.out)
etaSquared(aov.out)

aov.out<-aov(A~type,data=level_contrib)
summary(aov.out)
etaSquared(aov.out)

aov.out<-aov(N~type,data=level_contrib)
summary(aov.out)
etaSquared(aov.out)


#anova for the level H-M, H-L, L-M
high_mid<-rbind(cbind(high,type="1"),cbind(mid,type="2"))
high_low<-rbind(cbind(high,type="1"),cbind(low,type="2"))
low_mid<-rbind(cbind(low,type="1"),cbind(mid,type="2"))

aov.out<-aov(N~type,data=low_mid)
tukey.test <- TukeyHSD(aov.out)
tukey.test


