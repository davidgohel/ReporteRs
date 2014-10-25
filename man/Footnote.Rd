\name{Footnote}
\alias{Footnote}
\title{Create a Footnote}
\usage{
Footnote(value, par.properties = parProperties(),
  index.text.properties = textProperties(vertical.align = "superscript"))
}
\arguments{
  \item{value}{text to add to the document as paragraphs:
  an object of class \code{\link{pot}} or
  \code{\link{set_of_paragraphs}} or a character vector.}

  \item{par.properties}{\code{\link{parProperties}} to
  apply to paragraphs.}

  \item{index.text.properties}{\code{\link{textProperties}}
  to apply to note index symbol.}
}
\value{
an object of class \code{\link{Footnote}}.
}
\description{
Footnote
}

