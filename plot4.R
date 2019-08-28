# Across the United States, how have emissions from coal combustion-related sources changed 
# from 1999–2008?
 
library("ggplot2")
library("ggpubr")

# Find all the coal combustion related sources

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

CoalCombustionSources <- SCC[SCC$EI.Sector == "Fuel Comb - Comm/Institutional - Coal",]["SCC"]

emissionsFromCoal <- NEI[NEI$SCC %in% CoalCombustionSources$SCC,]

totalEmissionsByYear <- tapply(emissionsFromCoal$Emissions,emissionsFromCoal$year,sum)

png(filename="plot4.png")
par(mfrow=c(1,1))
plot(x=c(1999,2002,2005,2008),y=totalEmissionsByYear,xlab="Year",ylab="Total Emissions by Year",type="l",xlim=c(1999,2008),main="Coal-releated source emissions")
dev.off()