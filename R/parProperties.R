#' @title Paragraph formating properties 
#'
#' @description Create an object that describes paragraph formating properties. 
#' 
#' @details parProperties is used to control paragraph properties. 
#' It is used when creating a tableProperties and when adding plots into a docx object.
#' 
#' @param text.align text alignment - one of the following value : 'left', 'right', 'center', 'justify'.
#' @param padding.bottom an integer value, bottom padding in pixels.
#' @param padding.top an integer value, top padding in pixels.
#' @param padding.left an integer value, left padding in pixels.
#' @param padding.right an integer value, right padding in pixels.
#' @param padding an integer value, paddings in pixels, this value overwrite all padding.* values.
#' 
#' @export
#' @examples
#' parProperties( text.align = "center", padding = 5)
#' parProperties( text.align = "center", padding.top = 5, padding.bottom = 0, padding.left = 2, padding.right = 0)
#'  
#' @seealso \code{\link{addTable}}, \code{\link{addPlot.docx}}
parProperties = function(text.align = "left"
		, padding.bottom = 1, padding.top = 1
		, padding.left = 1, padding.right = 1, padding) {

		out = list( "text.align" = "left"
			, "padding.bottom" = 1, "padding.top" = 1
			, "padding.left" = 1, "padding.right" = 1 )

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
		
		class( out ) = "parProperties"
		
		out
}

#' @method print parProperties
#' @S3method print parProperties
print.parProperties = function (x, ...){
	cat( "\ttext-align: {" , x$text.align, "}\n" )
	cat( "\tpadding-bottom: {" , x$padding.bottom, "}\n" )
	cat( "\tpadding-top: {", x$padding.top, "}\n" )
	cat( "\tpadding-left: {", x$padding.left, "}\n" )
	cat( "\tpadding.right: {", x$padding.right, "}\n" )
}


.jParProperties = function( robject ){
	jparProp = .jnew("org/lysis/reporters/texts/ParProperties"
			, robject$text.align
			, robject$padding.bottom, robject$padding.top
			, robject$padding.left, robject$padding.right )

	jparProp
}
