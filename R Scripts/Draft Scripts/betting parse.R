u <- "http://www.footballlocks.com/nfl_point_spreads_week_8.shtml"
doc = htmlParse(u)
tableNodes = getNodeSet(doc, "//table")
tb = readHTMLTable(tableNodes[[15]],skip.rows = 1)
summary(tableNodes)
tableNodes[[3]]
tableNodes
str(tableNodes)
