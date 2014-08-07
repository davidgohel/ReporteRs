#' @title Insert a table into a docx object
#'
#' @description
#' Insert a table into the \code{docx} object.
#' 
#' @param doc the \code{docx} to use
#' @param data \code{data.frame} to add
#' @param layout.properties a \code{tableProperties} object to specify styles 
#' to use to format the table. optional. Default to 
#' @param header.labels a character whose elements define labels to display in table headers instead of colnames. 
#' Optional, if missing, headers will be filled with \code{data} column names.
#' @param groupedheader.row a named list whose elements define the upper header row (grouped header). Optional. 
#' Elements of that list are \code{values} and \code{colspan}. Element \code{values} is a character vector containing labels 
#' to display in the grouped header row. Element \code{colspan} is an integer vector containing number of columns to span 
#' for each \code{values}.
#' @param span.columns a character vector specifying columns names where row merging should be done (if successive values in a column are the same ; if data[p,j]==data[p-1,j] )
#' @param col.types a character whose elements define the formatting style of columns via their data roles. Optional
#' Possible values are : \emph{"character"}, \emph{"integer"}, \emph{"logical"}
#' 			, \emph{"double"}, \emph{"percent"}, \emph{"date"}, \emph{"datetime}".
#' If missing, factor and character will be formated as character
#' 			, integer as integer and numeric as double.
#' @param columns.bg.colors A named list of character vector. Define the background color of cells for a given column. optional.  
#' Names are \code{data} column names and values are character vectors specifying cells background colors.
#' Each element of the list is a vector of length \code{nrow(data)}.
#' @param columns.font.colors A named list of character vector. Define the font color of cells per column. optional.
#'		A name list, names are \code{data} column names and values 
#' 			are character vectors specifying cells font colors.
#'		Each element of the list is a vector of length \code{nrow(data)}.
#' @param par.properties paragraph formatting properties of the paragraph that contains the table. An object of class \code{\link{parProperties}}
#' @param bookmark a character vector specifying bookmark id (where to put the table). 
#'   	If provided, table will be add after paragraph that contains the bookmark. See \code{\link{bookmark}}.
#'   	If not provided, table will be added at the end of the document.
#' @param row.names logical value - should the row.names be included in the table. 
#' @param ... addTable arguments - see \code{\link{addTable}}. 
#' @return an object of class \code{"docx"}.
#' @examples
#' #START_TAG_TEST
#' doc.filename = "addTable_example.docx"
#' @example examples/docx.R
#' @example examples/addTitle1Level1.R
#' @example examples/simpleAddTable.R
#' @example examples/addTitle2Level1.R
#' @example examples/spanAddTable.R
#' @example examples/addTitle3Level1.R
#' @example examples/optionsDemoAddTable.R
#' @example examples/writeDoc_file.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{docx}}, \code{\link{addTable}}, \code{\link{tableProperties}}
#' , \code{\link{addFlexTable}}, \code{\link{FlexTable}}, \code{\link{bookmark}}
#' @method addTable docx
#' @S3method addTable docx
addTable.docx = function(doc, data, layout.properties
	, header.labels, groupedheader.row = list()
	, span.columns = character(0), col.types
	, columns.bg.colors = list(), columns.font.colors = list()
	, row.names = FALSE
	, par.properties = parProperties(text.align = "left")
	, bookmark
	, ...) {
	
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
	
	if( missing( bookmark ) )
		doc = addFlexTable( doc, flextable = ft, par.properties = par.properties )
	else doc = addFlexTable( doc, flextable = ft, bookmark = bookmark, par.properties = par.properties )
	doc
}

