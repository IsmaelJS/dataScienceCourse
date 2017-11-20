### Get the address from (lat= "51.4965946", lon="-0.1436476")
r_address <- GET("http://nominatim.openstreetmap.org/reverse", query= list(format = "json", lat= "51.4965946", lon="-0.1436476"))
address <- content(r_address)$address

### Get number of crimes commited in that location in April 2017
r_crimes <- GET("https://data.police.uk/api/crimes-at-location", query= list(date = "2017-04",  lat = "51.4965946", lng="-0.1436476") )
list_crimes <- content(r_crimes)
paste(length(list_crimes), "crimes were commited in April 2017") 

### Count crimes by category

#Get category names
category_names_r <- GET("https://data.police.uk/api/crime-categories", query = list(date = "2017-04"))
category_names <- content(category_names_r)
names(category_names) <- lapply(category_names, function(x){x$url})

#Get crimes by category
crimes_by_category <- vapply(list_crimes, function(crime){category_names[[crime$category]]$name}, FUN.VALUE = character(1))

#Show table of frequencies with number of crimes of each category
table(crimes_by_category)
