#' @title Insert a date into a document object
#'
#' @description Insert a date into a document object
#' 
#' @param doc document object
#' @param ... further arguments passed to other methods 
#' @return a document object
#' @details 
#' addDate only works for pptx slides. See \code{\link{addSlide.pptx}}. 
#' \code{docx} and \code{html} object have no method \code{addDate} implemented.  
#' @export
#' @seealso \code{\link{pptx}}, \code{\link{addSlide.pptx}}
addDate = function(doc, ...){
	checkHasSlide(doc)
	UseMethod("addDate")
}

#' @title Insert a FlexTable into a document object
#'
#' @description Insert a FlexTable into a document object
#' 
#' @param doc document object
#' @param flextable the \code{FlexTable} object
#' @param ... further arguments passed to other methods 
#' @return a document object
#' @export
#' @seealso \code{\link{FlexTable}}
#' @examples
#' \dontrun{
#' data( data_ReporteRs )
#' myFlexTable = FlexTable( data = data_ReporteRs, span.columns="col1"
#' 	, header.columns=TRUE, row.names=FALSE )
#' myFlexTable[ 1:2, 2:3] = textProperties( color="red" )
#' myFlexTable[ 3:4, 4:5] = parProperties( text.align="right" )
#' myFlexTable[ 1:2, 5:6] = cellProperties( background.color="#F2969F")
#' myFlexTable = setFlexCellContent( myFlexTable, 3, 6, pot("Hello"
#' 	, format=textProperties(font.weight="bold") ) + pot("World"
#' 	, format=textProperties(font.weight="bold", vertical.align="superscript") ) )
#' doc = addFlexTable( doc, myFlexTable )
#' }
addFlexTable = function(doc, flextable, ...){
	
	checkHasSlide(doc)
	if( !inherits(flextable, "FlexTable") )
		stop("argument flextable must be a FlexTable object.")
	
	UseMethod("addFlexTable")
}


#' @title Insert a footer into a document object
#'
#' @description Insert a footer into a document object
#' 
#' @param doc document object
#' @param ... further arguments passed to other methods 
#' @return a document object
#' @details 
#' addFooter only works for pptx slides. See \code{\link{addFooter.pptx}}. 
#' \code{docx} and \code{html} object have no method \code{addFooter} implemented.  
#' @export
#' @seealso \code{\link{pptx}}, \code{\link{addSlide.pptx}}
addFooter = function(doc, ...){
	checkHasSlide(doc)
	UseMethod("addFooter")
}


#' @title Add an external image into a document object
#'
#' @description Add an external image into a document object
#' 
#' @param doc document object
#' @param filename \code{"character"} value, complete filename 
#' of the external image
#' @param ... further arguments passed to other methods 
#' @return a document object
#' @export
#' @seealso \code{\link{docx}}, \code{\link{addImage.docx}}
#' , \code{\link{pptx}}, \code{\link{addImage.pptx}}
#' , \code{\link{html}}, \code{\link{addImage.html}}
addImage = function(doc, filename, ...){
	checkHasSlide(doc)
	if( missing( filename ) )
		stop("filename cannot be missing")
	if( !file.exists( filename ) )
		stop( filename, " does not exist")
	
	UseMethod("addImage")
}








#' @title Add a page into a document object
#'
#' @description Add a page into a document object
#' 
#' @param doc document object
#' @param ... further arguments passed to other methods 
#' @return a document object
#' @export
#' @seealso \code{\link{html}}
addPage = function(doc, ...){
	UseMethod("addPage")
}


#' @title Add a page break into a document object
#'
#' @description Add a page break into a document object
#' 
#' @param doc document object
#' @param ... further arguments passed to other methods 
#' @return a document object
#' @export
#' @seealso \code{\link{docx}}
addPageBreak = function(doc, ...){
	checkHasSlide(doc)
	UseMethod("addPageBreak")
}


#' @title Insert a page number into a document object
#'
#' @description Insert a page number into a document object
#' 
#' @param doc document object
#' @param ... further arguments passed to other methods 
#' @return a document object
#' @details 
#' addPageNumber only works for pptx slides. See \code{\link{addPageNumber.pptx}}. 
#' \code{docx} and \code{html} object have no method \code{addPageNumber} implemented.  
#' @export
#' @seealso \code{\link{pptx}}
addPageNumber = function(doc, ...){
	checkHasSlide(doc)
	UseMethod("addPageNumber")
}


