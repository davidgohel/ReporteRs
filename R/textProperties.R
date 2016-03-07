#' @title Text formatting properties
#'
#' @description Create a \code{textProperties} object that describes
#' text formatting properties.
#'
#' @param color font color - a single character value specifying
#' a valid color (e.g. "#000000" or "black").
#' @param font.size font size (in point) - 0 or positive integer value.
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
#' @param shading.color shading color - a single character value specifying
#' a valid color (e.g. "#000000" or "black").
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
#' # textProperties examples -------
#' @example examples/textProperties.R
#' @seealso \code{\link{pot}}, \code{\link{alterFlexTable}},
#' \code{\link{shortcut_properties}}
textProperties = function( color = "black", font.size = getOption("ReporteRs-fontsize")
		, font.weight = "normal", font.style = "normal", underlined = FALSE
		, font.family = getOption("ReporteRs-default-font")
		, vertical.align = "baseline", shading.color){

	out = list( "color" = "black"
			, "font.size" = 12
			, "font.weight" = "normal"
			, "font.style" = "normal"
			, "underlined" = FALSE
			, "font.family" = "Helvetica"
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
	else out$color = colorProperties( color )

	if( is.character( font.family ) ){
		out$font.family = font.family
	} else stop("font.family must be a character scalar (a font name, eg. 'Helvetica', 'Times', ...).")

	if( is.character( vertical.align ) ){
		if( is.element( vertical.align, c("subscript", "superscript") ) )
			out$vertical.align = vertical.align
		else out$vertical.align = "baseline"
	} else stop("vertical.align must be a character scalar ('baseline' | 'subscript' | 'superscript').")

	if( !missing(shading.color) ){
		if( !is.color( shading.color ) )
			stop("shading.color must be a valid color." )
		else out$shading.color = colorProperties( shading.color )
	}

	class( out ) = "textProperties"

	out
}

#' @param x \code{textProperties} object to print
#' @examples
#' print( textProperties (color="red", font.size = 12) )
#' @rdname textProperties
#' @export
print.textProperties = function (x, ...){

	if( !is.null( x$shading.color ) )
		shading.color = paste0("background-color:", as.character(x$shading.color), ";")
	else shading.color = ""

	cat( "{color:" , as.character(x$color), ";", sep = "" )
	cat( "font-size:" , x$font.size, ";", sep = "" )
	cat( "font-weight:" , x$font.weight, ";", sep = "" )
	cat( "font-style:" , x$font.style, ";", sep = "" )
	cat( "underlined:" , x$underlined, ";", sep = "" )
	cat( "font-family:" , x$font.family, ";", sep = "" )
	cat( shading.color )
	cat( "vertical.align:" , x$vertical.align, ";}", sep = "" )
}

#' @rdname textProperties
#' @export
as.character.textProperties = function (x, ...){

	if( x$vertical.align == "baseline" ) v.al = ""
	else if( x$vertical.align == "subscript" ) v.al = "vertical-align:sub;"
	else if( x$vertical.align == "superscript" ) v.al = "vertical-align:super;"
	else v.al = ""

	if( !is.null( x$shading.color ) )
		shading.color = paste0("background-color:", as.character(x$shading.color), ";")
	else shading.color = ""

	paste0( "{color:" , x$color, ";"
		, "font-size:" , x$font.size, ";"
		, "font-weight:" , x$font.weight, ";"
		, "font-style:" , x$font.style, ";"
		, "underlined:" , x$underlined, ";"
		, "font-family:" , x$font.family, ";"
		, shading.color
		, v.al
		, "}"
		)
}

.jTextProperties = function( robject ){
	jTextProperties = .jnew(class.text.TextProperties
		, robject$font.size, robject$font.weight=="bold"
		, robject$font.style=="italic"
		, robject$underlined
		, .jcolorProperties(robject$color)
		, robject$font.family
		, robject$vertical.align
		)
	if( !is.null( robject$shading.color ) )
		.jcall( jTextProperties, "V", "setShadingColor",
		        .jcolorProperties(robject$shading.color ) )

	jTextProperties
}



#' @param object \code{textProperties} object to update
#' @param ... further arguments - not used
#' @details
#' Get a modified version of a \code{textProperties} with
#' \code{chprop}.
#' @examples
#'
#' # chprop usage example ------
#' @example examples/chprop.textProperties.R
#' @rdname textProperties
#' @export
chprop.textProperties <- function(object, color, font.size
		, font.weight, font.style, underlined
		, font.family, vertical.align, shading.color, ...) {

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
		else object$color = colorProperties( color )
	}

	if( !missing( font.family ) ){
		if( is.character( font.family ) ){
			object$font.family = font.family
		} else stop("font.family must be a character scalar (a font name, eg. 'Helvetica', 'Times', ...).")
	}

	if( !missing( vertical.align ) ){
		if( is.character( vertical.align ) ){
			if( is.element( vertical.align, c("subscript", "superscript") ) )
				object$vertical.align = vertical.align
			else object$vertical.align = "baseline"
		} else stop("vertical.align must be a character scalar ('baseline' | 'subscript' | 'superscript').")
	}

	if( !missing(shading.color) ){
		if( !is.color( shading.color ) )
			stop("shading.color must be a valid color." )
		else object$shading.color = colorProperties( shading.color )
	}

	object
}
