# define some text
text1 = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
text2 = "In sit amet ipsum tellus. Vivamus arcu sit faucibus auctor."
text3 = "Quisque dictum tristique ligula."

# define parProperties with list properties
ordered.list.level1 = parProperties(list.style = "ordered", 
	level = 1 )
ordered.list.level2 = parProperties(list.style = "ordered", 
	level = 2 )

# define parProperties with list properties
unordered.list.level1 = parProperties(list.style = "unordered", 
	level = 1 )
unordered.list.level2 = parProperties(list.style = "unordered", 
	level = 2 )

# add ordered list items 
doc = addParagraph( doc, value = text1, 
	par.properties = ordered.list.level1 )
doc = addParagraph( doc, value = text2, append = TRUE, 
	par.properties = ordered.list.level2 )

doc = addParagraph(doc, "This paragraph has no list attribute", 
	append = TRUE )

# add ordered list items without restart renumbering
doc = addParagraph( doc, value = c( text1, text2, text3), 
	append = TRUE, par.properties = ordered.list.level1 )

# add ordered list items and restart renumbering
doc = addParagraph( doc, value = c( text1, text2, text3), 
	append = TRUE, restart.numbering = TRUE, 
	par.properties = ordered.list.level1 )

# add unordered list items
doc = addParagraph( doc, value = text1, 
		append = TRUE, 
		par.properties = unordered.list.level1 )
doc = addParagraph( doc, value = text2, 
		append = TRUE, 
		par.properties = unordered.list.level2 )

