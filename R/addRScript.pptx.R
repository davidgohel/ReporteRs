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
#' @param append boolean default to FALSE. If TRUE, paragraphs will be 
#' appened in the current shape instead of beeing sent into a new shape. 
#' Paragraphs can only be appended on shape containing paragraphs (i.e. you 
#' can not add paragraphs after a FlexTable).
#' @param ... further arguments, not used. 
#' @details 
#' You have to one of the following argument: file or text or rscript. 
#' @return an object of class \code{\link{pptx}}.
#' @examples
#' #START_TAG_TEST
#' doc.filename = "addRScript_example.pptx"
#' @example examples/pptx.R
#' @example examples/addSlide.R
#' @example examples/addTitle1NoLevel.R
#' @example examples/addRScript.R
#' @example examples/writeDoc_file.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{pptx}}, \code{\link{addRScript}}
#' @export
addRScript.pptx = function(doc, rscript, file, text, append = FALSE, ... ) {
	
	if( !missing ( file ) ){
		rscript = RScript( file = file, ... )
	} else if( !missing ( text ) ){
		rscript = RScript( text = text, ... )
	} 
	if( !append )
		out = .jcall( doc$current_slide, "I", "add", rscript$jobj )
	else out = .jcall( doc$current_slide, "I", "append", rscript$jobj )
	if( isSlideError( out ) ){
		stop( getSlideErrorString( out , "RScript") )
	}
	doc
}
