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

chBodyBackgroundColor = function( x, i, j, value ){

	if( !all( is.color( value ) ) ) {
		stop("value contains elements that are not valid colors")
	}

  color_compounds <- get_color_compounds(value)

	jflexcell = .jcall( x$jobj, "V", "setBackgroundColors",
      .jarray( as.integer( i-1 ) ),
			.jarray( as.integer( j-1 ) ),
			.jarray( color_compounds$r ),
			.jarray( color_compounds$g ),
			.jarray( color_compounds$b ),
			.jarray( color_compounds$a )
			)

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
	metarows = .jcall( x$jobj, "Lorg/lysis/reporters/tables/MetaRows;", "getHeader" )

	jtextProp = .jTextProperties( value )
	jflexcell = .jcall( metarows, "V", "set"
			, .jarray( as.integer( i-1 ) )
			, .jarray( as.integer( j-1 ) )
			, jtextProp  )
	x
}

chHeaderCellProperties = function( x, i, j, value ){

	if( !inherits( value , "cellProperties" ) ){
		stop("value is not a cellProperties object")
	}
	metarows = .jcall( x$jobj, "Lorg/lysis/reporters/tables/MetaRows;", "getHeader" )

	jcellProp = .jCellProperties( value )
	jflexcell = .jcall( metarows, "V", "set"
			, .jarray( as.integer( i-1 ) )
			, .jarray( as.integer( j-1 ) )
			, jcellProp  )
	x
}
chHeaderBackgroundColor = function( x, i, j, value ){

	if( !all( is.color( value ) ) ) {
		stop("value contains elements that are not valid colors")
	}

	metarows = .jcall( x$jobj, "Lorg/lysis/reporters/tables/MetaRows;", "getHeader" )

	color_compounds <- get_color_compounds(value)

	.jcall( metarows, "V", "setBackgroundColors",
	  .jarray(as.integer(i - 1)),
	  .jarray(as.integer(j - 1)),
	  .jarray(color_compounds$r),
	  .jarray(color_compounds$g),
	  .jarray(color_compounds$b),
	  .jarray(color_compounds$a)
	)

	x
}

chHeaderParProperties = function( x, i, j, value ){

	if( !inherits( value , "parProperties" ) ){
		stop("value is not a parProperties object")
	}
	metarows = .jcall( x$jobj, "Lorg/lysis/reporters/tables/MetaRows;", "getHeader" )

	jparProp = .jParProperties( value )
	jflexcell = .jcall( metarows, "V", "set"
			, .jarray( as.integer( i-1 ) )
			, .jarray( as.integer( j-1 ) )
			, jparProp  )
	x
}

chHeaderBorderProperties = function( x, i, j, side, value ){
	if( !inherits( value , "borderProperties" ) ){
		stop("value is not a borderProperties object")
	}
	metarows = .jcall( x$jobj, "Lorg/lysis/reporters/tables/MetaRows;", "getHeader" )

	jborderProp = .jborderProperties( value )
	.jcall( metarows, "V", "set"
			, .jarray( as.integer( i-1 ) )
			, .jarray( as.integer( j-1 ) )
			, jborderProp, side )

	x
}

chFooterTextProperties = function( x, i, j, value ){

	if( !inherits( value , "textProperties" ) ){
		stop("value is not a textProperties object")
	}
	metarows = .jcall( x$jobj, "Lorg/lysis/reporters/tables/MetaRows;", "getFooter" )

	jtextProp = .jTextProperties( value )
	jflexcell = .jcall( metarows, "V", "set"
			, .jarray( as.integer( i-1 ) )
			, .jarray( as.integer( j-1 ) )
			, jtextProp  )
	x
}

chFooterCellProperties = function( x, i, j, value ){

	if( !inherits( value , "cellProperties" ) ){
		stop("value is not a cellProperties object")
	}
	metarows = .jcall( x$jobj, "Lorg/lysis/reporters/tables/MetaRows;", "getFooter" )

	jcellProp = .jCellProperties( value )
	.jcall( metarows, "V", "set"
			, .jarray( as.integer( i-1 ) )
			, .jarray( as.integer( j-1 ) )
			, jcellProp  )
	x
}
chFooterBackgroundColor = function( x, i, j, value ){

	if( !all( is.color( value ) ) ) {
		stop("value contains elements that are not valid colors")
	}

	metarows = .jcall( x$jobj, "Lorg/lysis/reporters/tables/MetaRows;", "getFooter" )

	color_compounds <- get_color_compounds(value)

	.jcall( metarows, "V", "setBackgroundColors",
	        .jarray(as.integer(i - 1)),
	        .jarray(as.integer(j - 1)),
	        .jarray(color_compounds$r),
	        .jarray(color_compounds$g),
	        .jarray(color_compounds$b),
	        .jarray(color_compounds$a)
	)

	x
}

chFooterParProperties = function( x, i, j, value ){

	if( !inherits( value , "parProperties" ) ){
		stop("value is not a parProperties object")
	}
	metarows = .jcall( x$jobj, "Lorg/lysis/reporters/tables/MetaRows;", "getFooter" )

	jparProp = .jParProperties( value )
	jflexcell = .jcall( metarows, "V", "set"
			, .jarray( as.integer( i-1 ) )
			, .jarray( as.integer( j-1 ) )
			, jparProp  )
	x
}
chFooterBorderProperties = function( x, i, j, side, value ){
	if( !inherits( value , "borderProperties" ) ){
		stop("value is not a borderProperties object")
	}
	metarows = .jcall( x$jobj, "Lorg/lysis/reporters/tables/MetaRows;", "getFooter" )

	jborderProp = .jborderProperties( value )
	.jcall( metarows, "V", "set"
			, .jarray( as.integer( i-1 ) )
			, .jarray( as.integer( j-1 ) )
			, jborderProp, side )
	x
}


