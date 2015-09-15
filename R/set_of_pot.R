#' @title Set of paragraphs of text
#'
#' @description
#' Create a container of paragraphs of text (\code{\link{pot}} objects). 
#' 
#' @param ... pot objects, one per paragraph.
#' @details each pot are representing a paragraph. 
#' A paragraph consists of one or more pieces of text and ends with an end of line.
#' Objects of class \code{set_of_paragraphs} are to be used with \code{\link{addParagraph}}.
#' @export
#' @examples
#' pot1 = pot("My tailor", textProperties(color="red") ) + " is " + pot("rich"
#' 	, textProperties(font.weight="bold") )
#' pot2 = pot("Cats", textProperties(color="red") ) + " and " + pot("Dogs"
#' 	, textProperties(color="blue") )
#' my.pars = set_of_paragraphs( pot1, pot2 )
#' @seealso \code{\link{addParagraph}}, \code{\link{addParagraph.docx}}, 
#' \code{\link{addParagraph.pptx}}, \code{\link{addParagraph.bsdoc}},
#' \code{\link{pot}} 
set_of_paragraphs = function( ... ){
	
	.Object = list(...)
	if( length( .Object ) > 0 ){
		if( !all( sapply( .Object , inherits, c("pot", "character") ) ) )
			stop("set_of_paragraphs can only contains pot objects.")
		# cast characters as pot if any
		.Object = lapply( .Object, 
				function( x ) {
					if( inherits(x, "character") ) {
						pot( gsub("\\r", "", x ) )
					} else x 
				}
			)
	} else .Object = list()

	
	class( .Object ) = c("set_of_paragraphs")
	.Object
}

#' @title add a paraggraph to an existing set of paragraphs of text
#'
#' @description
#' add a paraggraph to an existing set of paragraphs of text (\code{\link{set_of_paragraphs}} object).
#' 
#' @param x \code{set_of_paragraphs} object
#' @param value \code{pot} object to add as a new paragraph
#' @export
#' @examples
#' pot1 = pot("My tailor", textProperties(color="red") ) + " is " + pot("rich"
#' 	, textProperties(font.weight="bold") )
#' my.pars = set_of_paragraphs( pot1 )
#' pot2 = pot("Cats", textProperties(color="red") ) + " and " + pot("Dogs"
#' 	, textProperties(color="blue") )
#' my.pars = add.pot( my.pars, pot2 )
#' @seealso \code{\link{set_of_paragraphs}}, \code{\link{pot}}
add.pot = function( x, value ){
	if ( class( x )!= "set_of_paragraphs" )
		stop("x must be a set_of_paragraphs object.")
	if ( class( value )!= "pot" )
		stop("value must be a pot object.")
	x[[length( x ) + 1]] = value
	x
}


#' @export
print.set_of_paragraphs = function (x, ...){
	for(i in seq_along(x)){
		print(x[[i]])
	}
}

