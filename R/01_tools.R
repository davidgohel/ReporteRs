#' @import rJava
#' @import ReporteRsjars
.onLoad= function(libname, pkgname){
	.jpackage( pkgname, lib.loc = libname )
	options("ReporteRs-default-font"="Helvetica")
	options("ReporteRs-locale.language"="en")
	options("ReporteRs-locale.region"="US")
	options("ReporteRs-backtick-color" = "#c7254e" )
	options("ReporteRs-backtick-shading-color" = "#f9f2f4" )
	options("ReporteRs-fontsize"=11L)
	
	options("ReporteRs-list-definition"= list( 		
		ol.left = seq( from = 0, by = 0.4, length.out = 9), 
		ol.hanging = rep( 0.4, 9 ), 
		ol.format = rep( "decimal", 9 ), 
		ol.pattern = paste0( "%", 1:9, "." ), 
		ul.left = seq( from = 0, by = 0.4, length.out = 9), 
		ul.hanging = rep( 0.4, 9 ), 
		ul.format = c( "disc", "circle", "square", "disc", "circle", "square", "disc", "circle", "square" ) 
		)
	)
	invisible()
}

.jset_of_paragraphs = function( value, par.properties ){
	
	parset = .jnew( class.ParagraphSet, .jParProperties(par.properties) )
	
	for( pot_index in 1:length( value ) ){
		paragrah = .jnew(class.Paragraph )
		pot_value = value[[pot_index]]
		for( i in 1:length(pot_value)){
			current_value = pot_value[[i]]
			if( is.null( current_value$format ) ) {
				if( is.null( current_value$hyperlink ) )
					.jcall( paragrah, "V", "addText", current_value$value )
				else .jcall( paragrah, "V", "addText", current_value$value, current_value$hyperlink )
			} else {
				jtext.properties = .jTextProperties( current_value$format )
				if( is.null( current_value$hyperlink ) )
					.jcall( paragrah, "V", "addText", current_value$value, jtext.properties )
				else .jcall( paragrah, "V", "addText", current_value$value, jtext.properties, current_value$hyperlink )
			}
			if( !is.null( current_value$footnote ) ) {
				jfn = .jFootnote(current_value$footnote)
				.jcall( paragrah, "V", "addFootnoteToLastEntry", jfn )
			}
		}
		.jcall( parset, "V", "addParagraph", paragrah )
	}
	parset
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



plotSlideLayout = function( doc, layout.name ){

	layout_description = .jcall( doc$obj, paste0("L", class.pptx4r.LayoutDescription, ";"), "getLayoutProperties", layout.name )
	dimensions = .jcall( doc$obj, "[I", "readSlideDimensions" )
	
	content_dims = matrix( .jcall( layout_description, "[I", "getContentDimensions" ), 
		ncol = 4, byrow = T, 
		dimnames = list(NULL, c( "offxs", "offys", "widths", "heights" ) ) 
	)
	
	header_dims = matrix( .jcall( layout_description, "[I", "getHeaderDimensions" ), 
		ncol = 5, byrow = T, 
		dimnames = list(NULL, c( "name", "offxs", "offys", "widths", "heights") )
	)
	
	if( nrow(header_dims) > 0 ){
		metas = c(TITLE = 0, FOOTER = 1, SLIDENUMBER = 2
				, DATE = 3, SUBTITLE = 4, CRTTITLE = 5)
		header_names = names( metas )[ match( header_dims[,"name"], metas ) ]
	} else header_names = character(0)
		
	if( nrow(content_dims) > 0 )
		body_names = paste("BODY", sprintf("%02.0f", 1:nrow(content_dims) ) )
	else body_names = character(0)
		
	polygons_info = rbind( header_dims[, -1], content_dims )
	
	position_left = polygons_info[,"offxs"]
	position_right = polygons_info[,"offxs"] + polygons_info[,"widths"]
	position_top = dimensions[2] - polygons_info[,"offys"] 
	position_bottom = dimensions[2] - (polygons_info[,"offys"] + polygons_info[,"heights"])
	
	positions = matrix( c( position_left, 
			position_right, position_top, 
			position_bottom
		), ncol = 4 )
	x = as.vector( apply( positions, 1, function( x ) c( x[1], x[1], x[2], x[2], NA ) ) )
	y = as.vector( apply( positions, 1, function( x ) c( x[4], x[3], x[3], x[4], NA ) ) )
	
	plot( x = c(0, dimensions[1]) , y = c(0, dimensions[2]), 
			type = "n", axes = F, 
			xaxs = "i", yaxs = "i", 
			xlab = "", ylab = "", main = "" )
	box()
	polygon(x, y )
	
	text( x = (position_left + position_right)/2, 
		y = (position_top + position_bottom)/2 ,
		labels = c( header_names, body_names )
		)
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

		pot.list = lapply( ldata, function(x, tp.list, default.properties ){
				x = x[ order(x[,2] ), ]
				out = pot("", format=default.properties)
				last_pos = 0
				for(i in 1:nrow(x) ){
					if( x[i,2] != (last_pos + 1) ){
						.size = x[i,2] - (last_pos + 1)
						out = out + pot( paste( rep( " ", .size ), collapse = "" ), format=default.properties)
					}
					prop.name = paste( x[i,"extentionTag"], ".properties", sep = "" )
					out = out + pot( x[i,"text"], format = tp.list[[ prop.name ]] )
					last_pos = x[i,4]
				}
				out
			} , tp.list = tp.list, default.properties = default.properties )
	out = lapply( 1: max( data[,3]) , function(x) pot() )
	names( out ) = as.character( 1: max( data[,3] ) )
	out[names(pot.list)] = pot.list
	out
}




getOldTable = function( data, layout.properties
	, header.labels, groupedheader.row = list()
	, span.columns = character(0), col.types
	, columns.bg.colors = list(), columns.font.colors = list()
	, row.names = FALSE ) {
	
	if( is.matrix( data )){
		.oldnames = names( data )
		data = as.data.frame( data )
		names( data ) = .oldnames
	}
	
	if( missing(header.labels) ){
		header.labels = names(data)
	}
	
	if( missing(layout.properties) )
		layout.properties = get.default.tableProperties()
	
	if( nrow( data ) < 2 ) span.columns = character(0)
	
	if( missing( col.types ) ){
		col.types = getDefaultColTypes( data )
	}
	nbcol = ncol( data ) + as.integer( row.names )
	
	if( row.names ){
		col.types = c("character", col.types )
	}
	
	for( j in 1:ncol( data ) ){
		if( is.factor(data[, j] ) ) tempdata = as.character( data[, j] )
		else if( is.logical(data[, j] ) ) tempdata = ifelse( data[, j], "TRUE", "FALSE" )
		else tempdata = data[, j]
		
		if( col.types[j] == "percent" ){
			format_str = paste( "%0.", layout.properties$fraction.percent.digit, "f" )
			data[, j] = sprintf( format_str, data[, j] * 100 )
		} else if( col.types[j] == "double" ){
			format_str = paste( "%0.", layout.properties$fraction.double.digit, "f" )
			data[, j] = sprintf( format_str, data[, j] )
		} else if( col.types[j] == "integer" ){
			data[, j] = sprintf( "%0.0f", data[, j] )			
		} else if( col.types[j] == "date" || col.types[j] == "datetime" ){
			data[, j] = format( tempdata, "%Y-%m-%d" )
		}
	}
	

	ft = FlexTable( data = data, header.columns = FALSE, add.rownames = row.names )
	for(j in span.columns ) 
		ft = spanFlexTableRows( ft, j=j, runs = as.character( data[,j] ) )
	
	for( j in 1:nbcol ){
		if( col.types[j] == "percent" ){
			ft[,j ] = layout.properties$percent.text
			ft[,j ] = layout.properties$percent.par
			ft[,j ] = layout.properties$percent.cell		
		}
		else if( col.types[j] == "double" ){
			ft[,j ] = layout.properties$double.text
			ft[,j ] = layout.properties$double.par
			ft[,j ] = layout.properties$double.cell
		}
		else if( col.types[j] == "integer" ){
			ft[,j ] = layout.properties$integer.text
			ft[,j ] = layout.properties$integer.par
			ft[,j ] = layout.properties$integer.cell
		}
		else if( col.types[j] == "character" ){
			ft[,j ] = layout.properties$character.text
			ft[,j ] = layout.properties$character.par
			ft[,j ] = layout.properties$character.cell
		}
		else if( col.types[j] == "date" ){
			ft[,j ] = layout.properties$date.text
			ft[,j ] = layout.properties$date.par
			ft[,j ] = layout.properties$date.cell
		}
		else if( col.types[j] == "datetime" ){
			ft[,j ] = layout.properties$datetime.text
			ft[,j ] = layout.properties$datetime.par
			ft[,j ] = layout.properties$datetime.cell
		}
		else if( col.types[j] == "logical" ){
			ft[,j ] = layout.properties$logical.text
			ft[,j ] = layout.properties$logical.par
			ft[,j ] = layout.properties$logical.cell
		}
		
		
	}
	if( length( groupedheader.row ) > 0 ){
		ft = addHeaderRow( ft
				, value = groupedheader.row$values
				, colspan = groupedheader.row$colspan
		)
	}
	ft = addHeaderRow( ft, value = header.labels )
	
	if( length( groupedheader.row ) > 0 ){
		ft[1,, to = "header"] = layout.properties$groupedheader.text
		ft[2,, to = "header"] = layout.properties$header.text
		ft[1,, to = "header"] = layout.properties$groupedheader.par
		ft[2,, to = "header"] = layout.properties$header.par
		ft[1,, to = "header"] = layout.properties$groupedheader.cell
		ft[2,, to = "header"] = layout.properties$header.cell
	} else {
		ft[1,, to = "header"] = layout.properties$header.text
		ft[1,, to = "header"] = layout.properties$header.par
		ft[1,, to = "header"] = layout.properties$header.cell
	}
	
	for( col in names(columns.bg.colors) ){
		j = match( col, ft$col_id )
		if( col.types[j] == "percent" ){
			cellProp = layout.properties$percent.cell		
		}
		else if( col.types[j] == "double" ){
			cellProp = layout.properties$double.cell
		}
		else if( col.types[j] == "integer" ){
			cellProp = layout.properties$integer.cell
		}
		else if( col.types[j] == "character" ){
			cellProp = layout.properties$character.cell
		}
		else if( col.types[j] == "date" ){
			cellProp = layout.properties$date.cell
		}
		else if( col.types[j] == "datetime" ){
			cellProp = layout.properties$datetime.cell
		}
		else if( col.types[j] == "logical" ){
			cellProp = layout.properties$logical.cell
		} else cellProp = layout.properties$character.cell
		
		for( color in unique(columns.bg.colors[[col]])){
			ft[columns.bg.colors[[col]] == color, col] = chprop(cellProp, background.color = color )
		}
		
	}
	
	
	
	for( col in names(columns.font.colors) ){
		j = match( col, ft$col_id )
		if( col.types[j] == "percent" ){
			textProp = layout.properties$percent.text		
		}
		else if( col.types[j] == "double" ){
			textProp = layout.properties$double.text
		}
		else if( col.types[j] == "integer" ){
			textProp = layout.properties$integer.text
		}
		else if( col.types[j] == "character" ){
			textProp = layout.properties$character.text
		}
		else if( col.types[j] == "date" ){
			textProp = layout.properties$date.text
		}
		else if( col.types[j] == "datetime" ){
			textProp = layout.properties$datetime.text
		}
		else if( col.types[j] == "logical" ){
			textProp = layout.properties$logical.text
		} else textProp = layout.properties$character.text
		for( color in unique(columns.font.colors[[col]])){
			ft[columns.font.colors[[col]] == color, col] = chprop(textProp, color = color )
		}
		
	}
	ft
}

