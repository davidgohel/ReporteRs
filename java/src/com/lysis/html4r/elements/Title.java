package com.lysis.html4r.elements;

import java.io.IOException;

import org.rendersnake.HtmlAttributes;
import org.rendersnake.HtmlCanvas;
import org.rendersnake.Renderable;

import com.lysis.html4r.tools.utils;

public class Title implements Renderable{
	private String value;
	private int level;
	private String uid;

	public Title(String str, int lev){
		value = org.apache.commons.lang.StringEscapeUtils.escapeHtml(str);
		level = lev;
		uid = utils.generateUniqueId();

	}
	public String getUID(){
		return uid;
	}
	public int getLevel(){
		return level;
	}
	public String getValue(){
		return value;
	}
	
	@Override
	public void renderOn(HtmlCanvas html) throws IOException {
		HtmlCanvas title ;
		HtmlAttributes ha = new HtmlAttributes();
		ha.id(uid);
		if( level == 1 ) title = html.h1(ha);
		else if( level == 2 ) title = html.h2(ha);
		else if( level == 3 ) title = html.h3(ha);
		else if( level == 4 ) title = html.h4(ha);
		else if( level == 5 ) title = html.h5(ha);
		else if( level == 6 ) title = html.h6(ha);
		else title = html.h1();
		title.content(value, false);

	}

	

}
