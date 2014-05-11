\name{chprop.textProperties}
\alias{chprop.textProperties}
\title{Modify text formatting properties}
\usage{
\method{chprop}{textProperties}(object, color, font.size, font.weight,
  font.style, underlined, font.family, vertical.align, ...)
}
\arguments{
  \item{object}{\code{textProperties} object to modify}

  \item{...}{further arguments - not used}

  \item{color}{font color - a single character value
  specifying a valid color (e.g. "#000000" or "black").}

  \item{font.size}{font size - 0 or positive integer
  value.}

  \item{font.weight}{single character value specifying font
  weight (expected value is \code{normal} or \code{bold}).}

  \item{font.style}{single character value specifying font
  style (expected value is \code{normal} or
  \code{italic}).}

  \item{underlined}{single logical value specifying if the
  font is underlined.}

  \item{font.family}{single character value specifying font
  name (it has to be an existing font in the OS).}

  \item{vertical.align}{single character value specifying
  font vertical alignments. Expected value is one of the
  following : default \code{'baseline'} or
  \code{'subscript'} or \code{'superscript'}}
}
\value{
a \code{textProperties} object
}
\description{
Modify an object of class \code{textProperties}.
}
\examples{
#START_TAG_TEST
textProp = textProperties()

textProp01 = chprop( textProp, color = "red" )
textProp02 = chprop( textProp, font.size = 12 )
textProp03 = chprop( textProp, font.weight = "bold" )
textProp04 = chprop( textProp, font.style = "italic" )
textProp05 = chprop( textProp, underlined = TRUE )
textProp06 = chprop( textProp, font.family = "Arial" )
textProp07 = chprop( textProp, vertical.align = "superscript" )

textProp08 = chprop( textProp, font.size = 12, font.weight = "bold", color = "red" )
#STOP_TAG_TEST
}
\seealso{
\code{\link{cellProperties}}, \code{\link{parProperties}},
\code{\link{textProperties}} ,
\code{\link{chprop.cellProperties}},
\code{\link{chprop.parProperties}} ,
\code{\link{FlexTable}}, \code{\link{tableProperties}},
\code{\link{pot}}
}

