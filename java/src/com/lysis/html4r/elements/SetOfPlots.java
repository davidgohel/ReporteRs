package com.lysis.html4r.elements;

import java.io.IOException;
import java.util.Vector;

import org.rendersnake.HtmlAttributes;
import org.rendersnake.HtmlCanvas;
import org.rendersnake.Renderable;

public class SetOfPlots implements Renderable{
	private Vector<String> img64;
	public SetOfPlots(){
		img64 = new Vector<String>();
	}
	
	public void addImage(String img){
		img64.add(img);
	}
	@Override
	public void renderOn(HtmlCanvas html) throws IOException {

		for( int i = 0 ; i < img64.size() ; i++ ){
			HtmlAttributes ha = new HtmlAttributes();
			ha.add("src", "data:image/png;base64,"+img64.get(i));
			html.div().img(ha);
			html._div();
		}
	}

	

}
