#' @title Text formating properties 
#'
#' @description Create an object that describes text formating properties.  
#' 
#' @param color single character value specifying font color. (default to \code{black})
#' @param font.size single integer value specifying font size in pixel. (default to \code{10})
#' @param font.weight single character value specifying font weight 
#' (expected value is \code{normal} or \code{bold}). (default to \code{normal})
#' @param font.style single character value specifying font style
#' (expected value is \code{normal} or \code{italic}). (default to \code{normal}) 
#' @param underlined single logical value specifying if the font is underlined 
#' (default to \code{FALSE}).
#' @param font.family single character value specifying font name (it has to be 
#' an existing font in the OS). (default to \code{Arial}).
#' @param vertical.align single character value specifying font vertical alignments.
#' Expected value is one of the following : default \code{'baseline'} or \code{'subscript'} or \code{'superscript'}
#' @export
#' @examples
#' # Create a new document 
#' doc = docx( title = "title" )
#' text = pot( value = "Hello Word"
#' 		, format = textProperties(color="red"
#' 				, font.size = 12
#' 				, font.weight = "bold"
#' 				, font.style = "italic" 
#' 				, underlined = TRUE
#' 				, font.family = "Courier New"
#' 		) 
#' ) + " is rich"
#' doc <- addParagraph(doc, set_of_paragraphs(text), "Normal");
#' writeDoc( doc, "Hello_Word.docx" )
#' @seealso \code{\link{docx}}
textProperties = function( color = "black", font.size = getOption("ReporteRs-fontsize")
		, font.weight = "normal", font.style = "normal", underlined = FALSE
		, font.family = getOption("ReporteRs-default-font")
		, vertical.align = "baseline"){
	
	out = list( "color" = "black"
			, "font.size" = 12
			, "font.weight" = "normal" 
			, "font.style" = "normal"
			, "underlined" = FALSE
			, "font.family" = "Arial"
			)
	out = list()
	if( is.numeric( font.size ) ) {
		if( as.integer( font.size ) < 0 || !is.finite( as.integer( font.size ) ) ) stop("invalid font.size : ", font.size)
		out$font.size = as.integer( font.size )
	} else stop("font.size must be a numeric scalar (point unit).")
	
	if( is.character( font.weight ) ){
		match.arg( font.weight, choices = c("normal", "bold", "bolder", "lighter" , as.character( seq(100, 900, by=100 ) ) ), several.ok = F )
		out$font.weight = font.weight
	} else stop("font.weight must be a character scalar ('normal' | 'bold' | 'bolder' | 'lighter' | '100' | ... | '900').")

	if( is.character( font.style ) ){
		match.arg( font.style, choices = c("normal", "italic", "oblique" ), several.ok = F )
		out$font.style = font.style
	} else stop("font.style must be a character scalar ('normal' | 'italic' | 'oblique').")

	if( is.logical( underlined ) ){
		out$underlined = underlined
	} else stop("underlined must be a logical scalar.")

	if( !is.color( color ) )
		stop("color must be a valid color." )
	else out$color = getHexColorCode( color )

	if( is.character( font.family ) ){
		check.fontfamily(font.family)
		out$font.family = font.family
	} else stop("font.family must be a character scalar (a font name, eg. 'Arial', 'Times', ...).")

	if( is.character( vertical.align ) ){
		if( is.element( vertical.align, c("subscript", "superscript") ) )
			out$vertical.align = vertical.align
		else out$vertical.align = "baseline"
	} else stop("vertical.align must be a character scalar ('baseline' | 'subscript' | 'superscript').")
	
	
	class( out ) = "textProperties"
	
	out
}

#' @title print formating properties
#'
#' @description
#' print text formating properties (an object of class \code{"textProperties"}).
#' 
#' @param x an object of class \code{"textProperties"}
#' @param ... further arguments, not used. 
#' @examples
#' print( textProperties (color="red", font.size = 12) )
#' @seealso \code{\link{pptx}}, \code{\link{docx}} 
#' @method print textProperties
#' @S3method print textProperties
print.textProperties = function (x, ...){
	cat( "{color:" , x$color, ";" )
	cat( "font-size:" , x$font.size, ";" )
	cat( "font-weight:" , x$font.weight, ";" )
	cat( "font-style:" , x$font.style, ";" )
	cat( "underlined:" , x$underlined, ";" )
	cat( "font-family:" , x$font.family, ";}" )
	cat( "vertical.align:" , x$vertical.align, ";}" )
}

#' @method as.character textProperties
#' @S3method as.character textProperties
as.character.textProperties = function (x, ...){
	
	if( x$vertical.align == "baseline" ) v.al = ""
	else if( x$vertical.align == "subscript" ) v.al = "vertical-align:sub;"
	else if( x$vertical.align == "superscript" ) v.al = "vertical-align:super;"
	else v.al = ""
	paste0( "{color:" , x$color, ";"
		, "font-size:" , x$font.size, ";"
		, "font-weight:" , x$font.weight, ";"
		, "font-style:" , x$font.style, ";"
		, "underlined:" , x$underlined, ";"
		, "font-family:" , x$font.family, ";" 
		, v.al
		, "}" 
		)
}

.jTextProperties = function( robject ){
	textProp = rJava::.jnew(class.texts.TextProperties
		, robject$font.size, robject$font.weight=="bold"
		, robject$font.style=="italic"
		, robject$underlined
		, robject$color
		, robject$font.family 
		, robject$vertical.align 
		)
	textProp
}

