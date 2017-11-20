setwd("~/Projects/Winthrop/AS/scripts")

library(checkpoint)
checkpoint("2017-04-01", use.knitr = TRUE)

Sys.time0 <- Sys.time()

sink("script.log")
files <- c("header.yaml",
           "preamble.Rmd")
           # "summarizePrevalence.Rmd",
           # "summarizePrevalenceControl.Rmd",
           # "summarizeIncidence.Rmd",
           # "abstractACR2017.Rmd",
           # "summarizePropensityScore.Rmd")
f <- file("master.Rmd", open = "w")
for (i in 1:length(files)) {
    x <- readLines(files[i])
    writeLines(x, f)
}
close(f)
library(knitr)
library(rmarkdown)
opts_chunk$set(echo = FALSE, fig.path = "../figures/", dpi = 300)
knit("master.Rmd", output = "../docs/index.md")
# knit("abstractACR2017.Rmd", output = "../docs/abstractACR2017.md")
# pandoc("../docs/abstractACR2017.md", format = "docx")
knit("summarizePropensityScore.Rmd", output = "../docs/summarizePropensityScore.md")
pandoc("../docs/summarizePropensityScore.md", format = "docx")
file.remove("master.Rmd")
sink()

sink("session.log")
list(completionDateTime = Sys.time(),
     executionTime = Sys.time() - Sys.time0,
     sessionInfo = sessionInfo())
sink()
