library(twitteR)

# Declare Twitter API Credentials
## https://apps.twitter.com/
api_key <- "your_api_key" # From dev.twitter.com
api_secret <- "your_api_secret" # From dev.twitter.com
token <- "your_toker" # From dev.twitter.com
token_secret <- "your_token_secret" # From dev.twitter.com
options(httr_oauth_cache=T)

# Create Twitter Connection
setup_twitter_oauth("your_api_key", "your_api_secret", "your_token", "your_token_secret")

tweets_1 <- searchTwitter("#Macri", lang="es")
tweets_2 <- searchTwitter("#PanaMacri", lang="es")

tweets.df.1 <- twListToDF(tweets_1)
tweets.df.2 <- twListToDF(tweets_2)

variables <- c("text","id")

tweets.df.1 <- tweets.df.1[variables]
tweets.df.2 <- tweets.df.2[variables]

tweets_final <- rbind(tweets.df.1,tweets.df.2)
#tweets_final <- tweets.df.2
#tweets_final <- rbind(tweets_final,data)
tweets_final <- unique(tweets_final)

write.table(tweets_final,"../data/tweets.csv",sep="\t",col.names=FALSE,append=TRUE)
write.table(tweets_final,"../data/new_tweets.csv",sep="\t",col.names=FALSE,append=FALSE)
    

