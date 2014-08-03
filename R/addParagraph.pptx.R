#' @title Insert a paragraph into a pptx object
#'
#' @description
#' Insert paragraph(s) of text into a \code{pptx} object
#' 
#' @param doc Object of class \code{"pptx"} where paragraph has to be added
#' @param value character vector containing text to add to the document as paragraphs: 
#' an object of class \code{\link{pot}} or \code{\link{set_of_paragraphs}} 
#' or a character vector.
#' @param offx optional, x position of the shape (top left position of the bounding box) 
#' in inch. See details.
#' @param offy optional, y position of the shape (top left position of the bounding box) 
#' in inch. See details.
#' @param width optional, width of the shape in inch. See details.
#' @param height optional, height of the shape in inch. See details.
#' @param par.properties a parProperties object
#' @param ... further arguments, not used. 
#' @return an object of class \code{"pptx"}.
#' @details
#' If arguments offx, offy, width, height are missing, position and dimensions
#' will be defined by the width and height of the next available shape of the slide. This 
#' dimensions can be defined in the layout of the PowerPoint template used to create 
#' the \code{pptx} object. 
#' 
#' If arguments offx, offy, width, height are provided, they become position and 
#' dimensions of the new shape.
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
#' @example examples/addParagraph_position_parProperties.R
#' @example examples/addSlide.R
#' @example examples/addTitle3Level1.R
#' @example examples/pot1_example.R
#' @example examples/pot2_example.R
#' @example examples/set_of_paragraphs_example.R
#' @example examples/addParagraph_parProperties.R
#' @example examples/writeDoc_file.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{pptx}}, \code{\link{addParagraph}}
#' @method addParagraph pptx
#' @S3method addParagraph pptx
addParagraph.pptx = function(doc, value, offx, offy, width, height, par.properties = parProperties(), ... ) {
	
	if( inherits( value, "character" ) ){
		x = lapply( value, function(x) pot(value = x) )
		value = do.call( "set_of_paragraphs", x )
	}
	if( inherits( value, "pot" ) ){
		value = set_of_paragraphs( value )
	}
	
	if( !inherits(value, "set_of_paragraphs") )
		stop("value must be an object of class pot, set_of_paragraphs or a character vector.")
	
	if( !inherits( par.properties, "parProperties" ) ){
		stop("argument 'par.properties' must be an object of class 'parProperties'")
	}
	
	
	slide = doc$current_slide 
	paragrahSection = ParagraphSection (value, par.properties )
	paragrah = .jnew(class.pptx4r.Paragraphs)
	.jcall( paragrah, "V", "setTextBody", paragrahSection$jobj)
	
	if( !missing( offx )){
		out = .jcall( slide, "I", "add", paragrah
				, as.double( offx ), as.double( offy ), as.double( width ), as.double( height ) )
	} else {
		out = .jcall( slide, "I", "add" , paragrah)
	}	
	
	if( isSlideError( out ) ){
		stop( getSlideErrorString( out , "pot") )
	}
	
	doc
}



