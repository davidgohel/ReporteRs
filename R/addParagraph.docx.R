#' @title Insert a paragraph into a docx object
#'
#' @description
#' Insert paragraph(s) of text into a \code{docx} object
#' 
#' @param doc Object of class \code{"docx"} where paragraph has to be added
#' @param value character vector containing texts to add OR an object of class 
#' \code{\link{set_of_paragraphs}}.
#' @param stylename value of the named style to apply to paragraphs in the docx document.
#' Expected value is an existing stylename of the template document used to create the 
#' \code{docx} object. see \code{\link{styles.docx}}.
#' @param bookmark a character value ; id of the Word bookmark to 
#' replace by the table. optional. See \code{\link{bookmark}}.
#' @param ... further arguments, not used. 
#' @return an object of class \code{"docx"}.
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
#' @example examples/writeDoc_file.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{docx}}, \code{\link{addParagraph}}, \code{\link{bookmark}}
#' @method addParagraph docx
#' @S3method addParagraph docx

addParagraph.docx = function(doc, value, stylename, bookmark, ... ) {
	if( missing( stylename )) {
		stop("argument 'stylename' is missing")
	} else if( !is.element( stylename , styles( doc ) ) ){
		stop(paste("Style {", stylename, "} does not exists.", sep = "") )
	}
	if( inherits( value, "character" ) ){
		x = lapply( value, function(x) pot(value = x) )
		value = do.call( "set_of_paragraphs", x )
	}
	
	if( inherits(value, "set_of_paragraphs") ){
		basedoc.j = .jcall( doc$obj, paste0("L", class.docx4j.WordprocessingMLPackage, ";"), "getBaseDocument" )
		paragrah = .jnew(class.docx4r.POT, basedoc.j, stylename )
		for( pot_index in 1:length( value ) ){
			.jcall( paragrah, "V", "addP")
			pot_value = value[[pot_index]]
			for( i in 1:length(pot_value)){
				if( is.null( pot_value[[i]]$format ) ) .jcall( paragrah, "V", "addText", pot_value[[i]]$value )
				else .jcall( paragrah, "V", "addPot", pot_value[[i]]$value
					, pot_value[[i]]$format$font.size
					, pot_value[[i]]$format$font.weight=="bold"
					, pot_value[[i]]$format$font.style=="italic"
					, pot_value[[i]]$format$underlined
					, pot_value[[i]]$format$color
					, pot_value[[i]]$format$font.family
					, pot_value[[i]]$format$vertical.align
					)
			}
		}
		if( missing( bookmark ) )
			.jcall( doc$obj, "V", "add" , paragrah)
		else .jcall( doc$obj, "V", "insert", bookmark, paragrah )
	} else stop("value must be an object of class 'set_of_paragraphs' or a character vector!")
	
	
	doc
}



