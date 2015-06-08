#' @title Add a code block into a pptx object
#'
#' @description Add a code block into a \code{\link{pptx}} object.
#' 
#' @param doc \code{\link{pptx}} object
#' @param file file. Not used if text is provided.
#' @param text character vector. The text to parse. Not used if file is provided.
#' @param par.properties code block paragraph properties. An object of class \code{\link{parProperties}}
#' @param text.properties code block text properties. An object of class \code{\link{textProperties}}
#' @param append boolean default to FALSE. If TRUE, paragraphs will be 
#' appened in the current shape instead of beeing sent into a new shape. 
#' Paragraphs can only be appended on shape containing paragraphs (i.e. you 
#' can not add paragraphs after a FlexTable).
#' @param ... further arguments, not used.
#' @return an object of class \code{\link{pptx}}.
#' @seealso \code{\link{pptx}}, \code{\link{addCodeBlock}}
#' @examples
#' #START_TAG_TEST
#' doc.filename = "addCodeBlock.pptx"
#' @example examples/pptx.R
#' @example examples/addSlide.R
#' @example examples/addTitle1NoLevel.R
#' @example examples/addCodeBlock.R
#' @example examples/writeDoc_file.R
#' @example examples/STOP_TAG_TEST.R
#' @export
addCodeBlock.pptx = function(doc, file, text, 
		par.properties = parProperties(), 
		text.properties = textProperties( color = "#A7947D" ), 
		append = FALSE, ... ) {
	
	if( !missing ( file ) ){
		script = CodeBlock( file = file, 
				par.properties = par.properties, 
				text.properties = text.properties )
	} else if( !missing ( text ) ){
		script = CodeBlock( text = text, 
				par.properties = par.properties, 
				text.properties = text.properties )
	} 
	
	
	if( !append )
		out = .jcall( doc$current_slide, "I", "add", script$jobj )
	else out = .jcall( doc$current_slide, "I", "append", script$jobj )
	if( isSlideError( out ) ){
		stop( getSlideErrorString( out , "CodeBlock") )
	}
	doc
}
