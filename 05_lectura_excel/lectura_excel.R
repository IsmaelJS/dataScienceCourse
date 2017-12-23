library(stringr)
library(readxl)
library(plyr)
library(data.table)

first_row_data_default <- 3

first_row_data_exceptions <- c("1992"=2, "2009"=2, "2012"=4, "2013"=4, "2014"=4, "2015"=4)
data_url <- "http://www.ine.es/pob_xls/pobmun.zip"

## Get year from filename
get_year <- function(filename){
  two_digits_year <- as.numeric(str_extract(pattern = "[0-9]{2}", string = filename))
  if (two_digits_year >= 90){
    return( two_digits_year + 1900)
  } else {
    return(two_digits_year + 2000)
  }
}
## Get first row
get_first_row <- function(year){
  if(is.element(as.character(year), names(first_row_data_exceptions))){
    return(first_row_data_exceptions[as.character(year)])
  }else{
    return(first_row_data_default)
  }
}


read_population <- function(filepath, year){
  row_index <- get_first_row(year)
  df <- read_excel(path= filepath, skip = row_index - 2)
  if(ncol(df) == 6){
    return(df[complete.cases(df),c(1,2,4)])
  }else{
    return(df[complete.cases(df),c(1,3,5)])
  }
}

import_file_data <- function(path){
  year <- get_year(path)
  df <- read_population(path, year)
  colnames(df) <- c("CPRO", "CMUN", "POBTOTAL")
  df$ANNO <- year
  return(df)
} 
temp <- tempfile()

zip_file <- download.file(url = data_url, destfile=temp)

list_files <- unzip(temp)

list_df <- lapply(list_files, import_file_data)

merged_df <- rbindlist(list_df)

write.table(merged_df[order(merged_df$ANNO)], file = "resultado.csv",row.names=FALSE, sep=";")

lapply(list_files, file.remove)

unlink(temp)