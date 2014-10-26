#' ReporteRs is an R package for creating Microsoft (Word docx 
#' and Powerpoint pptx) and html documents.
#' 
#' \tabular{ll}{
#' Package: \tab ReporteRs\cr
#' Type: \tab Package\cr
#' Version: \tab 0.6.6\cr
#' Date: \tab 2014-10-26\cr
#' License: \tab GPL (>= 3)\cr
#' LazyLoad: \tab yes\cr
#' }
#' 
#' To get an r document object:
#' \itemize{
#'   \item \code{\link{docx}} Create a Microsoft Word document object
#'   \item \code{\link{pptx}} Create a Microsoft PowerPoint document object
#'   \item \code{\link{html}} Create an HTML document object
#' }
#' 
#' The following functions can be used whatever the output format is (docx, pptx, html).
#' 
#' \itemize{
#'   \item \code{\link{addTitle}} Add a title
#'   \item \code{\link{addTable}} Add a table
#'   \item \code{\link{addFlexTable}} Add a table (new)
#'   \item \code{\link{addPlot}} Add plots
#'   \item \code{\link{addImage}} Add external images
#'   \item \code{\link{addParagraph}} Add paragraphs of text
#'   \item \code{\link{addRScript}} Add an r script 
#'   \item \code{\link{writeDoc}} Write the document into a file or a directory
#' }
#' 
#' \code{ReporteRs} comes with an object of class \code{\link{pot}} to let you 
#' handle text output and format. You can associate a text with formats (font 
#' size, font color, etc.), with an hyperlink or with a \code{\link{Footnote}} 
#' as a reference note. 
#' 
#' \code{ReporteRs} comes also with an object of class \code{\link{FlexTable}} 
#' that let you design and format tabular outputs.
#' 
#' 
#' Note that html is experimental. 
#' 
#' Default values:
#' 
#' With ReporteRs, some options can be used to reduce usage of some parameters:
#' \itemize{
#'   \item \code{"ReporteRs-default-font"} Default font family to use (default to "Helvetica").
#' This will be used as default values for argument \code{fontname} of \code{\link{addPlot}}
#' and argument \code{font.family} of \code{\link{pot}}. 
#' 
#' Note that if you do not have \code{Helvetica} font, this options must be set to an 
#' available font. 
#' 
#' 
#'   \item \code{"ReporteRs-fontsize"} Default font size to use (default to 11).
#' This will be used as default values for argument \code{pointsize} of \code{\link{addPlot}}
#' and argument \code{font.size} of \code{\link{pot}}.
#' 	 \item \code{"ReporteRs-list-definition"} see \code{\link{list.settings}}.
#'   \item \code{"ReporteRs-locale.language"} language encoding (for html objects). Default to "en".
#'   \item \code{"ReporteRs-locale.region"} region encoding (for html objects). Default to "US".
#' }
#' 
#' @examples
#' #START_TAG_TEST
#' options("ReporteRs-fontsize"=10, "ReporteRs-default-font"="Arial")
#' @example examples/options.listdefinitions.R
#' @example examples/STOP_TAG_TEST.R
#' @name ReporteRs-package
#' @aliases ReporteRs
#' @title ReporteRs: a package to create document from R
#' @author David Gohel \email{david.gohel@@lysis-consultants.fr}
#' @docType package
NULL

#' Dummy dataset used in ReporterRs examples
#' 
#' A dataset containing several data types and few rows
#' 
#' \itemize{
#'   \item col1 a character vector
#'   \item col2 an integer vector
#'   \item col3 a double vector
#'   \item col4 a date vector
#'   \item col5 a double vector (percent values)
#'   \item col6 a boolean vector
#' }
#' 
#' @docType data
#' @keywords datasets
#' @name data_ReporteRs
#' @usage data(data_ReporteRs)
#' @format A data frame with 4 rows and 6 variables
NULL


#' pbc summary
#' 
#' @docType data
#' @keywords datasets
#' @name pbc_summary
#' @usage data(pbc_summary)
#' @format A data frame
NULL


#' @title docx bookmarks
#'
#' @description \code{docx} can generate Word documents using bookmarks 
#' as placeholders to insert contents. Read MS documentation about bookmark here:
#' 
#' http://office.microsoft.com/en-us/word-help/add-or-delete-bookmarks-HP001226532.aspx#BM1
#' 
#' Functions \code{\link{addTable}}, \code{\link{addFlexTable}}, \code{\link{addPlot}}
#' , \code{\link{addParagraph}} and \code{\link{addImage}} can send respective 
#' outputs into these bookmarks.
#' 
#' These functions have an optional argument named \code{bookmark}.
#' 
#' When used with \code{\link{addPlot}}, \code{\link{addParagraph}} 
#' and \code{\link{addImage}}, content (plots, paragraphs or images) will replace 
#' the whole paragraph containing the bookmark.
#' 
#' When used with \code{\link{addTable}} and \code{\link{addFlexTable}} 
#' content (tables) will be inserted after the paragraph containing the bookmark.
#' 
#' To be used with a \code{docx} object, bookmark must be placed into 
#' a single paragraph, if placed along 1 or more paragraphs
#' side effects could occur and insertion of a content could fail. 
#' 
#' You can insert the bookmark at the beginning of the paragraph (see the file
#' bookmark_example.docx in the templates directory of the package for an example) 
#' or on a portion of a text in a paragraph.
#' 
#' @examples
#' #START_TAG_TEST
#' @example examples/bookmark.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{docx}}
#' @name docx-bookmark
#' @aliases bookmark
NULL
