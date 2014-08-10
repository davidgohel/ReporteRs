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
#' @return an object of class \code{\link{docx}}.
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
addTable.docx = function(doc, data, layout.properties = get.default.tableProperties()
	, header.labels, groupedheader.row = list()
	, span.columns = character(0), col.types
	, columns.bg.colors = list(), columns.font.colors = list()
	, row.names = FALSE
	, par.properties = parProperties(text.align = "left")
	, bookmark
	, ...) {
	
	args = list( data = data, layout.properties = layout.properties,
			groupedheader.row = groupedheader.row, 
			span.columns = span.columns,
			columns.bg.colors = columns.bg.colors,
			columns.font.colors = columns.font.colors,
			row.names = row.names)
	
	if( !missing(header.labels) ){
		args$header.labels = header.labels
	}
	if( missing( col.types ) ){
		args$col.types = getDefaultColTypes( data )
	} else args$col.types = col.types
	
	ft = do.call( getOldTable, args )
	
	if( missing( bookmark ) )
		doc = addFlexTable( doc, flextable = ft, par.properties = par.properties )
	else doc = addFlexTable( doc, flextable = ft, bookmark = bookmark, par.properties = par.properties )
	doc
}

