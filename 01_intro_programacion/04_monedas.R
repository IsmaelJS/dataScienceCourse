#Coin values vector in pennies
coinValues <- c("1p"=1, "2p"=2, "5p"=5, "10p"=10, "20p"=20, "50p"=50, "£1"=100, "£2"=200)

#Create a vector with 201 zeros. Each component represents the number of ways to return index-1 pennies using coins with values
#in coinValues vector
ways <- rep(0, 201)

#Initialization of the vector. It's only one way to return 1-1 = 0 pennies.
ways[1] = 1

for (coinValue in coinValues){
  for(i in coinValue:length(ways)){
    if(i-coinValue > 0){
      ways[i] = ways[i] + ways[i-coinValue]  
    }
  }
}

#Number of ways to return 2 pounds
total <- ways[201]

#Print out the result
paste("£2 can be made with", total, "combinations using", paste(names(coinValues), collapse=", "), "coins", sep=" ")
