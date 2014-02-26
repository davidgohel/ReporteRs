#' @title Table formating properties 
#'
#' @description Create an object that describes table formating properties. 
#' 
#' @details tableProperties is used to control table format when addTable is used. 
#' One can customize headers (or grouped headers) and content. 
#' Headers share all the same format.
#' Content is formated according to its data type (\code{col.types} argument 
#' in \code{\link{addTable}}). "double" columns share all the same format, 
#' "character" columns share all the same format, etc. 
#' Conditionnal formating is not specified in tableProperties but in \code{\link{addTable}}.
#' 
#' @param data.cell cell formatting properties for columns of any type. Overwrites any *.cell (except headers)
#' @param data.par paragraph formatting properties for columns of any type. Overwrites any *.par (except headers)
#' @param data.text text formatting properties for columns of any type. Overwrites any *.text (except headers)
#' @param header.text text formatting properties of column headers
#' @param header.par paragraph formatting properties of column headers
#' @param header.cell cell formatting properties of column headers
#' @param groupedheader.text text formatting properties of groupedheaders
#' @param groupedheader.par paragraph formatting properties of groupedheaders
#' @param groupedheader.cell cell formatting properties of groupedheaders
#' @param double.text text formatting properties of columns of type 'double'
#' @param double.par paragraph formatting properties for columns of type 'double'
#' @param double.cell cell formatting properties for columns of type 'double'
#' @param integer.text text formatting properties for columns of type 'integer'
#' @param integer.par paragraph formatting properties for columns of type 'integer'
#' @param integer.cell cell formatting properties for columns of type 'integer'
#' @param percent.text text formatting properties for columns of type 'percent'
#' @param percent.par paragraph formatting properties for columns of type 'percent'
#' @param percent.cell cell formatting properties for columns of type 'percent'
#' @param character.text text formatting properties for columns of type 'character'
#' @param character.par paragraph formatting properties for columns of type 'character'
#' @param character.cell cell formatting properties for columns of type 'character'
#' @param date.text text formatting properties for columns of type 'date'
#' @param date.par paragraph formatting properties for columns of type 'date'
#' @param date.cell cell formatting properties for columns of type 'date'
#' @param logical.text text formatting properties for columns of type 'logical'
#' @param logical.par paragraph formatting properties for columns of type 'logical'
#' @param logical.cell cell formatting properties for columns of type 'logical'
#' @param datetime.text text formatting properties for columns of type 'datetime'
#' @param datetime.par paragraph formatting properties for columns of type 'datetime'
#' @param datetime.cell cell formatting properties for columns of type 'datetime'
#' @param percent.addsymbol represents the symbol to add after percent data as been formated (character, default to '')
#' @param fraction.double.digit the minimum number of digits to the right of the decimal point in formatting 'double' data. Allowed values are fraction.double.digit >=0.
#' @param fraction.percent.digit the minimum number of digits to the right of the decimal point in formatting 'percent' data. Allowed values are fraction.percent.digit >=0.
#' @param locale.language locale language symbol ("fr, "en", etc.) - default to getOption("ReporteRs-locale.language")
#' @param locale.region locale region symbol ("FR, "US", etc.) - default to getOption("ReporteRs-locale.region")
#' @export
#' @examples
#' # define table properties - set headers aligned on the right, font color 
#' # is gray and font size is 12 points  
#' tableProperties( header.text = textProperties(color="gray", font.size = 12) 
#' 		, header.par = parProperties( text.align = "right" ) 
#' )
#'  
#' @seealso \code{\link{addTable}}
tableProperties = function( 
		header.text = textProperties( font.size = 12, font.weight = "bold" )
		, header.par = parProperties( padding = 3, text.align = "left" )
		, header.cell = cellProperties( border.width = 1, background.color = "#e8eaeb" )
		
		, groupedheader.text = textProperties( font.size = 12, font.weight = "bold" )
		, groupedheader.par = parProperties( padding = 3, text.align = "left" )
		, groupedheader.cell = cellProperties( border.width = 1, background.color = "#e8eaeb" )
		
		, double.text = textProperties(font.size = 12)
		, double.par = parProperties( padding = 3, text.align = "left" )
		, double.cell = cellProperties()
		
		, integer.text = textProperties(font.size = 12)
		, integer.par = parProperties( padding = 3, text.align = "left" )
		, integer.cell = cellProperties()
		
		, percent.text = textProperties(font.size = 12)
		, percent.par = parProperties( padding = 3, text.align = "left" )
		, percent.cell = cellProperties()
		
		, character.text = textProperties(font.size = 12)
		, character.par = parProperties( padding = 3, text.align = "left" )
		, character.cell = cellProperties( )
		
		, date.text = textProperties(font.size = 12, font.style="italic")
		, date.par = parProperties( padding = 3, text.align = "left" )
		, date.cell = cellProperties()
		
		, datetime.text = textProperties(font.size = 12, font.style="italic")
		, datetime.par = parProperties( padding = 3, text.align = "left" )
		, datetime.cell = cellProperties()

		, logical.text = textProperties(font.size = 12, font.style="italic")
		, logical.par = parProperties( padding = 3, text.align = "left" )
		, logical.cell = cellProperties()

		, percent.addsymbol = "%"
		, locale.language = getOption("ReporteRs-locale.language")
		, locale.region = getOption("ReporteRs-locale.region")
		, fraction.double.digit = 4L
		, fraction.percent.digit = 3L
		, data.cell, data.par, data.text
		){
	.Object = list()

	if( !missing( data.cell ) ){
		if( class( data.cell ) == "cellProperties" ) {
			double.cell = integer.cell = percent.cell = character.cell = date.cell = datetime.cell = logical.cell = data.cell
		} else {
			stop("data.cell must be a cellProperties object.")
		}
	}
	if( !missing( data.par ) ){
		if( class( data.par ) == "parProperties" ) {
			double.par = integer.par = percent.par = character.par = date.par = datetime.par = logical.par = data.par
		} else {
			stop("data.par must be a parProperties object.")
		}
	}
	if( !missing( data.text ) ){
		if( class( data.text ) == "textProperties" ) {
			double.text = integer.text = percent.text = character.text = date.text = datetime.text = logical.text = data.text
		} else {
			stop("data.text must be a textProperties object.")
		}
	}
	
	.Object = list()
	.Object$header.text = header.text
	.Object$header.par = header.par
	.Object$header.cell = header.cell
	
	.Object$groupedheader.text = groupedheader.text
	.Object$groupedheader.par = groupedheader.par
	.Object$groupedheader.cell = groupedheader.cell
	
	.Object$double.text = double.text
	.Object$double.par = double.par
	.Object$double.cell = double.cell
	
	.Object$integer.text = integer.text
	.Object$integer.par = integer.par
	.Object$integer.cell = integer.cell
	
	.Object$percent.text = percent.text
	.Object$percent.par = percent.par
	.Object$percent.cell = percent.cell
	
	.Object$character.text = character.text
	.Object$character.par = character.par
	.Object$character.cell = character.cell
	
	.Object$date.text = date.text
	.Object$date.par = date.par
	.Object$date.cell = date.cell
	
	.Object$datetime.text = datetime.text
	.Object$datetime.par = datetime.par
	.Object$datetime.cell = datetime.cell
	
	.Object$logical.text = logical.text
	.Object$logical.par = logical.par
	.Object$logical.cell = logical.cell
	
	.Object$percent.addsymbol = percent.addsymbol
	.Object$fraction.double.digit = as.integer( fraction.double.digit )
	.Object$fraction.percent.digit = as.integer( fraction.percent.digit )
	
	.Object$locale.language = as.character( locale.language )
	.Object$locale.region = as.character( locale.region )
	
	class( .Object ) = "tableProperties"
	.Object
}

