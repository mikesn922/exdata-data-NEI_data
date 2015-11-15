#firstly read data. data should be in the current working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#calculate sum
totalEachYear <- tapply(NEI$Emissions, NEI$year, sum)

#draw figure
png("plot1.png")
barplot(totalEachYear, xlab = "year", ylab = "PM2.5 in tons", main = "Total Emissions of PM2.5 for All Sources in U.S.")

#close device
dev.off()