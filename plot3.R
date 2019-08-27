# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.
# 
library("ggplot2")
library("ggpubr")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

both <- left_join(NEI,SCC)
baltimore_point <- subset(NEI,fips=="24510" & type=="POINT")
baltimore_npoint <- subset(NEI,fips=="24510" & type=="NONPOINT")
baltimore_onroad <- subset(NEI,fips=="24510" & type=="ON-ROAD")
baltimore_nroad <- subset(NEI,fips=="24510" & type=="NON-ROAD")

p1 <- ggplot(baltimore_point,aes(x=year,y=log10(Emissions),group=year)) + geom_boxplot() + labs(title = "Point")
p2 <- ggplot(baltimore_npoint,aes(x=year,y=log10(Emissions),group=year)) + geom_boxplot() + labs(title = "Non-Point")
p3 <- ggplot(baltimore_onroad,aes(x=year,y=log10(Emissions),group=year)) + geom_boxplot() + labs(title = "On-Road")
p4 <- ggplot(baltimore_nroad,aes(x=year,y=log10(Emissions),group=year)) + geom_boxplot() + labs(title = "Non-Road")

png(filename = "plot3.png")
ggarrange(p1,p2,p3,p4,nrow = 2,ncol = 2)
dev.off()