#主成分和因子分析
##主成分分析
###判断主成分个数
library(psych)
fa.parallel(USJudgeRatings[,-1], fa = "pc", n.iter =100,
            show.legend = FALSE, main = "Scree plot with parallel analysis")
#展示了基于观测特征值的碎石检验（由线段和x符号组成），根据100个随机数据矩阵推到出来的
#特征值均值（虚线）以及大于1的特征值准则（y=1）的水平线
#三种准则表明只需要一个主成分即可保留数据集的大部分信息
pc <- principal(USJudgeRatings[,-1], nfactors = 1)
#r 相关系数矩阵或者原始数据矩阵
#nfactor 设定主成分数
#rotate 指定旋转方法
#socre 设定是否需要计算主成分得分
pc
#PC1 成分载荷  component loading  可以用来解释主成分的含义
#h2 成分公因子方差 主成分对每个变量的方差解释度 
#u2 成分唯一性，方差无法被主成分解释的部分 1-h2
#PHYS 80%可以用第一主成分解释，20%不能

fa.parallel(Harman23.cor$cov, n.obs = 302, fa = "pc", n.iter = 100,
            show.legend = FALSE, main = "Scree plot with parallel analysis")
#选择前两个主成分
pc <- principal(Harman23.cor$cov, nfactors = 2, rotate = "none")
pc

# Proportion Var        0.58 0.22 第一主成分解释了58%的方差，第二主成分解释了22%的方差
# Cumulative Var        0.58 0.81
#两者共解释了81%的方差

#主成分旋转
rc <- principal(Harman23.cor$cov, nfactors = 2, rotate = "varimax")
rc

#获取主成分得分
pc <- principal(USJudgeRatings[,-1], nfactors = 1, scores = TRUE)
head(pc$scores)

cor(USJudgeRatings$CONT, pc$scores)
#获取主成分得分的系数
rc<-principal(Harman23.cor$cov, nfactors = 2,rotate = "varimax")
round(unclass(rc$weights),2)
#pc1 =0.28*height +0.3*arm.span....


#探索性因子分析
options(digits = 2)
covariances <- ability.cov$cov
correlations <-cov2cor(covariances)
correlations
fa.parallel(correlations, n.obs = 112, fa = "both", n.iter = 100,
            main = "Scree plot with parallel analysis")

fa <-fa(correlations, nfactors = 2, rotate = "none", fm ="pa")
fa
#两个因子解释了六个心理学测验60%的方差 Cumulative Var        0.46 0.60

#因子旋转
fa.varimax <- fa(correlations, nfactors =2, rotate ="varimax",fm ="pa")
fa.varimax
#reading 和 vocab 在第一因子上的载荷较大
#picture和blocks，maze在第二因子上的载荷较大
#general 在两个因子上的载荷较为平均
#正交旋转将人为的强制两个因子不相关，若允许两个因子相关，则使用斜交转轴法
fa.promax <-fa(correlations, nfactors=2,rotate= "Promax", fm ="pa")
fa.promax

fsm <- function(oblique){
  if(class(oblique)[2] == "fa"& is.null(oblique$Phi)){
    warning("Object does not look like oblique EFA")
  }else{
    P <-unclass(oblique$loading)
    F <- P%*% oblique$Phi
    colnames(F) <-c("PA1","PA2")
    return(F)
  }
}
fsm(fa.promax)

factor.plot(fa.promax,labels = rownames(fa.promax$loadings))
fa.diagram(fa.promax,simple = FALSE)

fa.promax$weights


