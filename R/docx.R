#' @title Create Microsoft Word document object representation
#'
#' @description
#' Create a \code{\link{docx}} object
#'
#' @param title \code{"character"} value: title of the
#' document (in the doc properties).
#' @param template \code{"character"} value, it represents
#' the filename of the docx file used as a template.
#' @param empty_template wether the content of the template should
#' be clear or not.
#' @param list.definition a list definition to specify how ordered and unordered
#' lists have to be formated. See \code{\link{list.settings}}. Default to
#' \code{getOption("ReporteRs-list-definition")}.
#' @return an object of class \code{\link{docx}}.
#' @details
#' Several methods can used to send R output into an object of class \code{\link{docx}}.
#'
#' \itemize{
#'   \item \code{\link{addTitle}} add titles
#'   \item \code{\link{addParagraph}} add text
#'   \item \code{\link{addPlot}} add plots
#'   \item \code{\link{addFlexTable}} add tables. See \code{\link{FlexTable}}
#'   \item \code{\link{addImage}} add external images
#'   \item \code{\link{addMarkdown}} add markdown text
#'   \item \code{\link{addTOC}} add table of content
#'   \item \code{\link{addPageBreak}} add page break
#'   \item \code{\link{addSection}} add section (for landscape orientation)
#'   \item \code{\link{addDocument}} add an external \code{docx} file into
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
#'
#' @example examples/docx_example.R
#' @seealso \code{\link{bsdoc}}, \code{\link{pptx}}, \code{\link{bookmark}}
docx = function( title = "untitled", template, empty_template = FALSE, list.definition = getOption("ReporteRs-list-definition") ){

	if( missing( template ) )
		template = file.path( system.file(package = "ReporteRs"), "templates/EMPTY_DOC.docx" )
	.reg = regexpr( paste( "(\\.(?i)(docx))$", sep = "" ), template )

	template <- getAbsolutePath(template, expandTilde = TRUE)

	if( .reg < 1 )
	  stop("invalid template name, it must have extension .docx")

	if( !file.exists( template ) )
		stop(template , " can not be found.")

	lidef = do.call( list.settings, list.definition )
	# java calls
	obj = .jnew( class.docx4r.document )
	.jcall( obj, "V", "setBaseDocument", template, lidef )
	.sysenv = Sys.getenv(c("USERDOMAIN","COMPUTERNAME","USERNAME"))

	.jcall( obj, "V", "setDocPropertyTitle", title )
	.jcall( obj, "V", "setDocPropertyCreator", paste( .sysenv["USERDOMAIN"], "/", .sysenv["USERNAME"], " on computer ", .sysenv["COMPUTERNAME"], sep = "" ) )

	if( empty_template )
	  .jcall(obj, "V", "deleteContent")

	.Object = list( obj = obj
		, title = title
		, basefile = template
		, plot_first_id=1L
		)
	class( .Object ) = "docx"
	.Object$styles = styles( .Object )
	matchheaders = regexpr("^(Heading|Titre|Rubrik|Overskrift|berschrift|)[1-9]{1}$", .Object$styles )
	if( any( matchheaders > 0 ) ){
		.Object = declareTitlesStyles(.Object, stylenames = sort( .Object$styles[ matchheaders > 0 ] ) )
	} else .Object$header.styles = character(0)


	.Object
}


#' @details \code{dim} returns page width and height and page margins
#' of a \code{docx} object.
#' @param x a \code{docx} objet
#' @examples
#'
#' # get docx page dimensions ------
#' doc = docx( title = "title" )
#' dim( doc )
#' @rdname docx
#' @export
dim.docx = function( x ){
  temp = .jcall(x$obj, "[I", "getSectionDimensions")
  out = list( page = c( width = temp[1], height = temp[2] ) / 1440
              , margins = c(top = temp[3], right = temp[4], bottom = temp[5], left = temp[5]) / 1440
  )
  out
}


#' @details
#' \code{print} print informations about an object of
#' class \code{docx}.
#' @param ... unused
#' @rdname docx
#' @export
print.docx = function (x, ...){
  cat("[docx object]\n")

  cat("title:", x$title, "\n")

  cat(paste( "Original document: '", x$basefile, "'\n", sep = "" ) )

  cat( "Styles:\n" )
  print( styles( x ) )

  invisible()
}



