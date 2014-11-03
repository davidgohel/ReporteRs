\name{addMarkdown.html}
\alias{addMarkdown.html}
\title{Add a markdown text or file into an html object}
\usage{
\method{addMarkdown}{html}(doc, file, text,
  text.properties = textProperties(font.size =
  getOption("ReporteRs-fontsize")),
  default.par.properties = parProperties(text.align = "justify"),
  blockquote.par.properties = parProperties(padding.top = 0, padding.bottom =
  0, shading.color = "#eeeeee"),
  code.par.properties = parProperties(shading.color = "#eeeeee"),
  hr.border = borderSolid(width = 2, color = "gray10"), ...)
}
\arguments{
  \item{doc}{Object of class \code{\link{html}} where
  markdown has to be added}

  \item{file}{markdown file. Not used if text is provided.}

  \item{text}{character vector. The markdown text to
  parse.}

  \item{text.properties}{default
  \code{\link{textProperties}} object}

  \item{default.par.properties}{default
  \code{\link{parProperties}} object}

  \item{blockquote.par.properties}{\code{\link{parProperties}}
  object used for blockquote blocks.}

  \item{code.par.properties}{\code{\link{parProperties}}
  object used for code blocks.}

  \item{hr.border}{\code{\link{borderProperties}} object
  used for horizontal rules.}

  \item{...}{further arguments, not used.}
}
\value{
an object of class \code{\link{html}}.
}
\description{
Add markdown into a \code{\link{html}} object.
}
\seealso{
\code{\link{html}}
}

