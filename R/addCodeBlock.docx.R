#' @title Add a code block into a docx object
#'
#' @description Add a code block into a \code{\link{docx}} object.
#' 
#' @param doc Object of class \code{\link{docx}}
#' @param file file. Not used if text is provided.
#' @param text character vector. The text to parse. Not used if file is provided.
#' @param par.properties code block paragraph properties. An object of class \code{\link{parProperties}}
#' @param text.properties code block text properties. An object of class \code{\link{textProperties}}
#' @param bookmark a character value ; id of the Word bookmark to 
#' replace by the script. optional. See \code{\link{bookmark}}.
#' @param ... further arguments, not used. 
#' @details 
#' You have to one of the following argument: file or text or rscript. 
#' @return an object of class \code{\link{docx}}.
#' @seealso \code{\link{docx}}, \code{\link{addCodeBlock}}
#' @examples
#' #START_TAG_TEST
#' doc.filename = "addCodeBlock.docx"
#' @example examples/docx.R
#' @example examples/addCodeBlock.R
#' @example examples/writeDoc_file.R
#' @example examples/STOP_TAG_TEST.R
#' @export
#' @export
addCodeBlock.docx = function(doc, file, text, 
		par.properties = parProperties(), 
		text.properties = textProperties( color = "#A7947D" ), 
		bookmark, ... ) {
	
	if( !missing ( file ) ){
		script = CodeBlock( file = file, 
				par.properties = par.properties, 
				text.properties = text.properties )
	} else if( !missing ( text ) ){
		script = CodeBlock( text = text, 
				par.properties = par.properties, 
				text.properties = text.properties )
	} 
	.jcall( script$jobj, "V", "setDOCXReference", doc$obj )
	
	args = list( obj = doc$obj, 
			returnSig = "V", method = "add",
			script$jobj,
			.jParProperties(par.properties)
			)

	if( !missing( bookmark ) ) args[[length(args) +1 ]] = bookmark
	
	do.call( .jcall, args )
	
	doc
}