#' @title Add a paragraph into a document object
#'
#' @description Add a paragraph into a document object
#' 
#' @details a paragraph is a set of texts that ends with an end of line(\code{'\n'} in C). 
#' Read \code{\link{pot}} to see how to get different font formats.
#' Trying to insert a \code{'\n'} will have no effect. If an end of line is required
#' , a new paragraph is required.
#' @param doc document object
#' @param value character vector containing texts to add OR an object of 
#' class \code{\link{set_of_paragraphs}}.
#' A set_of_paragraphs object is a container for \code{pot} objects.
#' @param ... further arguments passed to other methods 
#' @return a document object
#' @examples
#' \dontrun{
#' # Add "Hello World" into the document doc
#' doc <- addParagraph(doc, "Hello Word!");
#' 
#' # Add into the document : "My tailor is rich" and "Cats and Dogs"
#' # format some of the pieces of text
#' pot1 = pot("My tailor", textProperties(color="red") ) + " is " + pot("rich"
#' 	, textProperties(font.weight="bold") )
#' my.pars = set_of_paragraphs( pot1 )
#' pot2 = pot("Cats", textProperties(color="red") ) + " and " + pot("Dogs"
#' 	, textProperties(color="blue") )
#' my.pars = set_of_paragraphs( pot1, pot2 )
#' doc <- addParagraph(doc, my.pars )
#' }
#' @export
#' @seealso \code{\link{docx}}, \code{\link{addParagraph.docx}}
#' , \code{\link{pptx}}, \code{\link{addParagraph.pptx}}
#' , \code{\link{html}}, \code{\link{addParagraph.html}}

addParagraph = function(doc, value, ...){
	checkHasSlide(doc)
	if( !inherits( value, c("set_of_paragraphs", "character") ) )
		stop("value must be an object of class 'set_of_paragraphs' or a character vector!")
	if( length(value) < 1 ){
		warning("value is empty.")
		return( doc )
	}
	UseMethod("addParagraph")
}


#' @title Add a plot into a document object
#'
#' @description Add a plot into a document object
#' 
#' @param doc document object
#' @param fun plot function
#' @param vector.graphic logical scalar, if TRUE, vector graphics 
#' are produced instead of PNG images. 
#' 
#' SVG will be produced for \code{html} objects
#' and DrawingML instructions for \code{docx} and \code{pptx} objects. 
#' 
#' DrawingML instructions
#' offer advantage to provide editable graphics (forms and texts colors
#' , texts contents, moving and resizing is disabled).
#' @param pointsize the default pointsize of plotted text in pixels, default to 12.
#' @param ... further arguments passed to or from other methods.. 
#' @return a document object
#' @details
#' Plot parameters are specified with the \code{...} argument. 
#' However, the most convenient usage is to wrap the plot code 
#' into a function whose parameters will be specified as '...'.
#'  
#' If you want to add ggplot2 or lattice plot, use 
#' \code{print} function. See examples for more details.
#' \describe{
#'   \item{vector.graphic}{If document is a pptx or html document, 
#' vector graphics will always be displayed.
#' Don't use vector graphics if document is a 
#' docx and MS Word version used to open the document is 2007.
#'		}
#' }
#' @examples 
#' \dontrun{
#' require( ggplot2 )
#' # Add a base plot
#' doc = addPlot( doc = doc, fun = plot
#' 		, x = rnorm( 100 )
#' 		, y = rnorm (100 )
#' 		, main = "base plot main title"
#' 	)
#' 
#' ## Add a ggplot2
#' myplot = qplot(Sepal.Length, Petal.Length, data = iris, color = Species
#' 	, size = Petal.Width, alpha = I(0.7))
#' doc = addPlot( doc = doc
#' 		, fun = print
#' 		, x = myplot #this argument MUST be named, print is expecting argument 'x'
#' 	)
#' 
#' ## Add a ggplot2 and another plot
#' doc = addPlot( doc = doc
#' 		, fun = function(){
#' 			print( qplot(Sepal.Length, Petal.Length, data = iris, color = Species
#' 				, size = Petal.Width, alpha = I(0.7)) )
#' 			plot(x = rnorm( 100 ), y = rnorm (100 ), main = "base plot main title")
#' 		}
#' 	)
#' }
#' @export
#' @seealso \code{\link{docx}}, \code{\link{addPlot.docx}}
#' , \code{\link{pptx}}, \code{\link{addPlot.pptx}}
#' , \code{\link{html}}, \code{\link{addPlot.html}}
addPlot = function(doc, fun, pointsize = 12, vector.graphic = F, ...){
	
	checkHasSlide(doc)
	UseMethod("addPlot")
}

