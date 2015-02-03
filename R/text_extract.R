#' @title Simple Text Extraction From a Word Document
#'
#' @description
#' Provides a simple method to get text from a docx document. 
#' It returns a \code{character} vector containing all 
#' chunk of text found in the document.
#' @param x \code{\link{docx}} object
#' @param body specifies to scan document body 
#' @param header specifies to scan document header 
#' @param footer specifies to scan document footer 
#' @param bookmark a character value ; id of the Word bookmark to scan.
#' @return a character vector
#' @examples 
#' #START_TAG_TEST
#' doc = docx( title = "My example", template = file.path( 
#'   find.package("ReporteRs"), "templates/bookmark_example.docx") )
#' text_extract( doc )
#' text_extract( doc, header = FALSE, footer = FALSE )
#' text_extract( doc, bookmark = "author" )
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{docx}}
#' @export
text_extract = function( x, body = TRUE, header = TRUE, footer = TRUE, bookmark){
	if( missing( bookmark ) )
		out = .jcall(x$obj, "[S", "getWords", body, header, footer)
	else {
		if( length( bookmark ) != 1 || !is.character(bookmark))
			stop("bookmark must be an atomic character.")
		out = .jcall(x$obj, "[S", "getWords", casefold( bookmark, upper = FALSE ) )
	}
	out
}
