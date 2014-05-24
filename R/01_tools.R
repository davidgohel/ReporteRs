#' @import rJava
#' @import ReporteRsjars
#' @import base64
.onLoad= function(libname, pkgname){
	.jpackage( pkgname, lib.loc = libname )
	options("ReporteRs-default-font"="Helvetica")
	options("ReporteRs-locale.language"="en")
	options("ReporteRs-locale.region"="US")
	options("ReporteRs-fontsize"=11L)
	invisible()
}

getDefaultColTypes = function( data ){
	lapply( data , function(x) {
		out = class(x)
		if( is.factor( out ) ) out = "character"
		else if (is.integer(out)) out = "integer"
		else if (is.numeric(out)) out = "double"
		else if (is.logical(out)) out = "logical"
		else if (inherits(out, "Date")) out = "date"
		else if (inherits(out, "POSIXct")) out = "datetime"
		else if (inherits(out, "POSIXlt")) out = "datetime"
		else out = "character"
		out
	} )
}


setData2Java = function( obj, data, header.labels, col.types
, groupedheader.row, columns.bg.colors, columns.font.colors
, row.names = T){
	dnames = names( data )
	if( row.names ){
		.jcall( obj , "V", "setData", "row_names", "", .jarray( as.character(row.names( data ) ) ) )		
	}
	for( j in 1:ncol( data ) ){
		if( is.factor(data[, j] ) ) tempdata = as.character( data[, j] )
		else if( is.logical(data[, j] ) ) tempdata = ifelse( data[, j], "TRUE", "FALSE" )
		else tempdata = data[, j]
		
		if( col.types[j] == "percent" )
			.jcall( obj , "V", "setPercentData", dnames[j], header.labels[j], .jarray(tempdata*100) )
		else if( col.types[j] == "double" )
			.jcall( obj , "V", "setData", dnames[j], header.labels[j], .jarray( as.double(tempdata)) )
		else if( col.types[j] == "integer" )
			.jcall( obj , "V", "setData", dnames[j], header.labels[j], .jarray( as.integer(tempdata)) )
		else if( col.types[j] == "character" )
			.jcall( obj , "V", "setData", dnames[j], header.labels[j], .jarray( as.character(tempdata)) )
		else if( col.types[j] == "date" )
			.jcall( obj , "V", "setDateData", dnames[j], header.labels[j], .jarray( format( tempdata, "%Y-%m-%d" ) ) )
		else if( col.types[j] == "datetime" )
			.jcall( obj , "V", "setDateData", dnames[j], header.labels[j], .jarray( format( tempdata, "%Y-%m-%d " ) ) )
		else if( col.types[j] == "logical" )
			.jcall( obj , "V", "setLogicalData", dnames[j], header.labels[j], .jarray( as.character(tempdata)) )
	}
	
	if( length( groupedheader.row ) > 0 ){
		if( row.names ){
			.jcall( obj , "V", "setGroupedCols", "", 1L )
		}
		for(gcol in 1:length(groupedheader.row$values ) ){
			value = groupedheader.row$values[gcol]
			colspan = groupedheader.row$colspan[gcol]
			.jcall( obj , "V", "setGroupedCols", value, as.integer(colspan) )
		}
	}
	
	if( length( columns.bg.colors ) > 0 ){
		for( j in names( columns.bg.colors ) ){ 
			.jcall( obj , "V", "setFillColors", j, .jarray( columns.bg.colors[[j]] ) )
		}
	}
	
	if( length( columns.font.colors ) > 0 ){
		for( j in names( columns.font.colors ) ){ 
			.jcall( obj , "V", "setFontColors", j, .jarray( columns.font.colors[[j]] ) )
		}
	}
	
}


