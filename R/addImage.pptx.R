#' @title Insert an external image into a pptx object
#'
#' @description Add an external image into a \code{\link{pptx}} object.
#' 
#' @param doc \code{\link{pptx}} object where external image has to be added
#' @param filename \code{"character"} value, complete filename of the external image
#' @param offx optional, x position of the shape (top left position of the bounding box) in inch. See details.
#' @param offy optional, y position of the shape (top left position of the bounding box) in inch See details.
#' @param width optional, width of the shape in inch See details.
#' @param height optional, height of the shape in inch See details.
#' @param ... further arguments, not used. 
#' @details 
#' Image is added to the next free 'content' shape of the current slide. 
#' See \code{\link{slide.layouts.pptx}} to view the slide layout.
#' 
#' If arguments offx, offy, width, height are missing, position and dimensions
#' will be defined by the width and height of the next available shape of the slide. This 
#' dimensions can be defined in the layout of the PowerPoint template used to create 
#' the \code{pptx} object. 
#' 
#' If arguments offx, offy, width, height are provided, they become position and 
#' dimensions of the new shape.
#' @return an object of class \code{\link{pptx}}.
#' @examples
#' #START_TAG_TEST
#' # Create a new document 
#' doc = pptx( title = "title" )
#' 
#' # add a slide with layout "Title and Content" then add an image
#' doc = addSlide( doc, slide.layout = "Title and Content" )
#' 
#' # the file 'logo.jpg' only exists in R for Windows
#' img.file = file.path( Sys.getenv("R_HOME"), "doc", "html", "logo.jpg" )
#' doc = addImage(doc, img.file )
#' 
#' writeDoc( doc, "addImage_example.pptx" )
#' #STOP_TAG_TEST
#' @seealso \code{\link{pptx}}, \code{\link{addPlot.pptx}}
#' , \code{\link{addImage}}
#' @export
addImage.pptx = function(doc, filename, offx, offy, width, height, ... ) {
	
	slide = doc$current_slide 
	check.dims = sum( c( !missing( offx ), !missing( offy ), !missing( width ), !missing( height ) ) )
	
	if( !missing(offx) && !is.numeric( offx ) ) stop("arguments offx must be a numeric vector")
	if( !missing(offy) && !is.numeric( offy ) ) stop("arguments offy must be a numeric vector")
	if( !missing(width) && !is.numeric( width ) ) stop("arguments width must be a numeric vector")
	if( !missing(height) && !is.numeric( height ) ) stop("arguments height must be a numeric vector")
	
	jimg = .jnew(class.Image , filename )

	if( check.dims > 3 ){
		out = .jcall( slide, "I", "add", jimg
				, as.double( offx ), as.double( offy ), as.double( width ), as.double( height ) )
	} else if( !missing(offx) && !missing(offy) && missing(width) && missing(height) ){
		out = .jcall( slide, "I", "add", jimg
				, as.double( offx ), as.double( offy ) )
	}  else if( check.dims < 1 ){
		out = .jcall( slide, "I", "add", jimg )
	} else {
		warning("arguments width and height ignored.")
		out = .jcall( slide, "I", "add", jimg )
	}
	
	if( isSlideError( out ) ){
		stop( getSlideErrorString( out , "image") )
	}

	doc
}
