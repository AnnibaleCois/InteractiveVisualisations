function(input, output) {
  
  # Filter data according to inputs
  data_filtered <- reactive({
    subset(DATA,
           sex %in% input$sex &
             agecat %in% input$agecat &
             year %in% input$year &
             geotype %in% input$geotype)  
  })
  
  # Recalculate outputs every time an input changes  
  # Sample size 
  rowCount <- reactive({
    nrow(data_filtered())
  })
  
  output$ssize <- renderValueBox({
    valueBox(
      value = rowCount(),
      subtitle = "Sample size",
      icon = icon("database"),
      color = "aqua"
    )
  })
  
  # Average CVD risk 
  avgRisk <- reactive({
    paste(round(mean(data_filtered()$cvdrisk, na.rm = TRUE),1),"%", sep = "")
  })
  
  output$cvdrisk <- renderValueBox({
    valueBox(
      value = avgRisk() ,
      subtitle = "Average CVD risk",
      icon = icon("heart-crack"),
      color = "red"
    )
  })
  
  # Percentage above risk threshold
  excRisk <- reactive({
    paste(round(mean(data_filtered()$cvdrisk > input$riskThreshold, na.rm = TRUE)*100,1),"%", sep = "")
  })
  
  output$excessrisk <- renderValueBox({
    valueBox(
      excRisk(),
      "Risk above threshold",
      icon = icon("percent"),
      color = "yellow"
    )
  })
  
  # Bar chart with provincial averages
  output$riskPlot <- renderPlotly({
    #output$riskPlot <- renderPlot({
    data <- data_filtered()
    if (nrow(data) == 0)
      return()
    data_province <- aggregate(data$cvdrisk, by = list(data$province), FUN = mean)
    data_province <- rename(data_province, Province = Group.1, cvdrisk = x )
    ggplot(data_province) +
      aes(x = Province, y = cvdrisk, fill = Province) +
      geom_bar(stat = "identity") +
      theme(legend.position = "none")
  })

  # Table with average levels of risk factors
  output$riskTable <- renderTable({
    data <- data_filtered()
    if (nrow(data) == 0)
      return()
    data_province <- aggregate(data[,c("bmi","sbp","dbp")], by = list(data$province), FUN = mean)
    data_province <- rename(data_province, Province = Group.1)
    data_province
  }, digits = 1)

}
