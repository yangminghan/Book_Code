#学习R 笔记 上
x<-c(TRUE,FALSE,NA)
xy<-expand.grid(x=x,y=x)#取得xy的所有组合
within(
  xy,
  {
    and<-x&y
    or<-x|y
    not.y<-!y
    not.x<-!x
  }
)

none_true<-c(FALSE,FALSE,FALSE)
some_true<-c(FALSE,FALSE,TRUE)
all_true<-c(TRUE,TRUE,TRUE)

any(none_true)
all(some_true)

#整数除法
10%/%3
x=sqrt(pi)^2
isTRUE(all.equal(x,pi))
isTRUE(x==pi)

exp(pi*1i)+1#欧拉公式
factanal()#gama公式
choose#beta公式
#计算1：1000所有整数的倒数的反正切
atan(1/1:1000)
x<-1:1000
y<-atan(1/x)
z<-1/tan(y)
table(x==z)
identical(x,z)
all.equal(x,z)
all.equal(x,z,tolerance=0)

true_and_missing<-c(TRUE,NA,TRUE)
false_and_missing<-c(FALSE,NA,FALSE)
mixed<-c(TRUE,FALSE,NA)

any(true_and_missing)
any(false_and_missing)
any(mixed)
all(true_and_missing)
all(false_and_missing)
any(mixed)
#R中数值变量有三种类别：浮点值numeric,整数integer,复数complex
num<-runif(30)
summary(num)

fac<-factor(sample(letters[1:5],30,replace = TRUE)) #sample函数使用重复抽样replace随机抽样30次
levels(fac)
nlevels(fac)

summary(fac)

bool<-sample(c(TRUE,FALSE,NA),30,replace = TRUE)
summary(bool)

dfr<-data.frame(num,fac,bool)
head(dfr)
summary(dfr)

unclass(fac)#显示变量如何构建
attributes(fac)# 显示属性

is.numeric(1)
is.integer(1)
is.character(3)

as.numeric("1.3323")
#删除工作区内的所有变量
rm(list = ls())

pet<-sample(c('dog','cat','hamster','goldfish'),1000,replace = TRUE)
summary(pet)
table(pet)
head(pet)

class(Inf)#类
class(NA)#not available
class(NaN)#not a number
class('')

typeof(Inf)#内部存储类型
typeof(NA)
typeof(NaN)
typeof("")

mode(Inf)#模式
mode(NA)
mode(NaN)
mode("")

storage.mode(Inf)#存储模式
storage.mode(NA)
storage.mode(NaN)
storage.mode("")

apple<-11
pear<-3
peach<-"ddd"
#列出工作区中所有含a的变量
ls(pattern = "a")

vector("complex",3)
vector("list",5)

seq(3,12,3)#seq可以指定步长

1:0
seq_len(0)
seq_int()
seq_along()

#长度
length(1:5)
name<-c("yangminghan","fujing")
length(name)
nchar(name)

length(name)<-5
#命名
c(apple=2,pear=4,"kiwi"=4,8)
x<-1:5
names(x)<-name 
x
####索引
x<-(1:5)^2
x[seq(1,5,2)]
x[-seq(2,4,2)]#与上面返回相同的值，- 代表去掉
x[c(T,F,T,F,T)]#vector logical可以生成逻辑向量，但是都为空 false

names(x)<-name
names(x)<-NULL
x["yangminghan"]
which(x>10)

#向量循环和重复
1:5+1#1+1:5
1:5+1:15
1:5+1:7

rep(1:5,3)
rep(1:5,each=3)
rep(1:5,times=1:5)
rep(1:5,length.out=7)

#数组和矩阵

three_d_array<-array(
  1:24,
  dim = c(4,3,2),
  dimnames = list(
    c("one","two","three","four"),
    c("ein","zwei","drei"),
    c("un","deux")
  )
)

four_d_array<-array(
  1:24,
  dim = c(4,3,2,2),
  dimnames = list(
    c("one","two","three","four"),
    c("ein","zwei","drei"),
    c("un","deux"),
    c("yang","fu")
  )
)#四维数组 排列组合

a_matrix<-matrix(
  1:12,
  nrow = 4,#ncol =3 有相同的效果
  dimnames=list(
    c("one","two","three","four"),
    c("ein","zwei","drei")
  )
)
two_d_array<-array(
  1:12,
  dim=c(4,3),#注意dim 数字依次为一维，二维，三维
  dimnames=list(
    c("one","two","three","four"),
    c("ein","zwei","drei")
  )
)
identical(two_d_array,a_matrix)
class(two_d_array)

