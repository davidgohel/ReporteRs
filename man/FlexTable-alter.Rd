\name{[<-.FlexTable}
\alias{[<-.FlexTable}
\alias{alterFlexTable}
\title{modify FlexTable content}
\usage{
\method{[}{FlexTable} (x, i, j, text.properties, newpar = F, byrow = FALSE, to = "body") <- value
}
\arguments{
  \item{x}{the \code{FlexTable} object}

  \item{i}{vector (integer index, row.names values or
  boolean vector) for rows selection.}

  \item{j}{vector (integer index, col.names values or
  boolean vector) for columns selection. or an object of
  class \code{\link{textProperties}}.}

  \item{text.properties}{formatting properties (an object
  of class \code{textProperties}).}

  \item{newpar}{logical value specifying wether or not the
  content should be added as a new paragraph}

  \item{byrow}{logical. If FALSE (the default) content is
  added by columns , otherwise content is added by rows.}

  \item{to}{specify on which part of the FlexTable to apply
  the \code{value}, must be one of the following values
  "body" or "header" or "footer"}

  \item{value}{To modify content formatting properties,
  value should be an object of class
  \code{\link{cellProperties}} or an object of class
  \code{\link{parProperties}} or an object of class
  \code{\link{textProperties}}. To add content, value
  should be a \code{data.frame} or a \code{matrix} or a
  \code{vector} with as many elements as defined by the
  selection. An exception is possible, if value is a vector
  of length 1 or a \code{pot} object, its value will be
  repeated in all cells defined by the selection.}
}
\description{
add text or format a FlexTable object
}
\details{
Use \code{YourFlexTable[ line subset, col subset] <- ...}
to apply formatting properties or to add text on the subset
of body of the FlexTable.

Use \code{YourFlexTable[..., to = "header"] <- ... } to
apply formatting properties or to add text on the subset of
header of the FlexTable.

Use \code{YourFlexTable[..., to = "footer"] <- ... } to
apply formatting properties or to add text on the subset of
footer of the FlexTable.

Use \code{YourFlexTable[] <- ... } to apply formatting
properties or to add text on the whole body of the
FlexTable (or header or footer depending if you are using
\code{to="header"} or \code{to="footer"}).
}
\examples{
#START_TAG_TEST
# Create a FlexTable object with first 10 lines of data.frame mtcars
# add row.names as first column
MyFTable = FlexTable( data = mtcars[1:10, ]
  , add.rownames=TRUE
)
# modify the text formatting properties for the row.names column
MyFTable[ , 1] = textProperties( font.style="italic", font.size = 9)
# align text to right for the row.names column
MyFTable[ , 1] = parProperties( text.align = "right" )

# change cell formatting properties for various columns
MyFTable[ c(3,6:9), c( "mpg", "disp"
  , "hp", "drat", "wt", "qsec" ) ] = cellProperties( background.color="#CCCCCC")
# add text to elements of the column cyl
MyFTable[, "cyl", text.properties = textProperties( 
  vertical.align="superscript", font.size = 9) ] = " miles/gallon"
# add a pot to header column 1
MyFTable[ 1, 1, to="header"] = pot("Row names", textBoldItalic())
# modify the cell formatting properties for header column 1
MyFTable[ 1, 1, to="header"] = cellProperties( background.color = "#EEEEEE")
# center text for the header row
MyFTable[ 1, , to="header"] = parProperties( text.align = "center" )
#STOP_TAG_TEST
}
\seealso{
\code{\link{addHeaderRow}}, \code{\link{addFooterRow}} ,
\code{\link{FlexTable}}, \code{\link{setFlexTableBorders}}
, \code{\link{spanFlexTableRows}},
\code{\link{spanFlexTableColumns}} ,
\code{\link{setRowsColors}},
\code{\link{setColumnsColors}}, \code{\link{setZebraStyle}}
, \code{\link{addFlexTable}},
\code{\link{addFlexTable.docx}} ,
\code{\link{addFlexTable.pptx}},
\code{\link{addFlexTable.html}}
}

