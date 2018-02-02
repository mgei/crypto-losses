library(quantmod)
library(PerformanceAnalytics)

from <- "2000-01-01"
btc <- getSymbols("BTC-USD", auto.assign = FALSE, from = from)
eth <- getSymbols("ETH-USD", auto.assign = FALSE, from = from)

returns <- ROC(merge(Cl(btc),Cl(eth)), type = "discrete")
colnames(returns) <- c("BTCUSD","ETHUSD")

from <- max(index(first(eth)), index(first(btc)))

charts.PerformanceSummary(returns[paste0(from,"/")])
charts.PerformanceSummary(returns["2017/"])
charts.PerformanceSummary(returns["2017-06/"])

table.Drawdowns(returns[,"BTCUSD"])
table.Drawdowns(returns[paste0(from,"/"),"BTCUSD"])
table.Drawdowns(returns[,"ETHUSD"], top = 10)
# findings: the current BTC crash from the high on December 17 2017 is the largest since mid-2015
# however, since beginning of the data availability, it's only the 4th largest crash.
# There was a whopping -93% loss for someone who invested on the peak in 2011
# for ETH the current drawdown is only the 6th largest in its history

chart.Correlation(returns)
chart.RelativePerformance(returns[,1], returns[,2])
#finding: ETH was a better investment in most of 2016 and 2017

table.Distributions(returns[paste0(from,"/")])
#finding: ETH is twice as volatile
  