b_matrix<-matrix(
  1:12,
  nrow = 4,#ncol =3 有相同的效果
  byrow = TRUE,# 创建矩阵默认按列填充矩阵，byrow指定按行填充矩阵
  dimnames=list(
    c("one","two","three","four"),
    c("ein","zwei","drei")
  )
)
dim(a_matrix)
dim(four_d_array)
nrow(b_matrix)
ncol(a_matrix)

dim(a_matrix)<-c(6,2)#可以使用dim重新分配数组维度，但是会删除原来维度名称
a_matrix

rownames(b_matrix)
colnames(b_matrix)
dim_names<-dimnames(four_d_array)
dim_names[1:2]
class(dimnames(four_d_array))

#索引数组（正整数，负整数，逻辑值，元素名称）

b_matrix[1,c("zwei","drei")]

#要取剩余所有维度，空置下标
b_matrix[1,]
another_matrix<-matrix(
  seq.int(2,24,2),
  nrow=4,
  dimnames = list(
    c("five","six","seven","eight"),
    c("vier","funf","sech")
  )
  
)
c(a_matrix,another_matrix)

cbind(another_matrix,b_matrix)#合并的行/列的名称沿用前面矩阵的名称
rbind(b_matrix,another_matrix)

#数组计算
#矩阵相加
b_matrix+another_matrix
#矩阵 对应元素相乘
b_matrix*another_matrix
#??矩阵内乘和外乘 矩阵内乘为数学上定义的矩阵乘法
b_matrix%*%t(b_matrix)
#外乘感觉像是升维的意思
1:3%o%2:3
outer(b_matrix,1:2)

m<-matrix(c(1,0,1,5,-3,1,2,4,7),nrow = 3)
m^-1#每一个元素求倒数
inverse_of_m<-solve(m)
inverse_of_m%*%m#求矩阵的逆

seq(0,1,0.25)

n<-1:20
tri<-n*(n+1)/2
names(tri)<-letters[1:20]
tri[c("a","e","i","u","o")]

diag(c(10:0,1:11))#创建以给定参数向量的对角阵

a<-diag(rep(1,20),nrow=20,ncol=21)
b<-rbind(a,rep(0,21))
c<-diag(rep(1,20),nrow = 21,ncol = 20)
d<-cbind(0,c)
e<-diag(abs(seq(-10,10)))#abs 绝对值absolute
f<-b+d+e
eigen(f)$values#求矩阵特征值和特征向量


#list
a_list<-list(
  vname<-c(1,2),
  month.abb,
  month.name,
  matrix(1:6,nrow = 2),
  asin
)
#命名可以创建时命名，也可后赋予
names(a_list)<-c(vname,mon,month,matt)
#索引同向量一样 有正整数，负整数，逻辑向量，名称
l<-list(
  first=1,
  second=2,
  third=list(
    alpha=3.1,
    beta=3.2
  )
)
l[1:2]
l[-3]
l[c(TRUE,TRUE,FALSE)]
#此时得到仍然是一个list，访问列表元素的内容
l[[1]]
is.list(l[[1]])

busy_beaver<-c(1,6,21,107)
as.list(busy_beaver)
unlist(busy_beaver)

c(list(a=1,b=2),list(3))

a_data_frame<-data.frame(
  x=letters[1:5],
  y=rnorm(5),
  z=runif(5)>0.5
)
a_data_frame

#R中还有一种列表形式，成对列表pairlists，只在内部使用，用于将参数传递到函数中，
#唯一可能被显式调用的情形是使用formals时，该函数将返回一个函数参数的成对列表
formals(sd)
sd(rnorm(10000))
formals(mean)

y<-rnorm(5)
names(y)<-month.name[1:5]
data.frame(
  x=letters[1:5],
  y=y,
  z=runif(5)>5,
  row.names = NULL#如果输入的任何向量有名称，行名称取第一个向量名称，
  #row.names取null则不取该名称,也可以通过row.names给行命名
)

#dataframe中length返回ncol，names返回colnames所以避免使用length和names函数
length(a_data_frame)
ncol(a_data_frame)
names(a_data_frame)
colnames(a_data_frame)
rownames(a_data_frame)

