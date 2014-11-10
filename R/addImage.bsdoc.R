#' @title Insert an external image into a bsdoc object
#'
#' @description Add an external image into a \code{\link{bsdoc}} object.
#' 
#' @param doc \code{\link{bsdoc}} object where external image has to be added
#' @param filename \code{"character"} value, complete filename of the external image
#' @param width image width in pixel
#' @param height image height in pixel
#' @param ... further arguments, not used. 
#' @return an object of class \code{\link{bsdoc}}.
#' @examples
#' #START_TAG_TEST
#' doc.filename = "addImage_bsdoc/example.html"
#' @example examples/bsdoc.R
#' @example examples/addImageRLogo.R
#' @example examples/writeDoc_file.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{bsdoc}}, \code{\link{addPlot.bsdoc}}
#' , \code{\link{addImage}}
#' @method addImage bsdoc
#' @S3method addImage bsdoc
addImage.bsdoc = function(doc, filename, width, height, ... ) {

	if( missing( width ) && missing(height) ){
		stop("width and height cannot be missing")
	}
	
	for( i in 1:length( filename ) ){
		jimg = .jnew(class.Image , filename[i] )
		if( !missing( width ) && !missing(height) )
			.jcall( jimg, "V", "setDim", as.integer(width), as.integer(height) )
		out = .jcall( doc$jobj, "I", "add", jimg )
		if( out != 1 )
			stop( "Problem while trying to add image(s)." )
	}
	
	
	doc
}
