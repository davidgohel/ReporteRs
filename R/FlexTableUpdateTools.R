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


addContentToMetaRows = function (object, i, j, value, to, textProperties, newpar = F, byrow = FALSE){
	
	if( !inherits(textProperties, "textProperties") )
		stop("argument textProperties must be a textProperties object.")
	
	jtext.properties = .jTextProperties( textProperties )
	if( to == "header" )
		metarows = .jcall( object$jobj, "Lorg/lysis/reporters/tables/MetaRows;", "getHeader" )
	else metarows = .jcall( object$jobj, "Lorg/lysis/reporters/tables/MetaRows;", "getFooter" )
	
	if( byrow ){
		.jcall( metarows, "V", "add"
				, .jarray( as.integer( i - 1 ) )
				, .jarray( as.integer( j - 1 ) )
				, .jarray( get.formatted.dataset( value ) )
				, jtext.properties
				, as.logical(newpar)
		)
	} else {
		.jcall( metarows, "V", "add"
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
	
	.jcall( x$jobj, "V", "addBodyText"
			, .jarray( as.integer( i-1 ) ), .jarray( as.integer( j-1 ) ), 
			.jpot( value ), as.logical(newpar)  )
	x
}
addPotToMetaRows = function( x, i, j, value, to, newpar ){
	if( to == "header" )
		metarows = .jcall( x$jobj, "Lorg/lysis/reporters/tables/MetaRows;", "getHeader" )
	else metarows = .jcall( x$jobj, "Lorg/lysis/reporters/tables/MetaRows;", "getFooter" )
	.jcall( metarows, "V", "add"
			, .jarray( as.integer( i-1 ) ), .jarray( as.integer( j-1 ) ), 
			.jpot( value ), as.logical(newpar)  )
	x
}


