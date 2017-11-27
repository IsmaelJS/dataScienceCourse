library(lubridate)
library(rvest)

get_df_meteo <- function(month, year){
  ##Get number of days of the month
  if(month < 12){
    n_days <- day (as.Date(paste(year,month + 1,1, sep="-")) - 1)   
  }else{
    n_days <- day (as.Date(paste(year+1, 1, 1, sep="-")) - 1) 
  }
  url = paste("http://www.ogimet.com/cgi-bin/gsynres?ord=REV&decoded=yes&ndays=",n_days, "&ano=", year, "&mes=", month, "&day=", n_days,"&hora=24&ind=08221", sep="")
  webpage <- read_html(url)
  data_table <- html_table(html_nodes(webpage, "table table")[[2]])
    df <- data.frame(date = as.POSIXct(x = paste(data_table[-1,1],data_table[-1,2]), format= "%d/%m/%Y %H:%M", tz="GMT"), "T(C)" = as.double(data_table[-1,3]), "ddd" = data_table[-1,7], "ff-kmh" = as.double(data_table[-1,8]), stringsAsFactors = FALSE) 
}

list_df_meteo <- lapply(1:12, get_df_meteo, 2008 )

df_meteo <- do.call("rbind", list_df_meteo)

colnames(df_meteo) <- c("date", "hour", "T(C)", "ddd", "ff kmh")

sorted_df_meteo<- df_meteo[order(df_meteo[,1]),]

##We figure out the #6896 observation has missing values in column 2 and 4, that refers to T(C) and ff-kmh

row_with_missing_values <- which(is.na(sorted_df_meteo), arr.ind=TRUE)

##Clean rows with missing values

clean_df_meteo <- na.omit(sorted_df_meteo)

##Summary of df

summary(clean_df_meteo)