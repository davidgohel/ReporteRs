#' @title Insert external images into a docx object
#'
#' @description Add external images into a \code{"docx"} object.
#' 
#' @param doc Object of class \code{"docx"} where external image has to be added
#' @param filename \code{"character"} value, complete filenamed of the external images
#' @param width images width in inches (default value is 6).
#' @param height images height in inches (default value is 6).
#' @param bookmark a character value ; id of the Word bookmark to replace by the image. 
#' optional. if missing, image is added at the end of the document.
#' @param parStyle paragraph formatting properties of the paragraph that contains images. 
#' An object of class \code{\link{parProperties}}
#' @param ... further arguments, not used. 
#' @return an object of class \code{"docx"}.
#' @examples
#' # Create a new document 
#' doc = docx( title = "title" )
#' 
#' img.file = file.path( Sys.getenv("R_HOME"), "doc", "html", "logo.jpg" )
#' doc <- addImage(doc, img.file )#work with only windows
#' 
#' # Write the object in file "document.docx"
#' writeDoc( doc, "document.docx" )
#' @seealso \code{\link{docx}}, \code{\link{addPlot.docx}}
#' , \code{\link{addImage}}
#' @method addImage docx
#' @S3method addImage docx

addImage.docx = function(doc, filename, width = 6, height = 6
	, bookmark
	, parStyle = parProperties(text.align = "center", padding = 5 )
	, ... ) {

	dims = as.integer( c( width*72.2 , height*72.2 )* 12700 )
	# Send the graph to java that will 'encode64ize' and place it in a docx4J object
	if( missing( bookmark ) )
		rJava::.jcall( doc$obj, "V", "addImage", .jarray( filename ), .jarray(dims)
				, parStyle$text.align
				, parStyle$padding.bottom
				, parStyle$padding.top
				, parStyle$padding.left
				, parStyle$padding.right
		)
	else rJava::.jcall( doc$obj, "V", "insertImage", bookmark, .jarray( filename ), .jarray(dims)
				, parStyle$text.align
				, parStyle$padding.bottom
				, parStyle$padding.top
				, parStyle$padding.left
				, parStyle$padding.right
		)
	
	doc
}
