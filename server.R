library(dplyr)
library(leaflet)
library(shiny)

server <- function(input, output, session) {
  
  colorpal <- colorNumeric("YlOrRd", maap$failure_rate)
  
  filteredData <- reactive({
    maap[maap$failure_rate >= input$rate[1] & 
           maap$failure_rate <= input$rate[2] & 
           as.numeric(maap$mon.yea) == input$date,]
  })
  
  
  output$map <- renderLeaflet({
    leaflet(maap) %>% addTiles() %>% 
      setView(lng = 56.22862, lat = 58.00768, zoom = 13)
      # fitBounds(~min(lng), ~min(lat), ~max(lng), ~max(lat))
  })
  
  observe({
    leafletProxy("map", data = filteredData()) %>%
      clearShapes() %>%
      addCircles(lat = ~ lat,
                 lng = ~ lng, 
                 weight = 1,
                 # radius = 100,
                 radius = ~ number_of_orders * 5,
                 color = "#777777",
                 fillColor = ~ colorpal(failure_rate), 
                 fillOpacity = 0.7, 
                 popup = ~ paste0(store_address, "<br>", 
                                  "Месяц: ", mon.yea, "<br>",
                                  "Количество заказов: ", number_of_orders, "<br>",
                                  "Количество незабранных заказов: ", number_of_cancels)) 
  })
  
  observe({
    leafletProxy("map", data = maap) %>% 
      clearControls() %>% 
      addLegend(title = "Доля незабранных заказов",
                position = "bottomright",
                pal = colorpal, values = ~ failure_rate)
    
  })
}
