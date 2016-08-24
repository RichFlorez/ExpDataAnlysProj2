## Working directory & file location
setwd("~/datasciencecoursera/ExploratoryDataAnalysis/ProjectWk4/")

## Load the ggplot library
library(ggplot2)

## Read the data files into memory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset combustion NEI data
cmbstnRel <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coalRel <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coalcmbstn <- (cmbstnRel & coalRel)
cmbstnSCC <- SCC[coalcmbstn,]$SCC
cmbstnNEI <- NEI[NEI$SCC %in% cmbstnSCC,]

## Create the ggplot
baltGGplot <- ggplot(cmbstnNEI, aes(factor(year), Emissions/10^5)) +
  geom_bar(stat="identity", fill="grey", width=0.75) +
  theme_bw() + guides(fill=FALSE) +
  labs(x="Year", y=expression("PM2.5 Emissions (100k Tons)")) + 
  labs(title=expression("US PM2.5 Coal Combustion Emissions"))
print(baltGGplot)

## Save the plot to the working directory
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()