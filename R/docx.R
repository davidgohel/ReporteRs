#' @title Create Microsoft Word document object representation
#'
#' @description
#' Create a \code{\link{docx}} object
#' 
#' @param title \code{"character"} value: title of the 
#' document (in the doc properties).
#' @param template \code{"character"} value, it represents 
#' the filename of the docx file used as a template.
#' @param list.definition a list definition to specify how ordered and unordered 
#' lists have to be formated. See \code{\link{list.settings}}. Default to 
#' \code{getOption("ReporteRs-list-definition")}.
#' @return an object of class \code{\link{docx}}.
#' @details
#' Several methods can used to send R output into an object of class \code{\link{docx}}.
#' 
#' \itemize{
#'   \item \code{\link{addTitle.docx}} add titles
#'   \item \code{\link{addParagraph.docx}} add text
#'   \item \code{\link{addPlot.docx}} add plots
#'   \item \code{\link{addFlexTable.docx}} add tables. See \code{\link{FlexTable}}
#'   \item \code{\link{addImage.docx}} add external images
#'   \item \code{\link{addMarkdown.docx}} add markdown text
#'   \item \code{\link{addTOC.docx}} add table of content
#'   \item \code{\link{addPageBreak.docx}} add page break
#'   \item \code{\link{addSection.docx}} add section (for landscape orientation)
#'   \item \code{\link{addDocument.docx}} add an external \code{docx} file into 
#' 		a \code{docx} object.
#' }
#' 
#' R outputs (tables, plots, paragraphs and images) can be inserted (and not added at the end) 
#' in a document if a bookmark exists in the template file. See \code{\link{bookmark}}.
#' 
#' Once object has content, user can write the docx into a ".docx" file, see \code{\link{writeDoc}}.
#' @references Wikipedia: Office Open XML\cr\url{http://en.wikipedia.org/wiki/Office_Open_XML}
#' @note Word 2007-2013 (*.docx) file formats are the only supported files.\cr Document are manipulated in-memory ; a \code{docx}'s document is not written to the disk unless the \code{\link{writeDoc}} method has been called on the object.
#' @export
#' @examples
#' #START_TAG_TEST
#' @example examples/docx_example.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{bsdoc}}, \code{\link{pptx}}, 
#' \code{\link{bookmark}}
docx = function( title = "untitled", template, list.definition = getOption("ReporteRs-list-definition") ){
	
	# docx base file mngt
	if( missing( template ) )
		template = paste( find.package("ReporteRs"), "templates/EMPTY_DOC.docx", sep = "/" )
	.reg = regexpr( paste( "(\\.(?i)(docx))$", sep = "" ), template )
	
	if( !file.exists( template ) || .reg < 1 )
		stop(template , " is not a valid file.")
	
	lidef = do.call( list.settings, list.definition )
	# java calls
	obj = .jnew( class.docx4r.document )
	.jcall( obj, "V", "setBaseDocument", template, lidef )
	.sysenv = Sys.getenv(c("USERDOMAIN","COMPUTERNAME","USERNAME"))
	
	.jcall( obj, "V", "setDocPropertyTitle", title )
	.jcall( obj, "V", "setDocPropertyCreator", paste( .sysenv["USERDOMAIN"], "/", .sysenv["USERNAME"], " on computer ", .sysenv["COMPUTERNAME"], sep = "" ) )
	
	
	.Object = list( obj = obj
		, title = title
		, basefile = template
		, plot_first_id=1L
		)
	class( .Object ) = "docx"
	.Object$styles = styles( .Object )
	# uk-us,fr,?,?,?,simplifiedchinese
	matchheaders = regexpr("^(Heading|Titre|Rubrik|Overskrift|berschrift|)[1-9]{1}$", .Object$styles )
	#	matchheaders = regexpr("^(?i)(heading|titre|rubrik|overskrift|otsikko|titolo|titulo|baslik|uberschrift|rubrik)[1-9]{1}$", .Object@styles )
	if( any( matchheaders > 0 ) ){
		.Object = declareTitlesStyles(.Object, stylenames = sort( .Object$styles[ matchheaders > 0 ] ) )
	} else .Object$header.styles = character(0)
	
	
	.Object
}

