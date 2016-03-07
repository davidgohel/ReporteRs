#' @title Paragraph formatting properties
#'
#' @description Create a \code{parProperties} object that describes
#' paragraph formatting properties.
#'
#' @details parProperties is used to control paragraph properties.
#' It is used when adding plots or when adding content in a FlexTable.
#'
#' Default values are:
#' \itemize{
#'   \item \code{text.align} "left"
#'   \item \code{padding.bottom} 1
#'   \item \code{padding.top} 1
#'   \item \code{padding.left} 1
#'   \item \code{padding.right} 1
#'   \item \code{list.style} 'none'
#'   \item \code{level} 1
#' }
#' @param text.align text alignment - a single character value, expected value
#' is one of 'left', 'right', 'center', 'justify'.
#' @param padding.bottom paragraph bottom padding - 0 or positive integer value.
#' @param padding.top paragraph top padding - 0 or positive integer value.
#' @param padding.left paragraph left padding - 0 or positive integer value.
#' @param padding.right paragraph right padding - 0 or positive integer value.
#' @param padding paragraph padding - 0 or positive integer value. Argument \code{padding} overwrites
#' arguments \code{padding.bottom}, \code{padding.top}, \code{padding.left}, \code{padding.right}.
#' @param list.style list style - a single character value, expected value
#' is one of 'none' (default), 'unordered', 'ordered', 'blockquote'. This will not have any effect
#' if used in a FlexTable.
#' @param level list level if argument \code{list} is not 'none'. This will not have any effect
#' if used in a FlexTable.
#' @param border.bottom \code{\link{borderProperties}} for bottom border. overwrite all border.bottom.* if specified.
#' @param border.left \code{\link{borderProperties}} for left border. overwrite all border.left.* if specified.
#' @param border.top \code{\link{borderProperties}} for top border. overwrite all border.top.* if specified.
#' @param border.right \code{\link{borderProperties}} for right border. overwrite all border.right.* if specified.
#' @param shading.color shading color - a single character value specifying
#' a valid color (e.g. "#000000" or "black").
#' @return a \code{parProperties} object
#' @export
#' @examples
#' # parProperties examples -------
#' @example examples/parProperties.R
#' @seealso \code{\link{alterFlexTable}}, \code{\link{addParagraph}},
#' \code{\link{shortcut_properties}}
parProperties = function(text.align = "left",
		padding.bottom = 1, padding.top = 1,
		padding.left = 1, padding.right = 1, padding,
		list.style = "none", level = 1,
		border.bottom = borderNone(), border.left = borderNone(),
		border.top = borderNone(), border.right = borderNone(),
		shading.color) {

	out = list( "text.align" = "left",
			"padding.bottom" = 1, "padding.top" = 1,
			"padding.left" = 1, "padding.right" = 1,
			"margin.bottom" = 0, "margin.top" = 0,
			"margin.left" = 0, "margin.right" = 0,
			list = "none", level = 1,
			border.bottom = borderNone(), border.left = borderNone(),
			border.top = borderNone(), border.right = borderNone()
			)

	if( !missing( padding ) ){
		if( is.numeric( padding ) ) {
			if( as.integer( padding ) < 0 || !is.finite( as.integer( padding ) ) ) stop("invalid padding : ", padding )
			padding.bottom = padding.top = padding.right = padding.left = as.integer( padding )
		} else {
			stop("padding must be a integer value ( >=0 ).")
		}
	}

	if( is.character( text.align ) ){
		match.arg( text.align, choices = c("left", "right", "center", "justify"), several.ok = F )
		out$text.align = text.align
	} else stop("text.align must be a character scalar ('left' | 'right' | 'center' | 'justify').")


	if( is.numeric( padding.bottom ) ) {
		if( as.integer( padding.bottom ) < 0 || !is.finite( as.integer( padding.bottom ) ) ) stop("invalid padding.bottom : ", padding.bottom)
		out$padding.bottom = as.integer( padding.bottom )
	} else stop("padding.bottom must be a numeric scalar (pixel unit).")

	if( is.numeric( padding.top ) ) {
		if( as.integer( padding.top ) < 0 || !is.finite( as.integer( padding.top ) ) ) stop("invalid padding.top : ", padding.top)
		out$padding.top = as.integer( padding.top )
	} else stop("padding.top must be a numeric scalar (pixel unit).")

	if( is.numeric( padding.left ) ) {
		if( as.integer( padding.left ) < 0 || !is.finite( as.integer( padding.left ) ) ) stop("invalid padding.left : ", padding.left)
		out$padding.left = as.integer( padding.left )
	} else stop("padding.left must be a numeric scalar (pixel unit).")

	if( is.numeric( padding.right ) ) {
		if( as.integer( padding.right ) < 0 || !is.finite( as.integer( padding.right ) ) ) stop("invalid padding.right : ", padding.right)
		out$padding.right = as.integer( padding.right )
	} else stop("padding.right must be a numeric scalar (pixel unit).")


	if( is.character( list.style ) ) {
		match.arg( list.style, choices = c('none', 'ordered', 'unordered', 'blockquote' ), several.ok = F )
		out$list.style = list.style
	} else stop("list.style must be a character value ('none' | 'ordered' | 'unordered', 'blockquote' ).")

	if( is.numeric( level ) ) {
		if( as.integer( level ) < 0 || !is.finite( as.integer( level ) ) || as.integer( level ) > 9 )
			stop("invalid level value: ", level)
		out$level = as.integer( level )
	} else stop("level must be a positive integer value (1 to 9).")



	if( inherits( border.bottom, "borderProperties" ) ) {
		out$border.bottom = border.bottom
	} else {
		stop("border.bottom must be a borderProperties object.")
	}

	if( inherits( border.top, "borderProperties" ) ) {
		out$border.top = border.top
	} else {
		stop("border.top must be a borderProperties object.")
	}

	if( inherits( border.left, "borderProperties" ) ) {
		out$border.left = border.left
	} else {
		stop("border.left must be a borderProperties object.")
	}

	if( inherits( border.right, "borderProperties" ) ) {
		out$border.right = border.right
	} else {
		stop("border.right must be a borderProperties object.")
	}

	if( !missing(shading.color) ){
		if( !is.color( shading.color ) )
			stop("shading.color must be a valid color." )
		else out$shading.color = colorProperties( shading.color )
	}

	class( out ) = "parProperties"

	out
}

