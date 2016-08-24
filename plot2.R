## Working directory & file location
setwd("~/datasciencecoursera/ExploratoryDataAnalysis/ProjectWk4/")

## Read the data files into memory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset Baltimore emissions data
baltNEI <- NEI[NEI$fips=="24510",]

## Aggregate Baltimore emissions data by year
aggTotBalt <- aggregate(Emissions ~ year, baltNEI, sum)

## Create the barplot
barplot(
  aggTotBalt$Emissions,
  names.arg=aggTotBalt$year,
  xlab="Year",
  ylab="PM2.5 Emissions (Tons)",
  main="Total Baltimore PM2.5 Emissions (All Sources)")

## Save the plot to the working directory
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()