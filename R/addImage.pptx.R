#' @title Insert an external image into a pptx object
#'
#' @description Add an external image into a \code{\link{pptx}} object.
#'
#' @param doc \code{\link{pptx}} object where external image has to be added
#' @param filename \code{"character"} value, complete filename of the external image
#' @param width width of the shape in inches. See details.
#' @param height height of the shape in inches. See details.
#' @param offx optional, x position of the shape (top left position of the bounding box) in inches. See details.
#' @param offy optional, y position of the shape (top left position of the bounding box) in inches See details.
#' @param ... further arguments, not used.
#' @details
#' By default, image is added to the next free 'content' shape of the current slide.
#' See \code{\link{slide.layouts.pptx}} to view the slide layout.
#'
#' Arguments \code{width} and \code{height} can be defined with functions
#' \code{png::readPNG}, \code{jpeg::readJPEG} or \code{bmp::read.bmp}.
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
#' @example examples/addImageWMFPresentation.R
#' @example examples/writeDoc_file.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{pptx}}, \code{\link{addPlot.pptx}},
#' \code{\link{addImage}}
#' @export
addImage.pptx = function(doc, filename, offx, offy, width, height, ... ) {

	slide = doc$current_slide

	if( missing(width) )
	  stop("width can not be missing")
	if( missing(height) )
	  stop("height can not be missing")

	if( !missing(offx) && !is.numeric( offx ) )
	  stop("arguments offx must be a numeric vector")
	if( !missing(offy) && !is.numeric( offy ) )
	  stop("arguments offy must be a numeric vector")
	if( !is.numeric( width ) )
	  stop("arguments width must be a numeric vector")
	if( !is.numeric( height ) )
	  stop("arguments height must be a numeric vector")

	jimg = .jnew(class.Image , filename, .jfloat( width ), .jfloat( height ) )

	if( !missing( offx ) && !missing( offy ) ){
		out = .jcall( slide, "I", "add", jimg, .jfloat( offx ), .jfloat( offy ) )
	} else {
	  out = .jcall( slide, "I", "add", jimg )
	}

	if( isSlideError( out ) ){
		stop( getSlideErrorString( out , "image") )
	}

	doc
}
