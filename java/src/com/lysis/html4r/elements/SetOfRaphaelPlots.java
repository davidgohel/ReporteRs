package com.lysis.html4r.elements;

import java.io.IOException;
import java.util.Iterator;
import java.util.LinkedHashMap;

import org.rendersnake.HtmlAttributes;
import org.rendersnake.HtmlCanvas;
import org.rendersnake.Renderable;

public class SetOfRaphaelPlots implements Renderable{
	private LinkedHashMap<String, String> img64;
	public SetOfRaphaelPlots(){
		img64 = new LinkedHashMap<String, String>();
	}
	
	public void addSlide(String id, String file){
		img64.put(id, file);
	}
	@Override
	public void renderOn(HtmlCanvas html) throws IOException {


		HtmlAttributes ceg = new HtmlAttributes();
		ceg.class_("container");

		html.div(ceg);

		for (Iterator<String> it1 = img64.keySet().iterator(); it1.hasNext();) {

			String id = it1.next();
			HtmlAttributes ha = new HtmlAttributes();
			ha.id(id);
			ha.add("width", "100%" );
			html.div(ha)._div();
			html.write("<script type=\"text/javascript\">", false);
			html.write(img64.get(id),false);
			html.write("</script>", false);
		}

		html._div();
	}

	

}
