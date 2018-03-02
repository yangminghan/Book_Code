#数据科学中的R语言 学习笔记
#第二章 数据对象
vector1<-1:10
vector2<-seq(from=1,to=10,by=2)

vector1<-1:10+2
vector2<-1:(10+2)
#计算sin函数从0到pi的曲线下面积
n<-1000
h<-seq(from=0,to=pi,length.out = n)
w<-pi/n
rect<-sin(h)*w
sum(rect)
#第三章 数据操作
func<-function(x){
  if(x%%2==0){
    ret<-"偶数"
  }else{
    ret<-"奇数"
  }
  return(ret)
}
vec<-round(runif(4)*100)
sapply(vec,func)
#将自定义函数改装成可以接受向量的函数
funcv<-Vectorize(func)
funcv(vec)
#使用ifelse 
ifelse(vec%%2,"odd","even")

#计算变异系数 
op<-options()
options(digits = 2)#控制小数点后两位
sapply(iris[,1:4],function(x) sd(x)/mean(x))
options(op)

#sapply对列表进行计算
mylist<-as.list(iris[,1:4])
sapply(mylist,mean)
#lapply 返回一个列表
lapply(mylist,mean)

myfunc<-function(x){
  ret<-c(mean(x),sd(x))
  return(ret)
}
result<-lapply(mylist,myfunc)

#将列表转换为矩阵
#先转成数据框，再转置
t(as.data.frame(result))
#使用取子集的二元操作符作为sapply的参数
t(sapply(result,"["))
#利用do.call 将result传入rbind函数中
do.call("rbind",result)
#计算矩阵
set.seed(1)
vec<-round(runif(12)*100)
mat<-matrix(vec,3,4)
apply(mat,MARGIN = 1,sum)
apply(mat,MARGIN = 2,sum)

#根据某一个分类变量进行分类计算
tapply(X=iris$Sepal.Length,INDEX = list(iris$Species),FUN = mean)
#与tapply类似的还有aggregate
with(iris,aggregate(Sepal.Length, by=list(Species),mean))

head(iris)
