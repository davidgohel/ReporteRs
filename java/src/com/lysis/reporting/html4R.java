package com.lysis.reporting;

import java.io.IOException;
import java.util.Iterator;
import java.util.LinkedHashMap;

import com.lysis.html4r.elements.MenuBar;
import com.lysis.html4r.tools.utils;



public class html4R {
	private LinkedHashMap<String, HTMLPageContent> pages;
	private LinkedHashMap<String, String> links;
	private String title;
	private int index;
	private String charset;
	public html4R ( String title, String charset) throws IOException {
		pages  = new LinkedHashMap<String, HTMLPageContent>();
		links  = new LinkedHashMap<String, String>();
		this.title = title;
		index = 0;
		this.charset= charset;
	}
	public void addNewPage ( String title, HTMLPageContent page){
		
		index++;
		String filename = "page_" + index + "_" + utils.generateUniqueId() + ".html";
		pages.put(title, page);
		links.put(title, filename);
		
	}

	public int writeDocument(String directory) {
		
		MenuBar mb = new MenuBar(title);
		for (Iterator<String> it1 = pages.keySet().iterator(); it1.hasNext();) {
			String id = it1.next();
			mb.addTitle(id, links.get(id));
		}
		for (Iterator<String> it1 = pages.keySet().iterator(); it1.hasNext();) {
			String id = it1.next();
			HTMLPageContent doc = pages.get(id);
			try {
				doc.setMenuBar((MenuBar)mb.clone());
			} catch (IOException e) {
				return( HTMLPageContent.error );
			}
			try {
				doc.setActiveMenuBarTitle(id);
			} catch (IOException e) {
				return( HTMLPageContent.error );
			}
		}
		
		for (Iterator<String> it1 = pages.keySet().iterator(); it1.hasNext();) {
			String id = it1.next();
			HTMLPageContent doc = pages.get(id);
			try {
				doc.writeHtmlToStream(directory + "/" + links.get(id), charset);
			} catch (IOException e) {
				return( HTMLPageContent.error );
			} 
		}
		return( HTMLPageContent.noproblem );
		
	}



}

