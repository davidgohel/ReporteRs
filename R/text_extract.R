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
#'
#' @example examples/text_extract_get_docx.R
#' @example examples/text_extract.R
#' @seealso \code{\link{docx}}, \code{\link{list_bookmarks}}
#' @export
text_extract = function( x, body = TRUE, header = TRUE, footer = TRUE, bookmark){

	if( !inherits(x, "docx")){
		stop("x must be a docx object.")
	}

	if( missing( bookmark ) )
		out = .jcall(x$obj, "[S", "getWords", body, header, footer)
	else {
		if( length( bookmark ) != 1 || !is.character(bookmark))
			stop("bookmark must be an atomic character.")
		out = .jcall(x$obj, "[S", "getWords", casefold( bookmark, upper = FALSE ) )
	}
	out
}

#' @title List Bookmarks from a Word Document
#'
#' @description
#' List all bookmarks available in a \code{docx} object.
#' @param x a \code{docx} object
#' @param body specifies to scan document body
#' @param header specifies to scan document header
#' @param footer specifies to scan document footer
#' @return a character vector
#' @examples
#'
#' @example examples/text_extract_get_docx.R
#' @example examples/list_bookmarks.R
#' @seealso \code{\link{docx}}, \code{\link{text_extract}}
#' @export
list_bookmarks = function( x, body = TRUE, header = TRUE, footer = TRUE){

	if( !inherits(x, "docx")){
		stop("x must be a docx object.")
	}

	out = .jcall(x$obj, "[S", "getBookMarks", body, header, footer)
	setdiff(out, "_GoBack" )
}
