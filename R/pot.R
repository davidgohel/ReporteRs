#' @title Piece of Text (formated text)
#'
#' @description
#' Create an object with a text to display and its formating properties.
#' 
#' @param value text value or a value that has a \code{format} method returning character value.
#' @param format formating properties (an object of class \code{textProperties}).
#' @details a pot (piece of text) is a convenient way to define a paragraph 
#' of text where some texts are not all formated the same.
#' @export
#' @examples
#' pot("My tailor", textProperties(color="red") ) + " is " + pot("rich"
#' 	, textProperties(font.weight="bold") )
#' @seealso \code{\link{addParagraph}}, \code{\link{addParagraph.docx}}, \code{\link{addParagraph.pptx}}, \code{\link{addParagraph.html}}
#' , \code{\link{pptx}}, \code{\link{docx}}, \code{\link{html}}
pot = function( value , format = textProperties() ){

	value = format( value )
	if( !is.character( value ) ){
		stop("value must be a character vector or must have a format method returning a string value.")
	}  
	
	if( length( value ) != 1 ){
		stop("length of value must be 1.")
	} 
	
	.Object = list()
	.Object[[1]] = list()
	.Object[[1]]$value = value
	if( !missing(format) ){
		if( !inherits(format, "textProperties") )
			stop("argument format must be a textProperties object.")
		else .Object[[1]]$format = format
	} else .Object[[1]]$format = NULL

	class( .Object ) = c("pot")
	.Object
}

#' @method print pot
#' @S3method print pot
print.pot = function (x, ...){
	for(i in 1:length(x)){
		if( !is.null(x[[i]]$format) ) cat("[", x[[i]]$value, as.character(x[[i]]$format), "]", sep = "" )
		else cat("[", x[[i]]$value, "]", sep = "" )
	}
}
#' @method as.character pot
#' @S3method as.character pot
as.character.pot = function (x, ...){
	out = ""
	for(i in 1:length(x)){
		if( !is.null(x[[i]]$format) ) out = paste0(out, "[", x[[i]]$value, as.character(x[[i]]$format), "]" )
		else out = paste0(out, "[", x[[i]]$value, "]" )
	}
	out
}

#' @title pot concatenation
#'
#' @description
#' "+" function is to be used for concatenation of \code{\link{pot}} elements.
#' Concatenation of 2 \code{pot} objects returns a pot (of length 2).
#' @param e1 a \code{pot} object or a character (vector of length 1).
#' @param e2 a \code{pot} object or a character (vector of length 1).
#' @details at least one of the two objects must be a \code{pot} object.
#' If one of the 2 parameters is a simple string, it is converted as a 
#' \code{pot} object with no associated format ; therefore, document default document style
#' will be used (see \code{\link{addParagraph}}).
#' @examples
#' pot("My tailor", textProperties(color="red") ) + " is " + pot("rich"
#' 	, textProperties(font.weight="bold") )
#' @seealso \code{\link{addParagraph}}, \code{\link{addParagraph.docx}}, \code{\link{addParagraph.pptx}}, \code{\link{pptx}}, \code{\link{docx}}
#' @method + pot
#' @S3method + pot
#' @rdname pot-add
"+.pot" <- function(e1, e2) {
	if( is.character(e1) ) e1 = pot(value = e1)
	if( is.character(e2) ) e2 = pot(value = e2)
	if( !inherits(e1, "pot") )
		stop("e1 must be a pot object")
	if( !inherits(e2, "pot") )
		stop("e2 must be a pot object")
	e1 = append( e1, e2 )
	class( e1 ) = c("pot")
	e1
}

