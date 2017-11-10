# Vector from 1 to 999
input <- 1:999

#Vector with multiples of 3 or 5
multiples <- input[(input %% 3) == 0 | (input %% 5) == 0]

#Sum of components of the vector
sum_multiples <- sum(multiples)

#Print the result
sum_multiples
