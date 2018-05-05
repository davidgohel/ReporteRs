#' @title format ordered and unordered lists
#'
#' @description
#' Create a description used to format ordered and unordered lists in object documents.
#'
#' @param ol.left left indent values (in inches) for each level of an ordered list. Length must
#' be 9 as there are 9 elements to define (from level1 to level9).
#' @param ol.hanging space values (in inches) between numbering label (argument \code{ol.format})
#' and content for each level of an ordered list. Length must be 9 as there are 9 elements to
#' define (from level1 to level9).
#' @param ol.format type of numbering for ordered levels, values can be 'decimal' or 'upperRoman'
#' or 'lowerRoman' or 'upperLetter' or 'lowerLetter'. Length must be 9 as there are 9 elements
#' to define (from level1 to level9).
#' @param ol.pattern numbering pattern for ordered levels. A level numbering has the following
#' syntax: \code{"\%1"} (numbering of level1), \code{"\%2"} (numbering of level2), ...,
#' \code{"\%9"} (numbering of level9).
#' @param ul.left left indent values for each level of an unordered list. Length must be 9 as
#' there are 9 elements to define (from level1 to level9). Length must be 9 as
#' there are 9 elements to define (from level1 to level9).
#' @param ul.hanging space values (in inches) between bullet symbol (argument \code{ul.format})
#' and content for each level of an unordered list. Length must be 9 as there are 9 elements
#' to define (from level1 to level9).
#' @param ul.format type of bullet for unordered levels, values can be 'disc' or 'circle' or 'square'.
#' Length must be 9 as there are 9 elements to define (from level1 to level9).
#' @details
#' List settings are used to configure formatting of list in documents.
#'
#' It can be set in R session options or as a parameter in \code{\link{docx}} or
#' \code{\link{pptx}}.
#' @examples
#' if( check_valid_java_version() ){
#' numbering.pattern = c( "%1.", "%1. %2.", "%1. %2. %3.",
#'   "%4.", "%5.", "%6.", "%7.", "%8.", "%9." )
#'
#' ordered.formats = rep( c( "decimal", "upperRoman", "upperLetter"), 3 )
#'
#' unordered.formats = rep( c( "square", "disc", "circle"), 3 )
#'
#' left.indent = seq( from = 0, by = 0.5, length.out = 9)
#'
#' options("ReporteRs-list-definition" = list(
#'   ol.left = left.indent,
#'   ol.hanging = rep( 0.4, 9 ),
#'   ol.format = ordered.formats,
#'   ol.pattern = numbering.pattern,
#'   ul.left = left.indent,
#'   ul.hanging = rep( 0.4, 9 ),
#'   ul.format = unordered.formats
#'   )
#' )
#'
#' \donttest{
#' doc.filename = "ex_list.docx"
#' doc <- docx()
#'
#' doc <- addTitle( doc, "List example", level = 1 )
#'
#' # define some text
#' text1 = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
#' text2 = "In sit amet ipsum tellus. Vivamus arcu sit amet faucibus auctor."
#' text3 = "Quisque dictum tristique ligula."
#'
#' # define parProperties with list properties
#' ordered.list.level1 = parProperties(list.style = "ordered",
#'                                     level = 1 )
#' ordered.list.level2 = parProperties(list.style = "ordered",
#'                                     level = 2 )
#'
#' # define parProperties with list properties
#' unordered.list.level1 = parProperties(list.style = "unordered",
#'                                       level = 1 )
#' unordered.list.level2 = parProperties(list.style = "unordered",
#'                                       level = 2 )
#'
#' # add ordered list items
#' doc = addParagraph( doc, value = text1,
#'                     par.properties = ordered.list.level1 )
#' doc = addParagraph( doc, value = text2,
#'                     par.properties = ordered.list.level2 )
#'
#' # add ordered list items without restart renumbering
#' doc = addParagraph( doc, value = c( text1, text2, text3),
#'                     par.properties = ordered.list.level1 )
#'
#' # add ordered list items and restart renumbering
#' doc = addParagraph( doc, value = c( text1, text2, text3),
#'                     restart.numbering = TRUE, par.properties = ordered.list.level1 )
#'
#' # add unordered list items
#' doc = addParagraph( doc, value = text1,
#'                     par.properties = unordered.list.level1 )
#' doc = addParagraph( doc, value = text2,
#'                     par.properties = unordered.list.level2 )
#'
#' writeDoc( doc, file = doc.filename )
#' }
#' }
#' @seealso \code{\link{addParagraph}}, \code{\link{ReporteRs}}
list.settings = function(
		ol.left = seq( from = 0, by = 0.4, length.out = 9),
		ol.hanging = rep( 0.4, 9 ),
		ol.format = rep( "decimal", 9 ),
		ol.pattern = paste0( "%", 1:9, "." ),
		ul.left = seq( from = 0, by = 0.4, length.out = 9),
		ul.hanging = rep( 0.4, 9 ),
		ul.format = c( "disc", "circle", "square", "disc", "circle", "square", "disc", "circle", "square" )
		){


	if( !( length( ol.left ) == 9 && length( ol.hanging ) == 9 && length( ol.format ) == 9 && length( ol.pattern ) == 9 &&
			length( ul.left ) == 9 && length( ul.hanging ) == 9 && length( ul.format ) == 9 ) ){
		stop("all parameters must have length 9 representing list levels from 1 to 9.")
	}

	if( !is.numeric( ol.left ) ){
		stop("ol.left must be a numeric vector.")
	}
	if( !is.numeric( ol.hanging ) ){
		stop("ol.hanging must be a numeric vector.")
	}
	if( !is.numeric( ul.left ) ){
		stop("ul.left must be a numeric vector.")
	}
	if( !is.numeric( ul.hanging ) ){
		stop("ul.hanging must be a numeric vector.")
	}

	stopifnot( all( ol.format %in% c("decimal", "upperRoman", "lowerRoman", "upperLetter", "lowerLetter") ) )

	stopifnot( all( ul.format %in% c("disc", "circle", "square") ) )

	if( !all( regexpr( "(\\%[0-9])+" , ol.pattern ) > 0 ) ){
		stop("each element of ol.pattern must contain a reference to a level number with a '%' symbol before level number reference (from 1 to 9).")
	}

	ol.left = as.double( ol.left )
	ol.hanging = as.double( ol.hanging )
	ul.left = as.double( ul.left )
	ul.hanging = as.double( ul.hanging )


	orderedSettings = .jnew(class.ListDefinition, as.integer(0) )
	for( i in seq_along( ol.left ) ){
		.jcall( orderedSettings, "Z", "addLevel", as.double( ol.left[i] ),
				as.double( ol.hanging[i] ), "left",
				as.character( ol.format[i] ), as.character( ol.pattern[i] ) )
	}
	unorderedSettings = .jnew(class.ListDefinition, as.integer(1) )
	for( i in seq_along( ul.left ) ){
		.jcall( unorderedSettings, "Z", "addLevel", as.double( ul.left[i] ),
				as.double( ul.hanging[i] ), "left",
				as.character( ul.format[i] ), paste0( "%", i ) )
	}
	numberingDefinition = .jnew(class.NumberingDefinition )

	.jcall( numberingDefinition, "V", "setOrdered",
		orderedSettings )
	.jcall( numberingDefinition, "V", "setUnOrdered",
		unorderedSettings )

	numberingDefinition
}

