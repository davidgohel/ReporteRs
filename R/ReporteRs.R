#' ReporteRs lets you create Microsoft Word, Microsoft PowerPoint
#' and html documents.
#'
#' To get an r document object:
#' \itemize{
#'   \item \code{\link{docx}} Create a Microsoft Word document object
#'   \item \code{\link{pptx}} Create a Microsoft PowerPoint document object
#'   \item \code{\link{bsdoc}} Create an HTML document object
#' }
#'
#' The following functions can be used whatever the output format is (docx, pptx, bsdoc).
#'
#' \itemize{
#'   \item \code{\link{addTitle}} Add a title
#'   \item \code{\link{addFlexTable}} Add a table (new)
#'   \item \code{\link{addPlot}} Add plots
#'   \item \code{\link{addImage}} Add external images
#'   \item \code{\link{addMarkdown}} Add markdown
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
#' If many text output is needed you may consider using
#' function \code{\link{addMarkdown}}.
#'
#' Default values:
#'
#' With ReporteRs, some options can be used to reduce usage of some parameters:
#' \itemize{
#'   \item \code{"ReporteRs-default-font"} Default font family to use (default to "Helvetica").
#' This will be used as default values for argument \code{fontname} of \code{\link{addPlot}}
#' and argument \code{font.family} of \code{\link{pot}}.
#'
#'
#'   \item \code{"ReporteRs-fontsize"} Default font size to use (default to 11).
#' This will be used as default values for argument \code{pointsize} of \code{\link{addPlot}}
#' and argument \code{font.size} of \code{\link{pot}}.
#'
#'   \item \code{"ReporteRs-backtick-color"} backtick font color in markdown
#'   \item \code{"ReporteRs-backtick-shading-color"} backtick shading color in markdown
#' 	 \item \code{"ReporteRs-list-definition"} see \code{\link{list.settings}}.
#'   \item \code{"ReporteRs-locale.language"} language encoding (for html objects). Default to "en".
#'   \item \code{"ReporteRs-locale.region"} region encoding (for html objects). Default to "US".
#' }
#'
#' @note
#'
#' Examples are in a \code{dontrun} section as they are using font that may be not
#' available on the host machine. Default font is Helvetica, it can be modified
#' with option \code{ReporteRs-default-font}. To run an example with 'Arial'
#' default font, run first
#'
#' 	\code{options("ReporteRs-default-font" = "Arial")}
#'
#' @examples
#' options("ReporteRs-fontsize"=10, "ReporteRs-default-font"="Helvetica")
#' @example examples/options.listdefinitions.R
#' @name ReporteRs-package
#' @aliases ReporteRs
#' @title ReporteRs: a package to create document from R
#' @author David Gohel \email{david.gohel@@lysis-consultants.fr}
#' @docType package
NULL


#' @title docx bookmarks
#'
#' @description \code{docx} can generate Word documents using bookmarks
#' as placeholders to insert contents. Read MS documentation about bookmark here:
#'
#' http://office.microsoft.com/en-us/word-help/add-or-delete-bookmarks-HP001226532.aspx#BM1
#'
#' Functions \code{\link{addFlexTable}}, \code{\link{addPlot}}
#' , \code{\link{addParagraph}} and \code{\link{addImage}} can send respective
#' outputs into these bookmarks.
#'
#' These functions have an optional argument named \code{bookmark}.
#'
#' When used with \code{\link{addPlot}}, \code{\link{addParagraph}}
#' and \code{\link{addImage}}, content (plots, paragraphs or images) will replace
#' the whole paragraph containing the bookmark.
#'
#' When used with \code{\link{addFlexTable}}
#' content (table) will be inserted after the paragraph containing the bookmark.
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
#'
#' @example examples/bookmark.R
#' @seealso \code{\link{docx}}
#' @name docx-bookmark
#' @aliases bookmark
NULL
