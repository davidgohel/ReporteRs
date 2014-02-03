#' @title Insert a paragraph into an reveal object
#'
#' @description
#' Insert paragraph(s) of text into a \code{reveal} object
#' 
#' @param doc Object of class \code{"reveal"} where paragraph has to be added
#' @param value character vector containing texts to add OR an object of class \code{\link{set_of_paragraphs}}.
#' @param stylename value of the named style to apply to paragraphs in the reveal document.
#' See http://getbootstrap.com/css and look for 'class' examples.
#' @param parent.type a character value ; parent tag for added paragraph. optional. If 'div', paragraph is normal 
#' ; if 'ol', paragraph will be an ordered list ; if 'ul', paragraph will be an unordered list
#' ; if 'pre', paragraph will be a preformatted text area.
#' @param ... further arguments, not used. 
#' @return an object of class \code{"reveal"}.
#' @examples
#' # Create a new document 
#' doc = reveal( title = "title" )
#' 
#' # add a page where to add R outputs with title 'page example 1'
#' doc = addSlide( doc )
#' 
#' # Add "Hello World" into the document doc
#' doc <- addParagraph(doc, "Hello Word!", stylename = "text-primary", parent.type = "div")
#' 
#' # add a page where to add R outputs with title 'page example 2'
#' doc = addSlide( doc )
#' 
#' # Add into the document : "My tailor is rich" and "Cats and Dogs"
#' # format some of the pieces of text
#' pot1 = pot("My tailor", textProperties(color="red") ) + " is " + pot("rich", textProperties(font.weight="bold") )
#' my.pars = set_of_paragraphs( pot1 )
#' pot2 = pot("Cats", textProperties(color="red") ) + " and " + pot("Dogs", textProperties(color="blue") )
#' my.pars = set_of_paragraphs( pot1, pot2 )
#' 
#' # used parent.type = "ul" so that paragraphs will be preceded by bullet points
#' doc <- addParagraph(doc, my.pars, stylename = "text-primary", parent.type = "ul")
#' 
#' # write the reveal object in a directory
#' reveal.directory <- "reveal_doc"
#' reveal.files = writeDoc( doc, directory = reveal.directory )
#' @seealso \code{\link{reveal}}, \code{\link{addTitle.reveal}}
#' , \code{\link{addParagraph}}
#' @method addParagraph reveal
#' @S3method addParagraph reveal

addParagraph.reveal = function(doc, value, stylename = "text-primary", parent.type = "div", ... ) {
	if( inherits( value, "character" ) ){
		x = lapply( value, function(x) pot(value = x) )
		value = do.call( "set_of_paragraphs", x )
	}
	
	parent.types = c("div", "ul", "ol", "pre")
	if( !is.element( parent.type, parent.types ) ) {
		stop("argument 'parent.type' must be of the of following values: div, ul, ol or pre.")
	}
	
	if( inherits(value, "set_of_paragraphs") ){
		paragrah = .jnew(class.html4r.POTsList, parent.type, stylename )
		
		for( pot_index in 1:length( value ) ){
			jpot = .jnew(class.html4r.POT, parent.type )
			pot_value = value[[pot_index]]
			for( i in 1:length(pot_value)){
				if( is.null( pot_value[[i]]$format ) ) rJava::.jcall( jpot, "V", "addText", pot_value[[i]]$value )
				else rJava::.jcall( jpot, "V", "addPot", pot_value[[i]]$value
					, pot_value[[i]]$format$font.size
					, pot_value[[i]]$format$font.weight=="bold"
					, pot_value[[i]]$format$font.style=="italic"
					, pot_value[[i]]$format$underlined
					, pot_value[[i]]$format$color
					, pot_value[[i]]$format$font.family
					)
			}
			rJava::.jcall( paragrah, "V", "addP" , jpot)

		}
		
		out = rJava::.jcall( doc$current_slide, "I", "add" , paragrah)
		if( out != 1 ){
			stop( "Problem while trying to add paragrahs." )
		}	
		
	} else stop("value must be an object of class 'set_of_paragraphs' or a character vector!")
	
	doc
}



