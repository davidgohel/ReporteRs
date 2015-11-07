bootstrap.copy = function ( www.directory, package.name ){
	css_from = file.path( system.file(package = package.name), "bootstrap/css", fsep = "/" )
	js_from = file.path( system.file(package = package.name), "bootstrap/js", fsep = "/" )
	fonts_from = file.path( system.file(package = package.name), "bootstrap/fonts", fsep = "/" )

	css_to = file.path( www.directory, "css", fsep = "/" )
	js_to = file.path( www.directory, "js", fsep = "/" )
	fonts_to = file.path( www.directory, "fonts", fsep = "/" )


	if( !file.exists( css_to ) ){
		file.copy( from = css_from, to = www.directory,  overwrite = T, recursive = T )
	}
	if( !file.exists( js_to ) ){
		file.copy( from = js_from, to = www.directory,  overwrite = T, recursive = T )
	}
	if( !file.exists( fonts_to ) ){
		file.copy( from = fonts_from, to = www.directory,  overwrite = T, recursive = T )
	}
	invisible()
}