#' @title Add a slide into a document object
#'
#' @description Add a slide into a document object
#' 
#' @param doc document object
#' @param ... further arguments passed to other methods 
#' @return a document object
#' @export
#' @seealso \code{\link{pptx}}, \code{\link{addSlide.pptx}}
addSlide = function(doc, ...){
	UseMethod("addSlide")
}


#' @title Add a subtitle shape into a document object
#'
#' @description Add a subtitle shape into a document object
#' 
#' @param doc document object
#' @param ... further arguments passed to other methods 
#' @return a document object
#' @export
#' @seealso \code{\link{pptx}}
addSubtitle = function(doc, ...){
	checkHasSlide(doc)
	UseMethod("addSubtitle")
}



#' @title Add R script into a document object
#'
#' @description Add R script into a document object
#' 
#' @param doc document object
#' @param file R script file. Not used if text is provided.
#' @param text character vector. The text to parse. Not used if file is provided.
#' @param ... further arguments passed to other methods 
#' @return a document object
#' @export
#' @seealso \code{\link{html}}
addRScript = function(doc, file, text, ...){
	if( missing( file ) && missing( text ) )
		stop("file OR text must be provided as argument.")
	
	if( !missing( file ) ){
		if( length( file ) != 1 ) stop("file must be a single filename.")
		if( !file.exists( file ) ) stop("file does not exist.")
	}
	
	UseMethod("addRScript")
}

