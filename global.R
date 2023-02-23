library(data.table)
library(highcharter)
library(shiny)
library(stringi)

# read
res = readRDS("data/results.rds")

# highchart theme
my_hc_theme = function (main = "white", back = NA)
{
  theme <- hc_theme(
    colors = c("#FD5901", "#FFA10D", "#0094A3", "#005F60"),
    chart = list(
      backgroundColor = back,
      style = list(fontFamily = "Inconsolata",
                   color = main)
    ),
    title = list(style = list(color = main),
                 align = "left"),
    subtitle = list(style = list(color = main),
                    align = "left"),
    legend = list(
      align = "right",
      verticalAlign = "bottom",
      itemStyle = list(fontWeight = "normal",
                       color = main)
    ),
    xAxis = list(
      gridLineDashStyle = "Dot",
      gridLineWidth = 1,
      gridLineColor = main,
      lineColor = main,
      minorGridLineColor = main,
      tickColor = main,
      tickWidth = 1,
      labels = list(style = list(color = main)),
      title = list(style = list(color = main))
    ),
    yAxis = list(
      gridLineDashStyle = "Dot",
      gridLineColor = main,
      lineColor = main,
      minorGridLineColor = main,
      tickColor = main,
      tickWidth = 1,
      labels = list(style = list(color = main)),
      title = list(style = list(color = main))
    )
  )
  
  theme <- structure(theme, class = "hc_theme")
  theme
}
