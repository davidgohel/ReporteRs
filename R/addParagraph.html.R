#' @title Insert a paragraph into an html object
#'
#' @description
#' Insert paragraph(s) of text into a \code{html} object
#' 
#' @param doc \code{\link{html}} object where paragraph has to be added
#' @param value text to add to the document as paragraphs: 
#' an object of class \code{\link{pot}} or \code{\link{set_of_paragraphs}} 
#' or a character vector.
#' @param parent.type a character value ; parent tag for added paragraph. optional. If 'div', paragraph is normal 
#' ; if 'ol', paragraph will be an ordered list ; if 'ul', paragraph will be an unordered list
#' ; if 'pre', paragraph will be a preformatted text area.
#' @param par.properties \code{\link{parProperties}} to apply to paragraphs.
#' @param restart.numbering boolean value. If \code{TRUE}, next numbered 
#' list counter will be set to 1.
#' @param ... further arguments, not used. 
#' @return an object of class \code{\link{html}}.
#' @examples
#' #START_TAG_TEST
#' doc.dirname = "addParagraph_example"
#' @example examples/html.R
#' @example examples/addPage.R
#' @example examples/addTitle1Level1.R
#' @example examples/addParagraph_hello_nostylename.R
#' @example examples/addTitle2Level1.R
#' @example examples/pot1_example.R
#' @example examples/pot2_example.R
#' @example examples/set_of_paragraphs_example.R
#' @example examples/addParagraph_sop_nostylename.R
#' @example examples/addTitle3Level1.R
#' @example examples/lists_doc.R
#' @example examples/writeDoc_directory.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{html}}, \code{\link{addParagraph}}
#' @method addParagraph html
#' @S3method addParagraph html

addParagraph.html = function(doc, value, 
		parent.type = "div", par.properties = parProperties(), 
		restart.numbering = FALSE, ... ) {

	if( inherits( value, "character" ) ){
		value = gsub("(\\n|\\r)", "", value )
		x = lapply( value, function(x) pot(value = x) )
		value = do.call( "set_of_paragraphs", x )
	}
	if( inherits( value, "pot" ) ){
		value = set_of_paragraphs( value )
	}
	
	if( !inherits(value, "set_of_paragraphs") )
		stop("value must be an object of class pot, set_of_paragraphs or a character vector.")
	
	
	parent.types = c("div", "ul", "ol", "pre")
	if( !is.element( parent.type, parent.types ) ) {
		stop("argument 'parent.type' must be of the of following values: div, ul, ol or pre.")
	}
	
	parset = .jnew( class.ParagraphSet, .jParProperties( par.properties ) )
	.jcall( parset, "V", "setTag", parent.type )
	for( pot_index in 1:length( value ) ){
		paragrah = .jnew(class.Paragraph )
		pot_value = value[[pot_index]]
		for( i in 1:length(pot_value)){
			if( is.null( pot_value[[i]]$format ) ) 
				.jcall( paragrah, "V", "addText", pot_value[[i]]$value )
			else .jcall( paragrah, "V", "addText", pot_value[[i]]$value, 
						.jTextProperties( pot_value[[i]]$format) )
		}
		.jcall( parset, "V", "addParagraph", paragrah )
	}
	
	if( restart.numbering ){
		.jcall( doc$current_slide, "V", "restartNumbering" )
	}
	
	out = .jcall( doc$current_slide, "I", "add" , parset )
	if( out != 1 ){
		stop( "Problem while trying to add paragrahs." )
	}	
	doc
}



