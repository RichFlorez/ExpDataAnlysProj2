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

## Subset Baltimore motor vehicle NEI Data
baltMtrVehNEI <- mtrVehNEI[mtrVehNEI$fips=="24510",]

## Create the ggplot
baltGGplot <- ggplot(baltMtrVehNEI, aes(factor(year), Emissions)) +
  geom_bar(stat="identity", fill="grey", width=0.75) +
  theme_bw() + guides(fill=FALSE) +
  labs(x="Year", y=expression("PM2.5 Emissions (100k Tons)")) + 
  labs(title=expression("Baltimore PM2.5 Motor Vehicle Emissions"))
print(baltGGplot)

## Save the plot to the working directory
dev.copy(png, file="plot5.png", height=480, width=480)
dev.off()