library(dplyr)
library(leaflet)
library(shiny)

ui <- bootstrapPage(
  tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
  leafletOutput("map", width = "100%", height = "100%"),
  absolutePanel(top = 10, right = 10,
                sliderInput("rate", "Доля незабранных заказов", 
                            min(maap$failure_rate), 
                            max(maap$failure_rate),
                            value = range(maap$failure_rate), step = 0.05),
                sliderInput("date", "Месяц", 
                            min(as.numeric(maap$mon.yea)), 
                            max(as.numeric(maap$mon.yea)),
                            value = 1, step = 1, animate = T)
  )
)