table.format.2java = function( x, type = "docx" ){
	
	if( type == "docx" ){
		jclassname = class.docx4r.TableLayoutDOCX
	} else if( type == "pptx" ){
		jclassname = class.pptx4r.TableLayoutPPTX
	} else if( type == "html" ){
		jclassname = class.html4r.TableLayoutHTML
	} else stop("unknown document type: ", type )
	
	obj = .jnew(jclassname, x$percent.addsymbol
			, x$fraction.double.digit, x$fraction.percent.digit
			, "YYYY-mm-dd", "HH:MM", "YYYY-mm-dd HH:MM"
			, x$locale.language, x$locale.region
	)
	
	rootnames = c("header", "groupedheader", "double", "integer", "percent", "character", "date", "datetime", "logical")
	
	for( what in rootnames ){
		#TODO: change that code 
		jwhatmethod = paste( casefold( substring(what , 1, 1 ),  upper = T ), casefold( substring(what , 2, nchar(what) ),  upper = F ), sep = "" )
		jwhatmethod = paste( "set", jwhatmethod, "Text", sep = "" )
		rwhatobject = paste( what, ".text", sep = "" )
		str = paste( "x$", rwhatobject , sep = "" )
		robject = eval( parse ( text = str ) )
		.jcall( obj, "V", jwhatmethod, as.character(robject$color)
				, robject$font.size
				, as.logical(robject$font.weight=="bold")
				, as.logical(robject$font.style=="italic")
				, as.logical(robject$underlined)
				, robject$font.family
				, robject$vertical.align
		)
		
	}
	
	for( what in rootnames ){
		jwhatmethod = paste( casefold( substring(what , 1, 1 ),  upper = T ), casefold( substring(what , 2, nchar(what) ),  upper = F ), sep = "" )
		jwhatmethod = paste( "set", jwhatmethod, "Par", sep = "" )
		rwhatobject = paste( what, ".par", sep = "" )
		str = paste( "x$", rwhatobject , sep = "" )
		robject = eval( parse ( text = str ) )
		.jcall( obj, "V", jwhatmethod, robject$text.align
				, robject$padding.bottom
				, robject$padding.top
				, robject$padding.left
				, robject$padding.right
		)
		
	}
	
	for( what in rootnames ){
		jwhatmethod = paste( casefold( substring(what , 1, 1 ),  upper = T ), casefold( substring(what , 2, nchar(what) ),  upper = F ), sep = "" )
		jwhatmethod = paste( "set", jwhatmethod, "Cell", sep = "" )
		rwhatobject = paste( what, ".cell", sep = "" )
		str = paste( "x$", rwhatobject , sep = "" )
		robject = eval( parse ( text = str ) )

		.jcall( obj, "V", jwhatmethod
				, as.character(robject$border.bottom.color )
				, as.character(robject$border.bottom.style )
				, as.integer( robject$border.bottom.width )
				, as.character(robject$border.left.color )
				, as.character(robject$border.left.style )
				, as.integer( robject$border.left.width )
				, as.character(robject$border.top.color )
				, as.character(robject$border.top.style )
				, as.integer( robject$border.top.width )
				, as.character(robject$border.right.color )
				, as.character(robject$border.right.style )
				, as.integer( robject$border.right.width )
				, as.character(robject$vertical.align )
				, as.integer( robject$padding.bottom )
				, as.integer( robject$padding.top )
				, as.integer( robject$padding.left )
				, as.integer( robject$padding.right )
				, as.character(robject$background.color )
		)
	}
	obj
}

shape_errors = c( UNDEFINED = -1, DONOTEXISTS = 0, ISFILLED = 1, NO_ERROR = 2, NOROOMLEFT = 3, UNDEFDIMENSION = 4)

error_codes = c( NO_ERROR = 0, READDOC_ERROR = 1
		, LOADDOC_ERROR = 2, LAYOUT_ERROR = 3, SAVE_ERROR = 4
		, PARTNAME_ERROR = 5, SLIDECREATION_ERROR = 6, UNDEFINED_ERROR = -1)

isSlideError = function( value ){
	.w = which( shape_errors == value )
	if( length( .w ) < 1 ) return (TRUE)
	else return ( shape_errors[.w] != shape_errors["NO_ERROR"] )
}
checkHasSlide = function( value ){
	if( inherits( value, c("pptx" ) ) && is.null( value$current_slide ) )
		stop("The document has no slide where to add content. Use addSlide first.")
	if( inherits( value, c("html" ) ) && is.null( value$current_slide ) )
		stop("The document has no page where to add content. Use addPage first.")
}

