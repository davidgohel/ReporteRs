
# define some text
sometext = c( "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
		, "In sit amet ipsum tellus. Vivamus dignissim arcu sit amet faucibus auctor."
		, "Quisque dictum tristique ligula."
)

# add sometext with stylename BulletList
doc = addParagraph( doc, value = sometext, stylename="BulletList" )
