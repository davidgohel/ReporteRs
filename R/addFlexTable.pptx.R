#' @title Insert a FlexTable into a pptx object
#'
#' @description Insert a FlexTable into a pptx object
#' 
#' @param doc docx object
#' @param flextable the \code{FlexTable} object
#' @param offx optional, x position of the shape (top left position of the bounding box) in inch. See details.
#' @param offy optional, y position of the shape (top left position of the bounding box) in inch. See details.
#' @param width optional, width of the shape in inch. See details.
#' @param height optional, height of the shape in inch. See details.
#' @param ... further arguments - not used
#' @return a pptx object
#' @seealso \code{\link{FlexTable}}, \code{\link{pptx}}
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
#' doc.filename = "addFlexTable_example.pptx"
#' @example examples/pptx.R
#' @example examples/addSlide.R
#' @example examples/addTitle1NoLevel.R
#' @example examples/FlexTableExample.R
#' @example examples/addFlexTable.R
#' @example examples/addSlide.R
#' @example examples/addTitle2NoLevel.R
#' @example examples/agg.mtcars.FlexTable.R
#' @example examples/addFlexTable.R
#' @example examples/addFlexTable_posdim.R
#' @example examples/addSlide.R
#' @example examples/addTitle3NoLevel.R
#' @example examples/setFlexTableBackgroundColors.R
#' @example examples/addFlexTable.R
#' @example examples/writeDoc_file.R
#' @example examples/STOP_TAG_TEST.R
#' @method addFlexTable pptx
#' @S3method addFlexTable pptx
addFlexTable.pptx = function(doc, flextable, offx, offy, width, height, ... ) {
	
	check.dims = sum( c( !missing( offx ), !missing( offy ), !missing( width ), !missing( height ) ) )
	if( check.dims > 0 && check.dims < 4 ) {
		if( missing( offx ) ) warning("arguments offx, offy, width and height must be all specified: offx is missing")
		if( missing( offy ) ) warning("arguments offx, offy, width and height must be all specified: offy is missing")
		if( missing( width ) ) warning("arguments offx, offy, width and height must be all specified: width is missing")
		if( missing( height ) ) warning("arguments offx, offy, width and height must be all specified: height is missing")
	}
	if( check.dims > 3 ) {
		if( !is.numeric( offx ) ) stop("arguments offx must be a numeric vector")
		if( !is.numeric( offy ) ) stop("arguments offy must be a numeric vector")
		if( !is.numeric( width ) ) stop("arguments width must be a numeric vector")
		if( !is.numeric( height ) ) stop("arguments height must be a numeric vector")
		
		if( length( offx ) != length( offy ) 
				|| length( offx ) != length( width )
				|| length( offx ) != length( height ) || length( offx )!= 1 ){
			stop("arguments offx, offy, width and height must have the same length")
		}
	}
	
	if( check.dims > 3 ){
		out = .jcall( doc$current_slide, "I", "add", flextable$jobj
				, as.double( offx ), as.double( offy ), as.double( width ), as.double( height ) )
	} else {
		out = .jcall( doc$current_slide, "I", "add", flextable$jobj )
	}	
	
	if( isSlideError( out ) ){
		stop( getSlideErrorString( out , "table") )
	}
	doc
}

