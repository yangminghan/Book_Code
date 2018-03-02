
#学习R笔记 下\
#第十二章有很多类型的数据读取，包含读取网络数据和连接数据库，现在没有条件
#以后想着重读这一章
data()
data(package = .packages(TRUE))
data("kidney",package="survival")
head(kidney)

library(learningr)
deer_file<-system.file(
  "extdata",
  "RedDeerEndocranialVolume.dlm",
  package = "learningr"
)
deer_data<-read.table(deer_file,header = TRUE,fill=TRUE)
str(deer_data,vec.len =1)
#vec.len 改变了输出变量
crab_file<-system.file(
  "extdata",
  "crabtag.csv",
  package = "learningr"
)
crab_id_block <-read.csv(
  crab_file,
  header = FALSE,
  skip =3,#skip 和nrow指定读文件中的那些位置
  nrow =2
)

#sql导出数据 na.string="NUll"
#SAS数据na.string="."
#excel数据 na.string=c("","#N/A","#DIV/0!","#num!")

write.csv(
  crab_id_block,
  "F:/crabdata.csv",
  row.names = FALSE,
  fileEncoding = "utf8"
)
#读取文本文件
text_file<-system.file(
  "extdata",
  "Shakespeare.s.The.Tempest..from.Project.Gutenberg.pg2235.txt",
  package = "learningr"
)
the_tempest<-readLines(text_file)
the_tempest[1926:1927]
#读取xml文件
library(XML)
xml_file <- system.file(
  "extdata",
  "options.xml",
  package = "learningr"
)
r_options<-xmlParse(xml_file)
#XML包提供两种选择，第一种是使用内部节点，第二种是使用R节点
#通常应该使用内部节点，这样就可以使用Xpath来查询节点树
#使用内部节点有一个问题就是str和head等汇总函数不能和他们一起使用
#使用R节点
xmlParse(xml_file,useInternalNodes = FALSE)
xmlTreeParse(xml_file)
#二者作用相同
#XPath是一种用于查询xml文档的语言
#他能基于某些过滤规则寻找到相应的节点
xpathSApply(r_options,"//variable[contains(@name,'warn')]")

#在文档//中找到命名为variable的结点，此结点[]name属性@包含contains
#warn字符串
#读取json数据
#首选RJSONIO 如果json数据存在一定问题
#使用rjson
library(RJSONIO)
library(rjson)
jamaican_file <- system.file(
  "extdata",
  "Jamaican.Cities.json",
  package = "learningr"
)

jamaican_city<-RJSONIO::fromJSON(jamaican_file)
jamaican_city_rjson<-rjson::fromJSON(file = jamaican_file)

special_numbers<-c(NaN,NA,Inf,-Inf)
RJSONIO::toJSON(special_numbers)

#读取Excel文件
library(xlsx)#rjava包加载不了，应该是环境变量的问题
#读取sas文件时使用foreign包要求电脑已经安装sas
#没安装所以还是用sas7bdat

#第十三章 数据清理和转换
library(learningr)
yn_to_logical<-function(x){
  y<-rep.int(NA,length(x))
  y[x == "Y"]<-TRUE
  y[x == "N"]<-FALSE
  y
}
alpe_d_huez$DrugUse<-yn_to_logical(alpe_d_huez$DrugUse)
head(alpe_d_huez)

data(english_monarchs,package = "learningr")
head(english_monarchs)
library(stringr)
multiple_kingdoms<-str_detect(english_monarchs$domain,fixed(","))
#寻找逗号，fixed函数表示寻找的是逗号而非正则
english_monarchs[multiple_kingdoms,c("name","domain")]
#在name一栏中查找有逗号或者and的行，忽略name为空的行
multiple_rulers<-str_detect(english_monarchs$name,",|and")
english_monarchs$name[multiple_rulers& !is.na(multiple_rulers)]

individual_rulers<-str_split(english_monarchs$name,", | and")
head(individual_rulers)

#str_count 计算字符出现的次数
th<-c("th","ð")#这里的拉丁字母应该是识别不出来
sapply(
  th,
  function(th){
    sum(str_count(english_monarchs$name,th))
  }
)

#str_replace_all 替换掉相应的字符
english_monarchs$new_name<-str_replace_all(english_monarchs$name,"a","e")

#
gender<-c(
  "MALE","Male","male","M","FEMALE",
  "Female","female","f",NA
)

