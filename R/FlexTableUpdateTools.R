addFlexCellContent = function (object, i, j, value, textProperties, newpar = F, byrow = FALSE){
	
	if( !inherits(textProperties, "textProperties") )
		stop("argument textProperties must be a textProperties object.")
	
	jtext.properties = .jTextProperties( textProperties )
	
	if( byrow ){
		.jcall( object$jobj, "V", "addBodyText"
				, .jarray( as.integer( i - 1 ) )
				, .jarray( as.integer( j - 1 ) )
				, .jarray( get.formatted.dataset( value ) )
				, jtext.properties
				, as.logical(newpar)
		)
	} else {
		.jcall( object$jobj, "V", "addBodyText"
				, .jarray( as.integer( i - 1 ) )
				, .jarray( as.integer( j - 1 ) )
				, .jarray( t( get.formatted.dataset( value ) ) )
				, jtext.properties
				, as.logical(newpar) 
		)
	}
	object
}

addFlexHeaderContent = function (object, i, j, value, textProperties, newpar = F, byrow = FALSE){
	
	if( !inherits(textProperties, "textProperties") )
		stop("argument textProperties must be a textProperties object.")
	
	jtext.properties = .jTextProperties( textProperties )
	
	if( byrow ){
		.jcall( object$jobj, "V", "addHeaderText"
				, .jarray( as.integer( i - 1 ) )
				, .jarray( as.integer( j - 1 ) )
				, .jarray( get.formatted.dataset( value ) )
				, jtext.properties
				, as.logical(newpar)
		)
	} else {
		.jcall( object$jobj, "V", "addHeaderText"
				, .jarray( as.integer( i - 1 ) )
				, .jarray( as.integer( j - 1 ) )
				, .jarray( t( get.formatted.dataset( value ) ) )
				, jtext.properties
				, as.logical(newpar) 
		)
	}
	object
}

addFlexFooterContent = function (object, i, j, value, textProperties, newpar = F, byrow = FALSE){
	
	if( !inherits(textProperties, "textProperties") )
		stop("argument textProperties must be a textProperties object.")
	
	jtext.properties = .jTextProperties( textProperties )
	
	if( byrow ){
		.jcall( object$jobj, "V", "addFooterText"
				, .jarray( as.integer( i - 1 ) )
				, .jarray( as.integer( j - 1 ) )
				, .jarray( get.formatted.dataset( value ) )
				, jtext.properties
				, as.logical(newpar)
		)
	} else {
		.jcall( object$jobj, "V", "addFooterText"
				, .jarray( as.integer( i - 1 ) )
				, .jarray( as.integer( j - 1 ) )
				, .jarray( t( get.formatted.dataset( value ) ) )
				, jtext.properties
				, as.logical(newpar) 
		)
	}
	object
}


addFlexBodyPot = function( x, i, j, value, newpar ){
	
	ps = Paragraph( value )
	.jcall( x$jobj, "V", "addBodyText"
			, .jarray( as.integer( i-1 ) ), .jarray( as.integer( j-1 ) ), 
			ps$jobj, as.logical(newpar)  )
	
	x
}

addFlexHeaderPot = function( x, i, j, value, newpar ){
	
	ps = Paragraph( value )
	.jcall( x$jobj, "V", "addHeaderText"
			, .jarray( as.integer( i-1 ) ), .jarray( as.integer( j-1 ) ), 
			ps$jobj, as.logical(newpar)  )
	
	x
}

addFlexFooterPot = function( x, i, j, value, newpar ){
	
	ps = Paragraph( value )
	.jcall( x$jobj, "V", "addFooterText"
			, .jarray( as.integer( i-1 ) ), .jarray( as.integer( j-1 ) ), 
			ps$jobj, as.logical(newpar)  )
	
	x
}


