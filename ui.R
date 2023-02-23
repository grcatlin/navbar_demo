navbarPage(
  "Generic Navbar Page",
  
  tabPanel(
    "Overall Results",
    
    # browser icon
    tags$head(tags$link(
      rel = "icon", type = "image/png", href = "icon.png"
    )),
    
    # link stylesheet
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
    ),
    
    h3("Effect of Past Data", style = "margin: 0 auto;width: 80%;"),
    
    fluidRow(align = "center",
             highchartOutput("effect_past", width = "80%")),
    
    tags$p(
      stri_rand_lipsum(1)
    ),
    
    h3("Effect of Forecast Horizon", style = "margin: 0 auto;width: 80%;"),
    
    fluidRow(align = "center",
             highchartOutput("effect_horizon", width = "80%")),
    
    tags$p(
      stri_rand_lipsum(1)
    )
  ),
  
  tabPanel(
    "Result Comparison",
    fluidPage(
      align = "center",
      
      fluidRow(
        column(4,
               sliderInput(
                 "PER",
                 "Past Data Given (Months)",
                 min = 2,
                 max = 12,
                 value = 12,
                 step = 1,
                 ticks = F
               )
               ),
        column(4,
               selectInput(
                 "TOPN",
                 "Top X?",
                 unique(res$TOP_N),
                 selected = 100
               )
               ),
        column(4,
               sliderInput(
                 "FOR",
                 "Forecast Horizon (Months)",
                 min = 1,
                 max = 6,
                 value = 1,
                 step = 1,
                 ticks = F
               )
               )
      ),
      
      br(),
      
      fluidRow(align = "center",
               highchartOutput("comp", width = "80%")),
      
      br(),
      
      tags$p(
        stri_rand_lipsum(1)
      )
    )
  )
)
