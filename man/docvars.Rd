% Generated by roxygen2 (4.0.2): do not edit by hand
\name{docvars}
\alias{docvars}
\alias{docvars<-}
\title{get or set for document-level variables}
\usage{
docvars(x, field = NULL)

docvars(x, field = NULL) <- value
}
\arguments{
\item{x}{corpus whose document-level variables will be read or set}

\item{field}{string containing the document-level variable name}

\item{value}{the new values of the document-level variable}
}
\value{
\code{docvars} returns a data.frame of the document-level variables

\code{docvars<-} assigns \code{value} to the named \code{field}
}
\description{
Get or set variables for the documents in a corpus
}
\examples{
head(docvars(inaugCorpus))
docvars(inaugCorpus, "President") <- paste("prez", 1:ndoc(inaugCorpus), sep="")
head(docvars(inaugCorpus))
}

