\name{addTable}
\alias{addTable}
\title{Add a table into a document object}
\usage{
addTable(doc, data, layout.properties, header.labels, groupedheader.row,
  span.columns, col.types, columns.bg.colors, columns.font.colors, row.names,
  ...)
}
\arguments{
  \item{doc}{document object}

  \item{data}{(a \code{data.frame} or \code{matrix} object)
  to add}

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

  \item{row.names}{logical value - should the row.names be
  included in the table.}

  \item{columns.font.colors}{A named list of character
  vector. Define the font color of cells per column.
  optional.  A name list, names are \code{data} column
  names and values are character vectors specifying cells
  font colors.  Each element of the list is a vector of
  length \code{nrow(data)}.}

  \item{...}{further arguments passed to or from other
  methods..}
}
\value{
a document object
}
\description{
Add a table into a document object
}
\details{
The table below shows the display model used to format
tables:\cr \preformatted{+--------------+---------------+}
\preformatted{GROUPEDHEADER_1|GROUPEDHEADER_2|}
\preformatted{+------+-------+-------+-------+}
\preformatted{HEADER1|HEADER2|HEADER3|HEADER4|}
\preformatted{+------+-------+-------+-------+}
\preformatted{ x[1,1]| x[1,2]| x[1,3]|| x[1,4]|}
\preformatted{+------+-------+-------+-------+}
\preformatted{ x[2,1]| x[2,2]| x[2,3]|| x[2,4]|}
\preformatted{+------+-------+-------+-------+}
\preformatted{ x[3,1]| x[3,2]| x[3,3]|| x[3,4]|}
\preformatted{+------+-------+-------+-------+}

See \code{\link{addTable.docx}} or
\code{\link{addTable.pptx}} or \code{\link{addTable.html}}
for examples.
}
\seealso{
\code{\link{docx}}, \code{\link{addTable.docx}} ,
\code{\link{pptx}}, \code{\link{addTable.pptx}} ,
\code{\link{html}}, \code{\link{addTable.html}}
}

