############################################
# Data Professor                           #
# http://youtube.com/dataprofessor         #
# http://github.com/dataprofessor          #
# http://facebook.com/dataprofessor        #
# https://www.instagram.com/data.professor #
############################################

# Import libraries
library(shiny)
library(shinythemes)
library(data.table)
library(randomForest)

# Read in the RF model
model <- readRDS("model.rds")


####################################
# User interface                   #
####################################

ui <- fluidPage(theme = shinytheme("darkly"),
  
  # Page header
  headerPanel('Bank note authentication Predictor'),
  
  # Input values
  sidebarPanel(
    #HTML("<h3>Input parameters</h3>"),
    tags$label(h3('Input parameters')),
    numericInput("variance", 
                 label = "Variance of Wavelet Transformed image", 
                 value = 1.1),
    numericInput("skewness", 
                 label = "Skewness of Wavelet Transformed image", 
                 value = 2.6),
    numericInput("curtosis", 
                 label = "Kurtosis of Wavelet Transformed image", 
                 value = 1.4),
    numericInput("entropy", 
                 label = "Entropy of image", 
                 value = 0.2),
    
    actionButton("submitbutton", "Submit", 
                 class = "btn btn-primary")
  ),
  
  mainPanel(
    tags$label(h3('Status/Output')), # Status/Output Text Box
    verbatimTextOutput('contents'),
    tableOutput('tabledata'), # Prediction results table
    HTML("<h4>This Server Predicts the probability for authenticity of bank notes: Label X0 is for authentic and label X1 is for inauthentic</h4>"),
    HTML("<h5>Data set:</h5>"),
    HTML("<h6>Volker Lohweg and Helene Dörksen(2012), UCI Machine Learning Repository[http://archive.ics.uci.edu/ml/datasets/banknote+authentication].Ostwestfalen-Lippe,University of Applied Sciences</h6>")
  )
)

####################################
# Server                           #
####################################

server<- function(input, output, session) {
  
  # Input Data
  datasetInput <- reactive({  
    
    df <- data.frame(
      Name = c("variance",
               "skewness",
               "curtosis",
               "entropy"),
      Value = as.character(c(input$variance,
                             input$skewness,
                             input$curtosis,
                             input$entropy)),
      stringsAsFactors = FALSE)
    
    class <- 0
    df <- rbind(df, class)
    input <- transpose(df)
    write.table(input,"input.csv", sep=",", quote = FALSE, row.names = FALSE, col.names = FALSE)
    
    test <- read.csv(paste("input", ".csv", sep=""), header = TRUE)
    
    Output <- data.frame(Prediction=predict(model,test), round(predict(model,test,type="prob"), 3))
    print(Output)
    
  })
  
  # Status/Output Text Box
  output$contents <- renderPrint({
    if (input$submitbutton>0) { 
      isolate("Calculation complete.") 
    } else {
      return("Server is ready for calculation.")
    }
  })
  
  # Prediction results table
  output$tabledata <- renderTable({
    if (input$submitbutton>0) { 
      isolate(datasetInput()) 
    } 
  })
  
}

####################################
# Create the shiny app             #
####################################
shinyApp(ui = ui, server = server)
