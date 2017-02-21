#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(ggplot2)
library(DT)
library(plotly)
library(shinythemes)
library(data.table)


# Define UI for application that draws a histogram
ui <- shinyUI(fluidPage(title = "Pocket plotter",theme = shinytheme("flatly"),
              #the above themes are taken from the following link
              #http://bootswatch.com/ 
                headerPanel("Pocket Plot!"),
                  sidebarLayout(
                  sidebarPanel(
                    fileInput("csvFile", 
                              "Upload csv file", 
                              multiple = FALSE, 
                              accept = c("*.csv")),
                    uiOutput("chooseX"),
                    uiOutput("chooseY"),
                    textOutput("explanation")
                  ),
                  mainPanel(
                    plotlyOutput("plot"),
                    dataTableOutput("table")
                  )
              )
        # uiOutput("x.axis", "Select x-axis"),
        # uiOutput("y.axis", "Select y-axis")
        )
)

# Define server logic required to draw a histogram
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
  
  output$table <- renderDataTable({
    req(csv.Frame)
    DT::datatable(csv.Frame())
  })
  
  output$plot <- renderPlotly({
    req(csv.Frame)
    req(input$x.axis)
    req(input$y.axis)
    p <- ggplot(csv.Frame(), aes_string(x=input$x.axis, y=input$y.axis)) + geom_point()
    p
  })
  
  output$explanation <- renderText({
    out <- "Hello! Welcome to Pocket Plot! This is a simple Shiny tool that lets you quickly plot \n csv data using Plotly. Upload a file and find out how easy it is."
    
  })
  
})

# Run the application 
shinyApp(ui = ui, server = server)

