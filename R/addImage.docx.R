#' @title Add external image into a docx object
#'
#' @description Add external images into a \code{\link{docx}} object.
#' 
#' @param doc Object of class \code{\link{docx}} where external image has to be added
#' @param filename \code{"character"} value, complete filename of the external image
#' @param bookmark a character value ; id of the Word bookmark to replace by the image. 
#' optional. if missing, image is added at the end of the document. See \code{\link{bookmark}}.
#' @param par.properties paragraph formatting properties of the paragraph that contains images. 
#' An object of class \code{\link{parProperties}}
#' @param width image width in inch
#' @param height image height in inch
#' @param ... further arguments, not used. 
#' @return an object of class \code{\link{docx}}.
#' @note If the following message is displayed: \code{can not read dpi, assuming 96 dpi.} 
#' ReporteRs try to read dpi from images when \code{width} and \code{height} are unknown. 
#' If it fails, the message is displayed and a value of 96 dpi is assumed. 
#' To avoid this, specify arguments \code{width} and \code{height} ; ReporteRs 
#' won't try to read dpi value.
#' @examples
#' #START_TAG_TEST
#' doc.filename = "addImage_example.docx"
#' @example examples/docx.R
#' @example examples/addImageRLogoNodim.R
#' @example examples/writeDoc_file.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{docx}}, \code{\link{addPlot.docx}}
#' , \code{\link{addImage}}, \code{\link{bookmark}}
#' @method addImage docx
#' @S3method addImage docx
addImage.docx = function(doc, filename, bookmark,
	par.properties = parProperties(text.align = "center", padding = 5 ), 
	width, height, ... ) {
	
	if( !missing( width ) && !missing(height) )
		jimg = .jnew(class.Image , filename, as.double( width ), as.double( height ) )
	else jimg = .jnew(class.Image , filename )
	
	if( missing( bookmark ) )
		.jcall( doc$obj, "V", "add", jimg
				, .jParProperties( par.properties ) )
	else .jcall( doc$obj, "V", "add", jimg, 
				.jParProperties( par.properties ), bookmark )
	
	doc
}