#以m或者M开头的，后面跟着一个可选的（？表示）ale，且以字符串结尾
clean_gender<-str_replace(
  gender,
  "^(m|M)(ale|ALE)?$",
  "Male"
)
clean_gender<-str_replace(
  clean_gender,
  "^(f|F)(emale|EMALE)?$",
  "Female"
)
clean_gender

english_monarchs$length.of.reign.years<-
  english_monarchs$end.of.reign-english_monarchs$start.of.reign

english_monarchs$length.of.reign.years<-with(
  english_monarchs,
  end.of.reign-start.of.reign
)
#within返回整个数据框，当要更改多个列的时候更有用
within(
  english_monarchs,
  length.of.reign.year<-end.of.reign-start.of.reign
)
within(
  english_monarchs,
  {
  length.of.reign.year<-end.of.reign-start.of.reign
  reign.was.more.than.30.year<-length.of.reign.year>30
  }
)
#mutate函数，接受新的和更改的列，并把它们当成名称 -值对
library(plyr)
english_monarchs<-mutate(
  english_monarchs,
  length.of.reign.years = end.of.reign-start.of.reign,
  reign.was.more.than.30.years =length.of.reign.years>30
)
#处理缺失值
#complete.cases 函数可以告诉我们哪一行没有缺失值
data("deer_endocranial_volume",package = "learningr")
has_all_measurements<- complete.cases(deer_endocranial_volume)
deer_endocranial_volume[has_all_measurements,]

#na.omit删除数据框中所有带有缺失值的行
na.omit(deer_endocranial_volume)

deer_wide<-deer_endocranial_volume[,1:5]
library(reshape2)
#melt函数可以将宽形式转换成长形式
deer_long<-melt(deer_wide,id.vars = "SkullID")
head(deer_long)
melt(deer_wide,measure.vars = c("VolCT","VolBead","VolLWH","VolFinarelli"))

dcast(deer_long,SkullID ~variable)
#dcast返回数据框 acast返回向量 矩阵或者数组
#这两个函数可以创造数据透视表

#使用SQL
library(sqldf)
subset(
  deer_endocranial_volume,
  VolCT >400 | VolCT2>400,
  c(VolCT,VolCT2)
)

query<-"select VolCT,VolCT2 
        from deer_endocranial_volume 
        where VolCT >400 or VolCT2>400"
sqldf(query)

#排序
x<-c(2,32,4,16,8)
sort(x)
sort(x,decreasing =TRUE)

sort(c("I","shot","the","city"))
x[order(x)]
#=sort(x)
#order对于数据框排序时非常有用，数据框不能直接使用sort
year_order <-order(english_monarchs$start.of.reign)
english_monarchs[year_order,]

#plyr包中arrange函数提供一个替代函数
arrange(english_monarchs,start.of.reign)

#rank函数为数据集中的每个元素给出了排名
x<-sample(3,7,replace = TRUE)
rank(x)
rank(x,ties.method = "first")
#函数式编程 此书介绍的不是很详细 ,这一部分详细看一下advance r中的介绍
ct2<-deer_endocranial_volume$VolCT2
isnt.na<-Negate(is.na)
identical(isnt.na(ct2),!is.na(ct2))

Filter(isnt.na,ct2)

Position(isnt.na,ct2)

Find(isnt.na,ct2)
#练习
data("hafu",package = "learningr")
hafu$FathersNationalityIsUncertain <- str_detect(hafu$Father,fixed("?"))
hafu$MontherssNationalityIsUncertain <- str_detect(hafu$Mother,fixed("?"))
hafu$Father<-str_replace(hafu$Father,fixed("?"),"")
hafu_long<-melt(hafu,measure.vars = c('Father','Mother'))

top10<-function(x){
  counts<-table(x,useNA = "always")#传递给table意味着NA将始终包含在counts对象中
  head(sort(counts,decreasing = TRUE),10)
}
top10(hafu$Mother)

top10_v2<-function(x){
  counts<-count(x)
  head(arrange(counts,desc(freq)),10)
}
top10_v2(hafu$Mother)

#第14章
data("obama_vs_mccain",package = "learningr")
obama<-obama_vs_mccain$Obama
mean(obama)

table(cut(obama,seq.int(0,100,10)))
var(obama)
#计算方差
sd(obama)
#计算标准差
mad(obama)
#计算平均绝对偏差

