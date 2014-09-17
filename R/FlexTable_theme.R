#' @title get a simple FlexTable from a dataset
#'
#' @description
#' get a simple FlexTable from a dataset
#' 
#' @export
#' @examples
#' vanilla.table( iris)
#' @seealso \code{\link{FlexTable}}
vanilla.table = function( dataset, double.format = "%0.3f" ){
	for(j in names( dataset ) ){
		if( is.numeric( dataset[, j] ) )
			dataset[, j] = sprintf(double.format, dataset[, j] )
	}
	
	ft = FlexTable( dataset, add.rownames = TRUE )
	
	ft[,,to="header"] = textBold()
	ft[,,to="header"] = parRight()
	ft[,,to="body"] = textNormal()
	ft[,,to="body"] = parRight()
	
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
#' @export
#' @examples
#' light.table( iris)
#' @seealso \code{\link{FlexTable}}
light.table = function( dataset, double.format = "%0.3f" ){
	for(j in names( dataset ) ){
		if( is.numeric( dataset[, j] ) )
			dataset[, j] = sprintf(double.format, dataset[, j] )
	}
	
	ft = FlexTable( dataset, add.rownames = TRUE )
	
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


