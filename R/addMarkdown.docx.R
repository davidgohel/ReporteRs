#' @title Add a markdown text or file into a docx object
#'
#' @description Add markdown into a \code{\link{docx}} object.
#'
#' @param doc Object of class \code{\link{docx}} where markdown has to be added
#' @param file markdown file. Not used if text is provided.
#' @param text character vector. The markdown text to parse.
#' @param text.properties default \code{\link{textProperties}} object
#' @param default.par.properties default \code{\link{parProperties}} object
#' @param blockquote.par.properties \code{\link{parProperties}} object used for
#' blockquote blocks.
#' @param code.par.properties \code{\link{parProperties}} object used for
#' code blocks.
#' @param hr.border \code{\link{borderProperties}} object used for
#' horizontal rules.
#' @param ... further arguments, not used.
#' @return an object of class \code{\link{docx}}.
#' @details
#' You can configure backtick rendering (single or double backtick) with
#' options "ReporteRs-backtick-color" and "ReporteRs-backtick-shading-color".
#' @examples
#' doc.filename = "addMarkdown_example.docx"
#' @example examples/docx.R
#' @example examples/addMarkdown.R
#' @example examples/writeDoc_file.R
#' @seealso \code{\link{docx}}, \code{\link{addMarkdown}}
#' @export
addMarkdown.docx = function(doc, file, text,
	text.properties = textProperties( font.size = getOption("ReporteRs-fontsize") ),
	default.par.properties = parProperties(text.align = "justify"),
	blockquote.par.properties = parProperties(padding = 6, shading.color = "#eeeeee"),
	code.par.properties = parProperties(shading.color = "#eeeeee"),
	hr.border = borderSolid(width=2, color = "gray10"),
	... ) {

	if( !missing( file ) ){
		if( length( file ) != 1 ) stop("file must be a single filename.")
		if( !file.exists( file ) ) stop("file does not exist.")
	}
	if( missing( file ) ){
		markdown = paste( text, collapse = "\n" )
	} else {
		markdown = paste( scan( file = file,
						strip.white = F,
						blank.lines.skip = FALSE,
						what = "character",
						sep = "\n", quiet = TRUE ), collapse = "\n" )
	}

	elt_table = get.blocks( markdown )

	footnotes_blocks = attr(elt_table, "footnotes" )
	footnotes = list()
	for(i in footnotes_blocks ){
		footnotes[[ i$id_ref[1] ]] = prepare.footnote(i,
				par.properties = default.par.properties,
				text.properties = text.properties )
	}
	attr(elt_table, "footnotes" ) = footnotes

	for(i in 1:nrow(elt_table) ){

		if( elt_table[ i, "block_type"]=="p" ){
			pars = get.paragraph.from.blockmd( text = elt_table[ i, "text"], text.properties = text.properties,
					blocktable_info = elt_table )
			doc = addParagraph( doc, value = pars,
					par.properties = chprop( default.par.properties, padding.left = guess.indentation(elt_table, i )*72 )
			)
		} else if( elt_table[ i, "block_type"]=="blockquotes" ){
			pars = get.paragraph.from.blockmd( text = elt_table[ i, "text"], text.properties = text.properties,
					blocktable_info = elt_table )
			bq.par.properties = chprop( blockquote.par.properties,
					list.style = "blockquote",
					level = elt_table[ i, "blockquotes_level"] )
			doc = addParagraph( doc, value = pars, par.properties = bq.par.properties)
		} else if( elt_table[ i, "block_type"]=="code" ){
			doc = addRScript( doc, text = elt_table[ i, "text"],
					par.properties = chprop( code.par.properties,
							padding.left = guess.indentation(elt_table, i )*72 )
			)
		} else if( elt_table[ i, "block_type"]=="list_item" ){
			pars = get.paragraph.from.blockmd( text = elt_table[ i, "text"], text.properties = text.properties,
					blocktable_info = elt_table )
			doc = addParagraph( doc, value = pars,
					par.properties = chprop( default.par.properties,
							list.style = ifelse( elt_table[ i, "list_type"] == "ol", "ordered", "unordered" ),
							level = elt_table[ i, "level"]
					)
			)
		} else if( elt_table[ i, "block_type"]=="h" ){
			doc = addTitle( doc, value = elt_table[ i, "text"], level = elt_table[ i, "level"] )
		} else if( elt_table[ i, "block_type"]=="hr" ){
			doc = addParagraph( doc, value = "", par.properties = chprop( default.par.properties, border.bottom = hr.border) )
		}
	}

	doc
}
