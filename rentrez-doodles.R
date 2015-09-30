library(rentrez)
entrez_dbs()
entrez_db_summary("cdd")
entrez_db_summary("pubmed")
entrez_db_searchable("sra")
entrez_db_searchable("pubmed")

r_search = entrez_search(db = "pubmed", term = "R language")
class(r_search)
str(r_search)
r_search$ids

another_r_search = entrez_search(db = "pubmed", term = "R language", retmax = 40)
another_r_search

entrez_search(db="sra",
              term="Tetrahymena thermophila[ORGN]",
              retmax=0)

entrez_search(db="sra",
              term="Tetrahymena thermophila[ORGN] AND 2013:2015[PDAT]",
              retmax=0)

entrez_search(db   = "pubmed",
              term = "(vivax malaria[MeSH]) AND (folic acid antagonists[MeSH])")

search_year <- function(year, term){
  query <- paste(term, "AND (", year, "[PDAT])")
  entrez_search(db="pubmed", term=query, retmax=0)$count
}

year <- 2008:2014
papers <- sapply(year, search_year, term="Connectome", USE.NAMES=FALSE)
papers

taxize_summ <- entrez_summary(db="pubmed", id=24555091)
taxize_summ
taxize_summ$articleids


nicks.papers = entrez_search(db = "pubmed",
                             term = "Ingolia NT[AUTH]",
                             retmax = 33)
nicks.papers$ids
nicks.papers.summ = entrez_summary(db = "pubmed",
                                   id = nicks.papers$ids)
nicks.papers.summ[[1]][[5]]$name
nicks.papers.summ[[1]][7]
