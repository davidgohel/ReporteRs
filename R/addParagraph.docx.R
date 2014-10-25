#' @title Insert a paragraph into a docx object
#'
#' @description
#' Insert paragraph(s) of text into a \code{docx} object
#' 
#' @param doc Object of class \code{\link{docx}} where paragraph has to be added
#' @param value text to add to the document as paragraphs: 
#' an object of class \code{\link{pot}} or \code{\link{set_of_paragraphs}} 
#' or a character vector.
#' @param stylename value of the named style to apply to paragraphs in the docx document.
#' Expected value is an existing stylename of the template document used to create the 
#' \code{docx} object. see \code{\link{styles.docx}}.
#' @param bookmark a character value ; id of the Word bookmark to 
#' replace by the table. optional. See \code{\link{bookmark}}.
#' @param par.properties \code{\link{parProperties}} to apply to paragraphs, only used 
#' if \code{stylename} if missing.
#' @param restart.numbering boolean value. If \code{TRUE}, next numbered 
#' list counter will be set to 1.
#' @param ... further arguments, not used. 
#' @return an object of class \code{\link{docx}}.
#' @examples
#' #START_TAG_TEST
#' doc.filename = "addParagraph_example.docx"
#' @example examples/docx.R
#' @example examples/styles.docx.R
#' @example examples/addTitle1Level1.R
#' @example examples/addParagraph_hello_docx.R
#' @example examples/addTitle2Level1.R
#' @example examples/addParagraph_bullets_docx.R
#' @example examples/addTitle3Level1.R
#' @example examples/pot1_example.R
#' @example examples/pot2_example.R
#' @example examples/set_of_paragraphs_example.R
#' @example examples/addParagraph_sop_docx.R
#' @example examples/addTitle4Level1.R
#' @example examples/lists_doc.R
#' @example examples/writeDoc_file.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{docx}}, \code{\link{addParagraph}}, \code{\link{bookmark}}
#' @method addParagraph docx
#' @S3method addParagraph docx
addParagraph.docx = function(doc, value, stylename, bookmark, 
		par.properties = parProperties(), 
		restart.numbering = FALSE, ... ) {
	
	if( !missing(stylename) && !is.element( stylename , styles( doc ) ) ){
		stop(paste("Style {", stylename, "} does not exists.", sep = "") )
	}
	
	if( missing( value ) ){
		stop("argument value is missing." )
	} else if( inherits( value, "character" ) ){
		value = gsub("(\\n|\\r)", "", value )
		x = lapply( value, function(x) pot(value = x) )
		value = do.call( "set_of_paragraphs", x )
	}
	
	if( inherits( value, "pot" ) ){
		value = set_of_paragraphs( value )
	}
	
	if( !inherits(value, "set_of_paragraphs") )
		stop("value must be an object of class pot, set_of_paragraphs or a character vector.")
	
	parset = .jnew( class.ParagraphSet, .jParProperties(par.properties) )
	
	for( pot_index in 1:length( value ) ){
		paragrah = .jnew(class.Paragraph )
		pot_value = value[[pot_index]]
		for( i in 1:length(pot_value)){
			current_value = pot_value[[i]]
			if( is.null( current_value$format ) ) {
				if( is.null( current_value$hyperlink ) )
					.jcall( paragrah, "V", "addText", current_value$value )
				else .jcall( paragrah, "V", "addText", current_value$value, current_value$hyperlink )
			} else {
				jtext.properties = .jTextProperties( current_value$format )
				if( is.null( current_value$hyperlink ) )
					.jcall( paragrah, "V", "addText", current_value$value, jtext.properties )
				else .jcall( paragrah, "V", "addText", current_value$value, jtext.properties, current_value$hyperlink )
			}
		}
		.jcall( parset, "V", "addParagraph", paragrah )
	}
	
	if( restart.numbering ){
		.jcall( doc$obj, "V", "restartNumbering" )
	}
	
	if( missing( bookmark ) && !missing( stylename ) ){
		.jcall( doc$obj, "V", "addWithStyle" , parset, stylename)
	} else if( missing( bookmark ) && missing( stylename ) ){
		.jcall( doc$obj, "V", "add" , parset )
	} else if( !missing( bookmark ) && !missing( stylename ) ){
		.jcall( doc$obj, "V", "addWithStyle", parset, stylename, bookmark )
	} else if( !missing( bookmark ) && missing( stylename ) ){
		.jcall( doc$obj, "V", "add" , parset, bookmark )
	}
	
	doc
}