#索引数据框
a_data_frame[2:3,-3]#第一个参数为行，第二个参数为列

a_data_frame[a_data_frame$y>0|a_data_frame$z,"x"]

subset(a_data_frame,y>0|z,x)
#subset需要三个参数，一个数据框，一个选择行的逻辑向量，一个要保留的列的名字向量

another_dataframe<-data.frame(
  z=rlnorm(5),#对数分布的 随机数
  y=sample(5),#1到5随机排列的数
  x=letters[3:7]
)
rbind(a_data_frame,another_dataframe)#rbind可以智能地对列重新排列以匹配
cbind(a_data_frame,another_dataframe)
#cbind不会对列名进行重复性检查

merge(a_data_frame,another_dataframe,by="x",all = TRUE)


#如何判断一个数是否是另一个数的平方
#等差数列 1,3,5,。。。2n-1求和为n^2

squarenum <- function(x){#还是有哪里不对
  i=1;
  while(i>=x|isTRUE(all.equal(sum(seq(1,x,2)),x)))
  
}
squarenumv<-Vectorize(squarenum)

#答案
x<-1:100
sqrt_x<-sqrt(x)
is_square_num<-sqrt_x==floor(sqrt_x)
square_num<-x[is_square_num]
groups<-cut(
  square_num,
  seq.int(min(x),max(x),10),
  include.lowest = TRUE,
  right = FALSE
)
groups
split(square_num,groups)
#生成一个1到100 每十个一行的矩阵，判断每一个数字是否为平方数，以此为索引，得到所有平方数，再转换为list

mean_iris<-sapply(iris[,1:4],mean)
mean_iris
colMeans(iris[,1:4])

beaver1$id<-1
beaver2$id<-2
beaver<-rbind(beaver1,beaver2)
subset(beaver,activ==1)
beaver[beaver$activ==1,"id"]

#环境
an_environment<new.env()
an_environment[["pythag"]]<-c(12,15,20,21)
an_environment$root<-polyroot(c(1,2,1))#解出一个多项式的根
an_environment$root

assign(
  "monday",
  weekdays(as.Date("1969/07/20")),
  an_environment
)
get("monday",an_environment)

ls(envir = an_environment)#列出环境中的所有变量
ls.str(envir = an_environment)
ls(envir = an_environment,pattern = "a")

exists("pythag",an_environment)#测试变量是否在环境中

a_list<-as.list(an_environment) #将环境转换为列表
as.environment(a_list)
list2env(a_list)

#所有环境都是嵌套的，exist和get函数将在父环境中寻找变量，可以传入 inherits=false 指定在当前环境中查找
nested_envi<-new.env(parent = an_environment)
exists("pythag",nested_envi)
exists("pythag",nested_envi,inherits = FALSE)

hypotenuse<-function(x,y)
{
  sqrt(x^2+y^2)
}
#等价于 hypotenuse<-function(x,y) sqrt(x^2+y^2)
hypotenuse(3,4)
#调用函数时，如果不声明参数，R按照顺序匹配

#返回函数参数
formals(hypotenuse)
args(hypotenuse)
#返回函数体
body(hypotenuse)
deparse(hypotenuse)

normalize<-function(x,m=mean(x),s=sd(x)){
  (x-m)/s
}
normalized<-normalize(c(1,3,6,10,15))
normalize(c(1,3,6,10,NA))
#R中提供了一个特殊的参数...，包含所有不能被位置或名称匹配的参数(像是给不知道的参数起了一个别名)
#mean，sd中有一个特殊的参数na.rm ,可以删除计算之前的任何缺失值
mean(c(1,3,6,10,NA),na.rm = TRUE)

normalize<-function(x,m=mean(x,...),s=sd(x,...),...){
  (x-m)/s
}

normalize(c(1,3,6,10,NA),na.rm=TRUE)

#函数可以像其他变量类型一样使用，do.call可以将其他函数作为参数
dfr1<-data.frame(x=1:5,y=rt(5,1))
dfr2<-data.frame(x=6:10,y=rf(5,1,1))
dfr3<-data.frame(x=11:15,y=rbeta(5,1,1))
do.call(rbind,list(dfr1,dfr2,dfr3))

#采用匿名的方式
do.call(function(x,y) x+y,list(1:5,5:1))

