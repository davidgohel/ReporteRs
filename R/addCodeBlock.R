#' @title Add code block into a document object
#'
#' @description Add a code block into a document object
#'
#' @param doc document object
#' @param file script file. Not used if text is provided.
#' @param text character vector. The text to parse.
#' Not used if file is provided.
#' @param ... further arguments passed to other methods
#' @return a document object
#' @export
#' @examples
#'
#' cb <- "ls -a\nwhich -a ls"
#'
#' options( "ReporteRs-fontsize" = 11 )
#'
#' @seealso \code{\link{bsdoc}}, \code{\link{docx}}, \code{\link{pptx}}
addCodeBlock = function(doc, file, text, ... ){

  if( missing( file ) && missing( text ) )
    stop("need a file or text argument.")

  UseMethod("addCodeBlock")
}


#' @param par.properties code block paragraph properties.
#' An object of class \code{\link{parProperties}}
#' @param text.properties code block text properties.
#' An object of class \code{\link{textProperties}}
#' @param bookmark Only for \code{docx}. A character value ; id of the Word bookmark to
#' replace by the script. optional. See \code{\link{bookmark}}.
#' @examples
#' # docx example ---------
#' doc = docx( )
#' doc <- addCodeBlock( doc, text = cb )
#' writeDoc( doc, file = "ex_codeblock.docx" )
#'
#'
#' @export
#' @rdname addCodeBlock
addCodeBlock.docx = function(doc, file, text,
                             par.properties = parProperties(),
                             text.properties = textProperties( color = "#A7947D" ),
                             bookmark, ... ) {

  if( !missing ( file ) ){
    script = CodeBlock( file = file,
                        par.properties = par.properties,
                        text.properties = text.properties )
  } else if( !missing ( text ) ){
    script = CodeBlock( text = text,
                        par.properties = par.properties,
                        text.properties = text.properties )
  }
  .jcall( script$jobj, "V", "setDOCXReference", doc$obj )

  args = list( obj = doc$obj,
               returnSig = "V", method = "add",
               script$jobj,
               .jParProperties(par.properties)
  )

  if( !missing( bookmark ) ) args[[length(args) +1 ]] = bookmark

  do.call( .jcall, args )

  doc
}


#' @examples
#' # bsdoc example ---------
#' doc = bsdoc( )
#' doc <- addCodeBlock( doc, text = cb )
#' writeDoc( doc, file = "ex_codeblock/example.html" )
#'
#'
#' @export
#' @rdname addCodeBlock
addCodeBlock.bsdoc = function(doc, file, text,
		par.properties = parProperties(),
		text.properties = textProperties( color = "#A7947D" ), ...) {

	if( !missing ( file ) ){
		script = CodeBlock( file = file,
				par.properties = par.properties,
				text.properties = text.properties )
	} else if( !missing ( text ) ){
		script = CodeBlock( text = text,
				par.properties = par.properties,
				text.properties = text.properties )
	}

	out = .jcall( doc$jobj, "I", "add" , script$jobj)
	if( out != 1 ){
		stop( "Problem while trying to add rscript." )
	}
	doc
}



#' @param append Only for \code{pptx}. boolean default to FALSE. If TRUE, paragraphs will be
#' appened in the current shape instead of beeing sent into a new shape.
#' Paragraphs can only be appended on shape containing paragraphs (i.e. you
#' can not add paragraphs after a FlexTable).
#' @examples
#' # pptx example ---------
#' doc = pptx( )
#' doc = addSlide( doc, slide.layout = "Title and Content" )
#' doc <- addCodeBlock( doc, text = cb )
#' writeDoc( doc, file = "ex_codeblock.pptx" )
#'
#'
#' @export
#' @rdname addCodeBlock
addCodeBlock.pptx = function(doc, file, text,
                             par.properties = parProperties(),
                             text.properties = textProperties( color = "#A7947D" ),
                             append = FALSE, ... ) {

  if( !missing ( file ) ){
    script = CodeBlock( file = file,
                        par.properties = par.properties,
                        text.properties = text.properties )
  } else if( !missing ( text ) ){
    script = CodeBlock( text = text,
                        par.properties = par.properties,
                        text.properties = text.properties )
  }


  if( !append )
    out = .jcall( doc$current_slide, "I", "add", script$jobj )
  else out = .jcall( doc$current_slide, "I", "append", script$jobj )
  if( isSlideError( out ) ){
    stop( getSlideErrorString( out , "CodeBlock") )
  }
  doc
}
