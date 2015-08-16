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

Sample index file content follows


```r
read.table("indexes.txt", header=FALSE) 
```

```
##         V1                        V2
## 1    ^AORD          AUSAllOrdinaries
## 2     ^DJI    DoweJonesIndustrailAvr
## 3    ^IXIC                    NASDAQ
## 4  ^GSPTSE             Canadianindex
## 5      EWA                Australian
## 6      EWO                   Austria
## 7      EWZ                    Brazil
## 8      EWC                    Brazil
## 9      FXI                     China
## 10     EWG                   Germany
## 11     EWH                  HongKong
## 12    INDA                     India
## 13     EWI                     Italy
## 14     EWJ                     Japan
## 15     EWW                    Mexico
## 16     RSX                    Russia
## 17     EZA               SouthAfrica
## 18     EWY                SouthKorea
## 19     EFA                    Canada
## 20     SPY                        US
## 21     VEU       AllworldexcludingUS
## 22     IWM             SmallUSEquity
## 23     DIA DowJonesIndustrialAverage
## 24    SPDR DowJonesIndustrialAverage
## 25     QQQ                    NASDAQ
## 26     XLE          EnergySectorSPDR
## 27     XLF       FinancialSectorSPDR
## 28     IYR              USRealEstate
## 29     OIH                       Oil
## 30     BBH                   BIOTech
## 31     USO                     USOil
## 32     GLD                      Gold
## 33     SLV                    Silver
## 34     UNG              USNaturalGas
## 35     BKF             BRICcountries
## 36     EZU             EuropeanUnion
## 37     EUR                EuroDollar
## 38     EEM           EmergingMarkets
## 39     FXA          Australiandollar
## 40     AUD          AustralianDollar
## 41     FXB              Britishpound
## 42     GBP              Britishpound
## 43     FXC            Canadiandollar
## 44     CYB               Chineseyuan
## 45     FXE                      Euro
## 46     INR               Indianrupee
## 47     FXM               Mexicanpeso
## 48     FXJ               Japaneseyen
## 49     JYP               Japaneseyen
## 50    FXRU              Russianruble
## 51     FXF                Swissfranc
## 52     DXY                  USDollar
## 53     USD                  USDollar
```

Sample screens follows

--- .cover #FitToHeight

## Sample 1 - Scatter Plot

![height](screen1.GIF)
 
 



--- .cover .w #FitToWidth

## Sample 2 - Correlation Matrix

![width](screen3.GIF)

--- .cover #FitToHeight

## Sample 3 - Pair Plot

![height](screen2.GIF)
