#' @title add an item in a \code{BootstrapMenu} or a \code{DropDownMenu}
#'
#' @description
#' add an item in a \code{BootstrapMenu} or \code{DropDownMenu} object. 
#' An item can be a simple link associated with a label or a \code{DropDownMenu} 
#' object.
#' 
#' @param x a \code{DropDownMenu} or a \code{BootstrapMenu} object.
#' @param label \code{"character"} value: label of a simple link. If used, 
#' argument \code{link} must be specified.
#' @param link \code{"character"} value: hyperlink value. If used, 
#' argument \code{label} must be specified.
#' @param dd a \code{DropDownMenu} object to insert into the menu. If used, 
#' arguments \code{label} and \code{link} will be ignored.
#' @param separator.before if TRUE, a separator will be inserted 
#' before the new item. It only applies when x is a \code{DropDownMenu} object.
#' @param separator.after if TRUE, a separator will be inserted 
#' after the new item. It only applies when x is a \code{DropDownMenu} object.
#' @param active if TRUE, the item will be declared as active (highlighted).
#' @return an object of class \code{BootstrapMenu}.
#' @export
#' @examples
#' #
#' @example examples/BootstrapMenu.R
#' @seealso \code{\link{bsdoc}}, \code{\link{addBootstrapMenu}}
addLinkItem = function( x, label, link, dd, separator.before = FALSE, separator.after = FALSE, active = FALSE ){
	if( !inherits( x , "BootstrapMenu") && !inherits( x , "DropDownMenu") ){
		stop("addLinkItem only applies to DropDownMenu or BootstrapMenu objects.")
	}
	
	if( inherits( x , "DropDownMenu") ){
		
		if( separator.before ) 
			.jcall( x$jobj, "V", "addSeparator" )
		
		if( !missing( dd ) ){
			if( !inherits( dd , "DropDownMenu") ) stop("dd must be a DropDownMenu object.")
			if( active ) .jcall( dd$jobj, "V", "setActive" )
			.jcall( x$jobj, "V", "add", dd$jobj )
		} else if( !missing( label ) && !missing( link ) ){
			.jcall( x$jobj, "V", "add", label, link, as.logical(active) )
		}
		
		if( separator.after ) 
			.jcall( x$jobj, "V", "addSeparator" )
	} else if( inherits( x , "BootstrapMenu") ){
		
		if( !missing( dd ) ){
			if( !inherits( dd , "DropDownMenu") ) stop("dd must be a DropDownMenu object.")
			if( active ) .jcall( dd$jobj, "V", "setActive" )
			.jcall( x$jobj, "V", "add", dd$jobj )
		} else if( !missing( label ) && !missing( link ) ){
			.jcall( x$jobj, "V", "add", label, link, as.logical(active) )
		}
	}
	x
}

