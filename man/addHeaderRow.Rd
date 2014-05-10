\name{addHeaderRow}
\alias{addHeaderRow}
\title{add header in a FlexTable}
\usage{
addHeaderRow(x, value, colspan, text.properties, par.properties,
  cell.properties)
}
\arguments{
  \item{x}{a \code{FlexTable} object}

  \item{value}{\code{FlexRow} object to insert as an header
  row or a character vector specifying labels to use as
  columns labels.}

  \item{colspan}{integer vector. Optional. Applies only
  when argument \code{value} is a character vector. Vector
  specifying the number of columns to span for each
  corresponding value (in \code{values}).}

  \item{text.properties}{Optional. textProperties to apply
  to each cell. Used only if values are not missing.
  Default is the value of argument \code{header.text.props}
  provided to funtion \code{FlexTable} when object has been
  created}

  \item{par.properties}{Optional. parProperties to apply to
  each cell. Used only if values are not missing. Default
  is the value of argument \code{header.par.props} provided
  to funtion \code{FlexTable} when object has been created}

  \item{cell.properties}{Optional. cellProperties to apply
  to each cell. Used only if values are not missing.
  Default is the value of argument \code{header.cell.props}
  provided to funtion \code{FlexTable} when object has been
  created}
}
\description{
add a header row in a FlexTable
}
\examples{
#START_TAG_TEST
#############################
# simple example
#############################

data(pbc_summary)

# set header.columns to FALSE so that default header row is not added in
# the FlexTable object
# We do only want the 4 first columns of the dataset
MyFTable = FlexTable( data = pbc_summary[,1:4], header.columns = FALSE )

# add an header row with 2 cells, the first one spans three columns
# and the second one spans one column (normal width)
MyFTable = addHeaderRow( MyFTable
  , value = c("By variables", "Serum cholesterol (mg/dl)")
  , colspan = c( 3, 1) 
)

# add an header row with table columns labels
MyFTable = addHeaderRow( MyFTable
  , value=c("Treatment", "Sex", "Status", "Mean")
)
#######################################
# how to change default formats
#######################################
data(pbc_summary)

MyFTable = FlexTable( data = pbc_summary[,1:4], header.columns = FALSE
  , body.cell.props = cellProperties(border.color="#7895A2")
)
# add an header row with table columns labels
MyFTable = addHeaderRow( MyFTable
  , text.properties = textProperties(color = "#517281", font.weight="bold")
  , cell.properties = cellProperties(border.color="#7895A2")
  , value=c("Treatment", "Sex", "Status", "Serum cholesterol (mg/dl)")
)
#########################################
# example with FlexRow objects usage
#########################################

data(pbc_summary)

# cell styles definitions
cellProperties1 = cellProperties( border.top.width = 2
    , border.right.style="dashed"
    , border.bottom.style="dashed"
    , border.left.width = 2 )
cellProperties2 = cellProperties( border.top.width = 2
    , border.left.style="dashed"
    , border.bottom.style="dashed"
    , border.right.width = 2 )

# create a FlexTable
MyFTable = FlexTable( data = pbc_summary[,1:4]
  , header.columns = FALSE, body.text.props=textProperties() )

# create a FlexRow - container for 2 cells
headerRow = FlexRow()
headerRow[1] = FlexCell( "By variables", colspan = 3, cell.properties = cellProperties1 )
headerRow[2] = FlexCell( "Serum cholesterol (mg/dl)", cell.properties = cellProperties2 )
# add the FlexRow to the FlexTable
MyFTable = addHeaderRow( MyFTable, headerRow )


# cell styles definitions
cellProperties3 = cellProperties( border.bottom.width = 2, border.left.width = 2
    , border.right.style="dashed"
    , border.top.style="dashed" 
)
cellProperties4 = cellProperties( border.bottom.width = 2
    , border.right.style="dashed", border.left.style="dashed"
    , border.top.style="dashed" )
cellProperties5 = cellProperties( border.bottom.width = 2, border.right.width = 2
    , border.left.style="dashed"
    , border.top.style="dashed"
)

# create a FlexRow - container for 4 cells
headerRow = FlexRow()
headerRow[1] = FlexCell( "Treatment", cell.properties = cellProperties3 )
headerRow[2] = FlexCell( "Sex", cell.properties = cellProperties4 )
headerRow[3] = FlexCell( "Status", cell.properties = cellProperties4 )
headerRow[4] = FlexCell( "Mean", cell.properties = cellProperties5 )
# add the FlexRow to the FlexTable
MyFTable = addHeaderRow( MyFTable, headerRow )
MyFTable = setFlexTableBorders( MyFTable
  , inner.vertical = borderProperties( style = "dashed" )
  , inner.horizontal = borderProperties( style = "dashed" )
  , outer.vertical = borderProperties( width = 2 )
  , outer.horizontal = borderProperties( width = 2 )
)
#' #STOP_TAG_TEST
}
\seealso{
\code{\link{FlexTable}}, \code{\link{addFooterRow}},
\code{\link{setFlexTableWidths}} ,
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

