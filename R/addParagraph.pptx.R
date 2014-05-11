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
#' #START_TAG_TEST
#' doc.filename = "addParagraph_example.pptx"
#' @example examples/pptx.R
#' @example examples/addSlide.R
#' @example examples/addTitle1Level1.R
#' @example examples/addParagraph_hello_nostylename.R
#' @example examples/addSlide.R
#' @example examples/addTitle2Level1.R
#' @example examples/pot1_example.R
#' @example examples/pot2_example.R
#' @example examples/set_of_paragraphs_example.R
#' @example examples/addParagraph_sop_nostylename.R
#' @example examples/writeDoc_file.R
#' @example examples/STOP_TAG_TEST.R
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