#' @method print tableProperties
#' @S3method print tableProperties
print.tableProperties = function (x, ...){
	cat("tableProperties properties{\n")
	
	cat("\theader\n")
	print( x$header.text )
	print( x$header.par )
	print( x$header.cell )
	
	cat("\tgroupedheader\n")
	print( x$groupedheader.text )
	print( x$groupedheader.par )
	print( x$groupedheader.cell )
	
	cat("\tdouble\n")
	print( x$double.text )
	print( x$double.par )
	print( x$double.cell )
	
	cat("\tinteger.text\n")
	print( x$integer.text )
	print( x$integer.par )
	print( x$integer.cell )
	
	cat("\tpercent.text\n")
	print( x$percent.text )
	print( x$percent.par )
	print( x$percent.cell )
	
	cat("\tcharacter.text\n")
	print( x$character.text )
	print( x$character.par )
	print( x$character.cell )
	
	cat("\tdate.text\n")
	print( x$date.text )
	print( x$date.par )
	print( x$date.cell )
	
	cat("\tdatetime.text\n")
	print( x$datetime.text )
	print( x$datetime.par )
	print( x$datetime.cell )

	cat("\tlogical.text\n")
	print( x$logical.text )
	print( x$logical.par )
	print( x$logical.cell )
	
	cat("\tpercent.addsymbol\n")
	print( x$percent.addsymbol )
	
	cat("\tfraction.double.digit\n")
	print( x$fraction.double.digit )
	cat("\tfraction.percent.digit\n")
	print( x$fraction.percent.digit )
	

	cat("\n}\n")
}