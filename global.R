library(feather)
library(dplyr)
# setwd("D:/Программирование/R/прочее/CASC 2019/pharm_map")
maap <- read_feather("data/maap.feather")
maap <- maap %>% 
  mutate(mon.yea = ordered(mon.yea, levels = c("4.2018",
                                               "5.2018",
                                               "6.2018",
                                               "7.2018",
                                               "8.2018",
                                               "9.2018",
                                               "10.2018",
                                               "11.2018",
                                               "12.2018",
                                               "1.2019",
                                               "2.2019",
                                               "3.2019",
                                               "4.2019",
                                               "5.2019",
                                               "6.2019")))
