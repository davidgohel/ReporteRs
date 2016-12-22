#' @title map titles styles
#'
#' @description Set manually headers'styles of a docx object
#' @details
#' Function \code{addTitle} need to know which styles
#' are corresponding to which title level (1 ; 1.1 ; 1.1.1 ; etc.).
#' When template is read, function \code{docx} try to guess what
#' are theses styles. If he do not succeed, an error occured saying
#' 'You must defined header styles via map_title first.'. In that
#' case, run \code{styles(...)} to see what are available styles, then
#' map_title to indicate which available styles are meant to be
#' used as header styles.
#'
#' @param doc \code{docx} object to be used with map_title.
#' @param stylenames existing styles (character vector) where first element
#' represents the style to use for title 1, second element represents
#' the style to use for title 2, etc.
#' @examples
#' \donttest{
#' doc.filename = "addImage_example.docx"
#' doc <- docx()
#' doc = map_title(doc, stylenames = c("Titre1", "Titre2", "Titre3",
#'   "Titre4", "Titre5", "Titre6", "Titre7", "Titre8", "Titre9" ) )
#' }
#' @seealso \code{\link{docx}},\code{\link{styles.docx}},\code{\link{addTitle.docx}}
#' @export
map_title = function( doc, stylenames ) {
  stopifnot(inherits(doc, "docx"))

	if( !all( is.element( stylenames, styles( doc ) ) ) ){
		stop("Some of the stylenames are not in available styles (run styles on your object to list available styles.")
	}
	doc$header.styles = stylenames
	doc
}
