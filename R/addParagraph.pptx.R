#' @title Insert a paragraph into a pptx object
#'
#' @description
#' Insert paragraph(s) of text into a \code{pptx} object
#' 
#' @param doc Object of class \code{"pptx"} where paragraph has to be added
#' @param value character vector containing texts to add OR an object of class \code{\link{set_of_paragraphs}}.
#' @param ... further arguments, not used. 
#' @return an object of class \code{"pptx"}.
#' @examples
#' # Create a new document 
#' doc <- pptx( )
#' # Add a slide
#' doc = addSlide( doc, slide.layout = "Title and Content" )
#' # Add "Hello World" into the document doc
#' doc <- addParagraph(doc, "Hello Word!" )
#' 
#' # Add a slide
#' doc = addSlide( doc, slide.layout = "Title and Content" )

#' # Add into the document : "My tailor is rich" and "Cats and Dogs"
#' # format some of the pieces of text
#' pot1 = pot("My tailor", textProperties(color="red") ) + " is " + pot("rich"
#' 	, textProperties(font.weight="bold") )
#' my.pars = set_of_paragraphs( pot1 )
#' pot2 = pot("Cats", textProperties(color="red") ) + " and " + pot("Dogs"
#' 	, textProperties(color="blue") )
#' my.pars = set_of_paragraphs( pot1, pot2 )
#' doc <- addParagraph(doc, my.pars )
#' writeDoc( doc, "addParagraph_example.pptx")
#' @seealso \code{\link{pptx}}, \code{\link{addParagraph}}
#' @method addParagraph pptx
#' @S3method addParagraph pptx

addParagraph.pptx = function(doc, value, ... ) {
	
	if( inherits( value, "character" ) ){
		x = lapply( value, function(x) pot(value = x) )
		value = do.call( "set_of_paragraphs", x )
	}
	
	
	if( inherits(value, "set_of_paragraphs") ){
		slide = doc$current_slide 
		paragrah = .jnew(class.pptx4r.POT)
		for( pot_index in 1:length( value ) ){
			.jcall( paragrah, "V", "addP")
			pot_value = value[[pot_index]]
			for( i in 1:length(pot_value)){
				if( is.null( pot_value[[i]]$format ) ) .jcall( paragrah, "V", "addText", pot_value[[i]]$value )
				else .jcall( paragrah, "V", "addPot", pot_value[[i]]$value
							, pot_value[[i]]$format$font.size
							, pot_value[[i]]$format$font.weight=="bold"
							, pot_value[[i]]$format$font.style=="italic"
							, pot_value[[i]]$format$underlined
							, pot_value[[i]]$format$color
							, pot_value[[i]]$format$font.family
							, pot_value[[i]]$format$vertical.align
				)
			}
		}
		out = .jcall( slide, "I", "add" , paragrah)
		if( isSlideError( out ) ){
			stop( getSlideErrorString( out , "pot") )
		}
	} else stop("value must be an object of class 'set_of_paragraphs' or a character vector!")

	doc
}



