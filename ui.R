library(shiny)

# Read gene names
genenames <- readRDS("data/genenames.Rds")

# Display
shinyUI(fluidPage(
    
    titlePanel("Explore the spatiotemporal expression program of Xenopus embryos"),
    
    sidebarLayout(
        sidebarPanel(
            # Select gene
            selectInput("gene", label = h3("Select Gene"), 
                        choices = genenames, selected = 1),
            # Plot expression as barplot
            plotOutput("barPlot")
        ),
        
        mainPanel(
            # Plot the colored embryo
            plotOutput("xenPlot")
        )
    )
))