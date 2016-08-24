## Working directory & file location
setwd("~/datasciencecoursera/ExploratoryDataAnalysis/ProjectWk4/")

## Load the ggplot library
library(ggplot2)

## Read the data files into memory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset Baltimore emissions data
baltNEI <- NEI[NEI$fips=="24510",]

## Aggregate Baltimore emissions data by year
aggTotBalt <- aggregate(Emissions ~ year, baltNEI, sum)

## Create the ggplot
baltGGplot <- ggplot(baltNEI,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity") +
  theme_bw() + guides(fill=FALSE)+
  facet_grid(.~type,scales = "free", space="free") + 
  labs(x="Year", y=expression("PM2.5 Emissions (Tons)")) + 
  labs(title=expression("PM2.5 Baltimore Emissions (by Source)"))
print(baltGGplot)

## Save the plot to the working directory
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()