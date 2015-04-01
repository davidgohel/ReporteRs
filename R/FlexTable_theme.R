#' @title get a simple FlexTable from a dataset
#'
#' @description
#' get a simple FlexTable from a dataset
#' 
#' @param dataset the data to use
#' @param add.rownames logical value - should the row.names be included in the table. 
#' @param text.direction header cell text rotation - a single character value, expected 
#' value is one of "lrtb", "tbrl", "btlr".
#' @export
#' @examples
#' vanilla.table( iris)
#' @seealso \code{\link{FlexTable}}
vanilla.table = function( dataset, add.rownames = FALSE, text.direction = "lrtb" ){
	for(j in names( dataset ) ){
		if( is.numeric( dataset[, j] ) )
			dataset[, j] = format(dataset[, j] )
	}
	
	ft = FlexTable( dataset, add.rownames = add.rownames, 
			header.cell.props = cellProperties(text.direction=text.direction) )
	
	ft[,,to="header"] = textBold()
	ft[,,to="header"] = parRight(padding.left = 4, padding.right = 4)
	ft[,,to="body"] = textNormal()
	ft[,,to="body"] = parRight(padding.left = 4, padding.right = 4)
	
	ft = setFlexTableBorders( ft
			, inner.vertical = borderProperties( width=0 )
			, inner.horizontal = borderProperties( width=0 )
			, outer.vertical = borderProperties( width = 0 )
			, outer.horizontal = borderProperties( width = 2 )
	)
	ft
}

#' @title get a simple FlexTable from a dataset
#'
#' @description
#' get a simple FlexTable from a dataset
#' 
#' @param dataset the data to use
#' @param add.rownames logical value - should the row.names be included in the table. 
#' @param text.direction header cell text rotation - a single character value, expected 
#' value is one of "lrtb", "tbrl", "btlr".
#' @export
#' @examples
#' light.table( iris)
#' @seealso \code{\link{FlexTable}}
light.table = function( dataset, add.rownames = FALSE, text.direction = "lrtb" ){
	for(j in names( dataset ) ){
		dataset[, j] = format( dataset[, j] )
	}
	
	ft = FlexTable( dataset, add.rownames = add.rownames, 
			header.cell.props = cellProperties(text.direction=text.direction) )
	
	ft[,,to="header"] = textBold()
	ft[,,to="header"] = parRight()
	ft[,,to="body"] = textNormal()
	ft[,,to="body"] = parRight()
	
	ft = setFlexTableBorders( ft
			, inner.vertical = borderProperties( width = 1 )
			, inner.horizontal = borderProperties( width = 1 )
			, outer.vertical = borderProperties( width = 2 )
			, outer.horizontal = borderProperties( width = 2 )
	)
	ft
}


