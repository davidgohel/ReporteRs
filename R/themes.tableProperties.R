#' @title get default tableProperties 
#'
#' @description
#' default tableProperties object
#' 
#' @export
#' @examples
#' get.default.tableProperties()
#' @seealso \code{\link{addTable}}
#' , \code{\link{get.light.tableProperties}}
#' , \code{\link{get.greenheader.tableProperties}}
#' , \code{\link{get.darker.tableProperties}}
get.default.tableProperties = function(){
	
	
	header.cellProperties = cellProperties( border.width = 1, background.color = "#e8eaeb" )
	header.textProperties = textProperties( font.size = 12, font.weight = "bold" )
	
	data.cellProperties = cellProperties( border.width = 1, background.color = "#ffffff" )
	data.textProperties = textProperties( font.size = 12 )
	
	global_parProperties = parProperties( padding = 3, text.align = "left" )
	
	
	my.formats = tableProperties( 
			groupedheader.cell = header.cellProperties
			, groupedheader.par = global_parProperties
			, groupedheader.text = header.textProperties
			, header.cell = header.cellProperties
			, header.par = global_parProperties
			, header.text = header.textProperties
			, data.cell = data.cellProperties
			, data.text = data.textProperties
			, double.par = global_parProperties
			, integer.par = global_parProperties
			, character.par = global_parProperties
			, percent.par = global_parProperties
			, date.par = global_parProperties 
			, datetime.par = global_parProperties 
	)
	
	
	my.formats
}


#' @title get a 'lighter' tableProperties 
#'
#' @description
#' light tableProperties object
#' 
#' @export
#' @examples
#' get.light.tableProperties()
#' @seealso \code{\link{addTable}}
#' , \code{\link{get.default.tableProperties}}
#' , \code{\link{get.greenheader.tableProperties}}
#' , \code{\link{get.darker.tableProperties}}
get.light.tableProperties = function(){
	
	tableProperties( header.text = textProperties( color = "#102E37", font.weight="bold", font.size=12 )
			, header.par = parProperties( text.align = "right", padding.bottom=2, padding.top=2, padding.right=0, padding.left=10 )
			, header.cell = cellProperties(border.bottom.color="#102E37", border.top.width=0, border.left.width=0, border.right.width=0)
			, data.par = parProperties( text.align = "right", padding.bottom=1, padding.top=1, padding.right=0, padding.left=10  )
			, data.cell = cellProperties( border.width=0)
			, data.text = textProperties( color = "#102E37", font.size=11)
			, percent.addsymbol= "%" , fraction.double.digit=3, fraction.percent.digit=2
	)
}

#' @title get a green header tableProperties 
#'
#' @description
#' green header tableProperties object
#' 
#' @export
#' @examples
#' get.greenheader.tableProperties()
#' @seealso \code{\link{addTable}}
#' , \code{\link{get.default.tableProperties}}
#' , \code{\link{get.light.tableProperties}}
#' , \code{\link{get.darker.tableProperties}}
get.greenheader.tableProperties = function(){
	
	tableProperties( header.text = textProperties( color = "#333333", font.weight="bold", font.size=12 )
		, header.par = parProperties( text.align = "right", padding.bottom=2, padding.top=2, padding.right=0, padding.left=10 )
		, header.cell = cellProperties(background.color="#90CA77", border.width=1)
		, data.par = parProperties( text.align = "right", padding.bottom=1, padding.top=1, padding.right=0, padding.left=10  )
		, data.cell = cellProperties( border.width = 1) 
		, character.text = textProperties( font.style="italic", font.size=11) 
		, percent.text = textProperties( color="#003366", font.size=11 ) 
		, double.text = textProperties( font.size=11) 
		, date.text = textProperties( color="#999999", font.size=11) 
		, integer.text = textProperties( font.size=11) 
		, percent.addsymbol= " %" , fraction.double.digit=3, fraction.percent.digit=2
	)
}

#' @title get a darker tableProperties 
#'
#' @description
#' darker tableProperties object
#' 
#' @export
#' @examples
#' get.darker.tableProperties()
#' @seealso \code{\link{addTable}}
#' , \code{\link{get.default.tableProperties}}
#' , \code{\link{get.light.tableProperties}}
#' , \code{\link{get.greenheader.tableProperties}}
get.darker.tableProperties = function(){
	tableProperties( 
		header.text = textProperties( color = "#E8EDE0", font.weight="bold", font.size=12 )
		, header.par = parProperties( text.align = "right", padding.bottom=2, padding.top=2, padding.right=10, padding.left=10 )
		, header.cell = cellProperties(background.color= "#102E37", border.color="#F78D3F")
		, groupedheader.text = textProperties( color = "#E8EDE0", font.weight="bold", font.size=12 )
		, groupedheader.par = parProperties( text.align = "right", padding.bottom=2, padding.top=2, padding.right=10, padding.left=10 )
		, groupedheader.cell = cellProperties(background.color= "#102E37", border.color="#F78D3F")
		, data.par = parProperties( text.align = "right" )
		, data.cell = cellProperties( background.color = "#E8EDE0", border.color="#F78D3F")
		, data.text = textProperties( color = "#102E37", font.size=12)
		, percent.addsymbol= " (%)" , fraction.double.digit=2, fraction.percent.digit=1
	)
}
