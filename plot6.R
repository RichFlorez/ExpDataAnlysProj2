## Working directory & file location
setwd("~/datasciencecoursera/ExploratoryDataAnalysis/ProjectWk4/")

## Load the ggplot library
library(ggplot2)

## Read the data files into memory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset motor vehicle NEI data
mtrVeh <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
mtrVehSCC <- SCC[mtrVeh,]$SCC
mtrVehNEI <- NEI[NEI$SCC %in% mtrVehSCC,]

## Subset motor vehicles NEI data by city
mtrVehBaltNEI <- mtrVehNEI[mtrVehNEI$fips=="24510",]
mtrVehBaltNEI$city <- "Baltimore"
mtrVehLosAngNEI <- mtrVehNEI[mtrVehNEI$fips=="06037",]
mtrVehLosAngNEI$city <- "Los Angeles"

## Combine Baltimore & LA NEI data
baltLosAngNEI <- rbind(mtrVehBaltNEI,mtrVehLosAngNEI)

## Create the ggplot
baltGGplot <- ggplot(baltLosAngNEI, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  theme_bw() + guides(fill=FALSE) +
  labs(x="Year", y=expression("PM2.5 Emissions (100k Tons)")) + 
  labs(title=expression("Baltimore vs Los Angeles PM2.5 Motor Vehicle Emissions"))
print(baltGGplot)

## Save the plot to the working directory
dev.copy(png, file="plot6.png", height=480, width=480)
dev.off()