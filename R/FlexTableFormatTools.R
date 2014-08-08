chBodyCellProperties = function( x, i, j, value ){
	if( !inherits( value , "cellProperties" ) ){
		stop("value is not a cellProperties object")
	}
	jcellProp = .jCellProperties( value )
	jflexcell = .jcall( x$jobj, "V", "setCellProperties"
			, .jarray( as.integer( i-1 ) )
			, .jarray( as.integer( j-1 ) )
			, jcellProp  )
	
	x
}

chBodyParProperties = function( x, i, j, value ){
	if( !inherits( value , "parProperties" ) ){
		stop("value is not a parProperties object")
	}
	
	jparProp = .jParProperties( value )
	jflexcell = .jcall( x$jobj, "V", "setParProperties"
			, .jarray( as.integer( i-1 ) )
			, .jarray( as.integer( j-1 ) )
			, jparProp  )
	
	x
}

chBodyTextProperties = function( x, i, j, value ){
	if( !inherits( value , "textProperties" ) ){
		stop("value is not a textProperties object")
	}
	
	jtextProp = .jTextProperties( value )
	jflexcell = .jcall( x$jobj, "V", "setTextProperties"
			, .jarray( as.integer( i-1 ) )
			, .jarray( as.integer( j-1 ) )
			, jtextProp  )
	
	x
}
chBodyBorderProperties = function( x, i, j, side, value ){

	if( !inherits( value , "borderProperties" ) ){
		stop("value is not a borderProperties object")
	}
	
	jborderProp = .jborderProperties( value )
	.jcall( x$jobj, "V", "setBodyBorderProperties"
			, .jarray( as.integer( i-1 ) )
			, .jarray( as.integer( j-1 ) )
			, jborderProp, side )
	
	x
}

chHeaderTextProperties = function( x, i, j, value ){
	
	if( !inherits( value , "textProperties" ) ){
		stop("value is not a textProperties object")
	}
	
	jtextProp = .jTextProperties( value )
	jflexcell = .jcall( x$jobj, "V", "setHeaderTextProperties"
			, .jarray( as.integer( i-1 ) )
			, .jarray( as.integer( j-1 ) )
			, jtextProp  )
	x
}

chHeaderCellProperties = function( x, i, j, value ){
	
	if( !inherits( value , "cellProperties" ) ){
		stop("value is not a cellProperties object")
	}
	
	jcellProp = .jCellProperties( value )
	jflexcell = .jcall( x$jobj, "V", "setHeaderCellProperties"
			, .jarray( as.integer( i-1 ) )
			, .jarray( as.integer( j-1 ) )
			, jcellProp  )
	x
}

chHeaderParProperties = function( x, i, j, value ){
	
	if( !inherits( value , "parProperties" ) ){
		stop("value is not a parProperties object")
	}
	
	jparProp = .jParProperties( value )
	jflexcell = .jcall( x$jobj, "V", "setHeaderParProperties"
			, .jarray( as.integer( i-1 ) )
			, .jarray( as.integer( j-1 ) )
			, jparProp  )
	x
}
chHeaderBorderProperties = function( x, i, j, side, value ){
	if( !inherits( value , "borderProperties" ) ){
		stop("value is not a borderProperties object")
	}	
	
	jborderProp = .jborderProperties( value )
	.jcall( x$jobj, "V", "setHeaderBorderProperties"
			, .jarray( as.integer( i-1 ) )
			, .jarray( as.integer( j-1 ) )
			, jborderProp, side )
	
	x
}

chFooterTextProperties = function( x, i, j, value ){
	
	if( !inherits( value , "textProperties" ) ){
		stop("value is not a textProperties object")
	}
	
	jtextProp = .jTextProperties( value )
	jflexcell = .jcall( x$jobj, "V", "setFooterTextProperties"
			, .jarray( as.integer( i-1 ) )
			, .jarray( as.integer( j-1 ) )
			, jtextProp  )
	x
}

chFooterCellProperties = function( x, i, j, value ){
	
	if( !inherits( value , "cellProperties" ) ){
		stop("value is not a cellProperties object")
	}
	
	jcellProp = .jCellProperties( value )
	jflexcell = .jcall( x$jobj, "V", "setFooterCellProperties"
			, .jarray( as.integer( i-1 ) )
			, .jarray( as.integer( j-1 ) )
			, jcellProp  )
	x
}

chFooterParProperties = function( x, i, j, value ){
	
	if( !inherits( value , "parProperties" ) ){
		stop("value is not a parProperties object")
	}
	
	jparProp = .jParProperties( value )
	jflexcell = .jcall( x$jobj, "V", "setFooterParProperties"
			, .jarray( as.integer( i-1 ) )
			, .jarray( as.integer( j-1 ) )
			, jparProp  )
	x
}
chFooterBorderProperties = function( x, i, j, side, value ){
	if( !inherits( value , "borderProperties" ) ){
		stop("value is not a borderProperties object")
	}	
	
	jborderProp = .jborderProperties( value )
	.jcall( x$jobj, "V", "setFooterBorderProperties"
			, .jarray( as.integer( i-1 ) )
			, .jarray( as.integer( j-1 ) )
			, jborderProp, side )
	
	x
}


