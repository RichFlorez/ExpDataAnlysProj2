## Working directory & file location
setwd("~/datasciencecoursera/ExploratoryDataAnalysis/ProjectWk4/")

## Read the data files into memory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Aggregate total emissions by year
aggTotByYr <- aggregate(Emissions ~ year, NEI, sum)

## Create the barplot
barplot(
  (aggTotByYr$Emissions)/10^6,
  names.arg=aggTotByYr$year,
  xlab="Year",
  ylab="PM2.5 Emissions (Millions of Tons)",
  main="Total PM2.5 Emissions (All Sources)")

## Save the plot to the working directory
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()