#返回值为函数的情况比较罕见，但是存在，ecdf函数返回一个向量的经验累积分布函数
emp_cum_dist_fun<-ecdf(rnorm(50))
is.function(emp_cum_dist_fun)
plot(emp_cum_dist_fun)

#变量的作用域

f<-function(x){
  y<-1
  g<-function(x){
    (x+y)/2#y被使用了，但是不是g的形式参数
  }
  g(x)#R试图在当前环境中查找变量，找不到，在父环境中继续查找，直到达到全局环境
}
f(sqrt(4))

h<-function(x){
  x*y
}
h(9)
y<-18
h(9)

h2<-function(x){
  if(runif(1)>0.5) y<-12
  x*y
}
h2(3)#小心使用全局变量，h2中参数y有一半的概率被定义为全局变量

replicate(10,h2(2))

multiples_of_pi<-new.env()
multiples_of_pi[["two_pi"]]<-1*pi
multiples_of_pi$three_pi<-3*pi
assign("four_pi",4*pi,multiples_of_pi)
ls(multiples_of_pi)

is_even<-function(x) x%%2 == 0
is_even(c(-5:5,Inf,-Inf,NA,NaN))

args_and_body<-function(fn){
  list(arguments =formals(fn),body=body(fn))
}
args_and_body(var)

#paste函数能将不同字符串组合起来，在他传入的参数向量中，
#每个元素都能自我循环已达到最长的矢量长度

paste(c("red","yellow"),"lorry")
paste(c("red","yellow"),"lorry",sep = "-")
paste(c("red","yellow"),"lorry",collapse = ",")#把结果收缩成一个包含所有元素的字符串
paste0(c("red","yellow"),"lorry")#去掉分隔符

x<-(1:15)^2
toString(x,width = 40)

cat(c("red","yellow"),"lorry")

x<-c("I","saw","you")
x
noquote(x)#去掉双引号，使得结果更可读

#格式化数字
pow<-1:3
powers_of_e<-exp(pow)
powers_of_e
formatC(powers_of_e)
formatC(powers_of_e,digits = 3)
formatC(powers_of_e,digits = 3,width = 10)
formatC(powers_of_e,digits = 3,format = "e")
formatC(powers_of_e,digits = 3,flag = "+")

#sprintf()第一个参数指定了一个格式化的字符串，
sprintf("%s %d =%f","Euler's constant to the power",
        pow,powers_of_e)#其中包括其他值的占位符，%s代表另一个字符串
sprintf("To three decimal places,e ^%d=%.3f",pow,powers_of_e)#%f和%e分别代表固定型格式和科学型格式的浮点数，
#%d表示整数
sprintf("in scientific notation,e ^%d=%e",pow,powers_of_e)

format(powers_of_e,digits = 3)#至少三个数字

format(powers_of_e,digits = 3,trim = TRUE)#去掉多余的0

format(powers_of_e,digits = 3,scientific = TRUE)

prettyNum(
  c(1e10,1e-20),
  big.mark = ",",
  small.mark = " ",
  preserve.width = "individual",
  scientific=FALSE
)

#特殊字符
cat("foo\tbar",fill = TRUE)
#\t 制表符
#\n 换行符
cat("foo\nbar",fill=TRUE)
cat("foo\\bar",fill = TRUE)

cat("\a")#可以报警
alarm()
toupper("I'm Shouting")#将字符串中的字符全部转换为大写
tolower("I'm Shouting")#字符串中的字符全部转换为小写

#截取字符串
woodchuck<-c(
  "How much",
  "if a woodchunk",
  "he would chunk",
  "and a chunk"
)
substring(woodchuck,2,3)#使用formals查看参数
substr(woodchuck,2,3)
formals(substr)

#分割字符串
strsplit(woodchuck," ",fixed = TRUE)
#注意strsplit返回的是列表

#R中有一个工作目录，默认为文件被读写的地方
getwd()
#/ 正斜杠 路径使用正斜杠 \\双反斜杠 也可以
file.path()
heights<-data.frame(
  height_cm<-c(161:170),
  gender<-c("female","male","female","male","male","male","female","female","male","male")
)
class(heights$gender)
heights$gender[1]<-"Female"

gender_char<-c("male","female","male")
class(gender_char)
gender_fac<-factor(gender_char)

