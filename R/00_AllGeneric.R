#' @title Add a column break into a section
#'
#' @description Add a column break into a section
#' 
#' @param doc document object
#' @param ... further arguments passed to other methods 
#' @return a document object
#' @details 
#' \code{addColumnBreak} only works with docx documents. 
#' 
#' See \code{\link{addColumnBreak.docx}} for examples. 
#' @export
#' @seealso \code{\link{docx}}, \code{\link{addColumnBreak.docx}}
addColumnBreak = function(doc, ...){
	checkHasSlide(doc)
	UseMethod("addColumnBreak")
}



#' @title Insert a date into a document object
#'
#' @description Insert a column break
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


#' @title Add an external document into a document object
#'
#' @description Add an external document into a document object
#' 
#' @param doc document object
#' @param filename \code{"character"} value, complete filename 
#' of the external file
#' @param ... further arguments passed to other methods 
#' @return a document object
#' @export
#' @seealso \code{\link{docx}}, \code{\link{addDocument.docx}}
addDocument = function(doc, filename, ...){
	checkHasSlide(doc)
	if( missing( filename ) )
		stop("filename cannot be missing")
	if( !inherits( filename, "character" ) )
		stop("filename must be a single character value")
	if( length( filename ) != 1 )
		stop("filename must be a single character value")		
	if( !file.exists( filename ) )
		stop( filename, " does not exist")
	
	UseMethod("addDocument")
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
#' or \code{\link{addFlexTable.bsdoc}} for examples.
#' @return a document object
#' @export
#' @seealso \code{\link{FlexTable}}, \code{\link{addFlexTable.docx}}
#' , \code{\link{addFlexTable.pptx}}, \code{\link{addFlexTable.bsdoc}}
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
#' addFooter only works for pptx and bsdoc documents. 
#' @export
#' @seealso \code{\link{pptx}}, \code{\link{addFooter.pptx}}
#' , \code{\link{bsdoc}}, \code{\link{addFooter.bsdoc}}
addFooter = function(doc, ...){
	checkHasSlide(doc)
	UseMethod("addFooter")
}



#' @title Add an iframe into a document object
#'
#' @description Add an iframe into a document object
#' 
#' @param doc document object
#' @param ... further arguments passed to other methods 
#' @return a document object
#' @export
#' @seealso \code{\link{addIframe.bsdoc}}
addIframe = function(doc, ...){
	checkHasSlide(doc)
	UseMethod("addIframe")
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
#' or \code{\link{addImage.bsdoc}} for examples.
#' @export
#' @seealso \code{\link{docx}}, \code{\link{addImage.docx}}
#' , \code{\link{pptx}}, \code{\link{addImage.pptx}}
#' , \code{\link{bsdoc}}, \code{\link{addImage.bsdoc}}
addImage = function(doc, filename, ...){
	checkHasSlide(doc)
	if( missing( filename ) )
		stop("filename cannot be missing")
	if( !inherits( filename, "character" ) )
		stop("filename must be a single character value")
	if( length( filename ) != 1 )
		stop("filename must be a single character value")		
	if( !file.exists( filename ) )
		stop( filename, " does not exist")
	
	if( !grepl("\\.(png|jpg|jpeg|gif|bmp|wmf|emf)$", filename ) )
		stop( filename, " is not a valid file. Valid files are png, jpg, jpeg, gif, bmp, wmf, emf.")
	UseMethod("addImage")
}






#' @title Add a markdown text or file
#'
#' @description Add markdown into a document object
#' 
#' The markdown definition used is John Gruber documented here: 
#' \url{http://daringfireball.net/projects/markdown/syntax}.
#' 
#' Images are not available as \code{addImage} or \code{addPlot} is 
#' available. Pandoc footnotes have been added (see 
#' \url{http://johnmacfarlane.net/pandoc/README.html#footnotes}.
#' 
#' @param doc document object
#' @param file markdown file. Not used if text is provided.
#' @param text character vector. The markdown to parse. 
#' @param ... further arguments passed to other methods 
#' @return a document object
#' @export
#' @seealso \code{\link{docx}}, \code{\link{addMarkdown.docx}}
#' , \code{\link{bsdoc}}, \code{\link{addMarkdown.bsdoc}}
#' , \code{\link{pptx}}, \code{\link{addMarkdown.pptx}}
addMarkdown = function(doc, file, text, ...){
	if( missing( file ) && missing( text ) )
		stop("need a markdown file or text argument.")
	UseMethod("addMarkdown")
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
#' @details a paragraph is a set of text that ends with an end of line(\code{'\n'} in C). 
#' Read \code{\link{pot}} to see how to get different font formats.
#' Trying to insert a \code{'\n'} will have no effect. If an end of line is required
#' , a new paragraph is required.
#' @param doc document object
#' @param value text to add to the document as paragraphs: 
#' an object of class \code{\link{pot}} or \code{\link{set_of_paragraphs}} 
#' or a character vector.
#' @param ... further arguments passed to other methods 
#' @return a document object
#' @export
#' @details 
#' See \code{\link{addParagraph.docx}} or \code{\link{addParagraph.pptx}}
#' or \code{\link{addParagraph.bsdoc}} for examples.
#' @seealso \code{\link{docx}}, \code{\link{addParagraph.docx}}
#' , \code{\link{pptx}}, \code{\link{addParagraph.pptx}}
#' , \code{\link{bsdoc}}, \code{\link{addParagraph.bsdoc}}
#' , \code{\link{pot}}, \code{\link{textProperties}}
addParagraph = function(doc, value, ...){
	checkHasSlide(doc)
	if( !inherits( value, c("set_of_paragraphs", "character", "pot") ) )
		stop("value must be an object of class pot, set_of_paragraphs or a character vector.")
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
#' SVG will be produced for \code{bsdoc} objects
#' and DrawingML instructions for \code{docx} and \code{pptx} objects. 
#' 
#' DrawingML instructions offer the advantage of providing editable graphics 
#' (forms and text colors, text contents).
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
#' \code{vector.graphic}: if document is a pptx or bsdoc document, 
#' vector graphics will always be displayed. Don't use vector 
#' graphics if document is a docx and MS Word version used 
#' to open the document is 2007.
#' 
#' See \code{\link{addPlot.docx}} or \code{\link{addPlot.pptx}}
#' or \code{\link{addPlot.bsdoc}} for examples.
#' @export
#' @seealso \code{\link{docx}}, \code{\link{addPlot.docx}}
#' , \code{\link{pptx}}, \code{\link{addPlot.pptx}}
#' , \code{\link{bsdoc}}, \code{\link{addPlot.bsdoc}}
addPlot = function(doc, fun, pointsize = 12, vector.graphic = F, ...){
	
	checkHasSlide(doc)
	UseMethod("addPlot")
}

#' @title Add a section into a document object
#'
#' @description Add a section into a document object
#' 
#' @param doc document object
#' @param ... further arguments passed to other methods 
#' @return a document object
#' @details 
#' \code{addSection} only works with docx documents. See \code{\link{addSection.docx}} for examples.
#' @export
#' @seealso \code{\link{docx}}, \code{\link{addSection.docx}}
addSection = function(doc, ...){
	UseMethod("addSection")
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
#' @param file R script file. Not used if text or 
#' rscript is provided.
#' @param text character vector. The text to parse. 
#' Not used if file or rscript is provided.
#' @param rscript an object of class \code{RScript}. 
#' Not used if file or text is provided.
#' @param ... further arguments passed to other methods 
#' @details 
#' You have to one of the following argument: file or text or rscript. 
#' @return a document object
#' @export
#' @seealso \code{\link{addRScript.bsdoc}}, \code{\link{addRScript.docx}}
#' , \code{\link{addRScript.pptx}}
addRScript = function(doc, rscript, file, text, ... ){

	if( missing( file ) && missing( text ) && missing( rscript ) )
		stop("need a rscript or file or text argument.")
	
	UseMethod("addRScript")
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
#' or \code{\link{addTitle.bsdoc}} for examples.
#' @export
#' @seealso \code{\link{docx}}, \code{\link{addTitle.docx}}, \code{\link{pptx}}
#' , \code{\link{addTitle.pptx}}, \code{\link{bsdoc}}, \code{\link{addTitle.bsdoc}}
addTitle = function(doc, value, ...){
	checkHasSlide(doc)
	
	if( missing( value ) ) stop("value is missing.")
	if( !is.character( value ) && !inherits( value, "pot" ) )
		stop("value must be a character vector of length 1 or a pot object.")
	if( is.character( value ) && length( value ) != 1 )
		stop("value must be a character vector of length 1 or a pot object.")
	
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

#' @title R tables as FlexTables
#'
#' @description Get a \code{\link{FlexTable}} object from 
#' an R object.
#' 
#' @param x object to get \code{FlexTable} from
#' @param ... further arguments passed to other methods 
#' @return a \code{\link{FlexTable}} object
#' @export
#' @seealso \code{\link{FlexTable}}
as.FlexTable = function( x, ... ){
	UseMethod("as.FlexTable")
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
#' or \code{\link{writeDoc.bsdoc}} for examples.
#' @export
#' @seealso \code{\link{docx}}, \code{\link{writeDoc.docx}}
#' , \code{\link{pptx}}, \code{\link{writeDoc.pptx}}
#' , \code{\link{bsdoc}}, \code{\link{writeDoc.bsdoc}}
writeDoc = function(doc, ...){
	UseMethod("writeDoc")
}
