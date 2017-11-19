# Get the address from the next latitude and longitude
r <- GET("http://nominatim.openstreetmap.org/reverse?", query= list(format = "json", lat= "51.4965946", lon="-0.1436476"))
address <- content(r)$address

#Get number of crimes commited in that location in April 2017
r_crimes <- GET("https://data.police.uk/api/crimes-at-location", query= list(date = "2017-04",  lat = "51.4965946", lng="-0.1436476") )
list_crimes <- content(r_crimes)
paste(length(list_crimes), "crimes were commited in April 2017") 

#Count crimes by category
category_names <- GET("https://data.police.uk/api/crime-categories", query= list(date = "2017-04"))
category_names_list <- content(category_names)
names(category_names_list) <- lapply(category_names_list, function(x){x$url})

crimes_by_category <- vapply(list_crimes, '[[', "category", FUN.VALUE = character(1))


table(vapply(crimes_by_category, function(x){category_names_list[[x]]$name}, FUN.VALUE = character(1)))

