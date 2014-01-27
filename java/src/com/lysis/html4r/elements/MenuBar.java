package com.lysis.html4r.elements;

import java.io.IOException;
import java.util.Iterator;
import java.util.LinkedHashMap;

public class MenuBar implements Cloneable {
	private LinkedHashMap<String, String> titles;
	private String brand;
	private String activeTitle;
	
	public MenuBar(String headStr){
		titles = new LinkedHashMap<String, String>();
		brand = org.apache.commons.lang.StringEscapeUtils.escapeHtml(headStr);
	}
	
	public void addTitle(String title, String filename){
		titles.put(title, filename);
	}
	
	public void setActiveTitle(String title){
		activeTitle = title;
	}
	
	public Object clone() {
		Object o = null;
		try {
			// On récupère l'instance à renvoyer par l'appel de la 
			// méthode super.clone()
			o = super.clone();
		} catch(CloneNotSupportedException cnse) {
			// Ne devrait jamais arriver car nous implémentons 
			// l'interface Cloneable
			cnse.printStackTrace(System.err);
		}
		// on renvoie le clone
		return o;
	}
	/*
	<div id="navbar-div">
		<div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
			<div class="container">
				<a class="navbar-brand" href="#">Brand</a>
				<button class = "navbar-toggle" data-toggle = "collapse">
					<span class = "icon-bar"></span>
					<span class = "icon-bar"></span>
					<span class = "icon-bar"></span>
				</button>
				<div class="collapse navbar-collapse">
					<ul class="nav navbar-nav navbar-left">
						<li class="active"><a href="#UIDKdU3FD75Lh">Title 1</a></li>
						<li><a href="#UIDMLGYcVtlXC">Title 2</a></li>
						<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Title 3<b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><a href="#UIDaV8QZfgJmF">Title 3</a></li>
								<li><a href="#UIDaV8QZfgXXX">Title 3.1</a></li>
								
							</ul></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	*/

	public String getHTML() throws IOException {
		String ul = "<ul class=\"nav navbar-nav navbar-left\">";
		for (Iterator<String> it1 = titles.keySet().iterator(); it1.hasNext();) {
			String title = it1.next();
			String link = titles.get(title);
			if( activeTitle.equals(title) )
				ul += "<li class=\"active\"><a href=\"" + link + "\">" + org.apache.commons.lang.StringEscapeUtils.escapeHtml(title) + "</a></li>";
			else ul += "<li><a href=\"" + link + "\">" + org.apache.commons.lang.StringEscapeUtils.escapeHtml(title) + "</a></li>";
		}
		ul += "</ul>";
		
		String temp = "<div class=\"navbar navbar-inverse navbar-fixed-top\" role=\"navigation\">"
				+ "<div class=\"container\">"
					+ "<a class=\"navbar-brand\" href=\"#\">" + brand + "</a>"
					+ "<button class = \"navbar-toggle\" data-toggle = \"collapse\">"
						+ "<span class = \"icon-bar\"></span>"
						+ "<span class = \"icon-bar\"></span>"
						+ "<span class = \"icon-bar\"></span>"
					+ "</button>"
					+ "<div class=\"collapse navbar-collapse\">"
						+ ul
					+ "</div>"
				+ "</div>"
			+ "</div>";
		
		return temp;

	}


}