#' @param ... further arguments - not used
#' @param object \code{parProperties} object to update
#' @details
#' Get a modified version of a \code{parProperties} with
#' \code{chprop}.
#' @examples
#'
#' # chprop usage example ------
#' @example examples/chprop.parProperties.R
#' @export
#' @rdname parProperties
chprop.parProperties <- function(object, text.align
		, padding.bottom, padding.top
		, padding.left, padding.right,
		padding, list.style, level,
		border.bottom, border.left, border.top, border.right, shading.color, ...) {

	if( !missing( padding ) ){
		if( is.numeric( padding ) ) {
			if( as.integer( padding ) < 0 || !is.finite( as.integer( padding ) ) ) stop("invalid padding : ", padding )
			padding.bottom = padding.top = padding.right = padding.left = as.integer( padding )
		} else {
			stop("padding must be a integer value ( >=0 ).")
		}
	}


	if( !missing( text.align ) ){
		if( is.character( text.align ) ){
			match.arg( text.align, choices = c("left", "right", "center", "justify"), several.ok = F )
			object$text.align = text.align
		} else stop("text.align must be a character scalar ('left' | 'right' | 'center' | 'justify').")
	}

	if( !missing( padding.bottom ) ){
		if( is.numeric( padding.bottom ) ) {
			if( as.integer( padding.bottom ) < 0 || !is.finite( as.integer( padding.bottom ) ) ) stop("invalid padding.bottom : ", padding.bottom)
			object$padding.bottom = as.integer( padding.bottom )
		} else stop("padding.bottom must be a numeric scalar (pixel unit).")
	}

	if( !missing( padding.top ) ){
		if( is.numeric( padding.top ) ) {
			if( as.integer( padding.top ) < 0 || !is.finite( as.integer( padding.top ) ) ) stop("invalid padding.top : ", padding.top)
			object$padding.top = as.integer( padding.top )
		} else stop("padding.top must be a numeric scalar (pixel unit).")
	}

	if( !missing( padding.left ) ){
		if( is.numeric( padding.left ) ) {
			if( as.integer( padding.left ) < 0 || !is.finite( as.integer( padding.left ) ) ) stop("invalid padding.left : ", padding.left)
			object$padding.left = as.integer( padding.left )
		} else stop("padding.left must be a numeric scalar (pixel unit).")
	}

	if( !missing( padding.right ) ){
		if( is.numeric( padding.right ) ) {
			if( as.integer( padding.right ) < 0 || !is.finite( as.integer( padding.right ) ) ) stop("invalid padding.right : ", padding.right)
			object$padding.right = as.integer( padding.right )
		} else stop("padding.right must be a numeric scalar (pixel unit).")
	}

#	if( !missing( margin.bottom ) )
#		if( is.numeric( margin.bottom ) ) {
#			if( as.integer( margin.bottom ) < 0 || !is.finite( as.integer( margin.bottom ) ) ) stop("invalid margin.bottom : ", margin.bottom)
#			object$margin.bottom = as.integer( margin.bottom )
#		} else stop("margin.bottom must be a numeric scalar (pixel unit).")
#
#	if( !missing( margin.top ) )
#		if( is.numeric( margin.top ) ) {
#			if( as.integer( margin.top ) < 0 || !is.finite( as.integer( margin.top ) ) ) stop("invalid margin.top : ", margin.top)
#			object$margin.top = as.integer( margin.top )
#		} else stop("margin.top must be a numeric scalar (pixel unit).")
#
#	if( !missing( margin.left ) )
#		if( is.numeric( margin.left ) ) {
#			if( as.integer( margin.left ) < 0 || !is.finite( as.integer( margin.left ) ) ) stop("invalid margin.left : ", margin.left)
#			object$margin.left = as.integer( margin.left )
#		} else stop("margin.left must be a numeric scalar (pixel unit).")
#
#	if( !missing( margin.right ) )
#		if( is.numeric( margin.right ) ) {
#			if( as.integer( margin.right ) < 0 || !is.finite( as.integer( margin.right ) ) ) stop("invalid margin.right : ", margin.right)
#			object$margin.right = as.integer( margin.right )
#		} else stop("margin.right must be a numeric scalar (pixel unit).")
#


	if( !missing( list.style ) ){
		if( is.character( list.style ) ) {
			match.arg( list.style, choices = c('none', 'ordered', 'unordered', 'blockquote'), several.ok = F )
			object$list.style = list.style
		} else stop("list.style must be a character value ('none' | 'ordered' | 'unordered' | 'blockquote').")
	}
	if( !missing( level ) ){
		if( is.numeric( level ) ) {
			if( as.integer( level ) < 0 || !is.finite( as.integer( level ) ) || as.integer( level ) > 9 )
				stop("invalid level value: ", level)
			object$level = as.integer( level )
		} else stop("level must be a positive integer value (1 to 9).")

	}

	if( !missing( border.bottom ) ){
		if( inherits( border.bottom, "borderProperties" ) ) {
			object$border.bottom = border.bottom
		} else {
			stop("border.bottom must be a borderProperties object.")
		}
	}

	if( !missing( border.top ) ){
		if( inherits( border.top, "borderProperties" ) ) {
			object$border.top = border.top
		} else {
			stop("border.top must be a borderProperties object.")
		}
	}

	if( !missing( border.left ) ){
		if( inherits( border.left, "borderProperties" ) ) {
			object$border.left = border.left
		} else {
			stop("border.left must be a borderProperties object.")
		}
	}

	if( !missing( border.right ) ){
		if( inherits( border.right, "borderProperties" ) ) {
			object$border.right = border.right
		} else {
			stop("border.right must be a borderProperties object.")
		}
	}

	if( !missing(shading.color) ){
		if( !is.color( shading.color ) )
			stop("shading.color must be a valid color." )
		else object$shading.color = colorProperties( shading.color )
	}

	object
}


