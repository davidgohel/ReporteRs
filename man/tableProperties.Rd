\name{tableProperties}
\alias{tableProperties}
\title{Table formating properties}
\usage{
  tableProperties(header.text = textProperties(font.size = 12, font.weight = "bold"),
    header.par = parProperties(padding = 3, text.align = "left"),
    header.cell = cellProperties(border.width = 1, background.color = "#e8eaeb"),
    groupedheader.text = textProperties(font.size = 12, font.weight = "bold"),
    groupedheader.par = parProperties(padding = 3, text.align = "left"),
    groupedheader.cell = cellProperties(border.width = 1, background.color = "#e8eaeb"),
    double.text = textProperties(font.size = 12),
    double.par = parProperties(padding = 3, text.align = "left"),
    double.cell = cellProperties(),
    integer.text = textProperties(font.size = 12),
    integer.par = parProperties(padding = 3, text.align = "left"),
    integer.cell = cellProperties(),
    percent.text = textProperties(font.size = 12),
    percent.par = parProperties(padding = 3, text.align = "left"),
    percent.cell = cellProperties(),
    character.text = textProperties(font.size = 12),
    character.par = parProperties(padding = 3, text.align = "left"),
    character.cell = cellProperties(),
    date.text = textProperties(font.size = 12, font.style = "italic"),
    date.par = parProperties(padding = 3, text.align = "left"),
    date.cell = cellProperties(),
    datetime.text = textProperties(font.size = 12, font.style = "italic"),
    datetime.par = parProperties(padding = 3, text.align = "left"),
    datetime.cell = cellProperties(),
    logical.text = textProperties(font.size = 12, font.style = "italic"),
    logical.par = parProperties(padding = 3, text.align = "left"),
    logical.cell = cellProperties(),
    percent.addsymbol = "\%",
    locale.language = getOption("ReporteRs-locale.language"),
    locale.region = getOption("ReporteRs-locale.region"),
    fraction.double.digit = 4L,
    fraction.percent.digit = 3L, data.cell, data.par,
    data.text)
}
\arguments{
  \item{data.cell}{cell formatting properties for columns
  of any type. Overwrites any *.cell (except headers)}

  \item{data.par}{paragraph formatting properties for
  columns of any type. Overwrites any *.par (except
  headers)}

  \item{data.text}{text formatting properties for columns
  of any type. Overwrites any *.text (except headers)}

  \item{header.text}{text formatting properties of column
  headers}

  \item{header.par}{paragraph formatting properties of
  column headers}

  \item{header.cell}{cell formatting properties of column
  headers}

  \item{groupedheader.text}{text formatting properties of
  groupedheaders}

  \item{groupedheader.par}{paragraph formatting properties
  of groupedheaders}

  \item{groupedheader.cell}{cell formatting properties of
  groupedheaders}

  \item{double.text}{text formatting properties of columns
  of type 'double'}

  \item{double.par}{paragraph formatting properties for
  columns of type 'double'}

  \item{double.cell}{cell formatting properties for columns
  of type 'double'}

  \item{integer.text}{text formatting properties for
  columns of type 'integer'}

  \item{integer.par}{paragraph formatting properties for
  columns of type 'integer'}

  \item{integer.cell}{cell formatting properties for
  columns of type 'integer'}

  \item{percent.text}{text formatting properties for
  columns of type 'percent'}

  \item{percent.par}{paragraph formatting properties for
  columns of type 'percent'}

  \item{percent.cell}{cell formatting properties for
  columns of type 'percent'}

  \item{character.text}{text formatting properties for
  columns of type 'character'}

  \item{character.par}{paragraph formatting properties for
  columns of type 'character'}

  \item{character.cell}{cell formatting properties for
  columns of type 'character'}

  \item{date.text}{text formatting properties for columns
  of type 'date'}

  \item{date.par}{paragraph formatting properties for
  columns of type 'date'}

  \item{date.cell}{cell formatting properties for columns
  of type 'date'}

  \item{logical.text}{text formatting properties for
  columns of type 'logical'}

  \item{logical.par}{paragraph formatting properties for
  columns of type 'logical'}

  \item{logical.cell}{cell formatting properties for
  columns of type 'logical'}

  \item{datetime.text}{text formatting properties for
  columns of type 'datetime'}

  \item{datetime.par}{paragraph formatting properties for
  columns of type 'datetime'}

  \item{datetime.cell}{cell formatting properties for
  columns of type 'datetime'}

  \item{percent.addsymbol}{represents the symbol to add
  after percent data as been formated (character, default
  to '')}

  \item{fraction.double.digit}{the minimum number of digits
  to the right of the decimal point in formatting 'double'
  data. Allowed values are fraction.double.digit >=0.}

  \item{fraction.percent.digit}{the minimum number of
  digits to the right of the decimal point in formatting
  'percent' data. Allowed values are fraction.percent.digit
  >=0.}

  \item{locale.language}{locale language symbol ("fr, "en",
  etc.) - default to
  getOption("ReporteRs-locale.language")}

  \item{locale.region}{locale region symbol ("FR, "US",
  etc.) - default to getOption("ReporteRs-locale.region")}
}
\description{
  Create an object that describes table formating
  properties.
}
\details{
  tableProperties is used to control table format when
  addTable is used. One can customize headers (or grouped
  headers) and content. Headers share all the same format.
  Content is formated according to its data type
  (\code{col.types} argument in \code{\link{addTable}}).
  "double" columns share all the same format, "character"
  columns share all the same format, etc. Conditionnal
  formating is not specified in tableProperties but in
  \code{\link{addTable}}.
}
\examples{
# define table properties - set headers aligned on the right, font color
# is gray and font size is 12 points
tableProperties( header.text = textProperties(color="gray", font.size = 12)
		, header.par = parProperties( text.align = "right" )
)
}
\seealso{
  \code{\link{addTable}}
}

