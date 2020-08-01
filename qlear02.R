library(nnet)

R <- matrix(c(-1, -1, -1, -1, 0, -1,
              -1, -1, -1, 0, -1, 0,
              -1, -1, -1, 0, -1, -1, 
              -1, 0, 0, -1, 0, -1,
              0, -1, -1, 0, -1, 0,
              -1, 100, -1, -1, 100, 100), nrow=6, ncol=6, byrow=TRUE)
  
q.learn <- function(R, N, alpha, gamma, tgt.state) {
  ## initialize Q to be zero matrix, same size as R
  Q <- matrix(rep(0,length(R)), nrow=nrow(R))
  ## loop over episodes
  for (i in 1:N) {
    ## for each episode, choose an initial state at random
    cs <- sample(1:nrow(R), 1)
    ## iterate until we get to the tgt.state
    while (1) {
      ## choose next state from possible actions at current state
      ## Note: if only one possible action, then choose it;
      ## otherwise, choose one at random
      next.states <- which(R[cs,] > -1)
      if (length(next.states)==1)
        ns <- next.states
      else
        ns <- sample(next.states,1)
      ## this is the update
      Q[cs,ns] <- Q[cs,ns] + alpha*(R[cs,ns] + gamma*max(Q[ns, which(R[ns,] > -1)]) - Q[cs,ns])
      ## break out of while loop if target state is reached
      ## otherwise, set next.state as current.state and repeat      
      if (ns == tgt.state) break
      cs <- ns
    }
  }
  ## return resulting Q normalized by max value
  return(100*Q/max(Q))
}

results <- q.learn(R,10000,alpha=0.1,gamma=0.8,tgt.state=6)
results <- as.data.frame(results)

colnames(results) <- c("0","1","2","3","4","5")
rownames(results) <- c("0","1","2","3","4","5")

round(results,0)

for(i in 1:ncol(results)){

  if(results[i,6] > 0) {
    output <- paste("Si te encontras en ",i -1 ,"ahora dirigite a 5 y encuentras la salida")
  } else {
       if(results[which.is.max(results[i,]),6] > 0 ){
         output <-paste("Si te encontras en",i -1,"dirigete a",which.is.max(results[i,]) -1,"y encontraste la salida en 5")
  } else {
    output <-paste("Si te encuentras en",i - 1," ahora dirigete a",which.is.max(results[i,]) -1,"y luego a",which.is.max(which.is.max(results[i,])),
         "ahi encontraras la salida")
  }}
print(output)
}