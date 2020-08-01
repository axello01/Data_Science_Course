library(twitteR)
library(wordcloud) #nubes de palabras
library(tm) #libreria de text mining
library(stringr) #te permite manipular los textos  PONES ?stringr y ves todo

# Declare Twitter API Credentials
api_key <- "your_api_key" # From dev.twitter.com
api_secret <- "your_api_secret" # From dev.twitter.com
token <- "your_toker" # From dev.twitter.com
token_secret <- "your_token_secret" # From dev.twitter.com
options(httr_oauth_cache=T)
# Create Twitter Connection
setup_twitter_oauth("your_api_key", "your_api_secret", "your_token", "your_token_secret")

panama_papers <- searchTwitter("#panamapapers", lang="es")
pp.df <- twListToDF(panama_papers)

############ HASHTAGS
pp_hashtags <- str_extract_all(pp.df$text, "#\\w+") #esto te permite extraer lo que queres. \\w+
pp_hashtags <- as.data.frame(unlist(pp_hashtags))

write.table(pp_hashtags,"/Data/SENTIMENT/i314_NLP/data/hashtags.csv",sep="\t",col.names=FALSE,append=TRUE)

############ MENTIONS
pp_mentions <- str_extract_all(pp.df$text, "@\\w+")
pp_mentions <- as.data.frame(unlist(pp_mentions))

write.table(pp_mentions,"/Data/SENTIMENT/i314_NLP/data/mentions.csv",sep="\t",col.names=FALSE,append=TRUE)

#####################################################################
############### Ejercicio !! ########################################
##### a) Hacer un ranking con los 5 hashtags mas mencionados
##### b) Buscar expresion regular para filtrar URLs
##### c) Hacer un ranking con las 10 URLs mas mencionados