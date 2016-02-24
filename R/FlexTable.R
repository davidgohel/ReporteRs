#' @title FlexTable creation
#'
#' @description Create an object of class \code{FlexTable}.
#'
#' FlexTable can be manipulated so that almost any formatting can be specified.
#'
#' An API is available to let you manipulate (format, add text, merge cells, etc.)
#' your FlexTable. A FlexTable is made of 3 parts: header, body and footer. To insert
#' headers and footers rows with eventually merged cells, see
#' \code{\link{addHeaderRow}} and \code{\link{addFooterRow}}.
#'
#' Formating can be done on cells, paragraphs and text (borders, colors, fonts, etc.)
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
#' @param body.text.props default text formatting properties for table body
#' @param header.cell.props default cells formatting properties for table headers
#' @param header.par.props default paragraphs formatting properties for table headers
#' @param header.text.props default text formatting properties for table headers
#' @details
#'
#' The classical workflow would be to create a FlexTable, to add headers rows
#' (see \code{\link{addHeaderRow}}) and eventually footers
#' rows (see \code{\link{addFooterRow}}).
#'
#'
#' A FlexTable lets you add text in cells and modify cells, paragraphs and text
#' properties. Text can be added with operator \code{[<-}.
#' Text, paragraphs and cells properties can be also modified with operator \code{[<-}.
#' (see \code{\link{alterFlexTable}}).
#'
#'
#' Below list of functions to use with \code{FlexTable} objects:
#'
#'
#' \strong{Text formatting}
#'
#' Apply a \code{\link{textProperties}} object to a subset of the
#' FlexTable. Use the operator \code{[<-}. The \code{textProperties}
#' object will be used to format all text from selected cells. See
#' \code{\link{alterFlexTable}}.
#'
#' \strong{Text adding}
#'
#' Add text with operator \code{[<-}. Text can be added just after
#' the last text in the cell or as a new paragraph. Format can also
#' be specified. Text can also be a \code{\link{pot}} object if the
#' text format is complex.
#'
#' \strong{Paragraph formatting}
#'
#' Apply a \code{\link{parProperties}} object to a subset of the
#' FlexTable. Use the operator \code{[<-}. The \code{parProperties}
#' object will be used to format all paragraphs from selected cells. See
#' \code{\link{alterFlexTable}}.
#'
#' \strong{Cell formatting}
#'
#' Apply a \code{\link{cellProperties}} object to a subset of the
#' FlexTable. Use the operator \code{[<-}. The \code{cellProperties}
#' object will be used to format selected cells. See \code{\link{alterFlexTable}}.
#'
#' \strong{Borders}
#'
#' Apply borders scheme to a FlexTable with function \code{\link{setFlexTableBorders}}.
#'
#' Set a border to a selection in a FlexTable with the operator \code{[<-} and an object
#' of class \code{\link{borderProperties}}. Don't forget to specify argument \code{side}.
#' See \code{\link{alterFlexTable}}.
#'
#'
#' \strong{Cell background colors}
#'
#' Applies background colors to cells. See \code{\link{setFlexTableBackgroundColors}}.
#'
#' Alternate row colors (zebra striping) with function \code{\link{setZebraStyle}}.
#'
#' Applies background colors to rows with function \code{\link{setRowsColors}}.
#'
#' Applies background colors to columns with function \code{\link{setColumnsColors}}.
#'
#'
#' \strong{Cell merge}
#'
#' Span rows within columns with function \code{\link{spanFlexTableRows}}.
#'
#' Span columns within rows with function \code{\link{spanFlexTableColumns}}.
#'
#' \strong{Columns widths}
#'
#' Set columns widths with function \code{\link{setFlexTableWidths}}.
#'
#' @export
#' @examples
#' #
#' @example examples/FlexTableExample.R
#' @example examples/agg.mtcars.FlexTable.R
#' @example examples/setFlexTableBackgroundColors.R
#' @example examples/FlexTableAPIFullDemo.R
#' @seealso \code{\link{addHeaderRow}}, \code{\link{addFooterRow}}, \code{\link{setFlexTableWidths}}
#' , \code{\link{alterFlexTable}}, \code{\link{setFlexTableBorders}}
#' , \code{\link{spanFlexTableRows}}, \code{\link{spanFlexTableColumns}}
#' , \code{\link{setRowsColors}}, \code{\link{setColumnsColors}}, \code{\link{setZebraStyle}}
#' , \code{\link{setFlexTableBackgroundColors}}, \code{\link{pot}}
#' , \code{\link{addFlexTable.docx}}
#' , \code{\link{addFlexTable.pptx}}, \code{\link{addFlexTable.bsdoc}}
FlexTable = function(data, numrow, numcol
	, header.columns = TRUE, add.rownames = FALSE
	, body.cell.props = cellProperties()
	, body.par.props = parProperties(padding=0)
	, body.text.props = textProperties()
	, header.cell.props = cellProperties()
	, header.par.props = parProperties(padding=0)
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
		data = lapply( data, function(x) {
				if( is.character( x) ) x
				else if( is.factor( x ) ) as.character( x )
				else if( is.logical( x ) ) ifelse( x, "TRUE", "FALSE" )
				else if( is.integer( x ) ) as.character( x )
				else format(x)
			} )
		data = as.matrix( as.data.frame( data ) )
	} else {
		.row_names = rep(NA, numrow )
		.colnames = rep(NA, numcol )
		data = matrix("", nrow = numrow, ncol = numcol )
	}
	data[is.na(data)] = ""

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

	class( out ) = "FlexTable"

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

#' @export
length.FlexTable = function(x) {
	return(x$numrow)
}

#' @title Print FlexTables
#'
#' @description print a \code{\link{FlexTable}} object.
#' If R session is interactive, the FlexTable is
#' rendered in an HTML page and loaded into a WWW browser.
#'
#' @param x a \code{\link{FlexTable}} object
#' @param ... further arguments, not used.
#' @export
print.FlexTable = function(x, ...){

	if( is.jnull(x$jobj ) ) cat("java object is null. Object need to be rebuild.\n")

	if (!interactive() ){
		cat("FlexTable object with", x$numrow, "row(s) and", x$numcol, "column(s).\n")
	} else {
		viewer <- getOption("viewer")
		path = file.path(tempfile(), "temp_FlexTable.html" )
		doc = bsdoc( )
		doc = addFlexTable( doc, x )
		writeDoc( doc, path, reset.dir = TRUE)
		if( !is.null( viewer ) && is.function( viewer ) ){
			viewer( path )
		} else {
			utils::browseURL(path)
		}
	}

	invisible()

}


#' @importFrom knitr knit_print
#' @importFrom knitr asis_output
#' @title FlexTable custom printing function for knitr
#'
#' @description FlexTable custom printing function for knitr
#'
#' @param x a \code{FlexTable} to be printed
#' @param ... further arguments, not used.
#' @export
knit_print.FlexTable<- function(x, ...){
  asis_output(as.html(x))
}

