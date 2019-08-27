# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510" |fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.
# 
library("dplyr")

NEI <- readRDS("summarySCC_PM25.rds")

baltimore99 <- subset(NEI,fips=="24510" & year=="1999")
baltimore08 <- subset(NEI,fips=="24510" & year=="2008")

emissions_baltimore99 <- log10(as.numeric(baltimore99$Emissions))
emissions_baltimore08 <- log10(as.numeric(baltimore08$Emissions))

png(filename = "plot2.png")
boxplot(emissions_baltimore99,emissions_baltimore08,names = c("1999","2008"),main="Baltimore City Emissions")
dev.off()