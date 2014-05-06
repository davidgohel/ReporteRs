#' @title Create Microsoft Word document object representation
#'
#' @description
#' Create a \code{"docx"} object
#' 
#' @param title \code{"character"} value: title of the document (in the doc properties).
#' @param template \code{"character"} value, it represents the filename of the docx file used as a template.
#' @return an object of class \code{"docx"}.
#' @details
#' Several methods can used to send R output into an object of class \code{"docx"}.
#' 
#' \itemize{
#'   \item \code{\link{addTitle.docx}} add titles
#'   \item \code{\link{addParagraph.docx}} add texts
#'   \item \code{\link{addPlot.docx}} add plots
#'   \item \code{\link{addTable.docx}} add tables
#'   \item \code{\link{addFlexTable.docx}} add \code{\link{FlexTable}}
#'   \item \code{\link{addImage.docx}} add external images
#'   \item \code{\link{addTOC.docx}} add table of content
#'   \item \code{\link{addPageBreak.docx}} add page break
#' }
#' 
#' R outputs (tables, plots, paragraphs and images) can be inserted (and not added at the end) 
#' in a document if a bookmark exists in the template file.
#' 
#' Once object has content, user can write the docx into a ".docx" file, see \code{\link{writeDoc}}.
#' @references Wikipedia: Office Open XML\cr\url{http://en.wikipedia.org/wiki/Office_Open_XML}
#' @note Word 2007-2013 (*.docx) file formats are the only supported files.\cr Document are manipulated in-memory ; a \code{docx}'s document is not written to the disk unless the \code{\link{writeDoc}} method has been called on the object.
#' @export
#' @examples
#' #START_TAG_TEST
#' require( ggplot2 )
#' 
#' # Word document to write
#' docx.file = "document_example.docx"
#' 
#' # Create a new document
#' doc = docx( title = "title" )
#' 
#' # display layouts names
#' styles( doc )
#' 
#' # add title
#' doc = addParagraph( doc, "Document title", stylename = "TitleDoc" )
#' 
#' doc = addParagraph( doc , "This document is generated with ReporteRs."
#'              , stylename="Citationintense")
#' 
#' # add page break
#' doc = addPageBreak( doc )
#' 
#' # add a title
#' doc = addTitle( doc, "Table of contents", level =  1 )
#' 
#' # add a table of content
#' doc = addTOC( doc )
#' 
#' # add page break
#' doc = addPageBreak( doc )
#' 
#' # add a title
#' doc = addTitle( doc, "Texts demo", level =  1 )
#' texts = c( "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
#' , "In sit amet ipsum tellus. Vivamus dignissim arcu sit amet faucibus auctor."
#' , "Quisque dictum tristique ligula."
#' )
#' 
#' # add simple text
#' doc = addParagraph( doc, value = texts, stylename="BulletList" )
#' 
#' # Add "My tailor is rich" and "Cats and Dogs"
#' # format some of the pieces of text
#' pot1 = pot("My tailor"
#'      , textProperties(color="red", font.size = 12 ) ) + " is " + pot("rich"
#'              , textProperties(font.weight="bold") )
#' pot2 = pot("Cats"
#'      , textProperties(color="red", font.size = 12)
#'      ) + " and " + pot("Dogs"
#'              , textProperties(color="blue", font.size = 12) )
#' doc = addParagraph(doc, set_of_paragraphs( pot1, pot2 ), stylename="Normal" )
#' 
#' 
#' myplot = qplot(Sepal.Length, Petal.Length
#'      , data = iris, color = Species
#'      , size = Petal.Width, alpha = I(0.7)
#' )
#' # Add titles and then 'myplot' 
#' doc = addTitle( doc, "Plot examples", level =  1 )
#' doc = addPlot( doc, function( ) print( myplot ) )
#' # Add a legend below the plot
#' doc = addParagraph( doc, value = "my first plot", stylename = "rPlotLegend")
#' 
#' # Add a table
#' doc = addTitle( doc, "Table example", level =  1 )
#' # add iris sample
#' doc = addTable( doc, data = iris[25:33, ] )
#' # Add a legend below the table
#' doc = addParagraph( doc, value = "my first table", stylename = "rTableLegend")
#' 
#' # add page break and then tables of contents for produced plots and tables
#' doc = addPageBreak( doc )
#' doc = addTitle( doc, "List of graphics", level =  1 )
#' doc = addTOC( doc, stylename = "rPlotLegend" )
#' doc = addTitle( doc, "List of tables", level =  1 )
#' doc = addTOC( doc, stylename = "rTableLegend" )
#' 
#' # write the doc
#' writeDoc( doc, docx.file)
#' #STOP_TAG_TEST
#' @seealso \code{\link{addTitle.docx}}, \code{\link{addImage.docx}}, \code{\link{addParagraph.docx}}
#' , \code{\link{addPlot.docx}}, \code{\link{addTable.docx}}, \code{\link{addTOC.docx}}
#' , \code{\link{styles.docx}}, \code{\link{writeDoc.docx}}

docx = function( title = "untitled", template){
	
	# docx base file mngt
	if( missing( template ) )
		template = paste( find.package("ReporteRs"), "templates/EMPTY_DOC.docx", sep = "/" )
	.reg = regexpr( paste( "(\\.(?i)(docx))$", sep = "" ), template )
	
	if( !file.exists( template ) || .reg < 1 )
		stop(template , " is not a valid file.")
	
	# java calls
	obj = .jnew( class.docx4r.document )
	.jcall( obj, "V", "setBaseDocument", template )
	.sysenv = Sys.getenv(c("USERDOMAIN","COMPUTERNAME","USERNAME"))
	
	.jcall( obj, "V", "setDocPropertyTitle", title )
	.jcall( obj, "V", "setDocPropertyCreator", paste( .sysenv["USERDOMAIN"], "/", .sysenv["USERNAME"], " on computer ", .sysenv["COMPUTERNAME"], sep = "" ) )
	
	.Object = list( obj = obj
		, title = title
		, basefile = template
		, styles = .jcall( obj, "[S", "getStyleNames" ) 
		, plot_first_id=1L
		)
	class( .Object ) = "docx"
	# uk-us,fr,?,?,?,simplifiedchinese
	matchheaders = regexpr("^(Heading|Titre|Rubrik|Overskrift|berschrift|)[1-9]{1}$", .Object$styles )
	#	matchheaders = regexpr("^(?i)(heading|titre|rubrik|overskrift|otsikko|titolo|titulo|baslik|uberschrift|rubrik)[1-9]{1}$", .Object@styles )
	if( any( matchheaders > 0 ) ){
		.Object = declareTitlesStyles(.Object, stylenames = sort( .Object$styles[ matchheaders > 0 ] ) )
	} else .Object$header.styles = character(0)
	
	
	.Object
}

