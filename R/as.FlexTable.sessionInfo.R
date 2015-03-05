#' @title get FlexTable from a sessionInfo object
#'
#' @description Get a \code{\link{FlexTable}} object from 
#' a \code{\link{sessionInfo}} object.
#' 
#' @param x \code{sessionInfo} object to get \code{FlexTable} from
#' @param locale show locale information?
#' @param ... further arguments, not used. 
#' @return a \code{\link{FlexTable}} object
#' @examples
#' #
#' as.FlexTable( sessionInfo() )
#' @export 
as.FlexTable.sessionInfo = function( x, locale = TRUE, ... ){
	
	mkLabel <- function(L, n) {
		vers <- sapply(L[[n]], function(x) x[["Version"]])
		pkg <-  sapply(L[[n]], function(x) x[["Package"]])
		paste(pkg, vers, sep = "_")
	}
	out = matrix( character(0), ncol = 2 )
	out = rbind( out, c("Version" , x$R.version$version.string) )
	out = rbind( out, c("Platform" , x$platform) )
	
	if(locale){
		locale_val = strsplit(x$locale, ";", fixed=TRUE)[[1]]
		locale_val = matrix( c( rep("locale", length(locale_val) ), locale_val ), ncol = 2 )
		out = rbind( out, locale_val )
	}
	basePkgs = matrix( c( rep("base packages", length(x$basePkgs) ), x$basePkgs ), ncol = 2 )
	out = rbind( out, basePkgs )
	if(!is.null(x$otherPkgs)){
		otherPkgs = mkLabel(x, "otherPkgs")
		otherPkgs = matrix( c( rep("other attached packages", length(otherPkgs) ), otherPkgs ), ncol = 2 )
		out = rbind( out, otherPkgs )
	}
	if(!is.null(x$loadedOnly)){
		loadedPkgs = mkLabel(x, "loadedOnly")
		loadedPkgs = matrix( c( rep("loaded via a namespace (and not attached)", length(loadedPkgs) ), loadedPkgs ), ncol = 2 )
		out = rbind( out, loadedPkgs )
		
	}
	dimnames(out)[[2]] = c("Section", " ")
	ft = FlexTable(out, header.columns = FALSE)
	ft[, 1] = parCenter()
	ft[, 1] = textBold()
	ft = spanFlexTableRows(ft, j = 1, runs = out[, 1])
	ft
}
