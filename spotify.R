library(car)
library(Cairo)
library(caret)
library(magrittr)
# alternative, this also loads %>%
library(dplyr)    
library(tidyverse)
library(readr)
library(ggplot2)
library(plotly)
library(hrbrthemes)
suppressPackageStartupMessages(library(tidyverse))
library("xlsx")

# read excel file 
stream <- read.xlsx("/Users/stephanietran/Documents/school/sciences-po/semester-2//network-economy/case-study-pres/stream.xlsx", 1, as.data.frame = TRUE,header=TRUE)
view(stream)

# levels(stream$DSP.or.STORE)

stream$DSP.or.STORE <- reorder(stream$DSP.or.STORE, -stream$Market.Share.Revenue)

# stacked bar plot of market share revenue of each company by year
ggplot(data = stream, 
       aes(x = Year, y = Market.Share.Revenue, fill = DSP.or.STORE, 
           label = Market.Share.Revenue)) + 
  geom_bar(stat = 'identity') +
  geom_text(aes(label = sprintf("%1.2f%%", 100*Market.Share.Revenue)), size = 3, position = position_stack(vjust = 0.5)) +
  xlab("Year") +
  ylab("Market Share Revenue") +
  theme_ipsum(grid = "X") +
  labs(title = "Market Share Revenue for Top 10 Streaming Services", caption = "Source: The Trichordist, computation by Sciences Po students.") +
  scale_fill_discrete(name = "") +
  scale_y_continuous(labels = scales::percent)

# create new list ordered by per stream value
perStream <- stream
perStream$DSP.or.STORE <- reorder(stream$DSP.or.STORE, -stream$PER.STREAM)
levels(perStream$DSP.or.STORE)

# stacked bar plot of streams
ggplot(data = perStream, 
       aes(x = Year, y = PER.STREAM, fill = DSP.or.STORE, 
           label = PER.STREAM)) + 
  geom_bar(stat = 'identity') +
  geom_text(size = 3, position = position_stack(vjust = 0.5)) +
  xlab("Year") +
  ylab("Per Stream") +
  theme_ipsum(grid = "X") +
  labs(title = "Per Stream Top 10 Streaming Services", caption = "Source: The Trichordist, computation by Sciences Po students.") +
  scale_fill_discrete(name = "") 