#' @param x \code{parProperties} object to print
#' @rdname parProperties
#' @export
print.parProperties = function (x, ...){
	cat( "{text-align:" , x$text.align, ";" )
	cat( "padding-bottom:" , x$padding.bottom, ";" )
	cat( "padding-top:", x$padding.top, ";" )
	cat( "padding-left:", x$padding.left, ";" )
	cat( "padding-right:", x$padding.right, ";" )
	cat( "list.style:", x$list.style, ";" )
	cat( "level:", x$level, ";}\n" )
	cat( "border.bottom:", as.character(x$border.bottom), ";" )
	cat( "border.top:", as.character(x$border.top), ";" )
	cat( "border.left:", as.character(x$border.left), ";" )
	cat( "border.right:", as.character(x$border.right), ";" )

	if( !is.null( x$shading.color ) )
		shading.color = paste0("shading.color:", as.character(x$shading.color), ";")
	else shading.color = ""

	cat( shading.color, "\n" )
}


.jParProperties = function( robject ){
	jparProp = .jnew(class.text.ParProperties,
			robject$text.align,
			robject$padding.bottom, robject$padding.top,
			robject$padding.left, robject$padding.right,
			0L, 0L,
			0L, 0L,
			robject$list.style, robject$level,
			.jborderProperties(robject$border.bottom ),
			.jborderProperties(robject$border.left ),
			.jborderProperties(robject$border.top ),
			.jborderProperties(robject$border.right )
			)
	if( !is.null( robject$shading.color ) )
		.jcall( jparProp, "V", "setShadingColor", .jcolorProperties(robject$shading.color) )

	jparProp
}
