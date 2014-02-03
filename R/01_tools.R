# tools functions 
# 
# Author: David GOHEL <david.gohel@lysis-consultants.fr>
# Date: 31 mars 2013
# Version: 0.1
###############################################################################

#' @import rJava
.onLoad= function(libname, pkgname){
	rJava::.jpackage( pkgname, lib.loc = libname )
	options("ReporteRs-default-font"="Helvetica")
	options("ReporteRs-locale.language"="en")
	options("ReporteRs-locale.region"="US")
	options("ReporteRs-fontsize"=11L)
	invisible()
}

getDefaultColTypes = function( data ){
	lapply( data , function(x) {
		out = class(x)
		if( out == "factor") out = "character"
		else if( out == "integer") out = "integer"
		else if( out == "numeric") out = "double"
		else if( out == "logical") out = "logical" 
		else if( out == "Date") out = "date"
		else if( out == "POSIXct") out = "datetime"
		else if( out == "POSIXlt") out = "datetime"
		else "character"
		out
	} )
}


setData2Java = function( obj, data, header.labels, col.types
, groupedheader.row, columns.bg.colors, columns.font.colors
, row.names = T){
	dnames = names( data )
	if( row.names ){
		rJava::.jcall( obj , "V", "setData", "row_names", "", .jarray( as.character(row.names( data ) ) ) )		
	}
	for( j in 1:ncol( data ) ){
		if( is.factor(data[, j] ) ) tempdata = as.character( data[, j] )
		else if( is.logical(data[, j] ) ) tempdata = ifelse( data[, j], "TRUE", "FALSE" )
		else tempdata = data[, j]
		
		if( col.types[j] == "percent" )
			rJava::.jcall( obj , "V", "setPercentData", dnames[j], header.labels[j], .jarray(tempdata*100) )
		else if( col.types[j] == "double" )
			rJava::.jcall( obj , "V", "setData", dnames[j], header.labels[j], .jarray( as.double(tempdata)) )
		else if( col.types[j] == "integer" )
			rJava::.jcall( obj , "V", "setData", dnames[j], header.labels[j], .jarray( as.integer(tempdata)) )
		else if( col.types[j] == "character" )
			rJava::.jcall( obj , "V", "setData", dnames[j], header.labels[j], .jarray( as.character(tempdata)) )
		else if( col.types[j] == "date" )
			rJava::.jcall( obj , "V", "setDateData", dnames[j], header.labels[j], .jarray( format( tempdata, "%Y-%m-%d" ) ) )
		else if( col.types[j] == "datetime" )
			rJava::.jcall( obj , "V", "setDateData", dnames[j], header.labels[j], .jarray( format( tempdata, "%Y-%m-%d " ) ) )
		else if( col.types[j] == "logical" )
			rJava::.jcall( obj , "V", "setLogicalData", dnames[j], header.labels[j], .jarray( as.character(tempdata)) )
	}
	
	if( length( groupedheader.row ) > 0 ){
		if( row.names ){
			rJava::.jcall( obj , "V", "setGroupedCols", "", 1L )
		}
		for(gcol in 1:length(groupedheader.row$values ) ){
			value = groupedheader.row$values[gcol]
			colspan = groupedheader.row$colspan[gcol]
			rJava::.jcall( obj , "V", "setGroupedCols", value, as.integer(colspan) )
		}
	}
	
	if( length( columns.bg.colors ) > 0 ){
		for( j in names( columns.bg.colors ) ){ 
			rJava::.jcall( obj , "V", "setFillColors", j, .jarray( columns.bg.colors[[j]] ) )
		}
	}
	
	if( length( columns.font.colors ) > 0 ){
		for( j in names( columns.font.colors ) ){ 
			rJava::.jcall( obj , "V", "setFontColors", j, .jarray( columns.font.colors[[j]] ) )
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
		#TODO: change that code (refactor r2doc also in s3)
		jwhatmethod = paste( casefold( substring(what , 1, 1 ),  upper = T ), casefold( substring(what , 2, nchar(what) ),  upper = F ), sep = "" )
		jwhatmethod = paste( "set", jwhatmethod, "Text", sep = "" )
		rwhatobject = paste( what, ".text", sep = "" )
		str = paste( "x$", rwhatobject , sep = "" )
		robject = eval( parse ( text = str ) )
		rJava::.jcall( obj, "V", jwhatmethod, as.character(robject$color)
				, robject$font.size
				, as.logical(robject$font.weight=="bold")
				, as.logical(robject$font.style=="italic")
				, as.logical(robject$underlined)
				, robject$font.family
		)
		
	}
	
	for( what in rootnames ){
		jwhatmethod = paste( casefold( substring(what , 1, 1 ),  upper = T ), casefold( substring(what , 2, nchar(what) ),  upper = F ), sep = "" )
		jwhatmethod = paste( "set", jwhatmethod, "Par", sep = "" )
		rwhatobject = paste( what, ".par", sep = "" )
		str = paste( "x$", rwhatobject , sep = "" )
		robject = eval( parse ( text = str ) )
		rJava::.jcall( obj, "V", jwhatmethod, robject$text.align
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

		rJava::.jcall( obj, "V", jwhatmethod
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
	
	SlideLayout = rJava::.jcall( doc$obj, paste0("L", class.pptx4r.SlideLayout, ";"), "getSlideLayout", as.character(layout.name) )
	maxid = rJava::.jcall( SlideLayout, "I", "getContentSize")
	content_shapes = list()
	content_size = rJava::.jcall( SlideLayout, "I", "getContentSize" )
	if( content_size > 0 )
		for(i in 0:( maxid - 1 ) ){
			content_shapes[[i+1]] = list( 
					text = "content"
					, dim = rJava::.jcall( SlideLayout
							, "[I", "getContentDimensions"
							, as.integer(i) ) / 12700 
			)
		}
	
	meta_shapes = list()
	metas = c(TITLE = 0, FOOTER = 1, SLIDENUMBER = 2
			, DATE = 3, SUBTITLE = 4, CRTTITLE = 5)
	nummeta = 0
	for(i in 1:length(metas)){
		if( rJava::.jcall( SlideLayout, "Z", "contains", as.integer(metas[i]) ) ){
			nummeta = nummeta + 1
			meta_shapes[[nummeta]] = list( 
					text = names(metas)[i]
					, dim = rJava::.jcall( SlideLayout, "[I", "getMetaDimensions", as.integer(metas[i]) ) / 12700
					)
		}
	}

	dimensions = rJava::.jcall( doc$obj, "[I", "readSlideDimensions" ) / 12700
	
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



#' @title register Raphael plots
#'
#' @description register Raphael plots - internal use only
#' 
#' @param plot_attributes plot attributes
#' @param env environment
#' @export 
registerRaphaelGraph = function( plot_attributes, env ){
	plot_ids = get("plot_ids" , envir = env )
	plot_attributes = as.list( plot_attributes )
	names( plot_attributes ) = c("filename", "js.plotid","div.id")
	plot_ids[[length( plot_ids ) + 1]] = plot_attributes
	assign("plot_ids", plot_ids, envir = env)
	invisible()
}
check.fontfamily = function( fontfamily ){
	font = .jnew("java/awt/Font", fontfamily, 0L, 12L )
	font_family = rJava::.jcall( font, "S", "getFamily" )
	if( font_family == "Dialog" )
		stop("Font ", fontfamily, " can't be found in available fonts on this machine.")
	invisible()
}

getHexColorCode = function( valid.color ){
	rgb( t(col2rgb(valid.color)/255 ))
}
