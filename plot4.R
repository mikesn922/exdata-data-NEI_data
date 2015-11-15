library(ggplot2)

#firstly read data. data should be in the current working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#find coal combustion-related sources in the classification_code file
match <- grepl("coal", SCC$Short.Name, ignore.case = T)
coalSCC <- SCC[match, ]$SCC
coalNEI <- NEI[NEI$SCC %in% coalSCC, ]

#draw figure
png("plot4.png")
fig <- ggplot(coalNEI,aes(factor(year),Emissions)) + 
    geom_bar(stat="identity", fill = "grey") +
    theme_bw() +
    guides(fill=FALSE) +
    labs(x = "year", y = "Total PM2.5 Emisson in Tons") +
    labs(title = "Total PM2.5 Emission from Coal Combustion in U.S.")

print(fig)
#close device
dev.off()