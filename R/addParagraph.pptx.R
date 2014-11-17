#' @title Insert a paragraph into a pptx object
#'
#' @description
#' Insert paragraph(s) of text into a \code{pptx} object
#' 
#' @param doc \code{\link{pptx}} object where paragraph is added
#' @param value text to add to the document as paragraphs: 
#' an object of class \code{\link{pot}} or \code{\link{set_of_paragraphs}} 
#' or a character vector.
#' @param offx optional, x position of the shape (top left position of the bounding box) 
#' in inch. See details.
#' @param offy optional, y position of the shape (top left position of the bounding box) 
#' in inch. See details.
#' @param width optional, width of the shape in inch. See details.
#' @param height optional, height of the shape in inch. See details.
#' @param par.properties \code{\link{parProperties}} to apply to paragraphs. Shading 
#' and border settings will have no effect.
#' @param restart.numbering boolean value. If \code{TRUE}, next numbered 
#' list counter will be set to 1.
#' @param append boolean default to FALSE. If TRUE, paragraphs will be 
#' appened in the current shape instead of beeing sent into a new shape. 
#' Paragraphs can only be appended on shape containing paragraphs (i.e. you 
#' can not add paragraphs after a FlexTable).
#' @param ... further arguments, not used. 
#' @return an object of class \code{\link{pptx}}.
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
#' @example examples/addTitle1NoLevel.R
#' @example examples/addParagraph_hello_nostylename.R
#' @example examples/addSlide.R
#' @example examples/addTitle2NoLevel.R
#' @example examples/pot1_example.R
#' @example examples/pot2_example.R
#' @example examples/set_of_paragraphs_example.R
#' @example examples/addParagraph_sop_nostylename.R
#' @example examples/addParagraph_position_parProperties.R
#' @example examples/addSlide.R
#' @example examples/addTitle3NoLevel.R
#' @example examples/pot1_example.R
#' @example examples/pot2_example.R
#' @example examples/set_of_paragraphs_example.R
#' @example examples/addParagraph_parProperties.R
#' @example examples/addSlide.R
#' @example examples/addTitle1NoLevel.R
#' @example examples/lists_slide.R
#' @example examples/writeDoc_file.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{pptx}}, \code{\link{addParagraph}}
#' \code{\link{addMarkdown.pptx}}, \code{\link{pot}}
#' @method addParagraph pptx
#' @S3method addParagraph pptx
addParagraph.pptx = function(doc, value, offx, offy, width, height, 
		par.properties = parProperties(), 
		append = FALSE, 
		restart.numbering = FALSE, ... ) {
	
	check.dims = sum( c( !missing( offx ), !missing( offy ), !missing( width ), !missing( height ) ) )
	if( check.dims > 0 && check.dims < 4 ) {
		if( missing( offx ) ) warning("arguments offx, offy, width and height must all be specified: offx is missing")
		if( missing( offy ) ) warning("arguments offx, offy, width and height must all be specified: offy is missing")
		if( missing( width ) ) warning("arguments offx, offy, width and height must all be specified: width is missing")
		if( missing( height ) ) warning("arguments offx, offy, width and height must all be specified: height is missing")
	}
	if( check.dims > 3 ) {
		if( !is.numeric( offx ) ) stop("arguments offx must be a numeric value")
		if( !is.numeric( offy ) ) stop("arguments offy must be a numeric value")
		if( !is.numeric( width ) ) stop("arguments width must be a numeric value")
		if( !is.numeric( height ) ) stop("arguments height must be a numeric value")
		
		if( length( offx ) != length( offy ) 
				|| length( offx ) != length( width )
				|| length( offx ) != length( height ) || length( offx )!= 1 ){
			stop("arguments offx, offy, width and height must be numeric of length 1")
		}
	}
	
	
	if( inherits( value, "character" ) ){
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
		stop("argument 'par.properties' must be an object of class 'parProperties'")
	}
	
	
	slide = doc$current_slide 
	
	parset = .jset_of_paragraphs(value, par.properties)
	
	if( check.dims > 3 ){
		out = .jcall( slide, "I", "add", parset
				, as.double( offx ), as.double( offy ), as.double( width ), as.double( height ), 
				as.logical(restart.numbering) )
	} else {
		if( append ){
			out = .jcall( slide, "I", "append" , parset, as.logical(restart.numbering))
			if( out == 1) stop("append is possible if current shape is a shape containing paragraphs.") 
		} else out = .jcall( slide, "I", "add" , parset, as.logical(restart.numbering))
	}	
	
	if( isSlideError( out ) ){
		stop( getSlideErrorString( out , "pot") )
	}
	
	doc
}



