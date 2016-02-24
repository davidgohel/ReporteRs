#' @title Create a Footnote
#'
#' @description
#' A footnote is a a set of paragraphs placed at the bottom of a page if
#' document object is a \code{\link{docx}} object or used as a tooltip
#' if document object is an \code{\link{bsdoc}} object.
#'
#' If in a \code{docx} object, footnote will be flagged by a number immediately
#' following the portion of the text the note is in reference to.
#'
#' @param index.text.properties \code{\link{textProperties}} to apply to note
#' index symbol (only for \code{docx} object).
#' @return an object of class \code{\link{Footnote}}.
#' @examples
#'
#' @example examples/FootnoteDocxExample.R
#' @example examples/FootnoteHTMLExample.R
#' @seealso \code{\link{docx}}, \code{\link{bsdoc}}, \code{\link{pot}}
#' @export
Footnote = function( index.text.properties = textProperties(vertical.align = "superscript") ) {

	if( !inherits( index.text.properties, "textProperties" ) ){
		stop("argument index.text.properties is not a textProperties object." )
	}

	out = list( values = list(), text.properties = index.text.properties )
	class( out ) = "Footnote"

	out
}


#' @title Insert a paragraph into a Footnote object
#'
#' @description
#' Insert paragraph(s) of text into a \code{Footnote}. To create a \code{\link{Footnote}} made of
#' several paragraphs with different \code{\link{parProperties}}, add sequentially
#' paragraphs with their associated \code{parProperties} objects with this function.
#'
#' @param doc \code{\link{Footnote}} object where to add paragraphs.
#' @param value text to add to the document as paragraphs:
#' an object of class \code{\link{pot}} or \code{\link{set_of_paragraphs}}
#' or a character vector.
#' @param par.properties \code{\link{parProperties}} to apply to paragraphs.
#' @param ... further arguments, not used.
#' @return an object of class \code{\link{Footnote}}.
#' @seealso \code{\link{Footnote}}, \code{\link{parProperties}}, \code{\link{pot}}
#' , \code{\link{set_of_paragraphs}}
#' @export
addParagraph.Footnote = function( doc, value, par.properties = parProperties(), ... ) {
	if( missing( value ) ){
		stop("argument value is missing." )
	} else if( inherits( value, "character" ) ){
		value = gsub("(\\n|\\r)", "", value )
		x = lapply( value, function(x) pot(value = x) )
		value = do.call( "set_of_paragraphs", x )
	}

	if( inherits( value, "pot" ) ){
		value = set_of_paragraphs( value )
	}

	if( !inherits(value, "set_of_paragraphs") )
		stop("value must be an object of class pot, set_of_paragraphs or a character vector.")

	if( !inherits( par.properties, "parProperties" ) ){
		stop("argument par.properties is not a parProperties object." )
	}
	newid = length(doc$values) + 1
	doc$values[[newid]] = list( value = value , par.properties = par.properties )

	doc
}


.jFootnote = function( object ){
	if( !missing( object ) && !inherits( object, "Footnote" ) ){
		stop("argument 'object' must be an object of class 'Footnote'")
	}
	footnote = .jnew( class.Footnote, .jTextProperties(object$text.properties) )
	values = object$values
	for( index in 1:length( values ) ){

		if( inherits( values[[index]]$value , "RScript") ){
			.jcall( footnote, "V", "addParagraph" , values[[index]]$value$jobj )
		} else {
			parset = .jset_of_paragraphs( values[[index]]$value, values[[index]]$par.properties )
			.jcall( footnote, "V", "addParagraph" , parset )
		}

	}
	footnote
}



#' @title print a Footnote
#'
#' @description print a Footnote
#'
#' @param x a \code{\link{Footnote}} object
#' @param ... further arguments, not used.
#' @export
print.Footnote = function (x, ...){
	for(i in seq_along(x$values)){
		print(x$value[[i]]$value)
	}
}
