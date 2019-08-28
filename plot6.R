# 
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources 
# in Los Angeles County, California (fips == "06037" and fips=="06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

motorVehicleSources <-  unique(grep("Vehicles",SCC$EI.Sector,ignore.case = TRUE, value = TRUE))
motorVehicleSourceCodes <- SCC[SCC$EI.Sector %in% motorVehicleSources, ]["SCC"]

emissionFromMotorVehiclesInBaltimore <- NEI[NEI$SCC %in% motorVehicleSourceCodes$SCC & NEI$fips == "24510", ]
emissionFromMotorVehiclesInCalifornia <- NEI[NEI$SCC %in% motorVehicleSourceCodes$SCC & NEI$fips == "06037", ]

totalMotorVehicleEmissionsByYearBaltimore <- tapply(emissionFromMotorVehiclesInBaltimore$Emissions,emissionFromMotorVehiclesInBaltimore$year, sum)
totalMotorVehicleEmissionsByYearCalifornia <- tapply(emissionFromMotorVehiclesInCalifornia$Emissions,emissionFromMotorVehiclesInCalifornia$year, sum)


png(filename = "plot6.png")

g <- ggplot() + geom_line(aes(x=seq(1999,2008,by=3),y=totalMotorVehicleEmissionsByYearBaltimore),colour = "red") + geom_line(aes(x=seq(1999,2008,by=3),y=totalMotorVehicleEmissionsByYearCalifornia),colour = "green")
g <- g + labs(colour="Type")+xlab("Year") + ylab("Total Vechicle Emissions") 
g <- g + scale_colour_discrete(name = "County")
g

dev.off()

