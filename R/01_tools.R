#' @import rJava
#' @import ReporteRsjars
#' @importFrom grDevices col2rgb
#' @importFrom grDevices dev.cur
#' @importFrom grDevices dev.off
#' @importFrom grDevices dev.list
#' @importFrom grDevices rgb
#' @importFrom graphics box
#' @importFrom graphics plot
#' @importFrom graphics polygon
#' @importFrom graphics text
#' @importFrom utils getParseData
#' @importFrom utils browseURL
.onLoad= function(libname, pkgname){

	.jpackage( pkgname, lib.loc = libname )
	.jcall('java.lang.System','S','setProperty','file.encoding', 'UTF-8')
	.jcall('java.lang.System','S','setProperty','java.awt.headless', 'true')
	options("ReporteRs-default-font" = "Times New Roman")
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

	if( !missing( par.properties ))
		parset = .jnew( class.ParagraphSet, .jParProperties(par.properties) )
	else parset = .jnew( class.ParagraphSet )

	for( pot_index in 1:length( value ) ){
		paragrah = .jnew(class.Paragraph )
		pot_value = value[[pot_index]]
		for( i in 1:length(pot_value)){
			current_value = pot_value[[i]]
			if( !is.null( current_value$jimg )){
				.jcall( paragrah, "V", "addImage", current_value$jimg )
				.jcall( paragrah, "V", "addText", "" )
			} else {

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
		}
		.jcall( parset, "V", "addParagraph", paragrah )
	}
	parset
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

	graphics::plot( x = c(0, dimensions[1]) , y = c(0, dimensions[2]),
			type = "n", axes = F,
			xaxs = "i", yaxs = "i",
			xlab = "", ylab = "", main = "" )
	graphics::box()
	graphics::polygon(x, y )

	graphics::text( x = (position_left + position_right)/2,
		y = (position_top + position_bottom)/2 ,
		labels = c( header_names, body_names )
		)
	invisible()
}



getHexColorCode = function( valid.color ){
	rgb( t(col2rgb(valid.color)/255 ))
}

get_col_values = function( valid.color ){
  mat <- as.vector( col2rgb(valid.color, alpha = TRUE) )
  list( r = mat[1], g = mat[2], b = mat[3], a = mat[4] )
}

ReporteRs.border.styles = c( "none", "solid", "dotted", "dashed" )
#ReporteRs.text.directions = c( "lrTb", "tbRl", "btLr" )
ReporteRs.text.directions = c( "lrtb", "tbrl", "btlr" )

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

	data = utils::getParseData( myexpr )
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

last_elts <- function(x, n = 5L){
	.l = length( x )
	n = if (n < 0L) max(.l + n, 0L) else min(n, .l)
	x[seq.int(to = .l, length.out = n)]
}


next_shape_pos = function( doc ){
  slide = doc$current_slide

  id = .jcall( slide, "I", "getNextShapeIndex"  )
  maxid = .jcall( slide, "I", "getmax_shape"  )

  if( maxid-id < 1 )
    stop( getSlideErrorString( shape_errors["NOROOMLEFT"] , "plot") )

  layout_name <- .jcall( slide, "S", "getLayoutName" )
  classname_ <- paste0("L", class.pptx4r.LayoutDescription, ";")
  layout_description = .jcall( doc$obj, classname_,
                               "getLayoutProperties", layout_name )
  dims = .jcall( layout_description, "[I",
                 "getContentDimensions", as.integer(id) )
  width = dims[3] / 914400
  height = dims[4] / 914400
  offx = dims[1] / 914400
  offy = dims[2] / 914400
  list( width = width, height = height, offx = offx, offy = offy )
}




