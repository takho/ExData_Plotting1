#JHU- Exploratory Data Analysis Project1- Plot2
#========================================================

#The supplied datafile "household_power_consumption.txt" is downloaded to my local directory, e:\courses\jh-dataexplore\ws_dataexplore
#This script show how the data is subsetted and the plot into a PNG file

#```{r grep to extract data with 2007-02-01 and 2007-02-02}
# set localdirectory 
setwd("e://courses//jh-dataexplore//ws_dataexplore")
f <- file("household_power_consumption.txt","rt");

# setup a pipe to extract data that matches 2007-02-01 and 2007-02-02
nolines <- 100
greped<-c()
repeat {
  lines=readLines(f,n=nolines)       #read lines
  idx <- grep("^[12]/2/2007", lines) #find those that match
  greped<-c(greped, lines[idx])      #add the found lines
  #
  if(nolines!=length(lines)) {
    break #are we at the end of the file?
  }
}

#now we create a text connection and load data
tc<-textConnection(greped,"rt")
df<-read.csv(tc,sep=";",header=TRUE)
close(f)

# rename the column of dataframe df into original meaningful names
names(df)[1] <- "Date"
names(df)[2] <- "Time"
names(df)[3] <- "Global_active_power"
names(df)[4] <- "Global_reactive_power"
names(df)[5] <- "Voltage"
names(df)[6] <- "Global_intensity"
names(df)[7] <- "Sub_metering_1"
names(df)[8] <- "Sub_metering_2"
names(df)[9] <- "Sub_metering_3"

#``` The aboves lines are exactly the same proc as for plot1

# change the date time into column into dateTime class and append to 
#  the a new data.frame df2
datetime <- as.POSIXct(strptime(paste(df$Date, df$Time),format='%d/%m/%Y %H:%M:%S'))
df2 <- cbind(df, datetime)


#Plot the required graph with PNG devices

#```{r plot1, width=480px  height=480px}
png(filename = "plot2.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
with(df2, plot(datetime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)") )
dev.off()

#```

