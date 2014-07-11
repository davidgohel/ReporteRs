#' @title Insert a date into a document object
#'
#' @description Insert a date into a document object
#' 
#' @param doc document object
#' @param ... further arguments passed to other methods 
#' @return a document object
#' @details 
#' addDate only works for pptx documents. See \code{\link{addSlide.pptx}}. 
#' 
#' See \code{\link{addSlide.pptx}} for examples.
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
#' FlexTable can be manipulated so that almost any formatting can be specified. See
#' \code{\link{FlexTable}} for more details.
#' @param doc document object
#' @param flextable the \code{FlexTable} object
#' @param ... further arguments passed to other methods 
#' @details 
#' See \code{\link{addFlexTable.docx}} or \code{\link{addFlexTable.pptx}}
#' or \code{\link{addFlexTable.html}} for examples.
#' @return a document object
#' @export
#' @seealso \code{\link{FlexTable}}, \code{\link{addFlexTable.docx}}
#' , \code{\link{addFlexTable.pptx}}, \code{\link{addFlexTable.html}}
#' , \code{\link{addTable}}
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
#' addFooter only works for pptx documents. See \code{\link{addFooter.pptx}} for examples.
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
#' @details 
#' See \code{\link{addImage.docx}} or \code{\link{addImage.pptx}}
#' or \code{\link{addImage.html}} for examples.
#' @export
#' @seealso \code{\link{docx}}, \code{\link{addImage.docx}}
#' , \code{\link{pptx}}, \code{\link{addImage.pptx}}
#' , \code{\link{html}}, \code{\link{addImage.html}}
addImage = function(doc, filename, ...){
	checkHasSlide(doc)
	if( !inherits( filename, "character" ) )
		stop("filename must be a single character value")
	if( length( filename ) != 1 )
		stop("filename must be a single character value")		
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
#' @details 
#' \code{addPage} only works with html documents. See \code{\link{addPage.html}} for examples.
#' @export
#' @seealso \code{\link{html}}, \code{\link{addPage.html}}
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
#' @details 
#' \code{addPageBreak} only works with docx documents. 
#' 
#' See \code{\link{addPageBreak.docx}} for examples. 
#' @export
#' @seealso \code{\link{docx}}, \code{\link{addPageBreak.docx}}
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
#' \code{addPageNumber} only works with pptx documents.
#' 
#' See \code{\link{addPageNumber.pptx}} for examples.
#' @export
#' @seealso \code{\link{pptx}}, \code{\link{addPageNumber.pptx}}
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
#' @export
#' @details 
#' See \code{\link{addParagraph.docx}} or \code{\link{addParagraph.pptx}}
#' or \code{\link{addParagraph.html}} for examples.
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
#' \code{print} function. 
#' 
#' \code{vector.graphic}: if document is a pptx or html document, 
#' vector graphics will always be displayed.Don't use vector 
#' graphics if document is a docx and MS Word version used 
#' to open the document is 2007.
#' 
#' See \code{\link{addPlot.docx}} or \code{\link{addPlot.pptx}}
#' or \code{\link{addPlot.html}} for examples.
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
#' @details 
#' \code{addSlide} only works with pptx documents. See \code{\link{addSlide.pptx}} for examples.
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
#' @details 
#' \code{addSubtitle} only works with pptx documents. See \code{\link{addSubtitle.pptx}} for examples.
#' @export
#' @seealso \code{\link{pptx}}, \code{\link{addSubtitle.pptx}}
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
#' @param comment.properties comment txtProperties object
#' @param roxygencomment.properties roxygencomment txtProperties object
#' @param operators.properties operators txtProperties object
#' @param keyword.properties keyword txtProperties object
#' @param string.properties string txtProperties object
#' @param number.properties number txtProperties object
#' @param functioncall.properties functioncall txtProperties object
#' @param argument.properties argument txtProperties object
#' @param package.properties package txtProperties object
#' @param formalargs.properties formalargs txtProperties object
#' @param eqformalargs.properties eqformalargs txtProperties object
#' @param assignement.properties assignement txtProperties object
#' @param symbol.properties symbol txtProperties object
#' @param slot.properties slot txtProperties object
#' @param default.properties default txtProperties object
#' @param ... further arguments passed to other methods 
#' @return a document object
#' @export
#' @seealso \code{\link{addRScript.html}}, \code{\link{addRScript.docx}}
#' , \code{\link{addRScript.pptx}}
addRScript = function(doc, file, text
	, comment.properties = textProperties( color = "#A7947D" )
	, roxygencomment.properties = textProperties( color = "#5FB0B8" )
	, symbol.properties = textProperties( color = "black" )
	, operators.properties = textProperties( color = "black" )
	, keyword.properties = textProperties( color = "#4A444D" )
	, string.properties = textProperties( color = "#008B8B", font.style = "italic" )
	, number.properties = textProperties( color = "blue" )
	, functioncall.properties = textProperties( color = "blue" )
	, argument.properties = textProperties( color = "#F25774" )
	, package.properties = textProperties( color = "green" )
	, formalargs.properties = textProperties( color = "#424242" )
	, eqformalargs.properties = textProperties( color = "#424242" )
	, assignement.properties = textProperties( color = "black" )
	, slot.properties = textProperties( color = "#F25774" )
	, default.properties = textProperties( color = "black" )
  , ...
){
	
	if( !inherits(comment.properties, "textProperties") )
		stop("argument comment.properties must be a textProperties object.")
	
	if( !inherits(roxygencomment.properties, "textProperties") )
		stop("argument roxygencomment.properties must be a textProperties object.")
	
	if( !inherits(operators.properties, "textProperties") )
		stop("argument operators.properties must be a textProperties object.")
	
	if( !inherits(keyword.properties, "textProperties") )
		stop("argument keyword.properties must be a textProperties object.")
	
	if( !inherits(string.properties, "textProperties") )
		stop("argument string.properties must be a textProperties object.")
	
	if( !inherits(number.properties, "textProperties") )
		stop("argument number.properties must be a textProperties object.")
	
	if( !inherits(functioncall.properties, "textProperties") )
		stop("argument functioncall.properties must be a textProperties object.")
	
	if( !inherits(argument.properties, "textProperties") )
		stop("argument argument.properties must be a textProperties object.")
	
	if( !inherits(package.properties, "textProperties") )
		stop("argument package.properties must be a textProperties object.")
	
	if( !inherits(formalargs.properties, "textProperties") )
		stop("argument formalargs.properties must be a textProperties object.")
	
	if( !inherits(eqformalargs.properties, "textProperties") )
		stop("argument eqformalargs.properties must be a textProperties object.")
	
	if( !inherits(assignement.properties, "textProperties") )
		stop("argument assignement.properties must be a textProperties object.")
	
	if( !inherits(symbol.properties, "textProperties") )
		stop("argument symbol.properties must be a textProperties object.")
	
	if( !inherits(slot.properties, "textProperties") )
		stop("argument slot.properties must be a textProperties object.")
	
	if( !inherits(default.properties, "textProperties") )
		stop("argument default.properties must be a textProperties object.")
	
	if( missing( file ) && missing( text ) )
		stop("file OR text must be provided as argument.")
	
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
#' @param col.types a character whose elements define the formatting style 
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
#'
#' 
#' See \code{\link{addTable.docx}} or \code{\link{addTable.pptx}}
#' or \code{\link{addTable.html}} for examples.
#' @return a document object
#' @export
#' @seealso \code{\link{docx}}, \code{\link{addTable.docx}}, \code{\link{addFlexTable.docx}}
#' , \code{\link{pptx}}, \code{\link{addTable.pptx}}, \code{\link{addFlexTable.pptx}}
#' , \code{\link{html}}, \code{\link{addTable.html}}, \code{\link{addFlexTable.html}}
#' , \code{\link{FlexTable}}
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
#' @details 
#' See \code{\link{addTitle.docx}} or \code{\link{addTitle.pptx}}
#' or \code{\link{addTitle.html}} for examples.
#' @export
#' @seealso \code{\link{docx}}, \code{\link{addTitle.docx}}, \code{\link{pptx}}
#' , \code{\link{addTitle.pptx}}, \code{\link{html}}, \code{\link{addTitle.html}}
addTitle = function(doc, value, ...){
	checkHasSlide(doc)
	
	if( missing( value ) ) stop("value is missing.")
	if( !is.character( value ) )
		stop("value must be a character vector of length 1.")
	if( length( value ) != 1 )
		stop("value must be a character vector of length 1.")
	
	UseMethod("addTitle")
}

#' @title Set TOC options for a document object
#'
#' @description Set custom table of contents options for a document object
#' 
#' @param doc document object
#' @param ... further arguments passed to other methods 
#' @return a document object
#' @details 
#' \code{toc.options} only works with docx documents. 
#' 
#' See \code{\link{toc.options.docx}} for examples. 
#' @export
#' @seealso \code{\link{docx}}, \code{\link{addTOC.docx}}
toc.options = function(doc, ...){
	UseMethod("toc.options")
}

#' @title Add a table of contents into a document object
#'
#' @description Add a table of contents into a document object
#' 
#' @param doc document object
#' @param ... further arguments passed to other methods 
#' @return a document object
#' @details 
#' \code{addTOC} only works with docx documents. 
#' 
#' See \code{\link{addTOC.docx}} for examples. 
#' @export
#' @seealso \code{\link{docx}}, \code{\link{addTOC.docx}}, \code{\link{styles.docx}}
addTOC = function(doc, ...){
	UseMethod("addTOC")
}

#' @title Change a formatting properties object
#'
#' @description Change a formatting properties object
#' 
#' @param object formatting properties object
#' @param ... further arguments passed to other methods 
#' @return a formatting properties object
#' @details 
#' See \code{\link{chprop.textProperties}} or \code{\link{chprop.parProperties}}
#' or \code{\link{chprop.cellProperties}} for examples.
#' @export
#' @seealso \code{\link{cellProperties}}, \code{\link{textProperties}}
#' , \code{\link{parProperties}}
chprop = function( object, ... ){
	UseMethod("chprop")
}

#' @title get HTML code
#'
#' @description Get HTML code in a character vector.
#' 
#' @param object object to get HTML from
#' @param ... further arguments passed to other methods 
#' @return a character value
#' @details 
#' See \code{\link{FlexTable}} or \code{\link{raphael.html}} for examples.
#' @export
#' @seealso \code{\link{FlexTable}}, \code{\link{raphael.html}}
as.html = function( object, ... ){
	UseMethod("as.html")
}

#' @title Set manually headers'styles of a document object
#'
#' @description Set manually titles'styles of a document object
#' 
#' @param doc document object
#' @param ... further arguments passed to other methods 
#' @return a document object
#' @details 
#' \code{declareTitlesStyles} only works with docx documents. 
#' 
#' See \code{\link{declareTitlesStyles.docx}} for examples. 
#' @export
#' @seealso \code{\link{docx}}, \code{\link{styles.docx}}
#' , \code{\link{declareTitlesStyles.docx}}, \code{\link{addTOC.docx}}
declareTitlesStyles = function(doc, ...){
	UseMethod("declareTitlesStyles")
}

#' @title Get layout names of a document object 
#'
#' @description Get layout names that exist into a document
#' 
#' @param doc document object
#' @param ... further arguments passed to other methods 
#' @details 
#' \code{slide.layouts} only works with pptx documents. See \code{\link{slide.layouts.pptx}} for examples.
#' @export
#' @seealso \code{\link{pptx}}, \code{\link{slide.layouts.pptx}}, \code{\link{addSlide.pptx}}
slide.layouts = function(doc, ...){
	UseMethod("slide.layouts")
}

#' @title Get styles names of a document object 
#'
#' @description Get styles names that exist into a document
#' 
#' @param doc document object
#' @param ... further arguments passed to other methods 
#' @details 
#' \code{styles} only works with docx documents. 
#' 
#' See \code{\link{styles.docx}} for examples. 
#' @export
#' @seealso \code{\link{docx}}, \code{\link{styles.docx}}, \code{\link{addParagraph.docx}}
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
#' @details 
#' See \code{\link{writeDoc.docx}} or \code{\link{writeDoc.pptx}}
#' or \code{\link{writeDoc.html}} for examples.
#' @export
#' @seealso \code{\link{docx}}, \code{\link{writeDoc.docx}}
#' , \code{\link{pptx}}, \code{\link{writeDoc.pptx}}
#' , \code{\link{html}}, \code{\link{writeDoc.html}}
writeDoc = function(doc, ...){
	UseMethod("writeDoc")
}
