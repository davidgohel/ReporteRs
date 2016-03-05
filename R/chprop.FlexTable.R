#' @title format FlexTable
#'
#' @description Format a FlexTable object.
#'
#' @param object the \code{FlexTable} object
#' @param value a formatting properties object (\code{textProperties}, \code{parProperties},
#' \code{borderProperties}, \code{cellProperties})
#' @param i vector (integer index, row.names values or boolean vector) for rows selection.
#' @param j vector (integer index, col.names values or boolean vector) for columns selection.
#' @param to specify on which part of the FlexTable to apply the \code{value}, must be one of the following
#' values \dQuote{body} (default) or \dQuote{header} or \dQuote{footer}
#' @param side used only when value is a \code{\link{borderProperties}}, specify on which side to
#' apply the properties. It must be one of \dQuote{bottom}, \dQuote{top}, \dQuote{left}, \dQuote{right}.
#' @param ... unused
#' @examples
#' my_ft <- vanilla.table( head( iris, n = 5 ) )
#' my_ft <- chprop( my_ft, textBoldItalic(), i = 1, to = "header" )
#' my_ft <- chprop( my_ft, parCenter(), j = 5 )
#' my_ft <- chprop( my_ft, borderSolid(color = "red"), i = 5, side = "bottom" )
#' @export
chprop.FlexTable <- function(object, value, i, j, to = "body", side = "top", ...){

  args.get.indexes = list(object = object)
  if( !missing(i) ) args.get.indexes$i = i
  if( !missing(j) ) args.get.indexes$j = j
  args.get.indexes$partname = to

  indexes = do.call(getncheckid, args.get.indexes)
  i = indexes$i
  j = indexes$j

  if( inherits(value, "textProperties" ) ){
    switch(to,
           body = {
             object <- chBodyTextProperties( x = object, i=i, j=j, value=value )
           },
           header = {
             object <- chHeaderTextProperties( x = object, i=i, j=j, value=value )
           },
           footer =  {
             object <- chFooterTextProperties( x = object, i=i, j=j, value=value )
           }, stop("to should be one of 'body', 'header', 'footer'.")
    )
  } else if( inherits(value, "borderProperties" ) ){
    switch(to,
           body = {
             object <- chBodyBorderProperties ( x = object, i=i, j=j, side = side, value=value )
           },
           header = {
             object <- chHeaderBorderProperties ( x = object, i=i, j=j, side = side, value=value )
           },
           footer =  {
             object <- chFooterBorderProperties ( x = object, i=i, j=j, side = side, value=value )
           }, stop("to should be one of 'body', 'header', 'footer'.")
    )
  } else if( inherits(value, "parProperties" ) ){
    switch(to,
           body = {
             object <- chBodyParProperties( x = object, i=i, j=j, value=value )
           },
           header = {
             object <- chHeaderParProperties( x = object, i=i, j=j, value=value )
           },
           footer =  {
             object <- chFooterParProperties( x = object, i=i, j=j, value=value )
           }, stop("to should be one of 'body', 'header', 'footer'.")
    )
  } else if( inherits(value, "cellProperties" ) ){
    switch(to,
           body = {
             object <- chBodyCellProperties( x = object, i=i, j=j, value=value )
           },
           header = {
             object <- chHeaderCellProperties( x = object, i=i, j=j, value=value )
           },
           footer =  {
             object <- chFooterCellProperties( x = object, i=i, j=j, value=value )
           }, stop("to should be one of 'body', 'header', 'footer'.")
    )
  } else stop("unknown formatting property.")

  object
}


