#' @title Insert an external image into a html object
#'
#' @description Add an external image into a \code{"html"} object.
#' 
#' @param doc Object of class \code{"html"} where external image has to be added
#' @param filename \code{"character"} value, complete filename of the external image
#' @param ... further arguments, not used. 
#' @return an object of class \code{"html"}.
#' @import base64
#' @examples
#' # Create a new document 
#' doc = html( title = "title" )
#' # add a page where to add R outputs with title 'page example'
#' doc = addPage( doc, title = "page example" )
#' doc <- addImage(doc, file.path( Sys.getenv("R_HOME"), "doc", "html", "logo.jpg" ) );
#' writeDoc( doc, "image_html" )
#' @seealso \code{\link{html}}, \code{\link{addPlot.html}}
#' , \code{\link{addImage}}
#' @method addImage html
#' @S3method addImage html

addImage.html = function(doc, filename, ... ) {

	slide = doc$current_slide 
	
	jimg = .jnew(class.html4r.ImagesList )
	
	for( i in 1:length( filename ) ){
		.tempfile <- tempfile()
		base64::encode(filename[i], .tempfile)
		rJava::.jcall( jimg, "V", "addImage", as.character(paste(readLines(.tempfile), collapse = "\n")) )
		unlink(.tempfile)
	}
	out = rJava::.jcall( slide, "I", "add", jimg )
	if( out != 1 ){
		stop( "Problem while trying to add image(s)." )
	}
	
	doc
}