#' @title Add a table into a document object
#'
#' @description Add a table into a document object
#' 
#' @param doc document object
#' @param data (a \code{data.frame} or \code{matrix} object) to add
#' @param layout.properties a \code{tableProperties} object to specify 
#' styles to use to format the table. optional
#' @param header.labels a character whose elements define labels to display 
#' in table headers instead of colnames. 
#' Optional, if missing, headers will be filled with \code{data} column names.
#' @param groupedheader.row a named list whose elements define the upper 
#' header row (grouped header). Optional. 
#' Elements of that list are \code{values} and \code{colspan}. 
#' Element \code{values} is a character vector containing labels to display 
#' in the grouped header row. Element \code{colspan} is an integer vector containing 
#' number of columns to span for each \code{values}.
#' @param span.columns a character vector specifying columns names 
#' where row merging should be done (if successive values in a column 
#' are the same ; if data[p,j]==data[p-1,j] )
#' @param col.types a character whose elements define the formating style 
#' of columns via their data roles. Optional
#' Possible values are : \emph{"character"}, \emph{"integer"}, \emph{"logical"}
#' 			, \emph{"double"}, \emph{"percent"}, \emph{"date"}, \emph{"datetime}".
#' If missing, factor and character will be formated as character
#' 			, integer as integer and numeric as double.
#' @param columns.bg.colors A named list of character vector. Define the 
#' background color of cells for a given column. optional.  
#' Names are \code{data} column names and values are character vectors specifying 
#' cells background colors.
#' Each element of the list is a vector of length \code{nrow(data)}.
#' @param row.names logical value - should the row.names be included in the table. 
#' @param columns.font.colors A named list of character vector. Define the font 
#' color of cells per column. optional.
#'		A name list, names are \code{data} column names and values 
#' 			are character vectors specifying cells font colors.
#'		Each element of the list is a vector of length \code{nrow(data)}.
#' @param ... further arguments passed to or from other methods.. 
#' @details
#' The table below shows the display model used to format tables:\cr
#' \preformatted{+--------------+---------------+}
#' \preformatted{GROUPEDHEADER_1|GROUPEDHEADER_2|}
#' \preformatted{+------+-------+-------+-------+}
#' \preformatted{HEADER1|HEADER2|HEADER3|HEADER4|}
#' \preformatted{+------+-------+-------+-------+}
#' \preformatted{ x[1,1]| x[1,2]| x[1,3]|| x[1,4]|}
#' \preformatted{+------+-------+-------+-------+}
#' \preformatted{ x[2,1]| x[2,2]| x[2,3]|| x[2,4]|}
#' \preformatted{+------+-------+-------+-------+}
#' \preformatted{ x[3,1]| x[3,2]| x[3,3]|| x[3,4]|}
#' \preformatted{+------+-------+-------+-------+}
#' @return a document object
#' @examples
#' \dontrun{
#' # add the first 5 lines of iris
#' doc <- addTable( doc, head( iris, n = 5 ) )
#' 
#' # demo span.columns
#' doc <- addTable( doc, iris[ 46:55,], span.columns = "Species" )
#' 
#' data( data_ReporteRs )
#' # add iris and customise some options
#' doc <- addTable( doc
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
#' }
#' @export
#' @seealso \code{\link{docx}}, \code{\link{addTable.docx}}
#' , \code{\link{pptx}}, \code{\link{addTable.pptx}}
#' , \code{\link{html}}, \code{\link{addTable.html}}
addTable = function(doc, data, layout.properties
		, header.labels, groupedheader.row
		, span.columns, col.types
		, columns.bg.colors, columns.font.colors, row.names, ...){

	checkHasSlide(doc)
	known.types = c("character", "double", "integer", "percent", "date", "datetime", "logical")
		
	#### data checking
	if( missing( data ) ) stop("data is missing.")
	
	
	# check data is a data.frame
	if( !is.data.frame( data ) && !is.matrix( data ) )
		stop("data is not a data.frame nor a matrix.")
	# check data is a data.frame
	if( nrow( data )<1)
		stop("data has 0 row.")
	
	if( !missing( layout.properties ) ){
		if( class( layout.properties ) != "tableProperties" ) 
			stop( "layout.properties is not an object from the class 'tableProperties'." )
	} 
	#### check that every colnames has a matching label
	if( !missing( header.labels ) ){
		if( !is.character( header.labels ) )
			stop( "header.labels must be a character vector")

		if( length(header.labels) != ncol(data) ){
			stop( "header.labels length must be equal to the number of columns" ) 
		}
	}
	
	#### check span.first.columns
	if( !missing( span.columns ) ){
		if( !is.character( span.columns ) )
			stop( "span.columns must be a character vector")

		.ie.span.columns = is.element( span.columns , names( data ) )
		if( !all ( .ie.span.columns ) ){
			stop("span.columns contains unknown columns names :", paste( span.columns[!.ie.span.columns], collapse = "," ) )
		}	
	}
	if( !missing( col.types ) ){
		if( !is.character( col.types ) )
			stop("col.types must be a character vector.")
		
		if( length(col.types) != ncol(data) ){
			stop( "col.types length must be the same that the number of columns" ) 
		} else {
			.is.elt.types = is.element( col.types, known.types )
			if( !all( .is.elt.types ) ){
				stop( "col.types does contain invalid types not in (", paste( known.types, collapse = ", " ) ,") : " 
						, paste( names( col.types )[!.is.elt.types], collapse = ", " ), "\n"
				)
			}
		}
	}
	if( !missing( groupedheader.row ) ){
		if( class( groupedheader.row ) != "list"  ) 
			stop("groupedheader.row must be a list.")
		if( length( groupedheader.row ) > 0 ){
			if( !all( is.element( c("values", "colspan"), names( groupedheader.row ) ) ) ){
				stop("groupedheader.row must have 'values' and 'colspan' elements.")
			}
			if( any( groupedheader.row$colspan < 1 ) ){
				stop("Elements of 'groupedheader.row$colspan' must be integers > 0.")
			}
			if( sum( groupedheader.row$colspan ) != ncol( data ) ){
				stop("Sum of 'groupedheader.row$colspan' argument differs from number of columns in data.")
			}
		}
	} 
	
	if( !missing( columns.bg.colors ) ){
		if( class( columns.bg.colors ) != "list"  ) 
			stop("columns.bg.colors must be a list.")
		if( length( columns.bg.colors ) > 0 ){
			.is.elt.columns.bg.colors = is.element( names( columns.bg.colors ), names( data ) )
			
			if( !all( .is.elt.columns.bg.colors ) )
				stop("Some elements of 'columns.bg.colors' does not match with columns of 'data'."
						, paste( names( columns.bg.colors )[!.is.elt.columns.bg.colors], collapse = "," ) )
			
			if( !all( sapply( columns.bg.colors, length ) == nrow( data ) ) )
				stop("Lengths of 'columns.bg.colors' must be equal to nrow(data).")
			
			if( !all( sapply( columns.bg.colors, is.character ) ) )
				stop("'columns.bg.colors' must be a list of character vector describing valid css colors.")
			
		}
	} 
	
	if( !missing( columns.font.colors ) ){
		if( class( columns.font.colors ) != "list"  ) 
			stop("columns.font.colors must be a list.")
		if( length( columns.font.colors ) > 0 ){
			.is.elt.columns.font.colors = is.element( names( columns.font.colors ), names( data ) )
			
			if( !all( .is.elt.columns.font.colors ) )
				stop("Some elements of 'columns.font.colors' does not match with columns of 'data'."
						, paste( names( columns.font.colors )[!.is.elt.columns.font.colors], collapse = "," ) )
			
			if( !all( sapply( columns.font.colors, length ) == nrow( data ) ) )
				stop("Lengths of 'columns.font.colors' must be equal to nrow(data).")
			
			if( !all( sapply( columns.font.colors, is.character ) ) )
				stop("'columns.font.colors' must be a list of character vector describing valid css colors.")
			
		}
	}
	
	UseMethod("addTable")

}



