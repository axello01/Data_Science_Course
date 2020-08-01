library(twitteR)
library(wordcloud)
library(tm)
library(stringr)


api_key <- "your_api_key" # From dev.twitter.com aca pones ttu clave
api_secret <- "your_api_secret" # From dev.twitter.com
token <- "your_toker" # From dev.twitter.com
token_secret <- "your_token_secret" # From dev.twitter.com
options(httr_oauth_cache=T)
# Create Twitter Connection
setup_twitter_oauth("your_api_key", "your_api_secret", "your_toker", "your_token_secret")

BYMA <- searchTwitter("#BYMA", lang="es")
byma.df <- twListToDF(BYMA)
#ppdf <- str_replace_all(pp.df$text,"[^[:graph:]]", " ") 

############ HASHTAGS
byma_hashtags <- str_extract_all(byma.df$text, "#\\w+")
byma_hashtags <- as.data.frame(unlist(byma_hashtags))

write.table(pp_hashtags,"/Data/SENTIMENT/i314_NLP/data/hashtags.csv",sep="\t",col.names=FALSE,append=TRUE)

############ MENTIONS
byma_mentions <- str_extract_all(byma.df$text, "@\\w+")
byma_mentions <- as.data.frame(unlist(byma_mentions))

write.table(pp_mentions,"/Data/SENTIMENT/i314_NLP/data/mentions.csv",sep="\t",col.names=FALSE,append=TRUE)
