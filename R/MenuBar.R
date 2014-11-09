#' @export 
BoostrapMenu = function( title ) {

	out = list( jobj = .jnew( class.BoostrapMenu, title ), title = title )
	class( out ) = "BoostrapMenu"

	out
}

#' @export 
DropDown = function( label ) {
	out = list()
	out$jobj = .jnew( class.DropDown, label )
	class( out ) = "DropDown"
	out
}

#' @export 
addItem = function( x, label, link, dd, separator.before = FALSE, separator.after = FALSE ){
	if( !inherits( x , "BoostrapMenu") && !inherits( x , "DropDown") ){
		stop("addItem only applies to DropDown or BoostrapMenu objects.")
	}
	
	if( inherits( x , "DropDown") ){
	
		if( separator.before ) 
			.jcall( x$jobj, "V", "addSeparator" )
		
		if( !missing( dd ) ){
			if( !inherits( dd , "DropDown") ) stop("dd must be a DropDown object.")
			.jcall( x$jobj, "V", "add", dd$jobj )
		} else if( !missing( label ) && !missing( link ) ){
			.jcall( x$jobj, "V", "add", label, link )
		}
	
		if( separator.after ) 
			.jcall( x$jobj, "V", "addSeparator" )
	} else if( inherits( x , "BoostrapMenu") ){

		if( !missing( dd ) ){
			if( !inherits( dd , "DropDown") ) stop("dd must be a DropDown object.")
			.jcall( x$jobj, "V", "add", dd$jobj )
		} else if( !missing( label ) && !missing( link ) ){
			.jcall( x$jobj, "V", "add", label, link )
		}

	}
	x
}




#' @export 
addMenuBar = function( doc, menubar ){
	.jcall( doc$jobj, "V", "addHeaderMenu" , menubar$jobj )
	invisible()
}
