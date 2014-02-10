#' @method addFlexTable docx
#' @S3method addFlexTable docx
addFlexTable.docx = function(doc, flextable ) {
			
	rJava::.jcall( doc$obj, "V", "add", flextable$jobj )

	doc
}

