#' @title Paragraph formatting properties 
#'
#' @description Create a \code{parProperties} object that describes 
#' paragraph formatting properties. 
#' 
#' @details parProperties is used to control paragraph properties. 
#' It is used when creating a tableProperties, when adding plots 
#' into a docx object or when adding content in a FlexTable.
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
#' is one of 'none' (default), 'unordered', 'ordered'. This will not have any effect if used 
#' in a FlexTable.
#' @param level list level if argument \code{list} is not 'none'. This will not have any effect 
#' if used in a FlexTable.
#' @return a \code{parProperties} object
#' @export
#' @examples
#' #START_TAG_TEST
#' @example examples/parProperties.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{cellProperties}}, \code{\link{textProperties}}
#' , \code{\link{chprop.parProperties}}, \code{\link{chprop.textProperties}}
#' , \code{\link{FlexTable}}, \code{\link{tableProperties}}, \code{\link{addTable}}
#' , \code{\link{addPlot.docx}}
parProperties = function(text.align = "left"
		, padding.bottom = 1, padding.top = 1
		, padding.left = 1, padding.right = 1, padding, list.style = "none", level = 1) {
	
	out = list( "text.align" = "left"
			, "padding.bottom" = 1, "padding.top" = 1
			, "padding.left" = 1, "padding.right" = 1, list = "none", level = 1)
	
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
		match.arg( list.style, choices = c('none', 'ordered', 'unordered'), several.ok = F )
		out$list.style = list.style
	} else stop("list.style must be a character value ('none' | 'ordered' | 'unordered').")
	
	if( is.numeric( level ) ) {
		if( as.integer( level ) < 0 || !is.finite( as.integer( level ) ) || as.integer( level ) > 9 ) 
			stop("invalid level value: ", level)
		out$level = as.integer( level )
	} else stop("level must be a positive integer value (1 to 9).")
	
	
	class( out ) = "parProperties"
	
	out
}

#' @title Modify paragraph formatting properties 
#'
#' @description Modify an object of class \code{parProperties}.  
#' @param object \code{parProperties} object to modify
#' @param text.align text alignment - a single character value, expected value 
#' is one of 'left', 'right', 'center', 'justify'.
#' @param padding.bottom paragraph bottom padding - 0 or positive integer value.
#' @param padding.top paragraph top padding - 0 or positive integer value.
#' @param padding.left paragraph left padding - 0 or positive integer value.
#' @param padding.right paragraph right padding - 0 or positive integer value.
#' @param padding paragraph padding - 0 or positive integer value. Argument \code{padding} overwrites
#' arguments \code{padding.bottom}, \code{padding.top}, \code{padding.left}, \code{padding.right}.
#' @param list.style list style - a single character value, expected value 
#' is one of 'none' (default), 'unordered', 'ordered'.
#' @param level list level if argument \code{list} is not 'none'.
#' @param ... further arguments - not used 
#' @return a \code{parProperties} object
#' @examples
#' #START_TAG_TEST
#' @example examples/chprop.parProperties.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{cellProperties}}, \code{\link{parProperties}}, \code{\link{textProperties}}
#' , \code{\link{chprop.cellProperties}}, \code{\link{chprop.textProperties}}
#' , \code{\link{FlexTable}}, \code{\link{tableProperties}}
#' @method chprop parProperties
#' @S3method chprop parProperties
chprop.parProperties <- function(object, text.align
		, padding.bottom, padding.top
		, padding.left, padding.right, padding, list.style, level, ...) {
	
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
	
	
	
	if( !missing( list.style ) ){
		if( is.character( list.style ) ) {
			match.arg( list.style, choices = c('none', 'ordered', 'unordered'), several.ok = F )
			object$list.style = list.style
		} else stop("list.style must be a character value ('none' | 'ordered' | 'unordered').")
	}
	if( !missing( level ) ){
		if( is.numeric( level ) ) {
			if( as.integer( level ) < 0 || !is.finite( as.integer( level ) ) || as.integer( level ) > 9 ) 
				stop("invalid level value: ", level)
			object$level = as.integer( level )
		} else stop("level must be a positive integer value (1 to 9).")
		
	}
	
		
	object					
}


#' @method print parProperties
#' @S3method print parProperties
print.parProperties = function (x, ...){
	cat( "{text-align:" , x$text.align, ";" )
	cat( "padding-bottom:" , x$padding.bottom, ";" )
	cat( "padding-top:", x$padding.top, ";" )
	cat( "padding-left:", x$padding.left, ";" )
	cat( "padding.right:", x$padding.right, ";" )
	cat( "list.style:", x$list.style, ";" )
	cat( "level:", x$level, ";}\n" )
}


.jParProperties = function( robject ){
	jparProp = .jnew(class.text.ParProperties
			, robject$text.align
			, robject$padding.bottom, robject$padding.top
			, robject$padding.left, robject$padding.right, 
			robject$list.style, robject$level )
	
	jparProp
}
