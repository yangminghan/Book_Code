#Advance R 笔记
#空引用结合赋值操作会比较有用，因为会保持原有的对象类和数据结构
mtcars[]<-lapply(mtcars,as.integer)
mtcars<-lapply(mtcars,as.integer)
str(mtcars)
#对于列表可以使用子集选取+赋值+NULL的方式去除列表中的元素
x<-list(a=1,b=2)
x
x[["b"]]<-NULL
#使用[]和list(null)在列表中添加合法的NULL
y<-list(a=1)
y["b"]<-list(NULL)
str(y)
#字符匹配为创建查询表提供了一个强大的办法
#例如 你想将简写转换为全拼
x<-c("m","f","m","u","f","m")
lookup<-c(m="Male",f="Female",u=NA)
lookup[x]
unname(lookup[x])

grade<-c(1,2,2,3,1)
infr<-data.frame(
  grade=3:1,
  desc=c("Excellent","Good","Poor"),
  fail=c(F,F,T)
)
id<-match(grade,infr$grade)
id
infr[id,]
