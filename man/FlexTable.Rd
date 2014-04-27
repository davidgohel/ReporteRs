\name{FlexTable}
\alias{FlexTable}
\title{FlexTable creation}
\usage{
FlexTable(data, numrow, numcol, header.columns = TRUE, add.rownames = FALSE,
  body.cell.props = cellProperties(), body.par.props = parProperties(),
  body.text.props = textProperties(), header.cell.props = cellProperties(),
  header.par.props = parProperties(),
  header.text.props = textProperties(font.weight = "bold"))
}
\arguments{
  \item{data}{(a \code{data.frame} or \code{matrix} object)
  to add}

  \item{numrow}{number of row in the table body. Mandatory
  if data is missing.}

  \item{numcol}{number of col in the table body. Mandatory
  if data is missing.}

  \item{header.columns}{logical value - should the colnames
  be included in the table as table headers. If FALSE, no
  headers will be printed unless you use
  \code{\link{addHeaderRow}}.}

  \item{add.rownames}{logical value - should the row.names
  be included in the table.}

  \item{body.cell.props}{default cells formatting
  properties for table body}

  \item{body.par.props}{default paragraphs formatting
  properties for table body}

  \item{body.text.props}{default texts formatting
  properties for table body}

  \item{header.cell.props}{default cells formatting
  properties for table headers}

  \item{header.par.props}{default paragraphs formatting
  properties for table headers}

  \item{header.text.props}{default texts formatting
  properties for table headers}
}
\description{
Create an object of class \code{FlexTable}.

FlexTable can be manipulated so that almost any formating
can be specified. It allows to insert headers and footers
rows with eventually merged cells (see
\code{\link{addHeaderRow}} and \code{\link{addFooterRow}}).

Formating can be done on cells, paragraphs and texts
(borders, colors, fonts, etc.) , see
\code{\link{alterFlexTable}}.
}
\note{
The classical workflow would be to create a FlexTable, to
add headers rows (see \code{\link{addHeaderRow}}) and
eventually footers rows (see \code{\link{addFooterRow}}).

Additionnal texts can be added with subscript syntax (see
\code{\link{alterFlexTable}}).

Texts, paragraphs and cells properties can be modified with
subscript syntax (see \code{\link{alterFlexTable}}).

Cells background colors can also be modified with functions
\code{\link{setRowsColors}} ,
\code{\link{setColumnsColors}} and
\code{\link{setZebraStyle}}.

Merging cells can be done with functions
\code{\link{spanFlexTableRows}} and
\code{\link{spanFlexTableColumns}}.
}
\examples{
#START_TAG_TEST
MyFTable = FlexTable( data = mtcars, add.rownames = TRUE
  , body.cell.props = cellProperties( border.color="#EDBD3E")
  , header.cell.props = cellProperties( background.color="#5B7778"
    , border.color="#EDBD3E")
)

MyFTable = setZebraStyle( MyFTable, odd = "#D1E6E7", even = "#93A8A9" )

MyFTable = setFlexTableBorders(MyFTable
  , inner.vertical = borderProperties( color="#EDBD3E", style="dotted" )
  , inner.horizontal = borderProperties( color = "#EDBD3E", style = "none" )
  , outer.vertical = borderProperties( color = "#EDBD3E", style = "solid" )
  , outer.horizontal = borderProperties( color = "#EDBD3E", style = "solid" )
)
#' #STOP_TAG_TEST
}
\seealso{
\code{\link{addHeaderRow}}, \code{\link{addFooterRow}} ,
\code{\link{alterFlexTable}},
\code{\link{setFlexTableBorders}} ,
\code{\link{spanFlexTableRows}},
\code{\link{spanFlexTableColumns}} ,
\code{\link{setRowsColors}},
\code{\link{setColumnsColors}}, \code{\link{setZebraStyle}}
, \code{\link{addFlexTable}},
\code{\link{addFlexTable.docx}} ,
\code{\link{addFlexTable.pptx}},
\code{\link{addFlexTable.html}}
}

