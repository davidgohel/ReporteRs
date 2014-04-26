\name{FlexTable}
\alias{FlexTable}
\title{FlexTable}
\usage{
FlexTable(data, numrow, numcol, header.columns = TRUE, add.rownames = FALSE,
  cell_format = cellProperties(), par_format = parProperties(),
  text_format = textProperties(),
  header_text_format = textProperties(font.weight = "bold"))
}
\arguments{
  \item{data}{(a \code{data.frame} or \code{matrix} object)
  to add}

  \item{numrow}{number of row in the table body.}

  \item{numcol}{number of col in the table body.}

  \item{header.columns}{logical value - should the colnames
  be included in the table as table headers. If FALSE, no
  headers will be printed unless you use
  \code{\link{addHeaderRow}}.}

  \item{add.rownames}{logical value - should the row.names
  be included in the table.}

  \item{cell_format}{default cells formatting properties
  for any data}

  \item{par_format}{default paragraphs formatting
  properties for any data}

  \item{text_format}{default texts formatting properties
  for any data}
}
\description{
Create a representation of a table. FlexTable can be
manipulated so that almost any formating can be specified.
It allows to insert headers and footers rows with
eventually merged cells (see \code{\link{FlexRow}},
\code{\link{addHeaderRow}} and \code{\link{addFooterRow}}).
Formating can be done on cells, paragraphs and texts
(borders, colors, fonts, etc.), see ?"[<-.FlexTable".
Content (formated or not) can be added with the function
\code{\link{addFlexCellContent}}.
}
\examples{
#START_TAG_TEST
data( data_ReporteRs )

myFlexTable = FlexTable( data = data_ReporteRs
	, span.columns = "col1", header.columns = TRUE
 , add.rownames = FALSE )

myFlexTable[ 1:2, 2:3] = textProperties( color="red" )
myFlexTable[ 3:4, 4:5] = parProperties( text.align="right" )
myFlexTable[ 1:2, 5:6] = cellProperties( background.color="#F2969F")

myFlexTable2 = FlexTable( data=mtcars, header.columns=TRUE, add.rownames=TRUE
  , cell_format=cellProperties(background.color="#5B7778", border.color="#EDBD3E")
)

myFlexTable2 = setZebraStyle( myFlexTable2, "#D1E6E7", "#93A8A9" )
myFlexTable2 = setFlexBorder(myFlexTable2, inner_v=borderProperties(color="#EDBD3E", style="dotted", width=1)
  , inner_h=borderProperties(color="#EDBD3E", style="none", width=0)
  , outer_v=borderProperties(color="#EDBD3E", style="solid", width=1)
  , outer_h=borderProperties(color="#EDBD3E", style="solid", width=1) )


newdata = iris[1:10,]
myFT3 = FlexTable( numrow = nrow(newdata), numcol =5 )

myFT3 = addFlexCellContent(object = myFT3
  , value = newdata
  , textProperties = textProperties( color="blue" )
)
myFT3 = addFlexCellContent(object = myFT3, i = 8:10, j=1:3
  , value = matrix( paste( " (", letters[1:9], ")", sep = "" ), ncol = 3 )
  , textProperties = textProperties( color="blue" )
	)
myFT3 = spanRows( myFT3, j=1, from = 2, to = 5 )
myFT3 = spanCols( myFT3, i=6, from = 2, to = 5 )
myFT3[ 1:2, 2:3] = textProperties( color="blue" )
myFT3[ 3:4, 4:5] = parProperties( text.align="right" )

headerRow = FlexRow( names( newdata )
	, cellProp = cellProperties(
        background.color="#527578"
      , border.color="orange"
      , border.bottom.style="solid"
      , border.bottom.width=1)
  )
myFT3 = addHeaderRow( myFT3, headerRow)

myFT3 = setZebraStyle( myFT3, "#8A949B", "#FAFAFA" )
myFT3 = setFlexBorder(myFT3
  , inner_v=borderProperties(color="gray", style="solid", width=1)
  , inner_h=borderProperties(color="gray", style="solid", width=1)
  , outer_v=borderProperties(color="orange", style="solid", width=1)
  , outer_h=borderProperties(color="orange", style="solid", width=1)
)

#STOP_TAG_TEST
}
\seealso{
\code{\link{addFlexTable}}, \code{\link{FlexRow}},
\code{\link{FlexCell}} , \code{\link{addHeaderRow}} and
\code{\link{addFooterRow}} , \code{\link{pot}},
\code{\link{set_of_paragraphs}},
\code{\link{addFlexTable.docx}} ,
\code{\link{addFlexTable.pptx}},
\code{\link{addFlexTable.html}}
}

