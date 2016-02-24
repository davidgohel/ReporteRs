#' @title Set manually headers'styles of a docx object
#'
#' @description Set manually headers'styles of a docx object
#' @details
#' Function \code{addTitle} need to know which styles
#' are corresponding to which title level (1 ; 1.1 ; 1.1.1 ; etc.).
#' When template is read, function \code{docx} try to guess what
#' are theses styles. If he do not succeed, an error occured saying
#' 'You must defined header styles via declareTitlesStyles first.'. In that
#' case, run \code{styles(...)} to see what are available styles, then
#' declareTitlesStyles to indicate which available styles are meant to be
#' used as header styles.
#'
#' @param doc \code{docx} object to be used with declareTitlesStyles.
#' @param stylenames existing styles (character vector) where first element
#' represents the style to use for title 1, second element represents
#' the style to use for title 2, etc.
#' @param ... further arguments, not used.
#' @examples
#' doc.filename = "addImage_example.docx"
#' @example examples/docx.R
#' @example examples/declareTitlesStyles.docx.R
#' @seealso \code{\link{docx}},\code{\link{styles.docx}},\code{\link{addTitle.docx}}
#' ,\code{\link{declareTitlesStyles}}
#' @export
declareTitlesStyles.docx = function( doc, stylenames, ... ) {
	if( !all( is.element( stylenames, styles( doc ) ) ) ){
		stop("Some of the stylenames are not in available styles (run styles on your object to list available styles.")
	}
	doc$header.styles = stylenames
	doc
	}
