#第七章 基本统计分析
vars <- c("mpg", "hp", "wt")
head(mtcars[vars])

summary(mtcars[vars])

mystats <- function(x,na.omit=FALSE){
                if (na.omit)
                  x <-x[!is.na(x)]
                m <- mean(x)
                n <- length(x)
                s <- sd(x)
                skew <- sum((x-m)^3/s^3)/n
                kurt <- sum((x-m^4/s^4))/n-3
                return(c(n=n, mean=m, stdev=s, skew=skew, kurtosis=kurt))
}
sapply(mtcars[vars], mystats)

library(Hmisc)
describe(mtcars[vars])

library(pastecs)
stat.desc(mtcars[vars])

library(psych)
describe(mtcars[vars])

aggregate(mtcars[vars], by=list(am=mtcars$am), mean)
aggregate(mtcars[vars], by=list(am=mtcars$am), sd)

#dstats <- function(x)(c(mean=mean(x), sd=sd(x)))
#by(mtcars[vars], mtcars$am, dstats) #(list) object cannot be coerced to type 'double'

library(doBy)
summaryBy(mpg+hp+wt~am, data = mtcars,FUN=mystats)

library(psych)
describeBy(mtcars[vars], mtcars$am)
#describeBy函数不允许指定任意函数，所以普适性比较低
?describeBy

#现在推荐使用reshape2
library(reshape)
# measure.vars 
dstats <- function(x)(c(n=length(x), mean=mean(x), sd=sd(x)))
dfm <- melt(mtcars, measure.vars=c("mpg", "hp","wt"),id.vars = c("am", "cyl"))
cast(dfm, am + cyl+variable ~ .,dstats)

library(vcd)
head(Arthritis)
mytable <-with(Arthritis, table(Improved))
mytable

prop.table(mytable)

#二维列联表
mytable<-xtabs(~ Treatment +Improved, data = Arthritis)
mytable

margin.table(mytable,1)#生成边际频数
prop.table(mytable, 1)#生成边际比例

margin.table(mytable,2)#table语句中的第二个变量
prop.table(mytable,2)

#使用addmargins函数添加边际和
addmargins(mytable)
addmargins(prop.table(mytable))

addmargins(prop.table(mytable,1),2)
addmargins(prop.table(mytable,2),1)
#table函数默认忽略缺失值NA，若将NA视为一个有效类别，设定参数useNA=”ifany“

library(gmodels)
CrossTable(Arthritis$Treatment, Arthritis$Improved)
?CrossTable
#三维列联表
mytable <- xtabs(~Treatment+Sex+Improved,data = Arthritis)
mytable
margin.table(mytable, 1)
margin.table(mytable, 2)
margin.table(mytable, 3)

margin.table(mytable, c(1, 3))
ftable(prop.table(mytable, c(1, 2)))
ftable(addmargins(prop.table(mytable, c(1, 2)), 3))

#卡方独立性检验
library(vcd)
mytable <- xtabs(~Treatment+ Improved,data = Arthritis)
chisq.test(mytable)

mytable <- xtabs(~Improve +Sex,data = Arthritis)
chisq.test(mytable)

#Fisher精确检验
mytable <- xtabs(~Treatment+Improved, data = Arthritis)
fisher.test(mytable)
#fisher.test不能在2*2的列联表上使用
mytable <- xtabs(~Treatment +Improved+Sex,data = Arthritis)
mantelhaen.test(mytable)

library(vcd)
mytable <- xtabs(~Treatment+Improved, data = Arthritis)
assocstats(mytable)

#将表格转换为扁平格式
table2flat <-function(mytable){
  df <- as.data.frame(mytable)
  rows <- dim(df)[1]
  cols <- dim(df)[2]
  x <- NULL
  for (i in 1:rows){
    for(j in 1:df$Freq[i]){#将要转换的表格频数命名为Freq
      row <-df[i, c(1:cols-1)]
      x <- rbind(x,row)
    }
    row.names(x)<-c(1:dim(x)[1])
    return(x)
  }
}

treatment <- rep(c("Placebo", "Treated"), times=3)
improved <- rep(c("None", "Some", "Marked"), each=2)
Freq <- c(29,13,7,17,7,21)
mytable <- as.data.frame(cbind(treatment, improved, Freq))
mydata<-table2flat(mytable)
head(mydata)

states<-state.x77[,1:6]
cov(states)
cor(states)
cor(states, method = "spearman")

x<-states[,c("Population","Income","Illiteracy","HS Grad")]
y<-states[,c("Life Exp","Murder")]
cor(x,y)
