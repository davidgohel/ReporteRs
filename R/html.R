#' @title Create an HTML document object representation
#'
#' @description
#' Create a \code{"html"} object
#' 
#' @param title \code{"character"} value: title of the document (in the doc properties).
#' @return an object of class \code{"html"}.
#' @details
#' 
#' \code{html} objects are experimental ; codes and api will probably change later.
#' 
#' To send R output in an html document, a page (see \code{\link{addPage.html}}
#' have to be added to the object first (because output is beeing written in pages).
#' 
#' Several methods can used to send R output into an object of class \code{"html"}.
#'  
#' \itemize{
#'   \item \code{\link{addTitle.html}} add titles
#'   \item \code{\link{addImage.html}} add external images
#'   \item \code{\link{addParagraph.html}} add text
#'   \item \code{\link{addPlot.html}} add plots
#'   \item \code{\link{addTable.html}} add tables
#'   \item \code{\link{addFlexTable.html}} add \code{\link{FlexTable}}
#'   \item \code{\link{addRScript.html}} add R Script
#' }
#' Once object has content, user can write the htmls pages into a directory, see \code{\link{writeDoc.html}}.
#' @export
#' @examples
#' #START_TAG_TEST
#' @example examples/html_example.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{docx}}, \code{\link{pptx}}
html = function( title = "untitled" ){
		
	# java calls
	obj = .jnew(class.html4r.document, title, ifelse(l10n_info()$"UTF-8", "UTF-8", "ISO-8859-1") )
	
	.Object = list( obj = obj
		, title = title
		, canvas_id = 1
		, current_slide = NULL
		)
	class( .Object ) = "html"

	.Object
}
