\name{light.table}
\alias{light.table}
\title{get a simple FlexTable from a dataset}
\usage{
light.table(dataset, double.format = "\%0.3f")
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
light.table( iris)
#STOP_TAG_TEST
}
\seealso{
\code{\link{FlexTable}}
}

