package com.lysis.html4r.elements;

import java.io.IOException;
import java.util.LinkedHashMap;

import org.rendersnake.HtmlCanvas;
import org.rendersnake.Renderable;
import static org.rendersnake.HtmlAttributesFactory.*;


import com.lysis.html4r.elements.POT;

public class SetOfPot implements Renderable{
	private String class_;
	private LinkedHashMap<Integer, POT> potList;
	private int index;
	String type;
	
	public SetOfPot(String type, String class_){
		this.class_=class_;
		this.type = type;
		index = -1;
		potList = new LinkedHashMap<Integer, POT>();
	}
	
	public void addP ( POT pot ){
		index++;
		potList.put(index, pot);
	}
	
	private POT getP( int i) {
		return potList.get(i);
	}

	@Override
	public void renderOn(HtmlCanvas html) throws IOException {
		HtmlCanvas out = html.p();
		
		if( type.equals("div") ) out = html.div(class_(class_));
		else if( type.equals("ul") ) out = html.ul(class_(class_));
		else if( type.equals("ol") ) out = html.ol(class_(class_));
		else if( type.equals("pre") ) out = html.pre(class_(class_));
		else out = html.p(class_(class_));
		
		for(int i = 0 ; i <= index ; i++ ){
			out.render(getP(i));
		}
		if( type.equals("div") ) out = html._div();
		else if( type.equals("ul") ) out = html._ul();
		else if( type.equals("ol") ) out = html._ol();
		else if( type.equals("pre") ) out = html._pre();
		else out = html.p();
		
	}
}
