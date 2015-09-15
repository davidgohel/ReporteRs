#' @title Add a code block into a bsdoc object
#'
#' @description Add a code block into a \code{\link{bsdoc}} object.
#' 
#' @param doc \code{\link{bsdoc}} object where expressions have to be added
#' @param file file. Not used if text is provided.
#' @param text character vector. The text to parse. Not used if file is provided.
#' @param par.properties code block paragraph properties. An object of class \code{\link{parProperties}}
#' @param text.properties code block text properties. An object of class \code{\link{textProperties}}
#' @param ... further arguments, not used. 
#' @return an object of class \code{\link{bsdoc}}.
#' @seealso \code{\link{bsdoc}}, \code{\link{addCodeBlock}}
#' @examples
#' #START_TAG_TEST
#' doc.filename = "addCodeBlock/example.html"
#' @example examples/bsdoc.R
#' @example examples/addCodeBlock.R
#' @example examples/writeDoc_file.R
#' @example examples/STOP_TAG_TEST.R
#' @export
addCodeBlock.bsdoc = function(doc, file, text, 
		par.properties = parProperties(), 
		text.properties = textProperties( color = "#A7947D" ), ...) {
	
	if( !missing ( file ) ){
		script = CodeBlock( file = file, 
				par.properties = par.properties, 
				text.properties = text.properties )
	} else if( !missing ( text ) ){
		script = CodeBlock( text = text, 
				par.properties = par.properties, 
				text.properties = text.properties )
	} 
	
	out = .jcall( doc$jobj, "I", "add" , script$jobj)
	if( out != 1 ){
		stop( "Problem while trying to add rscript." )
	}
	doc
}