with(obama_vs_mccain,pmin(Obama,McCain))
#pmin计算相同长度的向量在相同位置上的最大最小值
range(obama)
#计算最小最大值
cummax(obama)
#cumin和cumax分别可以计算向量中的最小最大值，同样cumsum和sumprod可以计算数据中
#的累加与累乘
cumsum(obama)
cumprod(obama)
op=options()
options(digits = 3)
options=op

quantile(obama,type=5)
fivenum(obama)#fivenum对于quantile做了大量的简化而且运行速度更快
summary(obama_vs_mccain)

with(obama_vs_mccain,cor(Obama,McCain))#相关性
with(obama_vs_mccain,cancor(Obama,McCain))#
with(obama_vs_mccain,cov(Obama,McCain))#协方差

#plot会简单忽略缺失值
with(obama_vs_mccain,plot(Income,Turnout))
with(obama_vs_mccain,plot(Income,Turnout,col="violet",pch=20))#
plot(1:25,pch=1:25,bg="blue")

with(obama_vs_mccain,plot(Income,Turnout,log = "y"))

par(mar=c(3,3,0.5,0.5),oma=rep.int(0,4),mgp=c(2,1,0))
regions<-levels(obama_vs_mccain$Region)
plot_numbers<-seq_along(regions)
layout(matrix(plot_numbers,ncol=5,byrow = TRUE))
for(region in regions){
  regional_data<-subset(obama_vs_mccain,Region ==region)
  with(regional_data,plot(Income,Turnout))
}

library(lattice)
xyplot(Turnout~Income,obama_vs_mccain)

xyplot(Turnout~Income,obama_vs_mccain,col="violet",pch=20)

xyplot(
  Turnout~Income,
  obama_vs_mccain,
  scales =list(log=TRUE)
)

xyplot(
  Turnout~Income,
  obama_vs_mccain,
  scales = list(y=list(log=TRUE))
)
#通过scales指定坐标轴

xyplot(
  Turnout~Income | Region,
  obama_vs_mccain,
  scales = list(
    log=TRUE,
    relation="same",
    alternating=FALSE
  ),
  layout=c(5,2)
)
#lattice系统可以将绘图存贮在变量中
lat1<-xyplot(
  Turnout~Income|Region,
  obama_vs_mccain
)
lat2<-update(lat1,col="violet",pch=20)
lat2

library(ggplot2)
ggplot(obama_vs_mccain,aes(Income,Turnout))+
  geom_point()

ggplot(obama_vs_mccain,aes(Income,Turnout))+
  geom_point(color="violet",shape=20)

ggplot(obama_vs_mccain,aes(Income,Turnout))+
  geom_point()+
  scale_x_log10(breaks=seq(2e4,4e4,1e4))+
  scale_y_log10(breaks=seq(50,75,5))+
  facet_wrap(~Region,ncol = 4)#使用facet进行分面

gg1<-ggplot(obama_vs_mccain,aes(Income,Turnout))+
  geom_point()
gg2<-gg1+facet_wrap(~Region,ncol = 5)+theme(axis.text.x = element_text(angle=30,hjust = 1))
gg2

data(crab_tag,package = "learningr")
with(
  crab_tag$daylog,
  plot(Date,-Max.Depth,type = "l",ylim = c(-max(Max.Depth),0))
)
with(
  crab_tag$daylog,
  lines(Date,-Min.Depth,type = "l",col="blue")#添加另一条线
)

xyplot(-Min.Depth+ -Max.Depth ~Date,crab_tag$daylog,type="l")

ggplot(crab_tag$daylog,aes(Date,-Min.Depth))+
  geom_line()
ggplot(crab_tag$daylog,aes(Date))+
  geom_line(aes(y=-Max.Depth))+
  geom_line(aes(y=-Min.Depth))

library(reshape2)
crab_long <-melt(
  crab_tag$daylog,
  id.vars ="Date",
  measue.vars=c("Min.Depth","Max.Depth")
)

ggplot(crab_long,aes(Date,-value,group =variable))+geom_line()

ggplot(obama_vs_mccain,aes(Obama))+
  geom_histogram(binwidth = 5)
ggplot(obama_vs_mccain,aes(Obama,..density..))+
  geom_histogram(binwidth = 5)
boxplot(Obama~Region,data = obama_vs_mccain)
ovm<-within(
  obama_vs_mccain,
  Region<-reorder(Region,Obama,median)
)
boxplot(Obama~Region,data = ovm)