getSlideErrorString = function( value, shape ){
	if( value == shape_errors["UNDEFINED"] ) return (paste0("shape of type '", shape , "' - undefined error"))
	else if( value == shape_errors["DONOTEXISTS"] ) return (paste0("shape of type '", shape , "' cannot be found in the layout"))
	else if( value == shape_errors["ISFILLED"] ) return (paste0("shape of type '", shape , "' has already been filled"))
	else if( value == shape_errors["NOROOMLEFT"] ) return (paste0("shape of type '", shape , "' has no more room left to be displayed in the layout"))
	else if( value == shape_errors["UNDEFDIMENSION"] ) return ( paste0( "shape of type '", shape , "' has no dimension defined. "
									, "To define dimension, read the addSlide.pptx documentation (?addSlide.pptx). ")
				)#http://office.microsoft.com/en-us/powerpoint-help/overview-of-slide-layouts-HA010079907.aspx
	else return("")
}

get_poly_coord = function( x, height ){
	
	if( inherits(x, "try-error") || all( x$dim[1:2]< 1 ) ) 
		return (NULL)
	
	position_left_top = x$dim[1:2]
	size = x$dim[3:4]
	out = list()
	
	out$x = c( position_left_top[1], position_left_top[1] + size[1], position_left_top[1] + size[1], position_left_top[1], NA )
	
	newposytopleft = height - position_left_top[2]
	out$y = c( newposytopleft, newposytopleft, newposytopleft - size[2], newposytopleft - size[2], NA )
	
	out
}

get_text_coord = function( x, height ){
	
	if( inherits(x, "try-error") || all( x$dim[1:2]< 1 ) ) 
		return (NULL)
	position_left_top = x$dim[1:2]
	size = x$dim[3:4]
	out = list()
	out$x = position_left_top[1] + size[1] * 0.5
	newposytopleft = height - position_left_top[2]
	
	out$y = newposytopleft - size[2] * 0.5
	if( is.element("text", names( x ) ) ) out$labels = x$text
	out
}

plotSlideLayout = function( doc, layout.name ){
	
	SlideLayout = .jcall( doc$obj, paste0("L", class.pptx4r.SlideLayout, ";"), "getSlideLayout", as.character(layout.name) )
	maxid = .jcall( SlideLayout, "I", "getContentSize")
	content_shapes = list()
	content_size = .jcall( SlideLayout, "I", "getContentSize" )
	if( content_size > 0 )
		for(i in 0:( maxid - 1 ) ){
			content_shapes[[i+1]] = list( 
					text = "content"
					, dim = .jcall( SlideLayout
							, "[I", "getContentDimensions"
							, as.integer(i) ) / 12700 
			)
		}
	
	meta_shapes = list()
	metas = c(TITLE = 0, FOOTER = 1, SLIDENUMBER = 2
			, DATE = 3, SUBTITLE = 4, CRTTITLE = 5)
	nummeta = 0
	for(i in 1:length(metas)){
		if( .jcall( SlideLayout, "Z", "contains", as.integer(metas[i]) ) ){
			nummeta = nummeta + 1
			meta_shapes[[nummeta]] = list( 
					text = names(metas)[i]
					, dim = .jcall( SlideLayout, "[I", "getMetaDimensions", as.integer(metas[i]) ) / 12700
					)
		}
	}

	dimensions = .jcall( doc$obj, "[I", "readSlideDimensions" ) / 12700
	
	coords_poly_meta = lapply( meta_shapes, get_poly_coord, height = dimensions[2] )
	coords_poly_meta = coords_poly_meta[ !sapply( coords_poly_meta, is.null ) ]
	
	coords_text_meta = lapply( meta_shapes, get_text_coord, height = dimensions[2] )
	coords_text_meta = coords_text_meta[ !sapply( coords_text_meta, is.null ) ]
	
	if( content_size > 0 ){
		coords_poly_content = lapply( content_shapes, get_poly_coord, height = dimensions[2] )
		coords_text_content = lapply( content_shapes, get_text_coord, height = dimensions[2] )
	}
	
	plot( x = c(0, dimensions[1]) , y = c(0, dimensions[2]), type = "n", axes = F, xlab = "", ylab = "", main = "" )
	if( content_size > 0 ){
		lapply( coords_poly_content, function(x) polygon( x$x, x$y ) )
		for(i in 1:length( coords_text_content ))
			text( coords_text_content[[i]]$x, coords_text_content[[i]]$y, labels=paste("shape", i) )
	}
	lapply( coords_poly_meta, function(x) polygon( x$x, x$y ) )
	for(i in 1:length( coords_text_meta ))
		text( x = coords_text_meta[[i]]$x, y = coords_text_meta[[i]]$y, labels=coords_text_meta[[i]]$labels )
	
	invisible()
}



