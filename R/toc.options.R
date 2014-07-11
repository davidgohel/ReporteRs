#' @title Set TOC options
#'
#' @description set options for custom table of contents 
#' of a \code{docx} object.
#' 
#' @param x Object of class \code{docx}
#' @param list.separator list separator (should be the same than in computer's regional settings)
#' @details 
#' This function is to be used if TOC cannot be built. It is 
#' occuring when list separator used when building the TOC is 
#' different from the list separator in your computer's regional settings.
#' 
#' see \url{http://support.microsoft.com/kb/302865/EN-US}
#' @examples
#' #START_TAG_TEST
#' doc = docx( title = "title" )
#' doc = toc.options( doc, list.separator = "," )
#' #STOP_TAG_TEST
#' @seealso \code{\link{docx}}, \code{\link{addTOC.docx}}
#' @method toc.options docx
#' @S3method toc.options docx
toc.options.docx = function( x, list.separator ){
	
	if( missing( list.separator ) )
		stop("list.separator is missing")
	if( length( list.separator ) != 1 )
		stop("length of list.separator must be 1")
	if( nchar( list.separator ) != 1 )
		stop("number of character of list.separator must be 1 (',' or ';'")
	.jcall( x$obj, "V", "setListSeparator", list.separator )
	x
}
