#' @title color checking
#'
#' @description Check if character string is a valid color representation
#' @details
#' see \url{http://stackoverflow.com/questions/13289009/check-if-character-string-is-a-valid-color-representation/13290832#13290832}
#' @param x value(s) to be tested
#' @export
#' @examples
#' is.color( c(NA, "black", "blackk", "1", "#00", "#000000") )
#' @seealso \code{\link{pptx}}, \code{\link{docx}}

is.color = function(x) {
	out = sapply(x, function( x ) {
				tryCatch( is.matrix( col2rgb( x ) ), error = function( e ) F )
			})
	if(any( is.na( names(out) ) ) ) out[is.na( names(out) )] = FALSE
	out
}

