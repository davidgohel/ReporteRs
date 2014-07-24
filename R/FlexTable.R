#' @title FlexTable creation
#'
#' @description Create an object of class \code{FlexTable}.
#' 
#' FlexTable can be manipulated so that almost any formatting can be specified.
#' It allows to insert headers and footers rows with eventually merged cells 
#' (see \code{\link{addHeaderRow}} and \code{\link{addFooterRow}}).
#' 
#' Formating can be done on cells, paragraphs and texts (borders, colors, fonts, etc.)
#' , see \code{\link{alterFlexTable}}.
#' @param data (a \code{data.frame} or \code{matrix} object) to add
#' @param numrow number of row in the table body. Mandatory if data is missing. 
#' @param numcol number of col in the table body. Mandatory if data is missing. 
#' @param header.columns logical value - should the colnames be included in the table 
#' as table headers. If FALSE, no headers will be printed unless you 
#' use \code{\link{addHeaderRow}}. 
#' @param add.rownames logical value - should the row.names be included in the table. 
#' @param body.cell.props default cells formatting properties for table body
#' @param body.par.props default paragraphs formatting properties for table body
#' @param body.text.props default texts formatting properties for table body
#' @param header.cell.props default cells formatting properties for table headers
#' @param header.par.props default paragraphs formatting properties for table headers
#' @param header.text.props default texts formatting properties for table headers
#' @note The classical workflow would be to create a FlexTable, to add headers rows 
#' (see \code{\link{addHeaderRow}}) and eventually footers 
#' rows (see \code{\link{addFooterRow}}).
#' 
#' Additionnal texts can be added with subscript syntax (see \code{\link{alterFlexTable}}).
#' 
#' Texts, paragraphs and cells properties can be modified with subscript syntax 
#' (see \code{\link{alterFlexTable}}).
#' 
#' Cells background colors can also be modified with functions \code{\link{setRowsColors}}
#' , \code{\link{setColumnsColors}} and \code{\link{setZebraStyle}}.
#' 
#' Merging cells can be done with functions \code{\link{spanFlexTableRows}} and \code{\link{spanFlexTableColumns}}.
#' @export
#' @examples
#' #START_TAG_TEST
#' @example examples/FlexTableExample.R
#' @example examples/agg.mtcars.FlexTable.R
#' @example examples/agg.mtcars.FlexTable.R
#' @example examples/FlexTableAPIFullDemo.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{addHeaderRow}}, \code{\link{addFooterRow}}, \code{\link{setFlexTableWidths}}
#' , \code{\link{alterFlexTable}}, \code{\link{setFlexTableBorders}}
#' , \code{\link{spanFlexTableRows}}, \code{\link{spanFlexTableColumns}}
#' , \code{\link{setRowsColors}}, \code{\link{setColumnsColors}}, \code{\link{setZebraStyle}}
#' , \code{\link{addFlexTable}}, \code{\link{addFlexTable.docx}}
#' , \code{\link{addFlexTable.pptx}}, \code{\link{addFlexTable.html}}
FlexTable = function(data, numrow, numcol
	, header.columns = TRUE, add.rownames = FALSE
	, body.cell.props = cellProperties()
	, body.par.props = parProperties()
	, body.text.props = textProperties()
	, header.cell.props = cellProperties()
	, header.par.props = parProperties()
	, header.text.props = textProperties( font.weight= "bold" )
){
	miss_data = missing( data )
	if( !inherits(body.text.props, "textProperties") )
		stop("argument body.text.props must be a textProperties object.")
	if( !inherits(body.par.props, "parProperties") )
		stop("argument body.text.props must be a textProperties object.")
	if( !inherits(body.cell.props, "cellProperties") )
		stop("argument body.cell.props must be a cellProperties object.")

	if( miss_data && ( missing( numrow ) || missing( numcol ) ) ) {
		stop("numrow and numcol must be defined if no data is provided.")
	} else if( !miss_data && (!missing( numrow ) || !missing( numcol ) ) ) {
		warning("numrow and numcol arguments redefined with data dimensions.")
	}
	
	if( !miss_data ){
		# check data is a data.frame
		if( !is.data.frame( data ) && !is.matrix( data ) && !is.table( data ) )
			stop("data is not a data.frame nor a matrix.")
		
		if( is.table( data ) ) {
			if( length( dim( data ) ) > 2 )
				stop("data dimensions cannot be > 2.")
			else if( length( dim( data ) ) < 2 ){
				data = matrix( unclass( data )
					, dimnames = list( names( data ), "" )
			  		, nrow = dim( data )
			        )
			}
			else {
			  data = matrix( unclass( data )
			    , dimnames = dimnames( data )
				, nrow = dim( data )[1]
                )
		  }
		}
		if( !is.data.frame( data ) ) 
			data = as.data.frame( data )
		
		numrow = nrow( data )
		numcol = ncol( data )
		
		if( numrow < 1 )
			stop("data has 0 row.")
		
		.row_names = row.names(data)
		
		if( add.rownames ){
			.colnames = c( "", dimnames( data )[[2]] )
			numcol = numcol + 1
			data = cbind(rownames = .row_names, data )
		} else {
			.colnames = dimnames( data )[[2]]
		}
		
		row.names( data ) = NULL
		data = apply( data, 2, function(x) {
				if( is.character( x) ) x
				else if( is.factor( x ) ) as.character( x )
				else if( is.logical( x ) ) ifelse( x, "TRUE", "FALSE" )
				else format(x)
			} )
	} else {
		.row_names = rep(NA, numrow )
		.colnames = rep(NA, numcol )
		data = matrix("", nrow = numrow, ncol = numcol )
	}

	
	out = list(
		numcol = numcol
		, numrow = numrow
		, add.rownames = add.rownames
		, row_id = .row_names
		, col_id = .colnames
		, colspan = matrix(1, nrow = numrow, ncol = numcol )
		, rowspan = matrix(1, nrow = numrow, ncol = numcol )
	)
		
	jFlexTable = .jnew( class.FlexTable
		, as.integer( out$numrow ), as.integer( out$numcol )
		, .jTextProperties(body.text.props)
		, .jParProperties(body.par.props)
		, .jCellProperties(body.cell.props)
		)

	out$jobj = jFlexTable

	out$body.cell.props = body.cell.props
	out$body.par.props = body.par.props
	out$body.text.props = body.text.props
	out$header.cell.props = header.cell.props
	out$header.par.props = header.par.props
	out$header.text.props = header.text.props
	
	class( out ) = c("FlexTable", "FlexElement")

	if( !miss_data && header.columns ){
		headerRow = FlexRow(values = .colnames, text.properties = header.text.props, par.properties = header.par.props, cell.properties = header.cell.props )
		out = addHeaderRow( out, headerRow )
	}
	
	if( !miss_data ){
		addFlexCellContent (out, seq_len(out$numrow), seq_len(out$numcol)
				, value = data
				, textProperties = body.text.props
				, newpar = F
				, byrow = FALSE 
		)
	}
	
	out
}

#' @method length FlexTable
#' @S3method length FlexTable
length.FlexTable = function(x) {
	return(x$numrow)
}

#' @method print FlexTable
#' @S3method print FlexTable
print.FlexTable = function(x, ...){
	
	cat("FlexTable object with", x$numrow, "row(s) and", x$numcol, "column(s).\n")
	cat("Row ids:", paste( head( x$row_id ), collapse = ", " ), " ... \n" )
	cat("Col ids:", paste( head( x$col_id ), collapse = ", " ), " ... \n" )
	
	if( is.jnull(x$jobj ) ) cat("java object is null. Object need to be rebuild.\n")
	
	invisible()
}

#' @method str FlexTable
#' @S3method str FlexTable
str.FlexTable = function(object, ...){
	
	print( object )
	
	invisible()
}

