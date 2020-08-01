#https://rpubs.com/modelthinkingbr/fable

library(tidyverse)
library(fpp2)
library(tsibble)
library(fable)

head(auscafe)

cafe <- as_tsibble(auscafe)
cafe
cafe %>% ETS(formula = value)
cafe %>% ETS(value) %>% summary()
cafe %>% ETS(value) %>% forecast() %>% summary()
cafe %>% ETS(value) %>% forecast() %>% summary(level = 90)
cafe %>% ETS(value) %>% forecast() %>% autoplot()
