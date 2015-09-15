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
#' @param width image width in inches
#' @param height image height in inches
#' @param ppi dot per inches, default to 72
#' @param ... further arguments, not used. 
#' @return an object of class \code{\link{docx}}.
#' @details 
#' If arguments width and height are missing, values will be defined as 
#' their respective number of pixels divide by \code{ppi}.
#' @examples
#' #START_TAG_TEST
#' doc.filename = "addImage_example.docx"
#' @example examples/docx.R
#' @example examples/addImageDocument.R
#' @example examples/addImageWMFDocument.R
#' @example examples/writeDoc_file.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{docx}}, \code{\link{addPlot.docx}}
#' , \code{\link{addImage}}, \code{\link{bookmark}}
#' @export
addImage.docx = function(doc, filename, bookmark,
	par.properties = parProperties(text.align = "center", padding = 5 ), 
	width, height, ppi = 72, ... ) {

	if( grepl("\\.(wmf|emf)$", filename ) ){
		if( missing( width ) || missing(height) )
			stop("when using wmf or emf file, you must specify argument width and height.")
	}

	jimg = .jnew(class.Image , filename, as.integer(ppi) )
	if( !missing( width ) && !missing(height) )
		.jcall( jimg, "V", "setDim", as.double( width ), as.double( height ) )
	
	if( missing( bookmark ) )
		.jcall( doc$obj, "V", "add", jimg
				, .jParProperties( par.properties ) )
	else .jcall( doc$obj, "V", "add", jimg, 
				.jParProperties( par.properties ), bookmark )
	
	doc
}
