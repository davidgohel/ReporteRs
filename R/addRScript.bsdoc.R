#' @title Add R script into a bsdoc object
#'
#' @description Add R script into a \code{\link{bsdoc}} object.
#' 
#' @param doc \code{\link{bsdoc}} object where expressions have to be added
#' @param file R script file. Not used if text or 
#' rscript is provided.
#' @param text character vector. The text to parse. 
#' Not used if file or rscript is provided.
#' @param rscript an object of class \code{RScript}. 
#' Not used if file or text is provided.
#' @param ... further arguments, not used. 
#' @details 
#' You have to one of the following argument: file or text or rscript. 
#' @return an object of class \code{\link{bsdoc}}.
#' @examples
#' #START_TAG_TEST
#' doc.filename = "addRScript_bsdoc/example.html"
#' @example examples/bsdoc.R
#' @example examples/addRScript.R
#' @example examples/writeDoc_file.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{bsdoc}}, \code{\link{addRScript}}
#' @export
addRScript.bsdoc = function(doc, rscript, file, text, ...) {
	
	if( !missing ( file ) ){
		rscript = RScript( file = file, ... )
	} else if( !missing ( text ) ){
		rscript = RScript( text = text, ... )
	} 
	
	out = .jcall( doc$jobj, "I", "add" , rscript$jobj)
	if( out != 1 ){
		stop( "Problem while trying to add rscript." )
	}
	doc
}

