dashboardPage(
  dashboardHeader(title = "Cardiovascular Risk Dashboard"),
  dashboardSidebar(
    sliderInput(
      inputId = "riskThreshold", 
      label = "Risk Threshold",
      min = 0, 
      max = 50, 
      value = 3, 
      step = 1
    ),
    checkboxGroupInput(
      inputId = "geotype",
      label = "Geotype",
      inline = TRUE,
      choices = c("Urban","Rural"),
      selected = c("Urban","Rural")
    ),
    checkboxGroupInput(
      inputId = "sex",
      label = "Sex",
      inline = TRUE,
      choices = unique(DATA$sex),
      selected = c("Male","Female")
    ),
    checkboxGroupInput(
      inputId = "agecat",
      label = "Age Groups",
      inline = TRUE,
      choices = unique(DATA$agecat),
      selected = c("50-54")
    ),
    radioButtons(
      inputId = "year",
      label = "Year",
      inline = TRUE,
      choices = unique(DATA$year),
      selected = 2016
    ), 
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard"),
      menuItem("Raw data", tabName = "rawdata")
    )
  ),
  dashboardBody(
    tabItems(
      tabItem("dashboard",
        fluidRow(
          valueBoxOutput("ssize"),
          valueBoxOutput("cvdrisk"),
          valueBoxOutput("excessrisk")
        ),
        fluidRow(
          box(
            width = 8, status = "info", solidHeader = TRUE,
            title = "Cardiovascular risk, by province",
            plotlyOutput("riskPlot", width = "100%", height = 600)
            #plotOutput("riskPlot", width = "100%", height = 600)
          ),
          box(
            width = 4, status = "info",
            title = "Risk factors, averages",
            tableOutput("riskTable")
          )
        )
      ),
      tabItem("rawdata",
        numericInput("maxrows", "Rows to show", 25),
        verbatimTextOutput("rawtable"),
        downloadButton("downloadCsv", "Download as CSV")
      )
    )
  )
)

