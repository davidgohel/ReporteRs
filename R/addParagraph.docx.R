#' @title Insert a paragraph into a docx object
#'
#' @description
#' Insert paragraph(s) of text into a \code{docx} object
#' 
#' @param doc Object of class \code{"docx"} where paragraph has to be added
#' @param value character vector containing texts to add OR an object of class \code{\link{set_of_paragraphs}}.
#' @param stylename value of the named style to apply to paragraphs in the docx document. see \code{\link{styles.docx}}.
#' @param bookmark a character value ; id of the Word bookmark to replace by the table. optional
#' @param ... further arguments, not used. 
#' @return an object of class \code{"docx"}.
#' @examples
#' # Create a new document 
#' doc = docx( title = "title" )
#' 
#' # Add "Hello World" into the document doc
#' doc <- addParagraph(doc, "Hello Word!", "Normal");
#' 
#' # Add into the document : "My tailor is rich" and "Cats and Dogs"
#' # format some of the pieces of text
#' pot1 = pot("My tailor", textProperties(color="red") ) + " is " + pot("rich", textProperties(font.weight="bold") )
#' my.pars = set_of_paragraphs( pot1 )
#' pot2 = pot("Cats", textProperties(color="red") ) + " and " + pot("Dogs", textProperties(color="blue") )
#' my.pars = set_of_paragraphs( pot1, pot2 )
#' 
#' # used style is "BulletList" so that paragraphs will be preceded by bullet points
#' # ("BulletList" is an existing style in the defaut template docx of the package)
#' doc <- addParagraph(doc, my.pars, "BulletList");
#' 
#' # Write the object in file "~/document.docx"
#' writeDoc( doc, "~/document.docx" )
#' @seealso \code{\link{docx}}, \code{\link{addParagraph}}
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
		basedoc.j = rJava::.jcall( doc$obj, paste0("L", class.docx4j.WordprocessingMLPackage, ";"), "getBaseDocument" )
		paragrah = rJava::.jnew(class.docx4r.POT, basedoc.j, stylename )
		for( pot_index in 1:length( value ) ){
			rJava::.jcall( paragrah, "V", "addP")
			pot_value = value[[pot_index]]
			for( i in 1:length(pot_value)){
				if( is.null( pot_value[[i]]$format ) ) rJava::.jcall( paragrah, "V", "addText", pot_value[[i]]$value )
				else rJava::.jcall( paragrah, "V", "addPot", pot_value[[i]]$value
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
			rJava::.jcall( doc$obj, "V", "add" , paragrah)
		else rJava::.jcall( doc$obj, "V", "insert", bookmark, paragrah )
	} else stop("value must be an object of class 'set_of_paragraphs' or a character vector!")
	
	
	doc
}



