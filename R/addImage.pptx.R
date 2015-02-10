#' @title Insert an external image into a pptx object
#'
#' @description Add an external image into a \code{\link{pptx}} object.
#' 
#' @param doc \code{\link{pptx}} object where external image has to be added
#' @param filename \code{"character"} value, complete filename of the external image
#' @param offx optional, x position of the shape (top left position of the bounding box) in inches. See details.
#' @param offy optional, y position of the shape (top left position of the bounding box) in inches See details.
#' @param width optional, width of the shape in inches See details.
#' @param height optional, height of the shape in inches See details.
#' @param ppi dot per inches, default to 72
#' @param ... further arguments, not used. 
#' @details 
#' By default, image is added to the next free 'content' shape of the current slide. 
#' See \code{\link{slide.layouts.pptx}} to view the slide layout.
#' 
#' If arguments width and height are missing, values will be defined as 
#' their respective number of pixels divide by \code{ppi}.
#' 
#' If arguments offx and offy are missing, position is defined as 
#' the position of the next available shape of the slide. This 
#' dimensions can be defined in the layout of the PowerPoint template used to create 
#' the \code{pptx} object. 
#' @return an object of class \code{\link{pptx}}.
#' @examples
#' #START_TAG_TEST
#' doc.filename = "addImage_example.pptx"
#' @example examples/pptx.R
#' @example examples/addImagePresentation.R
#' @example examples/writeDoc_file.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{pptx}}, \code{\link{addPlot.pptx}}
#' , \code{\link{addImage}}
#' @export
addImage.pptx = function(doc, filename, offx, offy, width, height, ppi = 72, ... ) {
	
	slide = doc$current_slide 
	check.dims = sum( c( !missing( offx ), !missing( offy ), !missing( width ), !missing( height ) ) )
	
	if( !missing(offx) && !is.numeric( offx ) ) stop("arguments offx must be a numeric vector")
	if( !missing(offy) && !is.numeric( offy ) ) stop("arguments offy must be a numeric vector")
	if( !missing(width) && !is.numeric( width ) ) stop("arguments width must be a numeric vector")
	if( !missing(height) && !is.numeric( height ) ) stop("arguments height must be a numeric vector")
	
#	jimg = .jnew(class.Image , filename )
	jimg = .jnew(class.Image , filename, as.integer(ppi) )
	if( !missing( width ) && !missing(height) )
		.jcall( jimg, "V", "setDim", as.double( width ), as.double( height ) )
	
	if( check.dims > 3 ){
		out = .jcall( slide, "I", "add", jimg
				, as.double( offx ), as.double( offy ), as.double( width ), as.double( height ) )
	} else if( !missing(offx) && !missing(offy) && missing(width) && missing(height) ){
		out = .jcall( slide, "I", "add", jimg
				, as.double( offx ), as.double( offy ) )
	}  else if( check.dims < 1 ){
		out = .jcall( slide, "I", "add", jimg )
	} else {
#		warning("arguments width and height ignored.")
		out = .jcall( slide, "I", "add", jimg )
	}
	
	if( isSlideError( out ) ){
		stop( getSlideErrorString( out , "image") )
	}

	doc
}
