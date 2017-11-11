#Coin sizes vector
coinSizes <- c(1, 2, 5, 10, 20, 50, 100, 200)

#Create a vector with 201 zeros
ways <- rep(0, 201)
#First position of the vector corresponds to 0 pound
ways[1] = 1

for (coinSize in coinSizes){
  for(i in coinSize:length(ways)){
    if(i-coinSize > 0){
      ways[i] = ways[i] + ways[i-coinSize]  
    }
  }
}

total <- ways[201]