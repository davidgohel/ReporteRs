#' @title Add R script into a pptx object
#'
#' @description Add R script into a \code{"pptx"} object.
#' 
#' @param doc Object of class \code{"pptx"} where expressions have to be added
#' @param rscript an object of class \code{RScript}
#' @param ... further arguments, not used. 
#' @return an object of class \code{"pptx"}.
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
addRScript.pptx = function(doc, rscript, ... ) {
	out = .jcall( doc$current_slide, "I", "add", rscript$jobj )
	if( isSlideError( out ) ){
		stop( getSlideErrorString( out , "RScript") )
	}
	doc
}
