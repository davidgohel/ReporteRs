#' @title Insert a title into a pptx object
#'
#' @description Add a title into a \code{\link{pptx}} object.
#' 
#' @param doc \code{\link{pptx}} object
#' @param value \code{"character"} value to use as title text
#' @param ... further arguments, not used. 
#' 
#' @return an object of class \code{\link{pptx}}.
#' @examples
#' #START_TAG_TEST
#' # Create a new document 
#' doc = pptx( title = "title" )
#' 
#' # add a slide with layout "Title and Content"
#' doc = addSlide( doc, slide.layout = "Title and Content" )
#' 
#' # Here we fill the title shape with "My title"
#' doc = addTitle( doc, "My title" )
#' 
#' # Write the object in file "addTitle_example.pptx"
#' writeDoc( doc, "addTitle_example.pptx" )
#' #STOP_TAG_TEST
#' @seealso \code{\link{pptx}}, \code{\link{addTitle}}, \code{\link{addSlide.pptx}}
#' @method addTitle pptx
#' @S3method addTitle pptx
addTitle.pptx = function( doc, value, ... ) {

	slide = doc$current_slide 
	out = .jcall( slide, "I", "addTitle", value )
	if( isSlideError( out ) ){
		stop( getSlideErrorString( out , "title(or crttitle)") )
	}
	doc
}