getHexColorCode = function( valid.color ){
	rgb( t(col2rgb(valid.color)/255 ))
}

ReporteRs.border.styles = c( "none", "solid", "dotted", "dashed" )

get.pots.from.script = function( file, text
, comment.properties
, roxygencomment.properties
, operators.properties
, keyword.properties
, string.properties
, number.properties
, functioncall.properties
, argument.properties
, package.properties
, formalargs.properties
, eqformalargs.properties
, assignement.properties
, symbol.properties
, slot.properties
, default.properties
){
	
	if( !missing( file ) ){
		if( length( file ) != 1 ) stop("file must be a single filename.")
		if( !file.exists( file ) ) stop("file does not exist.")
	}
	
	if( missing( file ) ){
		myexpr = parse( text = text, keep.source = TRUE )
	} else {
		myexpr = parse( file = file, keep.source = TRUE )
	}
	
	data = getParseData( myexpr )
	data = data[ data$terminal, ]
	
	desc_token   = as.character( data[ data[["terminal"]], "token" ] )
	extentionTag = rep( "default", length( desc_token ) )
	
	extentionTag[ desc_token == "COMMENT"  ] = "comment"
	extentionTag[ desc_token == "ROXYGEN_COMMENT" ] = "roxygencomment"
	operators.regexpr = "(^'.*?'$|AND|AND2|EQ|GE|GT|LBB|LE|LT|NE|NS_GET|NS_GET_INT|OR|OR2|SPECIAL)"
	extentionTag[ grepl(operators.regexpr, desc_token ) ] = "operators"
	
	extentionTag[ desc_token %in% c('FUNCTION', 'IF', 'ELSE', 'WHILE', 'FOR', 'IN', 'BREAK', 'REPEAT', 'NEXT', 'NULL_CONST') ] = "keyword" 
	
	extentionTag[ desc_token == "STR_CONST" ] = "string"
	extentionTag[ desc_token == "NUM_CONST" ] = "number"
	
	extentionTag[ desc_token == "SYMBOL_FUNCTION_CALL" ] = "functioncall"
	extentionTag[ desc_token %in% c("SYMBOL_SUB", "EQ_SUB" )  ] = "argument"
	extentionTag[ desc_token == "SYMBOL_PACKAGE" ] = "package"
	
	extentionTag[ desc_token %in% c("SYMBOL_FORMALS") ] = "formalargs"
	extentionTag[ desc_token %in% "EQ_FORMALS" ] = "eqformalargs"
	
	extentionTag[ desc_token %in% c("EQ_ASSIGN", "LEFT_ASSIGN" )] = "assignement"
	extentionTag[ desc_token == "SYMBOL" ] = "symbol"
	extentionTag[ desc_token == "SLOT" ] = "slot"
	
	data$extentionTag = extentionTag
	
	ldata = split( data, data[,1] )
	
	tp.list = list( comment.properties = comment.properties
			, roxygencomment.properties = roxygencomment.properties
			, operators.properties = operators.properties
			, keyword.properties = keyword.properties
			, string.properties = string.properties
			, number.properties = number.properties
			, functioncall.properties = functioncall.properties
			, argument.properties = argument.properties
			, package.properties = package.properties
			, formalargs.properties = formalargs.properties
			, eqformalargs.properties = eqformalargs.properties
			, assignement.properties = assignement.properties
			, symbol.properties = symbol.properties
			, slot.properties = slot.properties
			, default.properties = default.properties
		)
	
	pot.list = lapply( ldata, function(x, tp.list ){
				x = x[ order(x[,2] ), ]
				out = pot()
				last_pos = 0
				for(i in 1:nrow(x) ){
					if( x[i,2] != (last_pos + 1) ){
						.size = x[i,2] - (last_pos + 1)
						out = out + paste( rep( " ", .size ), collapse = "" )
					}
					out = out + pot( x[i,"text"]
							, format = tp.list[[ paste( x[i,"extentionTag"], ".properties", sep = "" ) ]]
					)
					last_pos = x[i,4]
				}
				out
			} , tp.list = tp.list )
	out = lapply( 1: max( data[,3]) , function(x) pot() )
	names( out ) = as.character( 1: max( data[,3] ) )
	out[names(pot.list)] = pot.list
	out
}
