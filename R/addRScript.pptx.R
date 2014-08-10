#' @title Add R script into a pptx object
#'
#' @description Add R script into a \code{\link{pptx}} object.
#' 
#' @param doc \code{\link{pptx}} object where expressions have to be added
#' @param file R script file. Not used if text or 
#' rscript is provided.
#' @param text character vector. The text to parse. 
#' Not used if file or rscript is provided.
#' @param rscript an object of class \code{RScript}. 
#' Not used if file or text is provided.
#' @param ... further arguments, not used. 
#' @details 
#' You have to one of the following argument: file or text or rscript. 
#' @return an object of class \code{\link{pptx}}.
#' @examples
#' #START_TAG_TEST
#' doc.filename = "addRScript_example.pptx"
#' # Create a new document 
#' doc = pptx( title = "title" )
#' doc = addSlide( doc, slide.layout = "Title and Content" )
#' an_rscript = RScript( text = "ls()
#' x = rnorm(10)", par.properties = parProperties() )
#' doc = addRScript(doc, an_rscript )
#' 
#' @example examples/writeDoc_file.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{pptx}}, \code{\link{addRScript}}
#' @method addRScript pptx
#' @S3method addRScript pptx
addRScript.pptx = function(doc, rscript, file, text, ... ) {
	
	if( !missing ( file ) ){
		rscript = RScript( file = file, ... )
	} else if( !missing ( text ) ){
		rscript = RScript( text = text, ... )
	} 
	
	out = .jcall( doc$current_slide, "I", "add", rscript$jobj )
	if( isSlideError( out ) ){
		stop( getSlideErrorString( out , "RScript") )
	}
	doc
}
