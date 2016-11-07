library(data.table)

#intializing the url for file download
file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

#checking if the zip exists or else download it
if(!file.exists("power_consumption.zip")){
        download.file(file_url,method = "curl",destfile = "power_consumption.zip")
        downloadDate<- date()
        unzip("power_consumption.zip",exdir = "./power_consumption")
        #data_idaho<-read.csv("acs.csv",sep = ",",header = TRUE)
}

#reading the data from household_power_consumption.txt to data frame using read.table
powerData <- read.table(file = "power_consumption/household_power_consumption.txt",stringsAsFactors = FALSE,header = TRUE,sep = ";")

#subsetting the data based on dates
powerData<-powerData[grep("^[1,2]/2/2007",powerData$Date),]

#combining the date and time to create a timestamp variable
powerData$timeStamp <- paste(powerData$Date,powerData$Time,sep = " ")

#initializing graphic device
png("plot1.png", width=480, height=480)
hist(as.numeric(powerData$Global_active_power),col = "red",xlab = "Global Active Power (Kilowatts)",main = "Global Active Power")
dev.off()