getting_to_work<-data.frame(
  mode=c("bike","car","bus","walk"),
  time_min<-c(24,11,NA,14)
)
getting_to_work<-subset(getting_to_work,!is.na(time_min))
getting_to_work
unique(getting_to_work$mode)#只有三个不同值，但是因子水平为四
getting_to_work$mode<-droplevels(getting_to_work$mode)
getting_to_work<-droplevels(getting_to_work)

#有序因子
happy_choices<-c("depressed","grumpy","so-so","cheery")
happy_value<-sample(happy_choices,10000,replace = TRUE)
happy_fac<-factor(happy_value,happy_choices)
head(happy_fac)
happy_ord<-ordered(happy_value,happy_choices)
head(happy_ord)
#有序因子还是因子，但是因子不一定有序
#也可以通过指定factor中order参数实现

#将数值变量变为因子
ages<-16+50*rbeta(10000,2,3)
grouped_ages<-cut(ages,seq.int(16,66,10))
head(grouped_ages)
table(grouped_ages)

#脏数据中，如果有打错的数据，在数据导入的过程中，R会将该数据解释为字符串
#并将其转换为因子，
dirty<-data.frame(
  x=c("1.23","4..56","7.89")
)
#可以先把因子转换为字符向量，再转换为数值as.numeric(as.character(dirty$x))
#但是效率不高 更好的方法为把因子水平转换为数字
as.numeric(levels(dirty$x))[as.integer(dirty$x)]

typeof(dirty$x)
class(dirty$x)

#为了平衡数据，使得每一个水平上的数据点的数目相等，可用gl函数
#生成因子，第一个整型参数为要生成的因子的水平数，第二个整型参数为
#每个水平需要重复的次数
gl(3,2)
#可以给参数命名
gl(3,2,labels = letters[1:3])
gl(3,2,9,labels = letters[1:3])

#合并因子
treatment<-gl(3,3,labels = letters[1:3])
gender<-gl(2,1,6,labels = c("male","female"))
interaction(treatment,gender)

formatC(pi,digits = 16)
x<-"try to spill, this cha-cha"
strsplit(x,",? -? ?")#正则表达式不懂???

three_d6<-function(n){
  random_numbers<-matrix(
    sample(6,3*n,replace = TRUE),
    nrow = 3
    )    
    colSums(random_numbers)
}
scores<-three_d6(1000)
bonuses<-cut(#cut 所创造的间隔一般只包含上限，不包含下限
  scores,
  c(2,3,5,8,12,15,17,18),
  labels = -3:3
)
table(bonuses)

if(FALSE){
  message("this won't execute...")
}else{
  message("but this will")
}
ifelse(rbinom(10,1,0.5),"head","tail")#ifelse 是if的向量化函数
#第一个是逻辑条件向量，第二个参数在第一个向量为true时被返回
#第三个参数值在第一个向量为false时被返回
#R的for循环几乎总是其对应的向量化运行慢一到两个数量级，尽可能的向量化

greek<-switch(
  "gamma",
  alpha=1,
  beta=sqrt(4),
  gamma=4*sin(pi/3)^2
)
repeat{
  message("happy groundhog day")
  action<-sample(letters[1:5],1)
  message("action=",action)
  if(action=="a") break
}
action=1
while(action!="a"){
  message("happy groundhog day")
  action<-sample(letters[1:5],1)
  message("action=",action)
}
for(i in 1:5) message("i= ",i)
for(i in 1:5){
  j<-i^2
  message("j= ",j)
}
for(month in month.name){
  message("the month of ",month)
}
for(yn in c(TRUE,FALSE,NA)){
  message("this statement is ",yn)
}


two_d6<-function(n){
  random_numbers<-matrix(
    sample(6,2*n,replace = TRUE),
    nrow = 2
  )
  colSums(random_numbers)
}

score<-two_d6(1)
if(score %in% c(2,3,12)){
  game_status<-FALSE
  point <-NA
} else if(score %in% c(7,11)){
  game_status<-TRUE
  point <-NA
}else{
  game_status<-NA
  point<-score
}

if(is.na(game_status)){
  repeat({
    score<-two_d6(1)
    if(score ==7){
      game_status <-FALSE
      break
    }else if(score == point){
      game_status <-TRUE
      break
    }
  }
  )
}

