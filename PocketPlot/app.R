library(shiny)
library(tidyverse)
library(DT)
library(plotly)
library(shinythemes)
library(dtplyr)


# Define UI for application that draws a histogram
ui <- shinyUI(fluidPage(title = "Pocket plotter",theme = shinytheme("flatly"),
              #the above themes are taken from the following link
              #http://bootswatch.com/ 
                headerPanel("Pocket Plot!"),
                  sidebarLayout(
                  sidebarPanel(
                    textOutput("explanation"),
                    fileInput("csvFile", 
                              "Upload csv file", 
                              multiple = FALSE, 
                              accept = c("*.csv"))
                    ),
                  mainPanel(
                    tabsetPanel(
                      tabPanel("Plot",plotlyOutput("plot"),
                               uiOutput("chooseX"),
                               uiOutput("chooseY")),
                      tabPanel("Table", 
                               h2("Summary"), dataTableOutput("summary"),
                               h2("Full Table"), dataTableOutput("table")),
                      tabPanel("Histograms", plotOutput("hists")),
                      tabPanel("Correlation Matrix", dataTableOutput("cg"))
                    )
                  )
              )
        )
)

server <- shinyServer(function(input, output) {
   
  csv.Frame <- reactive({
    req(input$csvFile$datapath)
    data.table::fread(input$csvFile$datapath, header=TRUE,sep=",")  
  })
  
  output$chooseX <- renderUI({
    selectInput("x.axis", label = "Choose x-axis", choices=names(csv.Frame()))
  })
  
  output$chooseY <- renderUI({
    selectInput("y.axis", label = "Choose y-axis", choices = names(csv.Frame()))
  })
  
  output$summary <- renderDataTable({
    req(csv.Frame)
    df <- csv.Frame()

    Min <- apply(df, 2, min)
    Max <- apply(df, 2, max)
    Mean <- apply(df, 2, mean)
    Median <- apply(df, 2, median)
    StDev <- apply(df, 2, sd)
    
    df.summary <- rbind(Min, Max, Mean, Median, StDev)
    rownames(df.summary) <- c("Min", "Max", "Mean", "Median", "Standard Deviation")
    DT::datatable(t(df.summary), options = list(searching = FALSE))
  })
  
  output$table <- renderDataTable({
    req(csv.Frame)
    DT::datatable(csv.Frame())
  })
  
  output$plot <- renderPlotly({
    req(csv.Frame)
    req(input$x.axis)
    req(input$y.axis)
    p <- ggplot(csv.Frame(), aes_string(x=input$x.axis, y=input$y.axis)) + geom_point()
    p <- p + ggtitle(paste(input$y.axis, "vs.", input$x.axis))
    p
  })
  
  output$explanation <- renderText({
    out <- "Hello! Welcome to Pocket Plot! This is a simple Shiny tool that lets you quickly plot \n fixed-width data using Plotly. Upload a file and find out how easy it is."
  })
  
  output$hists <- renderPlot({
    req(csv.Frame)
    p <- ggplot(csv.Frame() %>% as.data.frame %>% melt(), aes(x=value)) + geom_histogram() 
    p <- p + facet_wrap(~variable, scales = "free")
    p
  })
  
  output$cg <- renderDataTable({
    req(csv.Frame)
    cdf <- cor(csv.Frame()) %>% as.data.frame()
    DT::datatable(round(cdf, digits=3),options=list(searching=FALSE, paging=FALSE))
  })
  
})

# Run the application 
shinyApp(ui = ui, server = server)

