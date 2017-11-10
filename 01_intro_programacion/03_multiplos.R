input <- 1:1000
multiples <- input[(input %% 3) == 0 | (input %% 5) == 0]
suma <- sum(multiples)

