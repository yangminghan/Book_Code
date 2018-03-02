#R语言实战
#第6章 基本图形
library(vcd)
counts <- table(Arthritis$Improved)

barplot(counts,
  main = "Simple Bar Plot",
  xlab = "Improved",
  ylab = "Frequency"
)

barplot(counts,
        main = "Simple Bar Plot",
        xlab = "Frequency",
        ylab = "Improved",
        horiz = TRUE)

plot(Arthritis$Improved,
     main = "Simple Bar Plot",
     xlab = "Improved",
     ylab = "Frequency")#horiz 横向放置

counts <- table(Arthritis$Improved, Arthritis$Treatment)

barplot(counts,
        main = "Stacked Barf Plot",
        xlab = "Treatment",
        ylab = "Frequency",
        col = c("red","yellow","green"),
        legend = rownames(counts))

barplot(counts,
        main = "Stacked Barf Plot",
        xlab = "Treatment",
        ylab = "Frequency",
        col = c("red","yellow","green"),
        legend = rownames(counts),
        beside = TRUE)

states <- data.frame(state.region, state.x77)
means <- aggregate(states$Illiteracy, by = list(state.region),FUN = mean)
means <- means[order(means$x)]

barplot(means$x, names.arg = means$Group.1)
title("Mean Illiteracy Rate")

par(mar = c(5,8,4,2))
par(las = 2)
counts <- table(Arthritis$Improved)

barplot(counts,
        main = "Treatment Outcome",
        horiz = TRUE,
        cex.names = 0.8,
        names.arg = c("No Improement","Some Improvement","Marked Improvement"))

#par 函数设定参数

attach(Arthritis)
counts <- table(Treatment, Improved)
spine(counts, main = "Spinogram Example")
detach(Arthritis)
#spinogram 每一个条形的高度均为1，每一段的高度代表比例

par(mfrow = c(2,2))
slices <- c(10,12,4,16,8)
lbls <-c("US", "UK",)







