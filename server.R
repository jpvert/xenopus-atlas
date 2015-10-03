library(shiny)
library(sp)
library(RColorBrewer)

# Color palette
ncolors <- 100
my_palette <- colorRampPalette(c("red", "white", "green"))(n = ncolors)

# Define a few points and their symmetric wrt the vertical axis
mypoints <- t(matrix(c(0,0,24,3,45,12,65,25,79,43,87,65,90,87,89,111,84,129,75,143,61,158,45,169,24,178,0,182,0,158,0,82,0,18,21,19,27,84,32,113,40,143,21,153,59,131,77,118,63,74,52,25,34,17,41,81,47,107),nrow=2))
n <- nrow(mypoints)
mypointsSym <- mypoints
mypointsSym[,1] <- -mypointsSym[,1]
mypoints <- rbind(mypoints, mypointsSym)

# Define polygones
a1 <- Polygon(mypoints[c(9, 10, 11, 12, 13, 14, 13+n, 12+n, 11+n, 10+n, 9+n, 24+n, 23+n, 21+n, 22+n, 15, 22, 21, 23, 24, 9),])
a2 <- Polygon(mypoints[c(15, 22+n, 21+n, 20+n, 19+n, 16, 19, 20, 21, 22, 15),])
a3 <- Polygon(mypoints[c(19, 20, 21, 23, 29, 28, 19),])
a3s <- Polygon(mypoints[c(19, 20, 21, 23, 29, 28, 19)+n,])
a4 <- Polygon(mypoints[c(16, 19+n, 18+n, 17, 18, 19, 16),])
a5 <- Polygon(mypoints[c(23, 24, 25, 26, 27, 28, 29, 23),])
a5s <- Polygon(mypoints[c(23, 24, 25, 26, 27, 28, 29, 23)+n,])
a6 <- Polygon(mypoints[c(1, 2, 3, 4, 5, 6, 7, 8, 9, 24, 25, 26, 27, 28, 19, 18, 17, 18+n, 19+n, 28+n, 27+n, 26+n, 25+n, 24+n, 9+n, 8+n, 7+n, 6+n, 5+n, 4+n, 3+n, 2+n, 1),])

# Define areas of interest as unions of polygones
S1 <- Polygons(list(a1), "s1")
S2 <- Polygons(list(a2), "s2")
S3 <- Polygons(list(a3, a3s), "s3")
S4 <- Polygons(list(a4), "s4")
S5 <- Polygons(list(a5, a5s), "s5")
S6 <- Polygons(list(a6), "s6")
Slist <- list(S1, S2, S3, S4, S5, S6)
nS <- length(Slist)

Sp <- SpatialPolygons(Slist, 1:nS)
locnames <- c("top", "bottom", "here", "there", "ici", "la")

# Expression data
genenames <- readRDS("data/genenames.Rds")
ngenes <- length(genenames)
expr <- readRDS("data/expression.Rds")
exprcol <- matrix(my_palette[as.numeric(cut(expr,breaks=ncolors))], nrow=ngenes)
ylim <- c(min(expr), max(expr))

# Define server logic required to draw the plots
shinyServer(function(input, output) {
    
    # Plot the embryo colored by the expression level of a gene
    output$xenPlot <- renderPlot({
        plot(Sp, col=exprcol[match(input$gene, genenames),])        
    })
    
    # Plot the distribution of expression values of a gene as a bar plot
    output$barPlot <- renderPlot({
        barplot(expr[match(input$gene, genenames),], names.arg=locnames, ylim=ylim)
    })
})

