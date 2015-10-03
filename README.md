# xenopus-atlas
Visualization of spatiotemporal gene expression in Xenopus embryo

To run from R, type:
```{r}
library(shiny)
shiny::runGitHub('xenopus-atlas', 'jpvert')
```

or try it online at
[https://jpvert.shinyapps.io/xenopus-atlas](https://jpvert.shinyapps.io/xenopus-atlas)

If you prefer to run it locally after cloning the repository (always from R):
```{r}
shiny::runApp('xenopus-atlas/')
```

Note: to deploy it on shinyapps.io, type from R:
```{r}
shinyapps::deployApp('xenopus-atlas/')
```
