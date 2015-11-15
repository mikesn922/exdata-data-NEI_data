library(ggplot2)

#firstly read data. data should be in the current working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#subset data for baltimore city, and  Los Angeles County
baltimoreData <- subset(NEI, fips == "24510")
losAngelesData <- subset(NEI, fips == "06037")

#find motor vehicle sources in the classification_code file
#here we try to find the vehicle in each level of the SCC
match1 <- grepl("[Vv]ehicles", SCC$SCC.Level.One, ignore.case = T)
match2 <- grepl("[Vv]ehicles", SCC$SCC.Level.Two, ignore.case = T)
match3 <- grepl("[Vv]ehicles", SCC$SCC.Level.Three, ignore.case = T)
match4 <- grepl("[Vv]ehicles", SCC$SCC.Level.Four, ignore.case = T)
#combine the findings together
match <- (match1 | match2 | match3 | match4)
motorSCC <- SCC[match, ]$SCC
#subset the Data with the SCC
motorNEI_baltimore <- baltimoreData[baltimoreData$SCC %in% motorSCC, ]
motorNEI_losAngeles <- losAngelesData[losAngelesData$SCC %in% motorSCC, ]
#row binding data
bothData <- rbind(motorNEI_baltimore, motorNEI_losAngeles)

#change the fips to the city name
cityNames <- list("06037" = "Los Angeles", "24510" = "Baltimore")
#generate a labeller function
cityName_labeller <- function(variable, value){
    return (cityNames[value])
}

#draw figure
png("plot6.png")
fig <- ggplot(bothData, aes(x = factor(year), y = Emissions, fill = fips)) + 
    geom_bar(stat="identity", aes(fill = year)) +
    theme_bw() +
    guides(fill=FALSE) +
    facet_grid(.~fips, labeller = cityName_labeller) +
    labs(x = "year", y = "Total PM2.5 Emisson in Tons") +
    labs(title = "PM2.5 Emission from Motor Vehicle Sources in Baltimore & LA")

print(fig)
#close device
dev.off()