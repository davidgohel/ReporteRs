#' @export
getShinyTable = function(data, layout.properties
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
		rJava::.jcall( obj , "V", "setMergeInstructions", j, .jarray( as.integer( unlist( instructions ) ) ) )
	}
	rJava::.jcall( obj , "S", "getHTML" )
	
	
}

