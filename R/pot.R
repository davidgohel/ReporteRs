#' @title Piece of Text (formated text)
#'
#' @description
#' Create an object with a text to display and its formatting properties.
#'
#' @param value text value or a value that has a \code{format} method returning character value.
#' @param format formatting properties (an object of class \code{textProperties}).
#' @param hyperlink a valid url to use as hyperlink when clicking on \code{value}.
#' @param footnote a \code{\link{Footnote}} object.
#' @details a pot (piece of text) is a convenient way to define a paragraph
#' of text where some text are not all formated the same.
#'
#' A pot can be associated with an hyperlink.
#'
#' A pot can be associated with a Footnote. Note that footnotes can not be inserted in
#' a \code{pptx} object.
#' @export
#' @examples
#' #
#' @example examples/pot1_example.R
#' @example examples/pot2_example.R
#' @seealso \code{\link{addParagraph.docx}}, \code{\link{addParagraph.pptx}},
#'  \code{\link{addParagraph.bsdoc}}, \code{\link{Footnote}}
#' , \code{\link{+.pot}}
pot = function( value ="", format = textProperties(), hyperlink, footnote ){

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
	.Object[[1]]$jimg = NULL

	if( !missing(format) ){
		if( !inherits(format, "textProperties") )
			stop("argument format must be a textProperties object.")
		else .Object[[1]]$format = format
	} else .Object[[1]]$format = NULL

	if( !missing( hyperlink )){
		if( !is.character( hyperlink ) || length( hyperlink ) != 1 )
			stop("hyperlink must be a character vector of size 1.")
		.Object[[1]]$hyperlink = hyperlink
	}

	if( !missing( footnote )){
		if( !inherits(footnote, "Footnote") )
			stop("footnote must be a Footnote object.")
		.Object[[1]]$footnote = footnote
	}

	class( .Object ) = c("pot")
	.Object
}

#' @title Image to be concatenate with pot object
#'
#' @description
#' Create an pot object that handle images.
#'
#' @param filename \code{"character"} value, complete filename of the external image
#' @param width image width in inches
#' @param height image height in inches
#' @export
pot_img = function( filename, width, height ){

	if( length( filename ) != 1 ){
		stop("length of filename must be 1.")
	}

  filename <- getAbsolutePath(filename, expandTilde = TRUE)

  if( !file.exists( filename ) )
		stop( filename, " does not exist")

	if( !grepl("\\.(png|jpg|jpeg|gif|bmp|wmf|emf)$", filename ) )
		stop( filename, " is not a valid file. Valid files are png, jpg, jpeg, gif, bmp, wmf, emf.")

  if( missing(width) )
    stop("width can not be missing")
  if( missing(height) )
    stop("height can not be missing")

	jimg = .jnew(class.Image , filename, .jfloat( width ), .jfloat( height ) )

	.Object = list()
	.Object[[1]] = list()
	.Object[[1]]$value = ""
	.Object[[1]]$jimg = jimg

	class( .Object ) = c("pot")
	.Object
}


#' @title Print pot objects
#'
#' @description print a \code{\link{pot}} object.
#' Within RStudio, the pot is rendered in the viewer.
#'
#' @param x a \code{\link{pot}} object
#' @param ... further arguments, not used.
#' @export
print.pot = function (x, ...){

	viewer <- getOption("viewer")
	if ( !interactive() || is.null( viewer ) ){
		for(i in seq_along(x)){
			if( !is.null(x[[i]]$format) ) cat("[", x[[i]]$value, as.character(x[[i]]$format), "]", sep = "" )
			else cat("[", x[[i]]$value, "]", sep = "" )
		}
	} else {

		path = file.path(tempfile(), "index.html" )
		doc = bsdoc( )
		doc = addParagraph( doc, x )
		doc = writeDoc( doc, path, reset.dir = TRUE)
		if( !is.null( viewer ) && is.function( viewer ) ){
			viewer( path )
		} else {
			utils::browseURL(path)
		}
	}
}

#' @export
as.character.pot = function (x, ...){
	out = ""
	for(i in seq_along(x)){
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
#' @seealso \code{\link{addParagraph}}
#' @export
"+.pot" = function(e1, e2) {
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

#' @title get HTML code from a pot
#'
#' @description get HTML code from a pot
#'
#' @param object the \code{pot} object
#' @param ... further arguments passed to other methods
#' @return a character value
#' @seealso \code{\link{pot}}
#' @examples
#' my_pot = pot("My tailor", textProperties(color="red") ) + " is " + pot("rich"
#' 	, textProperties(font.weight="bold") )
#' as.html( my_pot )
#' @export
as.html.pot = function( object, ... ) {
	par = .jpot( object )
	.jcall( par, "S", "getHTML" )
}

#' @importFrom knitr knit_print
#' @importFrom knitr asis_output
#' @title pot custom printing function for knitr
#'
#' @description pot custom printing function for knitr
#'
#' @param x a \code{pot} to be printed
#' @param ... further arguments, not used.
#' @export
knit_print.pot<- function(x, ...){
  asis_output(paste0("<p>", as.html(x), "</p>"))
}

.jpot = function( object ){
	if( !missing( object ) && !inherits( object, "pot" ) ){
		stop("argument 'object' must be an object of class 'pot'")
	}
	paragrah = .jnew(class.Paragraph)
	if( !missing( object ) )
		for( i in 1:length(object)){
			current_value = object[[i]]
			if( !is.null( current_value$jimg )){
				.jcall( paragrah, "V", "addImage", current_value$jimg )
				.jcall( paragrah, "V", "addText", "")
			} else {
				if( is.null( current_value$format ) ) {
					if( is.null( current_value$hyperlink ) )
						.jcall( paragrah, "V", "addText", current_value$value )
					else .jcall( paragrah, "V", "addText", current_value$value, current_value$hyperlink )
				} else {
					jtext.properties = .jTextProperties( current_value$format )
					if( is.null( current_value$hyperlink ) )
						.jcall( paragrah, "V", "addText", current_value$value, jtext.properties )
					else .jcall( paragrah, "V", "addText", current_value$value, jtext.properties, current_value$hyperlink )
				}
				if( !is.null( current_value$footnote ) ) {
					.jcall( paragrah, "V", "addFootnoteToLastEntry", .jFootnote(current_value$footnote ) )
				}
			}
		}
	paragrah
}
