# loop over layout names to plot each slide style
for(i in layouts ){
	slide.layouts(doc, i )
	title(sub = i )
	if( interactive() ) readline(prompt = "show next slide layout")
} 
