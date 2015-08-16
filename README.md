# DevelopingDataProducts

## See Index HTML for an overview of how to run the application.

---
title       : Developing Data Products Assignment
subtitle    : Market Indexes High Level Correlation
author      : Kim Monks
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides

---


## Stock Correlation 


This application is intended to present a high level view of the correlation between various stock market entities. 

It uses a text/csv file as input to provide the selection lists. From the selected indexes/currency/stocks an x/y plot is produced of the closing trade (relative to the intial trade), closing return (todays close minus yesterdays close) in various formats. Also the correlation matrix is provided and a summary of each of the selected entities. It can be found at 
https://kmonks.shinyapps.io/DevelopingDataProducts

Sample screens follows

--- .cover #FitToHeight

## Sample 1 - Scatter Plot

![height](screen1.GIF)
 
 



--- .cover .w #FitToWidth

## Sample 2 - Correlation Matrix

![width](screen3.GIF)

--- .cover #FitToHeight

## Sample 3 - Pair Plot
