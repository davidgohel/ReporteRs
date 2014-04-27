#' @title Set manually headers'styles of a docx object
#'
#' @description Set manually headers'styles of a docx object
#' @details 
#' Function \code{addTitle} need to know which styles 
#' are corresponding to which title level (1 ; 1.1 ; 1.1.1 ; etc.).
#' When template is read, function \code{docx} try to guess what 
#' are theses styles. If he do not succeed, an error occured saying 
#' 'You must defined header styles via declareTitlesStyles first.'. In that
#' case, run \code{styles(...)} to see what are available styles, then
#' declareTitlesStyles to indicate which available styles are meant to be 
#' used as header styles.
#' 
#' @param doc \code{docx} object to be used with declareTitlesStyles.
#' @param stylenames existing styles (character vector) where first element 
#' represents the style to use for title 1, second element represents 
#' the style to use for title 2, etc.
#' @param ... further arguments, not used. 
#' @examples
#' \dontrun{
#' doc = docx( title = "My example" )
#' styles( doc )
#' # [1] "Normal"                  "Title1"                  "Title2"                 
#' # [4] "Title3"                  "Title4"                  "Title5"                 
#' # [7] "Title6"                  "Title7"                  "Title8"                 
#' #[10] "Title9"                  "Defaut"                  ...         
#' doc = declareTitlesStyles(doc
#' 	, stylenames = c("Title1", "Title2", "Title3"
#' 	, "Title4", "Title5", "Title6", "Title7", "Title8", "Title9" ) )
#' doc = addTitle( doc, "title 1", 1 )
#' }
#' @seealso \code{\link{docx}},\code{\link{styles.docx}},\code{\link{addTitle.docx}}
#' ,\code{\link{declareTitlesStyles}}
#' @method declareTitlesStyles docx
#' @S3method declareTitlesStyles docx
declareTitlesStyles.docx = function( doc, stylenames, ... ) {
	if( !all( is.element( stylenames, styles( doc ) ) ) ){
		stop("Some of the stylenames are not in available styles (run styles on your object to list available styles.")
	}
	doc$header.styles = stylenames
	doc
	}
