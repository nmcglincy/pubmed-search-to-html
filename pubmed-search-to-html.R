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
                        use_history = TRUE)

# there's some ambiguity here, I think that because I've invoked use_history I will get the total 
# list of ids, even if it at some point exceeds 20, but I'm not certain.
# nti.pap
# str(nti.pap)

nti.pap.summ = entrez_summary(db = "pubmed",
                              # id = nti.pap$ids,
                              web_history = nti.pap$web_history)
# Asks me to used either the $ids or the web_history, but not both.

nti.pap.summ

foo = extract_from_esummary(nti.pap.summ, 
                      c("authors", "title", "fulljournalname", "volume", "pages", "pubdate"), 
                      simplify = FALSE)
str(foo)
# paste(foo[[1]][[1]]$name, collapse = ", ")
# lapply(foo, function(x){paste(x[[1]]$name, collapse = ", ")})
# 
# foo$authors

header = '<div style="margin: 0 0 0.6em 0; text-indent: -2em; padding-left: 2em;"> '
library(stringr)
for (i in 1:length(foo)) {
  print(paste(header,
              paste(foo[[i]][[1]]$name, collapse = ", "),
              ". ",
              paste(foo[[i]][[2]]),
              " <i>", paste(foo[[i]][[3]]), "</i> ",
              "<b>", paste(foo[[i]][[4]]), "</b>: ",
              paste(foo[[i]][[5]]),
              " (", str_sub(paste(foo[[i]][[6]]), 1, 4), "). </div>",
              sep = ""))
}
# Ok, dealing with the different formats of page no might be tricky, leave until later
for (i in 1:length(foo)) {
  print(paste(foo[[i]][[5]]))
}



library(plyr)
library(dplyr)

lapply(foo, ldply)

bar = extract_from_esummary(nti.pap.summ,
                            "authors",
                            simplify = FALSE)
str(bar)
lapply(bar, function(x){paste(x[[1]]$name, collapse = ", ")})
paste(bar[[1]][[1]]$name, collapse = ", ")

ldply(bar, data.frame)

# this produces a list of lists


paste("<div style="margin: 0 0 0.6em 0; text-indent: -2em; padding-left: 2em;">",
      )


<div style="margin: 0 0 0.6em 0; text-indent: -2em; padding-left: 2em;">
Stern-Ginossar N, Weisburd B, Michalski A, Le VT, Hein
MY, Huang SX, Ma M, Shen B, Qian SB, Hengel H, Mann M,
Ingolia NT, Weissman JS. Decoding human
cytomegalovirus. <i>Science</i> <b>338</b>: 1088 (2012).
</div>