sea_shells<-c(
  "She","sells","sea","shells"
)
nchar_sea_shells<- nchar(sea_shells)
for(i in min(nchar_sea_shells):max(nchar_sea_shells)){
  message("these words have " , i," letters")
  print(toString(unique(sea_shells[nchar_sea_shells==i])))
}

rep(runif(1),5)#runif 一次重复5次
replicate(5,runif(1))#runif执行5次 在蒙特卡洛分析中有重要用途

time_for_commute<-function(){
  #选择当时所用的交通工具
  mode_of_transport<-sample(
    c("car","bus","train","bike"),
    size = 1,
    prob = c(0.1,0.2,0.3,0.4)
  )
  #根据交通工具，找到出行的时间
  time<-switch(
    mode_of_transport,
    car = rlnorm(1,log(30),0.5),
    bus = rlnorm(1,log(40),0.5),
    train = rnorm(1,30,10),
    bike= rnorm(1,60,5)
  )
  names(time) <-mode_of_transport
  time
}
#switch 语句很难向量化，需要多次调用time_for_commute来生成每天的数据
replicate(5,time_for_commute())

#lapply list apply

fac<-list(
  sample(1:5,6,replace = TRUE),
  sample(1:5,4,replace = TRUE)
)
lapply(fac,unique)

#vapply 如果函数的每次返回值大小相同，而且已知大小为多少，可以使用lapply
#的变种vapply vapply的含义是 应用于apply列表而返回向量。vapply输入的参数是一个列表和
#一个向量,还需要第三个参数即返回值的模板 他不直接返回列表，而是直接把结果
#简化为向量或数组

vapply(fac,length,numeric(1))

#sapply simple apply 尽可能地把结果简化到一个合适的向量和数组中
sapply(fac,summary)
sapply(list(),length)
#如果输入列表中的长度为零，无论函数传入了什么参数，sapply总会返回一个列表
#因此，数据已经是空的，且你已经知道返回值，使用vapply会更安全
vapply(list(),length,numeric(1))

r_files<-dir(pattern = "\\.R$")
lapply(r_files,source)
 
complemented<-c(2,3,6,18)
#可以将 rep.int 函数的times参数这样传进去
lapply(complemented,rep.int,times=4)
# 向量参数不止一个，需要自定义一个函数封装想要真正调用的函数

rep4x<-function(x) rep.int(4,times=x)
lapply(complemented,rep4x)

lapply(complemented,function(x) rep.int(4,times = x))

#在极个别的情况下，可能需要循环遍历环境（而非列表）中每一个变量，
#可以用专门的函数eapply 也可以使用lapply

env<-new.env()
env$molien <-c(1,0,1,0,1,1,2,1,3)
env$larry<-c("really","lerry","rarely")
eapply(env,length)

lapply(env,length)

#装载matlab包的时候会有一些函数被覆盖，使用完成
#matlab，可以使用detach("package:matlab")
library(matlab)
#magic函数将创建一个f方阵 ：nxn,从1排到n^2
magic4<-magic(4)
#apply函数提供了类似的按行/列计算的等效函数
#他以一个矩阵和函数作为参数
#维度为1代表把函数应用到每一行，维度为2代表把函数
#应用到每一列（更大的数字代表更高维的数组）
apply(magic4,1,sum)#计算每一行的和
apply(magic4,1,toString)

#apply 也可以用于数据框，但是，系统会将其转为Matrix，
#如果所有Column不是数字类型或者类型不一致，
#导致转换失败，那么apply是运算不出任何一列的结果。
#这时候应该使用lappy()函数或者sapply


baldwin<-data.frame(
  name=c("alex","daniel","billy","stephen"),
  num=sample(1:5,4,replace = TRUE),
  stringsAsFactors = FALSE #重要 不想设置因子型
)
apply(baldwin,1,toString)
apply(baldwin,2,toString)

#当你把函数按列应用到数据框上，apply与sapply
#的行为相同
sapply(baldwin,toString)
sapply(baldwin,range)

