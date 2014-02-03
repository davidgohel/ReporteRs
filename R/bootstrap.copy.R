bootstrap.copy = function ( www.directory, package.name ){
	css = file.path( find.package(package.name), "bootstrap/css", fsep = "/" )
	js = file.path( find.package(package.name), "bootstrap/js", fsep = "/" )
	fonts = file.path( find.package(package.name), "bootstrap/fonts", fsep = "/" )
	
	file.copy( from = css
			, to = www.directory
			,  overwrite = T
			, recursive = T )
	file.copy( from = js
			, to = www.directory
			,  overwrite = T
			, recursive = T )
	file.copy( from = fonts
			, to = www.directory
			,  overwrite = T
			, recursive = T )
	list( css = list.files( path = css )
			, js = list.files( path = js )
			, fonts = list.files( path = fonts )
	)
}
