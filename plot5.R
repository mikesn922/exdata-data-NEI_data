library(ggplot2)

#firstly read data. data should be in the current working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#subset data for baltimore city
baltimoreData <- subset(NEI, fips == "24510")

#find motor vehicle sources in the classification_code file
#here we try to find the vehicle in each level of the SCC
match1 <- grepl("[Vv]ehicles", SCC$SCC.Level.One, ignore.case = T)
match2 <- grepl("[Vv]ehicles", SCC$SCC.Level.Two, ignore.case = T)
match3 <- grepl("[Vv]ehicles", SCC$SCC.Level.Three, ignore.case = T)
match4 <- grepl("[Vv]ehicles", SCC$SCC.Level.Four, ignore.case = T)
#combine the findings together
match <- (match1 | match2 | match3 | match4)
motorSCC <- SCC[match, ]$SCC
#subset the baltimoreData with the SCC
motorNEI <- baltimoreData[baltimoreData$SCC %in% motorSCC, ]

#draw figure
png("plot5.png")
fig <- ggplot(motorNEI,aes(factor(year),Emissions)) + 
    geom_bar(stat="identity", fill = "grey") +
    theme_bw() +
    guides(fill=FALSE) +
    labs(x = "year", y = "Total PM2.5 Emisson in Tons") +
    labs(title = "Total PM2.5 Emission from Motor Vehicle Sources in Baltimore City")

print(fig)
#close device
dev.off()