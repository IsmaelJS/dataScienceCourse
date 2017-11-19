#Make a GET request to the API
r <- GET("http://www.cartociudad.es/services/api/geocoder/reverseGeocode", query = list(lat = 36.9003409, lon=-3.4244838))

#Extract the body from the response
content(r)

#Extract the HTTP status code from the response
status_code(r)

#Extract the headers from response
headers(r)

