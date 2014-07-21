#' @title Add R script into a docx object
#'
#' @description Add R script into a \code{"docx"} object.
#' 
#' @param doc Object of class \code{"docx"} where expressions have to be added
#' @param file R script file. Not used if text or 
#' rscript is provided.
#' @param text character vector. The text to parse. 
#' Not used if file or rscript is provided.
#' @param rscript an object of class \code{RScript}. 
#' Not used if file or text is provided.
#' @param bookmark a character value ; id of the Word bookmark to 
#' replace by the script. optional. See \code{\link{bookmark}}.
#' @param ... further arguments, not used. 
#' @details 
#' You have to one of the following argument: file or text or rscript. 
#' @return an object of class \code{"docx"}.
#' @examples
#' #START_TAG_TEST
#' doc.filename = "addRScript_example.docx"
#' # Create a new document 
#' doc = docx( title = "title" )
#' 
#' an_rscript = RScript( text = "ls()
#' x = rnorm(10)" )
#' doc = addRScript(doc, an_rscript )
#' 
#' doc = addPageBreak( doc )
#' 
#' doc = addRScript(doc, text = "ls()" )
#' 
#' @example examples/writeDoc_file.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{docx}}, \code{\link{addRScript}}, \code{\link{bookmark}}
#' @method addRScript docx
#' @S3method addRScript docx
addRScript.docx = function(doc, rscript, file, text, bookmark, ... ) {
	
	if( !missing ( file ) ){
		rscript = RScript( file = file, ... )
	} else if( !missing ( text ) ){
		rscript = RScript( text = text, ... )
	} 
	
	if( missing( bookmark ) )
		out = .jcall( doc$obj, "V", "addRScript" , rscript$jobj)
	else
		out = .jcall( doc$obj, "V", "addRScript" , bookmark, rscript$jobj)
	
	doc
}