#' @title Add a title into a document object
#'
#' @description Add a title into a document object
#' 
#' @param doc document object
#' @param value \code{"character"} value to use as title text
#' @param ... further arguments passed to or from other methods.. 
#' @return a document object
#' @export
#' @seealso \code{\link{docx}}, \code{\link{addTitle.docx}}, \code{\link{pptx}}
#' , \code{\link{addTitle.pptx}}
addTitle = function(doc, value, ...){
	checkHasSlide(doc)
	UseMethod("addTitle")
}

#' @title Add a table of contents into a document object
#'
#' @description Add a table of contents into a document object
#' 
#' @param doc document object
#' @param ... further arguments passed to other methods 
#' @return a document object
#' @export
#' @seealso \code{\link{docx}}, \code{\link{addTOC.docx}}, \code{\link{styles.docx}}
addTOC = function(doc, ...){
	UseMethod("addTOC")
}

#' @title Set manually headers'styles of a document object
#'
#' @description Set manually titles'styles of a document object
#' 
#' @param doc document object
#' @param ... further arguments passed to other methods 
#' @return a document object
#' @export
#' @seealso \code{\link{docx}}, \code{\link{styles.docx}}, \code{\link{declareTitlesStyles.docx}}
declareTitlesStyles = function(doc, ...){
	UseMethod("declareTitlesStyles")
}

#' @title Get layout names of a document object 
#'
#' @description Get layout names that exist into a document
#' 
#' @param doc document object
#' @param ... further arguments passed to other methods 
#' @export
#' @seealso \code{\link{pptx}}, \code{\link{slide.layouts.pptx}}
slide.layouts = function(doc, ...){
	UseMethod("slide.layouts")
}

#' @title Get styles names of a document object 
#'
#' @description Get styles names that exist into a document
#' 
#' @param doc document object
#' @param ... further arguments passed to other methods 
#' @export
#' @seealso \code{\link{docx}}, \code{\link{styles.docx}}
styles = function(doc, ...){
	UseMethod("styles")
}


#' @title Write a document object
#'
#' @description Write a document object into a file
#' 
#' @param doc document object
#' @param ... further arguments passed to other methods 
#' @return a document object
#' @export
#' @seealso \code{\link{docx}}, \code{\link{pptx}}, \code{\link{writeDoc.pptx}}
writeDoc = function(doc, ...){
	UseMethod("writeDoc")
}
