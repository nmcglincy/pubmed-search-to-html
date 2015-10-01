# Make a pubmed search for our group's papers and then format the output as html for the lab website
# NJM, 20150930
# Make a pubmed search for out group's papers
library(rentrez)
library(lubridate)
library(stringr)
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
nti.pap.summ = entrez_summary(db = "pubmed",
                              # id = nti.pap$ids,
                              web_history = nti.pap$web_history)
# Asks me to used either the $ids or the web_history, but not both.
foo = extract_from_esummary(nti.pap.summ,
                            c("authors", "title", "fulljournalname", "volume", "pages", "pubdate"), 
                            simplify = FALSE)
header = '<div style="margin: 0 0 0.6em 0; text-indent: -2em; padding-left: 2em;">'
for (i in 1:length(foo)) {
  cat(paste(header,
            "\n",
            paste(foo[[i]][[1]]$name, collapse = ", "),
            ". ",
            paste(foo[[i]][[2]]),
            " <i>",
            paste(foo[[i]][[3]]),
            "</i> ",
            "<b>",
            paste(foo[[i]][[4]]),
            "</b>: ",
            paste(foo[[i]][[5]]),
            " (",
            str_sub(paste(foo[[i]][[6]]), 1, 4),
            ").\n</div>",
            sep = ""),
      file = "papers.txt",
      sep = "\n",
      append = TRUE)
}
# the format of the page numbers are so different, I feel like it's going to be easier to sort it
# out manually, while I'm sorting the publication types.
