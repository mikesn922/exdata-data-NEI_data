#firstly read data. data should be in the current working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#subset for the Baltimore City
baltimoreData <- subset(NEI, fips == "24510")
#calculate sum
totalBaltimore <- tapply(baltimoreData$Emissions, baltimoreData$year, sum)

#draw figure
png("plot2.png")
barplot(totalBaltimore, xlab = "year", ylab= "PM2.5 in tons", main = "Total PM2.5 Emissions for All Sources in Baltimore City")

#close device
dev.off()