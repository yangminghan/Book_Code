#R语言实战 第九章
#方差分析
data(CO2)
w1b1 <- subset(CO2, Treatment == "chilled")
head(w1b1)
summary(w1b1)
fit <-aov(uptake ~ conc * Type +Error(Plant/(conc)),w1b1)
summary(fit)
