\name{vanilla.table}
\alias{vanilla.table}
\title{get a simple FlexTable from a dataset}
\usage{
vanilla.table(dataset, double.format = "\%0.3f")
}
\arguments{
  \item{dataset}{the data to use}

  \item{double.format}{format string for \code{double}
  column to format in the dataset. See argument \code{fmt}
  of \code{\link{sprintf}}.}
}
\description{
get a simple FlexTable from a dataset
}
\examples{
#START_TAG_TEST
vanilla.table( iris)
#STOP_TAG_TEST
}
\seealso{
\code{\link{FlexTable}}
}