#lapply的缺点之一是他的函数参数只能循环作用于
#单个向量参数吗，另一个缺点是，对于用于每个元素的函数，你不能访问
#该元素的名称
#mapply 是“多参数列表应用” multiple argument list apply它能
#让你传入尽可能多的向量作为参数
msg<-function(name,factors){
  ifelse(
    length(factors)==1,
    paste(name," is prime"),
    paste(name," has factors",toString(factors))
  )
}
fac<-factor(sample(letters[1:5],6,replace = TRUE))
names(fac)<-LETTERS[1:6]
mapply(msg,names(fac),fac)
#大多数函数时以数据对象为第一个参数，函数为第二个参数
#mapply的参数顺序是反过来的
#拆分 应用 合并 split apply combine
frogger<-data.frame(
  player=rep(c("tom","dick","harry"),times=c(2,5,3)),
  score=round(rlnorm(10,8),-1)
)
#计算每个玩家的平均得分
#1 按照玩家分开数据
score_by_player<-with(
  frogger,
  split(score,player)
)
#2 将mean用到每一个元素中
list_of_mean_by_player<-lapply(score_by_player,mean)
#3 将结果合并到单个向量中
mean_by_player<-unlist(list_of_mean_by_player)
mean_by_player

#简化方法 使用tapply 函数
with(frogger,tapply(score,player,mean))

#在sql中，其实就是group by

#plyr包
library(plyr)
#plyr包含一系列**ply的函数，其中*代表输入和输出的形式
#llply 代表输入参数是列表，将函数应用到每一个元素上，并返回一个列表
lis<-list(
  sample(letters[1:5],3,replace = TRUE),
  sample(letters[1:5],4,replace = TRUE)
)
llply(lis,unique)
#laply 以一个列表为参数，返回一个数组
laply(lis,length)
#raply 可以取代replicate，还有rlply和rdply函数能分别返回列表或数据
#框，还有一个r_ply函数能丢弃结果
raply(5,runif(1))#数组输出
rlply(5,runif(1))#列表输出
rdply(5,runif(1))#数据框输出
r_ply(5,runif(1))#丢弃输出

#plyr包中最常用的是ddply,她的输入和输出都是数据框

frogger$level<-floor(log(frogger$score))
ddply(
  frogger,
  .(player),#variables to split data frame by 用此列分割数据
  colwise(mean)#使用colwise函数告诉ddply函数应用于每一列（除了第二个参数以外）
)

ddply(
  frogger,
  .(player),
  summarize,#和ddply连用效果十分强大
  mean_score=mean(score),#对score调用mean
  max_level=max(level)#对level调用max
)
#使用colwise指定会更快，但是必须对每一列重复做同一件事
#使用summarize会更灵活，但是需要输入更多的内容

apropos("apply")#Find Objects by (Partial) Name
#lapply vapply sapply 三个函数都接受一个列表 并把函数一次应用到每个元素
#上，他们所不同的是返回值 lapply总是返回一个列表 vapply 总是
#返回一个由模板指定的向量或数组，sapply的返回值也是一样
#rapply是递归的，非常适合访问诸如树这样的深层次嵌套对象

wayans<-list(
  "kim"<-list(),
  "ivory"<-list(
    "ivory imani",
    "ivory jr"
  ),
  "deman"<-list(
    "deman jr",
    "michael"
  )
  
)
vapply(wayans,length,numeric(1))

str(state.x77)
head(state.x77)
class(state.x77)

apply(state.x77,2,mean)
apply(state.x77,2,sd)

commute_times<-replicate(1000,time_for_commute())
commute_times<-data.frame(
  time = commute_times,
  mode =names(commute_times)
)
ddply(
  commute_times,
  .(mode),
  summarize,
  tim_p75 = quantile(time,0.75)
)
with(
  commute_times,
  tapply(time,mode,quantile,prob=0.75)
)

library(devtools)
install_github("knitr","yihui")#从github上安装包

pkgs<-installed.packages()
table(pkgs[,"LibPath"])

#R中有三个时间类 POSIXct POSIXlt date
#POSIX时间和日期是R 的经典程序
#ct是 calendar time的简称 POSIXct记录了以
#世界标准时（UTC）时区为准的从1970年开始计时的秒数计数
#POSIXlt将日期存储为一个列表，其中包含秒，分钟，
#月份等 POSIXct最适合与存储和计算时间，POSIXlt适合
#提取日期中某个特定的部分

now_ct<-Sys.time()
class(now_ct)
#POSIXct类有两个元素，一个元素是POSIXct变量，还有POSIXct继承
#自类POSIXt
unclass(now_ct)
now_lt<-as.POSIXlt(now_ct)
unclass(now_lt)
#POSIXlt和POSIXct内部存储方式相当不同
now_lt$sec
now_lt[["min"]]
#Date类存储了从1970年开始计算的天数，最适合于当你不在乎一天中的
#某个时刻时
now_date<-as.Date(now_ct)
class(now_date)
unclass(now_date)

