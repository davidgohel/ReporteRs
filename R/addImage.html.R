#' @title Insert an external image into a html object
#'
#' @description Add an external image into a \code{"html"} object.
#' 
#' @param doc Object of class \code{"html"} where external image has to be added
#' @param filename \code{"character"} value, complete filename of the external image
#' @param width image width in pixel
#' @param height image height in pixel
#' @param ... further arguments, not used. 
#' @return an object of class \code{"html"}.
#' @examples
#' #START_TAG_TEST
#' # Create a new document 
#' doc = html( title = "title" )
#' 
#' # add a page where to add content
#' doc = addPage( doc, title = "page example" )
#' 
#' # the file 'logo.jpg' only exists in R for Windows
#' img.file = file.path( Sys.getenv("R_HOME"), "doc", "html", "logo.jpg" )
#' doc <- addImage(doc, img.file, width = 100, height = 76 )
#' 
#' writeDoc( doc, "addImage_example" )
#' #STOP_TAG_TEST
#' @seealso \code{\link{html}}, \code{\link{addPlot.html}}
#' , \code{\link{addImage}}
#' @method addImage html
#' @S3method addImage html

addImage.html = function(doc, filename, width, height, ... ) {

	slide = doc$current_slide 
	
	jimg = .jnew(class.html4r.ImagesList, as.integer(width), as.integer( height ) )
	
	for( i in 1:length( filename ) ){
		.tempfile <- tempfile()
		base64::encode(filename[i], .tempfile)
		.jcall( jimg, "V", "addImage", as.character(paste(readLines(.tempfile), collapse = "\n")) )
		unlink(.tempfile)
	}
	out = .jcall( slide, "I", "add", jimg )
	if( out != 1 ){
		stop( "Problem while trying to add image(s)." )
	}
	
	doc
}
