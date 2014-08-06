#' @title Add external image into a docx object
#'
#' @description Add external images into a \code{"docx"} object.
#' 
#' @param doc Object of class \code{"docx"} where external image has to be added
#' @param filename \code{"character"} value, complete filename of the external image
#' @param bookmark a character value ; id of the Word bookmark to replace by the image. 
#' optional. if missing, image is added at the end of the document. See \code{\link{bookmark}}.
#' @param par.properties paragraph formatting properties of the paragraph that contains images. 
#' An object of class \code{\link{parProperties}}
#' @param ... further arguments, not used. 
#' @return an object of class \code{"docx"}.
#' @examples
#' #START_TAG_TEST
#' # Create a new document 
#' doc = docx( title = "title" )
#' 
#' # the file 'logo.jpg' only exists in R for Windows
#' img.file = file.path( Sys.getenv("R_HOME"), "doc", "html", "logo.jpg" )
#' doc = addImage(doc, img.file )
#' 
#' # Write the object in file "addImage_example.docx"
#' writeDoc( doc, "addImage_example.docx" )
#' #STOP_TAG_TEST
#' @seealso \code{\link{docx}}, \code{\link{addPlot.docx}}
#' , \code{\link{addImage}}, \code{\link{bookmark}}
#' @method addImage docx
#' @S3method addImage docx
addImage.docx = function(doc, filename, bookmark,
	par.properties = parProperties(text.align = "center", padding = 5 ), ... ) {
	
	jimg = .jnew(class.Image , filename )
	
	if( missing( bookmark ) )
		.jcall( doc$obj, "V", "add", jimg
				, .jParProperties( par.properties ) )
	else .jcall( doc$obj, "V", "add", jimg, 
				.jParProperties( par.properties ), bookmark )
	
	doc
}
