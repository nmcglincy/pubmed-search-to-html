# Make a pubmed search for our group's papers and then format the output as html for the lab website
# NJM, 20150930
# Make a pubmed search for out group's papers
library(rentrez)
library(lubridate)

# Specifically, Nick's papers from a year to the present year
from.year = 2013
present.year = year(Sys.Date())
search.term = paste("Ingolia NT[AUTH] AND ", 
                    from.year, 
                    ":", 
                    present.year, 
                    "[PDAT]", 
                    sep = "")

nti.pap = entrez_search(db = "pubmed",
                        term = search.term,
                        retmax = 33)

