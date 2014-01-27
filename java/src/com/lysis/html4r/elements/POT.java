package com.lysis.html4r.elements;

import java.io.IOException;
import java.util.LinkedHashMap;

import org.rendersnake.HtmlAttributes;
import org.rendersnake.HtmlCanvas;
import org.rendersnake.Renderable;

import com.lysis.html4r.tools.Format;

public class POT implements Renderable{
	private String parent_type;
	private LinkedHashMap<Integer, String> textList;
	private LinkedHashMap<Integer, LinkedHashMap<String, String>> formatList;
	private int index;

	public POT( String parentType ) {
		textList = new LinkedHashMap<Integer, String>();
		formatList = new LinkedHashMap<Integer, LinkedHashMap<String, String>>();
		index = -1;
		parent_type = parentType;
	}

	public void addPot ( String value, int size, boolean bold, boolean italic, boolean underlined, String color, String fontfamily ) throws IOException{
		index++;
		LinkedHashMap<String, String> rpr = Format.getTextProperties(color, size, bold, italic, underlined, fontfamily);
		textList.put(index, org.apache.commons.lang.StringEscapeUtils.escapeHtml(value) );
		formatList.put(index, rpr);
	}
	
	public void addText ( String value ) throws IOException{
		index++;
		textList.put(index, org.apache.commons.lang.StringEscapeUtils.escapeHtml(value) );
		formatList.put(index, null);
	}

	@Override
	public void renderOn(HtmlCanvas html) throws IOException {
		HtmlCanvas out;
		if( parent_type.equals("div") ) out = html.p();
		else if( parent_type.equals("ul") ) out = html.li();
		else if( parent_type.equals("ol") ) out = html.li();
		else if( parent_type.equals("pre") ) out = html.span()._span();
		else out = html.p();

		for(int i = 0 ; i < index +1 ; i++ ){
			if( formatList.get(i) == null )
				out.span().content(textList.get(i), false);
			else {
				HtmlAttributes ha_s = new HtmlAttributes();
				ha_s.add("style", com.lysis.html4r.tools.Format.getJSString(formatList.get(i)));
				HtmlCanvas span = out.span(ha_s);
				span.content(textList.get(i), false);
			}
		}
		
		if( parent_type.equals("div") ) out._p();
		else if( parent_type.equals("ul") ) out._li();
		else if( parent_type.equals("ol") ) out._li();
		else if( parent_type.equals("pre") ) out.br();
		else out._p();

	}

	


}
