\name{writeDoc.bsdoc}
\alias{writeDoc.bsdoc}
\title{Write a \code{bsdoc} object in a html file}
\usage{
\method{writeDoc}{bsdoc}(doc, file, reset.dir = FALSE, ...)
}
\arguments{
  \item{doc}{\code{\link{bsdoc}} object that has to be
  written.}

  \item{file}{single character value, name of the html file
  to write.}

  \item{reset.dir}{logical defaut to FALSE. Used to specify
  if the directory containing the file to produced should
  be deleted first (if existing for example). Set to FALSE
  enable to produce several html files in the same
  directory.}

  \item{...}{further arguments, not used.}
}
\value{
the function a character vector containing generated html
documents filenames.
}
\description{
Write the \code{\link{bsdoc}} object in '.html' files
located in a specified directory.

bootstrap files will be copied in the directory if
directory does not exist.
}
\examples{
#START_TAG_TEST
doc.filename = "writeDoc_bsdoc/example.html"

# set default font size to 11
options( "ReporteRs-fontsize" = 11 )

doc = bsdoc( )

# Write the object
writeDoc( doc, file = doc.filename )
#STOP_TAG_TEST
}
\seealso{
\code{\link{bsdoc}}, \code{\link{writeDoc}}
}

