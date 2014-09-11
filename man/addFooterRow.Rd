\name{addFooterRow}
\alias{addFooterRow}
\title{add footer in a FlexTable}
\usage{
addFooterRow(x, value, colspan, text.properties, par.properties,
  cell.properties)
}
\arguments{
  \item{x}{a \code{FlexTable} object}

  \item{value}{\code{FlexRow} object to insert as a footer
  row or a character vector specifying labels to use as
  columns labels.}

  \item{colspan}{integer vector. Optional. Applies only
  when argument \code{value} is a character vector. Vector
  specifying the number of columns to span for each
  corresponding value (in \code{values}).}

  \item{text.properties}{Optional. textProperties to apply
  to each cell. Used only if values are not missing.}

  \item{par.properties}{Optional. parProperties to apply to
  each cell. Used only if values are not missing.}

  \item{cell.properties}{Optional. cellProperties to apply
  to each cell. Used only if values are not missing.}
}
\description{
add a footer row in a FlexTable
}
\examples{
#START_TAG_TEST
#############################
# simple example
#############################

data(pbc_summary)

MyFTable = FlexTable( data = pbc_summary[,1:4], header.columns = TRUE )

# add a footer row with 1 cell that spans four columns
MyFTable = addFooterRow( MyFTable
  , value = c("Mean of serum cholesterol (mg/dl)"), colspan = 4 )
#########################################
# example with FlexRow objects usage
#########################################

data(pbc_summary)

# create a FlexTable
MyFTable = FlexTable( data = pbc_summary[,1:4] )

# define a complex formatted text
mytext = pot("*"
    , format = textProperties(vertical.align="superscript", font.size = 9) 
  ) + pot( " Mean of serum cholesterol (mg/dl)"
    , format = textProperties(font.size = 9)
  )

# create a FlexRow - container for 1 cell
footerRow = FlexRow()
footerRow[1] = FlexCell( mytext, colspan = 4 )

# add the FlexRow to the FlexTable
MyFTable = addFooterRow( MyFTable, footerRow )
#STOP_TAG_TEST
}
\seealso{
\code{\link{FlexTable}}, \code{\link{addHeaderRow}} ,
\code{\link{alterFlexTable}}
}

