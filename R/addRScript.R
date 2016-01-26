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
#' @seealso \code{\link{bsdoc}}, \code{\link{docx}}, \code{\link{pptx}}
addRScript = function(doc, rscript, file, text, ... ){

  if( missing( file ) && missing( text ) && missing( rscript ) )
    stop("need a rscript or file or text argument.")

  UseMethod("addRScript")
}



#' @param par.properties paragraph formatting properties of the
#' paragraphs that contain rscript. An object of class \code{\link{parProperties}}
#' @param bookmark a character value ; id of the Word bookmark to
#' replace by the script. optional. See \code{\link{bookmark}}.
#' @examples
#'
#' # docx example -----------
#' doc.filename = "ex_rscript.docx"
#' @example examples/docx.R
#' @example examples/addRScript.R
#' @example examples/writeDoc_file.R
#' @rdname addRScript
#' @export
addRScript.docx = function(doc, rscript, file, text, bookmark, par.properties = parProperties(), ... ) {

	if( !missing ( file ) ){
		rscript = RScript( file = file, ... )
	} else if( !missing ( text ) ){
		rscript = RScript( text = text, ... )
	}
	.jcall( rscript$jobj, "V", "setDOCXReference", doc$obj )

	args = list( obj = doc$obj,
			returnSig = "V", method = "add",
			rscript$jobj,
			.jParProperties(par.properties)
			)

	if( !missing( bookmark ) ) args[[length(args) +1 ]] = bookmark

	do.call( .jcall, args )

	doc
}



#' @param append boolean default to FALSE. If TRUE, paragraphs will be
#' appened in the current shape instead of beeing sent into a new shape.
#' Paragraphs can only be appended on shape containing paragraphs (i.e. you
#' can not add paragraphs after a FlexTable).
#' @examples
#'
#' # pptx example -----------
#' doc.filename = "ex_rscript.pptx"
#' @example examples/pptx.R
#' @example examples/addSlide.R
#' @example examples/addTitle1NoLevel.R
#' @example examples/addRScript.R
#' @example examples/writeDoc_file.R
#' @export
#' @rdname addRScript
addRScript.pptx = function(doc, rscript, file, text, append = FALSE, ... ) {

  if( !missing ( file ) ){
    rscript = RScript( file = file, ... )
  } else if( !missing ( text ) ){
    rscript = RScript( text = text, ... )
  }
  if( !append )
    out = .jcall( doc$current_slide, "I", "add", rscript$jobj )
  else out = .jcall( doc$current_slide, "I", "append", rscript$jobj )
  if( isSlideError( out ) ){
    stop( getSlideErrorString( out , "RScript") )
  }
  doc
}


#' @examples
#'
#' # bsdoc example -----------
#' doc.filename = "ex_rscript/example.html"
#' @example examples/bsdoc.R
#' @example examples/addRScript.R
#' @example examples/writeDoc_file.R
#' @rdname addRScript
#' @export
addRScript.bsdoc = function(doc, rscript, file, text, ...) {

  if( !missing ( file ) ){
    rscript = RScript( file = file, ... )
  } else if( !missing ( text ) ){
    rscript = RScript( text = text, ... )
  }

  out = .jcall( doc$jobj, "I", "add" , rscript$jobj)
  if( out != 1 ){
    stop( "Problem while trying to add rscript." )
  }
  doc
}


