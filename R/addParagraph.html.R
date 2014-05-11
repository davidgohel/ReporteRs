#' @title Insert a paragraph into an html object
#'
#' @description
#' Insert paragraph(s) of text into a \code{html} object
#' 
#' @param doc Object of class \code{"html"} where paragraph has to be added
#' @param value character vector containing texts to add OR an object of class \code{\link{set_of_paragraphs}}.
#' @param stylename value of the named style to apply to paragraphs in the html document.
#' See http://getbootstrap.com/css and look for 'class' examples.
#' @param parent.type a character value ; parent tag for added paragraph. optional. If 'div', paragraph is normal 
#' ; if 'ol', paragraph will be an ordered list ; if 'ul', paragraph will be an unordered list
#' ; if 'pre', paragraph will be a preformatted text area.
#' @param ... further arguments, not used. 
#' @return an object of class \code{"html"}.
#' @examples
#' #START_TAG_TEST
#' doc.dirname = "addParagraph_example"
#' @example examples/html.R
#' @example examples/addPage.R
#' @example examples/addTitle1Level1.R
#' @example examples/addParagraph_hello_nostylename.R
#' @example examples/addTitle2Level1.R
#' @example examples/pot1_example.R
#' @example examples/pot2_example.R
#' @example examples/set_of_paragraphs_example.R
#' @example examples/addParagraph_sop_nostylename.R
#' @example examples/writeDoc_directory.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{docx}}, \code{\link{addTitle.docx}}
#' , \code{\link{addTOC.docx}}, \code{\link{addParagraph}}
#' @method addParagraph html
#' @S3method addParagraph html

addParagraph.html = function(doc, value, stylename = "text-primary", parent.type = "div", ... ) {
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
				if( is.null( pot_value[[i]]$format ) ) .jcall( jpot, "V", "addText", pot_value[[i]]$value )
				else .jcall( jpot, "V", "addPot", pot_value[[i]]$value
					, pot_value[[i]]$format$font.size
					, pot_value[[i]]$format$font.weight=="bold"
					, pot_value[[i]]$format$font.style=="italic"
					, pot_value[[i]]$format$underlined
					, pot_value[[i]]$format$color
					, pot_value[[i]]$format$font.family
					, pot_value[[i]]$format$vertical.align
					)
			}
			.jcall( paragrah, "V", "addP" , jpot)

		}
		
		out = .jcall( doc$current_slide, "I", "add" , paragrah)
		if( out != 1 ){
			stop( "Problem while trying to add paragrahs." )
		}	
		
	} else stop("value must be an object of class 'set_of_paragraphs' or a character vector!")
	
	doc
}



