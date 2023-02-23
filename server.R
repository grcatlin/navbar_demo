function(input, output, session) {
  output$effect_past = renderHighchart({
    dat = res[FORECAST == 1 & TOP_N == 100 & ORDER_HORIZON == F]
    dat[, MEAN := round(MEAN * 100, 2)]
    dat[, UB := round(UB * 100, 2)]
    dat[, LB := round(LB * 100, 2)]
    
    hchart(dat,
           "line",
           hcaes(x = PERIOD, y = MEAN, group = METHOD)) %>%
      hc_title(text = "Accuracy as Past Data is Increased") %>%
      hc_subtitle(text = "Forecast Horizon Fixed at 1 Month") %>%
      hc_xAxis(title = list(text = "Past Months Given")) %>%
      hc_yAxis(title = list(text = "Accuracy")) %>%
      hc_tooltip(
        headerFormat = "",
        pointFormat = paste0(
          "<b>{point.METHOD}</b> <br>",
          "Avg Accuracy: <b> {point.MEAN}% </b> <br>",
          "({point.LB}%, {point.UB}%)"
        )
      ) %>%
      hc_plotOptions(line = list(lineWidth = 4,
                                 marker = list(radius = 5))) %>% 
      hc_add_theme(my_hc_theme())
  })
  
  output$effect_horizon = renderHighchart({
    dat = res[PERIOD == 12 & TOP_N == 100 & ORDER_HORIZON == F]
    dat[, MEAN := round(MEAN * 100, 2)]
    dat[, UB := round(UB * 100, 2)]
    dat[, LB := round(LB * 100, 2)]
    
    hchart(dat,
           "line",
           hcaes(x = FORECAST, y = MEAN, group = METHOD)) %>%
      hc_title(text = "Accuracy as Forecast Horizon is Increased") %>%
      hc_subtitle(text = "Past Data Fixed at 12 Months") %>%
      hc_xAxis(title = list(text = "Future Months Predicted")) %>%
      hc_yAxis(title = list(text = "Accuracy")) %>%
      hc_tooltip(
        headerFormat = "",
        pointFormat = paste0(
          "<b>{point.METHOD}</b> <br>",
          "Avg Accuracy: <b> {point.MEAN}% </b> <br>",
          "({point.LB}%, {point.UB}%)"
        )
      ) %>%
      hc_plotOptions(line = list(lineWidth = 4,
                                 marker = list(radius = 5))) %>% 
      hc_add_theme(my_hc_theme())
  })
  
  comp_dat = reactive({
    dat = res[PERIOD == input$PER & TOP_N == input$TOPN & FORECAST == input$FOR]
    dat[, MEAN := round(MEAN * 100, 2)]
    dat[, UB := round(UB * 100, 2)]
    dat[, LB := round(LB * 100, 2)]
    return(dat)
  })
  
  output$comp = renderHighchart({
    dat = comp_dat()
    hchart(dat,
           "column",
           hcaes(
             x = METHOD,
             y = MEAN,
             color = c("#FD5901", "#FFA10D", "#0094A3", "#005F60")
           )) %>%
      hc_add_series(dat,
                    "errorbar",
                    hcaes(x = METHOD, low = LB, high = UB),
                    enableMouseTracking = F) %>%
      hc_plotOptions(errorbar = list(color = "white",
                                     lineWidth = 4)) %>%
      hc_title(text = paste0("Accuracy on Top ", input$TOPN)) %>%
      hc_xAxis(title = list(text = "Method")) %>%
      hc_yAxis(title = list(text = "Accuracy"),
               min = 0,
               max = 100) %>%
      hc_tooltip(
        headerFormat = "",
        pointFormat = paste0(
          "<b>{point.METHOD}</b> <br>",
          "Avg Accuracy: <b> {point.MEAN}% </b> <br>",
          "({point.LB}%, {point.UB}%)"
        )
      ) %>%
      hc_add_theme(my_hc_theme())
  })
}