moon_landing_str<-c(
  "20:17:40 20/07/1969",
  "06:54:35 19/11/1969"
)
#解析日期
moon_landing_lt<-strptime(
  moon_landing_str,
  "%H:%M:%S %d/%m/%Y",
  tz="UTC"
)
#如果字符串不匹配格式字符串中的格式那么取NA值
#格式化日期 %I表示12小时制 %p是AM/PM指示，%A是星期几的全民，%B 是月的全名
strftime(now_ct,"It's %I:%M%p on %A %d %B %Y")

#转换时区
strftime(now_ct,tz="America/Los_Angeles")
#可以给UFT一个偏移量 -5或+5 正的是东边，负的是西边
strftime(now_ct,tz="UFT-5")

now_ct+86400#将数字与POSIX日期相加，会以秒为单位增加时间
now_lt+86400
now_date+1

the_start_of_time<-as.Date("1970-01-01")
the_end_of_time<-as.Date("2012-12-21")
all_time<-the_end_of_time - the_start_of_time
#时间相减是有意义的，代表时间之间的差别 all_time
difftime(the_end_of_time,the_start_of_time,units = "secs")
difftime(the_end_of_time,the_start_of_time,units = "weeks")

seq(the_start_of_time,the_end_of_time,by = "1 year")

methods(class = "POSIXt")

library(lubridate)
john_harrison_birth_date<-c(
  "1693-03 24",
  "1693/03\\24",
  "Tuesday+1693.3*24"
)
ymd(john_harrison_birth_date)
#ymd 要以正确的顺序获取日期

#stamp函数可以格式化日期，当指定一个日期，会返回一个用于日期格式化的函数
date_format_function<-
  stamp("A moon landing occurred on Monday 01 January 1900 at 18:00:00")
date_format_function(moon_landing_lt)


#lubridate 有三种不同类型的变量可用于时间范围的处理
#Duration 持续时间 指定的时间倍数为秒的倍数
#闰年的存在使得日期往后倒了一天
duration_one_to_ten_years<-dyears(1:10)
today()+duration_one_to_ten_years)
#除了years 还有dseconds dminutes
#period 周期 根据时钟上的时间来指定时间跨度,这意味着
#在把他们添加到一个瞬间之前，他们确切的时间跨度是看不出来的
period_one_to_ten_years<-years(1:10)
today()+period_one_to_ten_years
#闰年的日期保持不变
#还可以使用seconds minutes new_period
#interval 间隔定义为某段具有开始和结束的时间
#最常用与指定持续时间和周期
a_year <-dyears(1)
as.period(a_year)
#当起始（或结束）的时间已知时，我们可以使用 interval和一个媒介
#把持续时间转换为周期
start_date<-ymd("2016-02-28")
interval_over_leap_year <- interval(
  start_date,
  start_date+a_year
)
as.period(interval_over_leap_year)
ymd("2016-02-28")%--%ymd("2016-03-01")#用于定义间隔
ymd("2016-02-29")%within% interval_over_leap_year
#用于检查日期是否在间隔之内
#对于时区的处理，with_tz允许你改变日期的时区而无需把它打印出来
with_tz(now_lt,tz="America/Los_Angeles")
head(OlsonNames())#将以字母或经度顺序返回R所知道的所有Olson风格的
#时区名字列表
floor_date(today(),"year")
ceiling_date(today(),"year")

in_string<-c("1940-07-07","1940-10-09")
parsed<-strptime(in_string,"%Y-%m-%d")
out_string<-strftime(parsed,"%a %d %b %y")
out_string

date_format_function<-
  stamp("Wed 07 Jul 40")
date_format_function(strptime("1940-07-07","%Y-%m-%d"))
#写一个函数判断是什么星座
zodiac_sign<-function(x){
  month_x<-month(x,label = TRUE)
  day_x<-day(x)
  switch(
    month_x,
    Jan = if(day_x<20) "Capricorn" else 'Aqurius',
    Feb = if(day_x<19) "Aqurius" else 'Pisces',
  )
}
zodiac_sign(as.Date("2017-01-04"))













