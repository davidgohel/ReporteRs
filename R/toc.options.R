#' @title Set TOC options
#'
#' @description set options for custom table of contents
#' of a \code{docx} object.
#'
#' @param doc Object of class \code{docx}
#' @param list.separator list separator (should be the same than in computer's regional settings)
#' @param ... further arguments passed to other methods - not used.
#' @details
#' This function is to be used if TOC cannot be built. It is
#' occuring when list separator used when building the TOC is
#' different from the list separator in your computer's regional settings.
#'
#' See entry 302865 of Microsoft knowledge database for more information.
#'
#' @examples
#' doc = docx( title = "title" )
#' doc = toc.options( doc, list.separator = "," )
#' @seealso \code{\link{docx}}, \code{\link{addTOC.docx}}
#' @export
toc.options.docx = function( doc, list.separator, ... ){

	if( missing( list.separator ) )
		stop("list.separator is missing")
	if( length( list.separator ) != 1 )
		stop("length of list.separator must be 1")
	if( nchar( list.separator ) != 1 )
		stop("number of character of list.separator must be 1 (',' or ';'")
	.jcall( doc$obj, "V", "setListSeparator", list.separator )
	doc
}
