package com.lysis.reporting;

import static org.rendersnake.HtmlAttributesFactory.http_equiv;
import static org.rendersnake.HtmlAttributesFactory.name;
import static org.rendersnake.HtmlAttributesFactory.rel;
import static org.rendersnake.HtmlAttributesFactory.type;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

import org.rendersnake.HtmlCanvas;

import com.lysis.html4r.elements.DataTable;
import com.lysis.html4r.elements.MenuBar;
import com.lysis.html4r.elements.RScript;
import com.lysis.html4r.elements.SetOfPlots;
import com.lysis.html4r.elements.SetOfPot;
import com.lysis.html4r.elements.SetOfRaphaelPlots;
import com.lysis.html4r.elements.TOC;
import com.lysis.html4r.elements.Title;

public class HTMLPageContent {
	
	public static int error = 0;
	public static int noproblem = 1;
	public static int fileproblem = 2;


	
	private HtmlCanvas html ;
	private TOC titles;
	private String title;
	private MenuBar mb;
	

	public HTMLPageContent ( String title) throws IOException {
		html  = new HtmlCanvas();
		this.title = title;
		titles = new TOC(this.title);
	}

	public int add( SetOfPot pot )  {
		try {
			html.render(pot);
			return noproblem;
		} catch (IOException e) {
			return error;
		}
	}//
	
	public int add( RScript rscript )  {
		try {
			html.render(rscript);
			return noproblem;
		} catch (IOException e) {
			return error;
		}
	}//RScript

	
	public void setMenuBar( MenuBar mb ) throws IOException {
		this.mb = mb;
	}
	public void setActiveMenuBarTitle( String title) throws IOException {
		mb.setActiveTitle(title);
	}

	public int add( Title title ) {
		
		try {
			titles.addTitle(title);
			html.render(title);
			return noproblem;
		} catch (IOException e) {
			return error;
		}
	}
	public int add( SetOfPlots c ) {
		try {
			html.render(c);
			return noproblem;
		} catch (IOException e) {
			return error;
		}
	}
	public int add( SetOfRaphaelPlots c ){
		try {
			html.render(c);
			return noproblem;
		} catch (IOException e) {
			return error;
		}
	}
	public int add( DataTable table ) {
		try {
			html.render(table);
			return noproblem;
		} catch (IOException e) {
			return error;
		}
	}

	
	public void writeHtmlToStream(String target, String charset) throws IOException {
		HtmlCanvas doc = new HtmlCanvas();
		File f = new File(target);
        BufferedWriter output = new BufferedWriter(new FileWriter(f));
        
		doc
		.html()
		.head()
		    .meta(
		        name("viewport")
		        .content("width=device-width, initial-scale=1.0"))
		    .meta(
		        http_equiv("Content-Type")
		        .content("text/html; charset="+charset))
		    .title().write(title,false)._title()
		    .link(
		        rel("stylesheet")
		        .href("css/bootstrap.min.css")
		        .type("text/css")
		        .media("all"))
		    .link(
		        rel("stylesheet")
		        .href("css/html4r.css")
		        .type("text/css")
		        .media("all"))
		    .link(
		        rel("stylesheet")
		        .href("css/highlight.css")
		        .type("text/css")
		        .media("all"))
		    .meta(
		        name("format-detection")
		        .content("telephone=no"))
		    .script(type("text/javascript").src("js/jquery.min.js"))._script()
		    .script(type("text/javascript").src("js/bootstrap.min.js"))._script()
		    .script(type("text/javascript").src("js/raphael-min.js"))._script()
		._head()
		.body()
		.write("<div class=\"container bs-docs-container\">", false)
		    .write("<div class=\"row\">", false)
		        .write("<div class=\"col-md-3\" id=\"navbar-div\">", false)
			        .write("<div class=\"navbar-fixed-topleft nav nav-list bs-sidebar\" role=\"navigation\">", false)
			        .render(titles)
			        .write("</div>", false)
		        .write("</div>", false)
		        .write("<div class=\"col-md-9\" data-spy=\"scroll\" data-target=\"#navbar-div\">", false);

        output.write("<!DOCTYPE html>");
        output.write(doc.toHtml());
        
        output.write(html.toHtml());
        output.write("</div>");//col-md-9
        output.write("</div>");//row
        output.write("</div>");//container
        output.write(mb.getHTML());
        output.write("<script type=\"text/javascript\">$('body').scrollspy({ target: '#navbar-div' });</script>");
        output.write("</body>");
        output.write("</html>");
        output.close();
	

	}



}

