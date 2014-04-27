\name{FlexTable}
\alias{FlexTable}
\title{FlexTable creation}
\usage{
FlexTable(data, numrow, numcol, header.columns = TRUE, add.rownames = FALSE,
  cell_format = cellProperties(), par_format = parProperties(),
  text_format = textProperties(), header_cell_format = cellProperties(),
  header_par_format = parProperties(),
  header_text_format = textProperties(font.weight = "bold"))
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

  \item{cell_format}{default cells formatting properties
  for any data}

  \item{par_format}{default paragraphs formatting
  properties for any data}

  \item{text_format}{default texts formatting properties
  for any data}

  \item{header_cell_format}{default cells formatting
  properties for header columns}

  \item{header_par_format}{default paragraphs formatting
  properties for header columns}

  \item{header_text_format}{default texts formatting
  properties for any header columns}
}
\description{
Create an object of class \code{FlexTable}.

FlexTable can be manipulated so that almost any formating
can be specified. It allows to insert headers and footers
rows with eventually merged cells (see
\code{\link{addHeaderRow}} and \code{\link{addFooterRow}}).

Formating can be done on cells, paragraphs and texts
(borders, colors, fonts, etc.) , see
\code{?alterFlexTable}.
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
  , cell_format = cellProperties( border.color="#EDBD3E")
  , header_cell_format = cellProperties( background.color="#5B7778"
    , border.color="#EDBD3E")
)

MyFTable = setZebraStyle( MyFTable, odd = "#D1E6E7", even = "#93A8A9" )

MyFTable = setFlexTableBorders(MyFTable
  , inner.vertical = borderProperties( color="#EDBD3E", style="dotted" )
  , inner.horizontal = borderProperties( color = "#EDBD3E", style = "none" )
  , outer.vertical = borderProperties( color = "#EDBD3E", style = "solid" )
  , outer.horizontal = borderProperties( color = "#EDBD3E", style = "solid" )
)
doc = docx( title = "title" )
doc = addFlexTable( doc, MyFTable )
writeDoc( doc, "addFlexTable_example.docx")
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

