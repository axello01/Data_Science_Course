rm(list=ls())

alpha <- letters
order <- c(1:26)

alpha_order <- data.frame(letters,order)

phrase <- c("seeyouatnoon")
key    <- c("cafe")

length_phrase <- nchar(phrase)
length_key    <- nchar(key)

n_repeat_key  <- length_phrase/length_key + 1
full_key <- paste(replicate(n_repeat_key, key),collapse="")
full_key_final <- substring(full_key, 1, length_phrase)

key_df <- as.data.frame(strsplit(full_key_final,""))
names(key_df) <- c("key")

df_phrase <- list() 
for (i in 1:nchar(phrase)) {
  str_i <- substr(phrase, i,i)
  pos_i <- as.numeric(na.omit(match(alpha_order$order,alpha_order$letters==str_i)))
  temp_i <- list(str_i,pos_i)  
  
  df_phrase[[i]] <- temp_i
  df <- do.call("rbind",df_phrase) 
  }

#########
df_key <- data.frame(match(unlist(strsplit(paste("",full_key_final,sep=""), split="")), letters))
names(df_key) <- c("key")

df_final <- data.frame(df,df_key)
df_final$sup <- df_final$key -1
df_final$sum <- as.numeric(as.character(df_final$X2)) + as.numeric(as.character(df_final$sup))

df_final_2 <- list()
for(k in 1:nrow(df_final)) {
  if(df_final$sum[k] < 26) {
    
    df_final_2[[k]] <- df_final$sum[k]
  } else {
    df_final_2[[k]] <- df_final$sum[k] - 26
  }
  
  df_2 <- data.frame(do.call("rbind",df_final_2))
  names(df_2) <- c("final")
}  
#########
df_f <- data.frame(cbind(df_final,df_2))
#########

df_message <- list() 
for (l in 1:nrow(df_f)) {
  str_l <- df_f$final[l]
  pos_l <- letters[str_l]
  temp_l <- list(str_l,pos_l)  
  
  df_message[[l]] <- temp_l
  df_m <- data.frame(do.call("rbind",df_message))
  names(df_m) <- c("pos","messa")
}
#########
cryp_mess <- as.character(df_m$messa)
print(cryp_mess)
