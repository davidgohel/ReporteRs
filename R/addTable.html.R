#' @title Insert a table into an html object
#'
#' @description
#' Insert a table into the \code{html} object.
#' 
#' @param doc the \code{html} to use
#' @param data \code{data.frame} to add
#' @param layout.properties a \code{tableProperties} object to specify styles to use to format the table. optional
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
#' @param row.names logical value - should the row.names be included in the table. 
#' @param ... addTable arguments - see \code{\link{addTable}}. 
#' @return an object of class \code{"html"}.
#' @examples
#' #START_TAG_TEST
#' # Create a new document 
#' doc = html( title = "title" )
#' 
#' # add a page where to add R outputs with title 'page example'
#' doc = addPage( doc, title = "page example" )
#' 
#' doc = addTitle( doc, "Iris dataset", level = 1 )
#' # add the first 5 lines of iris
#' doc = addTable( doc, head( iris, n = 5 ) )
#' 
#' doc = addTitle( doc, "Iris sample dataset with span cells", level = 2 )
#' # demo span.columns
#' doc = addTable( doc, iris[ 46:55,], span.columns = "Species" )
#' 
#' doc = addTitle( doc, "Dummy data and options demo", level = 1 )
#' data( data_ReporteRs )
#' # add dummy data 'data_ReporteRs' and customise some options
#' doc = addTable( doc
#'		, data = data_ReporteRs
#'		, header.labels = c( "Header 1", "Header 2", "Header 3"
#' 			, "Header 4", "Header 5", "Header 6" )
#'		, groupedheader.row = list( values = c("Grouped column 1", "Grouped column 2")
#' 			, colspan = c(3, 3) )
#'		, col.types = c( "character", "integer", "double", "date", "percent", "character" )
#'		, columns.font.colors = list( 
#' 			"col1" = c("#527578", "#84978F", "#ADA692", "#47423F")
#' 			, "col3" = c("#74A6BD", "#7195A3", "#D4E7ED", "#EB8540") 
#' 			)
#'		, columns.bg.colors = list( 
#' 			"col2" = c("#527578", "#84978F", "#ADA692", "#47423F")
#' 			, "col4" = c("#74A6BD", "#7195A3", "#D4E7ED", "#EB8540") 
#' 			)
#'	)
#' 
#' # write the html object in a directory
#' pages = writeDoc( doc, "addTable_example")
#' print( pages ) # print filenames of generated html pages
#' #STOP_TAG_TEST
#' @seealso \code{\link{html}}, \code{\link{addTable}}, \code{\link{tableProperties}}
#' @method addTable html
#' @S3method addTable html
addTable.html = function(doc, data, layout.properties
	, header.labels, groupedheader.row = list()
	, span.columns = character(0), col.types
	, columns.bg.colors = list(), columns.font.colors = list()
	, row.names = FALSE
	, ...) {
			
	if( is.matrix( data )){
		.oldnames = names( data )
		data = as.data.frame( data )
		names( data ) = .oldnames
	}
	
	if( missing(header.labels) ){
		header.labels = names(data)
		#names( header.labels ) = names(data)
	}
	
	if( missing(layout.properties) )
		layout.properties = get.default.tableProperties()
	
	if( nrow( data ) < 2 ) span.columns = character(0)
	
	if( missing( col.types ) ){
		col.types = getDefaultColTypes( data )
	}
	
	.jformats.object = table.format.2java( layout.properties, type = "html" )
	obj = .jnew(class.html4r.DataTable, .jformats.object  )
	setData2Java( obj, data, header.labels, col.types, groupedheader.row, columns.bg.colors, columns.font.colors, row.names)
	
	for(j in span.columns ){
		 instructions = list()
		 current.col = data[, j]
		 groups = cumsum( c(TRUE, current.col[-length(current.col)] != current.col[-1] ) )
		 groups.counts = tapply( groups, groups, length )
		 
		 for(i in 1:length( groups.counts )){
		   if( groups.counts[i] == 1 ) 
			   instructions[[i]] = 1
		   else {
		     instructions[[i]] = c(groups.counts[i] , rep(0, groups.counts[i]-1 ) )
		   }
		 }
		.jcall( obj , "V", "setMergeInstructions", j, .jarray( as.integer( unlist( instructions ) ) ) )
	}

	out = .jcall( doc$current_slide, "I", "add", obj )
	if( out != 1 ){
		stop( "Problem while trying to add table." )
	}

	doc
}

