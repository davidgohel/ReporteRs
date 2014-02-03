reveal.copy = function ( www.directory, package.name ){
	css = file.path( find.package(package.name), "reveal.js-2.6.1/css", fsep = "/" )
	js = file.path( find.package(package.name), "reveal.js-2.6.1/js", fsep = "/" )
	lib = file.path( find.package(package.name), "reveal.js-2.6.1/lib", fsep = "/" )
	plugin = file.path( find.package(package.name), "reveal.js-2.6.1/plugin", fsep = "/" )
	Gruntfile = file.path( find.package(package.name), "reveal.js-2.6.1/Gruntfile.js", fsep = "/" )
	LICENSE = file.path( find.package(package.name), "reveal.js-2.6.1/LICENSE", fsep = "/" )
	package.json = file.path( find.package(package.name), "reveal.js-2.6.1/package.json", fsep = "/" )
	
	file.copy( from = css
			, to = www.directory
			,  overwrite = T
			, recursive = T )
	file.copy( from = js
			, to = www.directory
			,  overwrite = T
			, recursive = T )
	file.copy( from = lib
			, to = www.directory
			,  overwrite = T
			, recursive = T )
	file.copy( from = plugin
			, to = www.directory
			,  overwrite = T
			, recursive = T )
	file.copy( from = Gruntfile, to = www.directory,  overwrite = T, recursive = F )
	file.copy( from = LICENSE, to = www.directory,  overwrite = T, recursive = F )
	file.copy( from = package.json, to = www.directory,  overwrite = T, recursive = F )
	
	invisible()
}