bwplot(Obama~Region,data = ovm)
ggplot(ovm,aes(Region,Obama))+geom_boxplot()

#练习
with(obama_vs_mccain,cor(Unemployment,Obama))
ggplot(obama_vs_mccain,aes(Unemployment,Obama))+
  geom_point()
data(alpe_d_huez2,package = "learningr")
head(alpe_d_huez2)
ggplot(data = alpe_d_huez2,aes(NumericTime))+
  geom_histogram(binwidth = 2)+
  facet_wrap(~DrugUse)

ggplot(data = alpe_d_huez2,aes(DrugUse,NumericTime,group=DrugUse))+
  geom_boxplot()
data(gonorrhoea,package = "learningr")

ggplot(gonorrhoea,aes(Age.Group,Rate))+
  geom_bar(stat = "identity",position = "dodge")+
  facet_wrap(~Ethnicity+Gender)

ggplot(gonorrhoea,aes(Age.Group,Rate,group=Year,color=Year))+
  geom_line()+
  facet_wrap(~Ethnicity+Gender)

ggplot(gonorrhoea,aes(Age.Group,Rate,group=Year,color=Year))+
  geom_line()+
  facet_grid(Ethnicity~Gender)

ggplot(gonorrhoea,aes(Age.Group,Rate,group=Year,color=Year))+
  geom_line()+
  facet_grid(Ethnicity ~Gender,scales = "free_y")

#第15章 分布与建模

sample(colors(),5)
sample(.leap.seconds,4)

weights<-c(1,1,2,3,5,8,13,21,8,3,1,1)
sample(month.abb,10,prob = weights)

runif(5)#生成5个 介于0~1之间的均匀分布的随机数
runif(5,1,10)#生成5个介于0~10之间的均匀分布的随机数
rnorm(5)#生成5个正态分布的随机数，中位数为0 ，标准差为1
rnorm(5,3,7)#生成5个正态分布的随机数，中位数为3，标准差为7

set.seed(1)#通过把种子设定为特定的值，可以保证每一次运行代码都能生成同样的随机数
runif(5)

data(gonorrhoea,package = "learningr")
model1<-lm(Rate~Year +Age.Group +Ethnicity+Gender,gonorrhoea)
model1
lapply(Filter(is.factor,gonorrhoea),levels)
summary(model1)

model2<-update(model1,~.-Year)
summary(model2)

anova(model1,model2)
#能计算模型的方差分析表，可以看到简化模型与全面模型相比是否有显著差别

AIC(model1,model2)
BIC(model1,model2)
#这两个函数利用对数似然值告诉我们用哪个模型拟合数据更好，较小的数字意味着更好的模型

silly_model<-update(model1,~.-Age.Group)
anova(model1,silly_model)
model3<-update(model2,~.,~Gender)
summary(model3)

plot_numbers<-1:6
layout(matrix(plot_numbers,ncol=2,byrow = TRUE))
plot(model3,plot_numbers)

#PDF函数名字以d开头，后面跟着分布的名称
#例如PDF格式的二项分布函数时dbinom
#CDF函数以p开头，逆CDF函数以q开头
dpois(3,3)
?pnbinom
pnbinom(12,1,0.25)
qbirthday(0.9)
model1<-lm(
  Rate~Year +Age.Group+Ethnicity +Gender,
  gonorrhoea,
  subset = Age.Group%in% c("15 to 19","20 to 24","25 to 29","30 to 34")
)
summary(model1)
model2<-update(model1,~.,-Year)
summary(model2)
model2

model3<-update(model2,~.+Ethnicity:Gender)
summary(model3)

data(obama_vs_mccain,package = "learningr")
ovm<-within(obama_vs_mccain,Obama<-Obama/100)
library(betareg)
beta_model1<-betareg(
  Obama~Turnout +Population+Unemployment +Urbanization +Black+Protestant,
  ovm,
  subset = State!="District of Columbia"
)
summary(beta_model1)
beta_model2<-update(beta_model1,~.-Urbanization)
summary(beta_model2)

beta_model3<-update(beta_model2,~.-Population)
summary(beta_model3)

plot_numbers<-1:6
layout(matrix(plot_numbers,ncol = 2,byrow = TRUE))
plot(beta_model3,plot_numbers)

f<-function(x){
  message("x contains ",toString(x))
  x
}
f(letters[1:5])











