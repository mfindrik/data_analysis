# How have emissions from motor vehicle sources changed from 1999–2008 in
# Baltimore City?


motorVehicleSources <-  unique(grep("Vehicles",SCC$EI.Sector,ignore.case = TRUE, value = TRUE))
motorVehicleSourceCodes <- SCC[SCC$EI.Sector %in% motorVehicleSources, ]["SCC"]

emissionFromMotorVehiclesInBaltimore <- NEI[NEI$SCC %in% motorVehicleSourceCodes$SCC & NEI$fips == "24510", ]

totalMotorVehicleEmissionsByYear <- tapply(emissionFromMotorVehiclesInBaltimore$Emissions,emissionFromMotorVehiclesInBaltimore$year, sum)

png(filename="plot5.png")
par(mfrow=c(1,1))
plot(x=c(1999,2002,2005,2008),y=totalEmissionsByYear,xlab="Year",ylab="Total Emissions by Year for Motor Vehicles",type="l",xlim=c(1999,2008),main="Coal-releated source emissions")
dev.off()