#' @title Text formatting properties 
#'
#' @description Create a \code{textProperties} object that describes 
#' text formatting properties.  
#' 
#' @param color font color - a single character value specifying 
#' a valid color (e.g. "#000000" or "black").
#' @param font.size font size - 0 or positive integer value.
#' @param font.weight single character value specifying font weight 
#' (expected value is \code{normal} or \code{bold}).
#' @param font.style single character value specifying font style
#' (expected value is \code{normal} or \code{italic}).
#' @param underlined single logical value specifying if the font is underlined.
#' @param font.family single character value specifying font name (it has to be 
#' an existing font in the OS).
#' @param vertical.align single character value specifying font vertical alignments.
#' Expected value is one of the following : default \code{'baseline'} 
#' or \code{'subscript'} or \code{'superscript'}
#' @return a \code{textProperties} object
#' @export
#' @details 
#' Default values are:
#' \itemize{
#'   \item \code{color} "black"
#'   \item \code{font.size} getOption("ReporteRs-fontsize")
#'   \item \code{font.weight} "normal"
#'   \item \code{font.style} "normal"
#'   \item \code{underlined} FALSE
#'   \item \code{font.family} getOption("ReporteRs-default-font")
#'   \item \code{vertical.align} "baseline"
#' }
#' @examples
#' #START_TAG_TEST
#' @example examples/parProperties.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{cellProperties}}, \code{\link{parProperties}}
#' , \code{\link{chprop.parProperties}}, \code{\link{chprop.textProperties}}
#' , \code{\link{chprop.cellProperties}}
#' , \code{\link{FlexTable}}, \code{\link{tableProperties}}, \code{\link{addTable}}
#' , \code{\link{pot}}
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
			, "vertical.align" = "baseline"
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

#' @title print formatting properties
#'
#' @description
#' print text formatting properties (an object of class \code{"textProperties"}).
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
	cat( "font-family:" , x$font.family, ";" )
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
	jTextProperties = .jnew(class.texts.TextProperties
		, robject$font.size, robject$font.weight=="bold"
		, robject$font.style=="italic"
		, robject$underlined
		, robject$color
		, robject$font.family 
		, robject$vertical.align 
		)
	jTextProperties
}



#' @title Modify text formatting properties 
#'
#' @description Modify an object of class \code{textProperties}.  
#' @param object \code{textProperties} object to modify
#' @inheritParams textProperties
#' @param ... further arguments - not used 
#' @return a \code{textProperties} object
#' @examples
#' #START_TAG_TEST
#' @example examples/chprop.textProperties.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{cellProperties}}, \code{\link{parProperties}}, \code{\link{textProperties}}
#' , \code{\link{chprop.cellProperties}}, \code{\link{chprop.parProperties}}
#' , \code{\link{FlexTable}}, \code{\link{tableProperties}}, \code{\link{pot}}
#' @method chprop textProperties
#' @S3method chprop textProperties
chprop.textProperties <- function(object, color, font.size
		, font.weight, font.style, underlined
		, font.family, vertical.align, ...) {
	
	if( !missing( font.size ) ){
		if( is.numeric( font.size ) ) {
			if( as.integer( font.size ) < 0 || !is.finite( as.integer( font.size ) ) ) stop("invalid font.size : ", font.size)
			object$font.size = as.integer( font.size )
		} else stop("font.size must be a numeric scalar (point unit).")
	}

	if( !missing( font.weight) ){
		if( is.character( font.weight ) ){
			match.arg( font.weight, choices = c("normal", "bold", "bolder", "lighter" , as.character( seq(100, 900, by=100 ) ) ), several.ok = F )
			object$font.weight = font.weight
		} else stop("font.weight must be a character scalar ('normal' | 'bold' | 'bolder' | 'lighter' | '100' | ... | '900').")
	}
	

	if( !missing( font.style ) ){
		if( is.character( font.style ) ){
			match.arg( font.style, choices = c("normal", "italic", "oblique" ), several.ok = F )
			object$font.style = font.style
		} else stop("font.style must be a character scalar ('normal' | 'italic' | 'oblique').")
	}
	
	if( !missing( underlined ) ){
		if( is.logical( underlined ) ){
			object$underlined = underlined
		} else stop("underlined must be a logical scalar.")
	}
	
	if( !missing( color ) ){
		if( !is.color( color ) )
			stop("color must be a valid color." )
		else object$color = getHexColorCode( color )
	}
	
	if( !missing( font.family ) ){
		if( is.character( font.family ) ){
			check.fontfamily(font.family)
			object$font.family = font.family
		} else stop("font.family must be a character scalar (a font name, eg. 'Arial', 'Times', ...).")
	}
	
	if( !missing( vertical.align ) ){
		if( is.character( vertical.align ) ){
			if( is.element( vertical.align, c("subscript", "superscript") ) )
				object$vertical.align = vertical.align
			else object$vertical.align = "baseline"
		} else stop("vertical.align must be a character scalar ('baseline' | 'subscript' | 'superscript').")
	}

	object					
}
