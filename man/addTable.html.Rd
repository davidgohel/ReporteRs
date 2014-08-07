\name{addTable.html}
\alias{addTable.html}
\title{Insert a table into an html object}
\usage{
\method{addTable}{html}(doc, data, layout.properties, header.labels,
  groupedheader.row = list(), span.columns = character(0), col.types,
  columns.bg.colors = list(), columns.font.colors = list(),
  row.names = FALSE, par.properties = parProperties(text.align = "left"),
  ...)
}
\arguments{
  \item{doc}{the \code{html} to use}

  \item{data}{\code{data.frame} to add}

  \item{layout.properties}{a \code{tableProperties} object
  to specify styles to use to format the table. optional}

  \item{header.labels}{a character whose elements define
  labels to display in table headers instead of colnames.
  Optional, if missing, headers will be filled with
  \code{data} column names.}

  \item{groupedheader.row}{a named list whose elements
  define the upper header row (grouped header). Optional.
  Elements of that list are \code{values} and
  \code{colspan}. Element \code{values} is a character
  vector containing labels to display in the grouped header
  row. Element \code{colspan} is an integer vector
  containing number of columns to span for each
  \code{values}.}

  \item{span.columns}{a character vector specifying columns
  names where row merging should be done (if successive
  values in a column are the same ; if
  data[p,j]==data[p-1,j] )}

  \item{col.types}{a character whose elements define the
  formatting style of columns via their data roles.
  Optional Possible values are : \emph{"character"},
  \emph{"integer"}, \emph{"logical"} , \emph{"double"},
  \emph{"percent"}, \emph{"date"}, \emph{"datetime}". If
  missing, factor and character will be formated as
  character , integer as integer and numeric as double.}

  \item{columns.bg.colors}{A named list of character
  vector. Define the background color of cells for a given
  column. optional. Names are \code{data} column names and
  values are character vectors specifying cells background
  colors. Each element of the list is a vector of length
  \code{nrow(data)}.}

  \item{columns.font.colors}{A named list of character
  vector. Define the font color of cells per column.
  optional.  A name list, names are \code{data} column
  names and values are character vectors specifying cells
  font colors.  Each element of the list is a vector of
  length \code{nrow(data)}.}

  \item{row.names}{logical value - should the row.names be
  included in the table.}

  \item{par.properties}{paragraph formatting properties of
  the paragraph that contains the table. An object of class
  \code{\link{parProperties}}}

  \item{...}{addTable arguments - see
  \code{\link{addTable}}.}
}
\value{
an object of class \code{"html"}.
}
\description{
Insert a table into the \code{html} object.
}
\examples{
#START_TAG_TEST
doc.dirname = "addTable_example"

# set default font size to 10
options( "ReporteRs-fontsize" = 10 )

doc = html()

# add a page with title "page example"
doc = addPage( doc, title = "page example" )

doc = addTitle( doc, "Title example 1", level = 1 )
#
# simpliest usage
doc = addTable( doc, iris[ 1:10,] )


doc = addTitle( doc, "Title example 2", level = 1 )
# demo span.columns
# Iris sample dataset with span cells on column Species
doc = addTable( doc, iris[ 46:55,], span.columns = "Species" )


doc = addTitle( doc, "Title example 3", level = 1 )
#
# demo many options
data( data_ReporteRs )
# add dummy data 'data_ReporteRs' and customise some options
doc = addTable( doc
    , data = data_ReporteRs
    , header.labels = c( "Header 1", "Header 2", "Header 3"
        , "Header 4", "Header 5", "Header 6" )
    , groupedheader.row = list( values = c("Grouped column 1", "Grouped column 2")
        , colspan = c(3, 3) )
    , col.types = c( "character", "integer", "double", "date", "percent", "character" )
    , columns.font.colors = list(
        "col1" = c("#527578", "#84978F", "#ADA692", "#47423F")
        , "col3" = c("#74A6BD", "#7195A3", "#D4E7ED", "#EB8540")
    )
    , columns.bg.colors = list(
        "col2" = c("#527578", "#84978F", "#ADA692", "#47423F")
        , "col4" = c("#74A6BD", "#7195A3", "#D4E7ED", "#EB8540")
    )
)

# Write the object
writeDoc( doc, directory = doc.dirname )
#STOP_TAG_TEST
}
\seealso{
\code{\link{html}}, \code{\link{addTable}} ,
\code{\link{tableProperties}},
\code{\link{addFlexTable.html}} , \code{\link{FlexTable}}
}

