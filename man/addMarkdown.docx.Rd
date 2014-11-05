\name{addMarkdown.docx}
\alias{addMarkdown.docx}
\title{Add a markdown text or file into a docx object}
\usage{
\method{addMarkdown}{docx}(doc, file, text,
  text.properties = textProperties(font.size =
  getOption("ReporteRs-fontsize")),
  default.par.properties = parProperties(text.align = "justify"),
  blockquote.par.properties = parProperties(padding = 6, shading.color =
  "#eeeeee"), code.par.properties = parProperties(shading.color = "#eeeeee"),
  hr.border = borderSolid(width = 2, color = "gray10"), ...)
}
\arguments{
  \item{doc}{Object of class \code{\link{docx}} where
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
an object of class \code{\link{docx}}.
}
\description{
Add markdown into a \code{\link{docx}} object.
}
\details{
You can configure backtick rendering (single or double
backtick) with options "ReporteRs-backtick-color" and
"ReporteRs-backtick-shading-color".
}
\examples{
#START_TAG_TEST
doc.filename = "addMarkdown_example.docx"

# set default font size to 10
options( "ReporteRs-fontsize" = 10 )

doc = docx( )
mkd = "# This is a title 1
		
This is a link to the [cran] (http://cran.r-project.org/). 

This paragraph demonstrates note usage[^anote]. It also show an example of 
reference link like this one: [DaringFireball][1].

[^anote]: Here's a note with multiple blocks.

    This paragraph is indented and belongs to the previous footnote.
    
    This paragraph also belongs to the previous footnote. 
    In this way, multi-paragraph footnotes work like
    multi-paragraph list items.

        ls()

    * This list item belongs to the previous footnote. 

## This is a title 1.1

Ex turba vero imae sortis et paupertinae in tabernis aliqui pernoctant 
vinariis, non nulli velariis umbraculorum theatralium latent, quae Campanam 
imitatus lasciviam Catulus in aedilitate sua suspendit omnium primus

Aut pugnaciter aleis certant turpi sono fragosis naribus introrsum reducto 
spiritu concrepantes; aut quod est studiorum omnium maximum ab ortu lucis 
ad vesperam sole fatiscunt vel pluviis, per minutias aurigarum equorumque 
praecipua vel delicta scrutantes.

Paragraphs must be separated by a blank line. Basic formatting of *italics* and **bold** is 
supported. This *can be **nested** like* so. Formatting of ``backtick`` is also 
supported.
		
# This is a title 2
		
## Ordered list

1. Item 1
2. A second item
3. Number 3


## Unordered list

* An item
* Another item
* Yet another item
		
# Code block
		
    x = rnorm( 1000 )
    plot( density( x ) )
		
You can also make `inline code` to add code into other things.
		
# Quote
		
> Here is a quote. Quotes are indented 
when used.
> > Subquotes are also supported.
		
# URLs
		
* A named link to [DaringFireball][1]. 
* Another named link to [DaringFireball](http://daringfireball.net/projects/markdown)
* Sometimes you just want a URL like <http://daringfireball.net/projects/markdown>.
		
# Miscellaneous
		
## Horizontal rule

A horizontal rule is a line that goes across the middle of the page.

---------

It's sometimes usefull for breaking things up.

## Images

This implementation does not support images yet. Use addImage or addPlot instead.

[1]: http://daringfireball.net/projects/markdown/
"

doc = addMarkdown( doc, text = mkd, 
	default.par.properties = parProperties(text.align = "justify", 
		padding.left = 0) )

# Write the object
writeDoc( doc, file = doc.filename )
#STOP_TAG_TEST
}
\seealso{
\code{\link{docx}}
}

