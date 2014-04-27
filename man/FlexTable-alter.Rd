\name{[<-.FlexTable}
\alias{[<-.FlexTable}
\alias{alterFlexTable}
\title{modify FlexTable content}
\usage{
\method{[}{FlexTable}(x, i, j, text.properties, newpar = F, byrow = FALSE)
  <- value
}
\arguments{
  \item{x}{the \code{FlexTable} object}

  \item{i}{vector (integer index, row.names values or
  boolean vector) for rows selection.}

  \item{j}{vector (integer index, col.names values or
  boolean vector) for columns selection. or an object of
  class \code{\link{textProperties}}.}

  \item{text.properties}{formating properties (an object of
  class \code{textProperties}).}

  \item{newpar}{logical value specifying wether or not the
  content should be added as a new paragraph}

  \item{byrow}{logical. If FALSE (the default) content is
  added by columns , otherwise content is added by rows.}

  \item{value}{an object of class
  \code{\link{cellProperties}} or an object of class
  \code{\link{parProperties}}}
}
\description{
add text into a FlexTable object or Format content of a
FlexTable object
}
\examples{
#
# Create a FlexTable object with first 10 lines of data.frame mtcars
# add row.names as first column
# specify cell formating properties for header columns row
MyFTable = FlexTable( data = mtcars[1:10, ]
  , add.rownames=TRUE
)
# modify the text formating properties for the row.names column
MyFTable[ , 1] = textProperties( font.style="italic", font.size = 9)
# align text to right for the row.names column
MyFTable[ , 1] = parProperties( text.align = "right" )

# change cell formating properties for various columns
MyFTable[ c(3,6:9), c( "mpg", "disp"
  , "hp", "drat", "wt", "qsec" ) ] = cellProperties( background.color="#CCCCCC")
# add text to elements of the column cyl
MyFTable[, "cyl", text.properties = textProperties( 
  vertical.align="superscript", font.size = 9) ] = " miles/gallon"
}
\seealso{
\code{\link{FlexTable}}, \code{\link{addFlexTable}} ,
\code{\link{addHeaderRow}},
\code{\link{spanFlexTableRows}},
\code{\link{spanFlexTableColumns}} ,
\code{\link{setRowsColors}},
\code{\link{setColumnsColors}}, \code{\link{setZebraStyle}}
}

