
# define some texts
texts = c( "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
		, "In sit amet ipsum tellus. Vivamus dignissim arcu sit amet faucibus auctor."
		, "Quisque dictum tristique ligula."
)

# add texts with stylename BulletList
doc = addParagraph( doc, value = texts, stylename="BulletList" )
