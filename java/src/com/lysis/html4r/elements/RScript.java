package com.lysis.html4r.elements;

import java.io.IOException;

import org.rendersnake.HtmlCanvas;
import org.rendersnake.Renderable;

public class RScript implements Renderable{
	private String rawHTML;
	public RScript(String html){
		rawHTML = html;
	}
	
	@Override
	public void renderOn(HtmlCanvas html) throws IOException {
		
		html.div();
		html.pre();
		
		html.write(rawHTML, false);
		
		html._pre();
		html._div();

	}


}
