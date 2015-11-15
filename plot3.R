library(ggplot2)

#firstly read data. data should be in the current working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#subset for the Baltimore City
baltimoreData <- subset(NEI, fips == "24510")

#draw figure
png("plot3.png")
fig <- ggplot(baltimoreData,aes(factor(year),Emissions,fill=type)) + 
     geom_bar(stat="identity") +
     theme_bw() +
     guides(fill=FALSE) +
     facet_grid(.~type) +
     labs(x = "year", y = "Total PM2.5 Emisson in Tons") +
     labs(title = "Total PM2.5 Emission in Baltimore City by Source Type")

print(fig)
#close device
dev.off()