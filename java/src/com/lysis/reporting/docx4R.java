package com.lysis.reporting;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;

import org.docx4j.docProps.core.CoreProperties;
import org.docx4j.docProps.core.dc.elements.SimpleLiteral;
import org.docx4j.model.structure.HeaderFooterPolicy;
import org.docx4j.model.structure.SectionWrapper;
import org.docx4j.openpackaging.exceptions.Docx4JException;
import org.docx4j.openpackaging.packages.WordprocessingMLPackage;
import org.docx4j.openpackaging.parts.DocPropsCorePart;
import org.docx4j.wml.ContentAccessor;
import org.docx4j.wml.P;
import org.docx4j.wml.PPr;
import org.docx4j.wml.Styles;

import com.lysis.docx4r.elements.DataTable;
import com.lysis.docx4r.elements.DrawingMLPlot;
import com.lysis.docx4r.elements.Image;
import com.lysis.docx4r.elements.POT;
import com.lysis.docx4r.elements.PageBreak;
import com.lysis.docx4r.elements.TableOfContent;
import com.lysis.docx4r.tools.DocExplorer;
//import com.lysis.docx4r.elements.Paragraph;
//import org.apache.log4j.Level;
//import org.apache.log4j.Logger;
import com.lysis.docx4r.tools.Format;
 
public class docx4R {
	private WordprocessingMLPackage basedoc;

	private int eltIndex;
	private LinkedHashMap<String, String> styleDefinitions;
	
	public docx4R ( ) {
		styleDefinitions = new LinkedHashMap<String, String>();
		eltIndex=0;
	}
	
	private void listStyleNames(){
		Styles styles = basedoc.getMainDocumentPart().getStyleDefinitionsPart().getJaxbElement();      
		for ( org.docx4j.wml.Style s : styles.getStyle() ) {
			if( s.getType().equals("paragraph") )
				styleDefinitions.put( s.getStyleId(), s.getName().getVal() );
		}
	}

	public String[] getStyleNames(){
		listStyleNames();
		String[] stylenames = new String[styleDefinitions.size()];
		int i = 0 ;
		for (Iterator<String> it1 = styleDefinitions.keySet().iterator(); it1.hasNext();) {
			stylenames[i] = it1.next();
			i++;
		}
		return stylenames;
	}
	private boolean existsStyleNames(String stylename){

		for (Iterator<String> it1 = styleDefinitions.keySet().iterator(); it1.hasNext();) {
			if( it1.next().equals(stylename)) return true;
		}
		return false;
	}

	public void setBaseDocument(String baseDocFileName) throws Exception{
		try {
			basedoc = WordprocessingMLPackage.load(new FileInputStream(new File(baseDocFileName)));
		} catch (FileNotFoundException e) {
			throw new Exception ("Cannot load base document [" +  baseDocFileName + "]. File is not found.");
		} catch (Docx4JException e) {
			throw new Exception ("Cannot load base document [" +  baseDocFileName + "]. File is found but a Docx4J exception occured.");
		}
		listStyleNames();
	}
	
	public WordprocessingMLPackage getBaseDocument() {
		return basedoc;
	}
	
	public void incrementElementIndex( int inc) {
		eltIndex = eltIndex + inc;
	}
	
	public int getElementIndex( ) {
		return eltIndex;
	}
	
	public void writeDocxToStream(String target) throws Exception{
		File f = new File(target);
		try {
			basedoc.save(f);
		} catch (Docx4JException e) {
			throw new Exception ("Cannot save document [" +  target + "]. A Docx4J exception occured.");
		}
	}

	public void setDocPropertyTitle(String value){
		DocPropsCorePart docProps = basedoc.getDocPropsCorePart();
		CoreProperties cp = docProps.getJaxbElement();
		org.docx4j.docProps.core.dc.elements.ObjectFactory dcElfactory = new org.docx4j.docProps.core.dc.elements.ObjectFactory();
		SimpleLiteral literal = dcElfactory.createSimpleLiteral();
		literal.getContent().add( value );
		cp.setTitle(dcElfactory.createTitle(literal));
	}
	
	public void setDocPropertyCreator(String value){
		DocPropsCorePart docProps = basedoc.getDocPropsCorePart();
		CoreProperties cp = docProps.getJaxbElement();
		org.docx4j.docProps.core.dc.elements.ObjectFactory dcElfactory = new org.docx4j.docProps.core.dc.elements.ObjectFactory();
		SimpleLiteral literal = dcElfactory.createSimpleLiteral();
		literal.getContent().add(value);
		cp.setCreator(literal);//(dcElfactory.createCreator(literal));
	}

	public void addPageBreak( ) throws Exception{
		eltIndex++;
		basedoc.getMainDocumentPart().addObject( PageBreak.getBreak() );
	}
	public void add( Object obj ) throws Exception{
		eltIndex++;
		basedoc.getMainDocumentPart().addObject(obj);
	}
	public void addTableOfContents( ) throws Exception{
		eltIndex++;
		TableOfContent.addTableOfContents(basedoc.getMainDocumentPart());
	}

	public void addTableOfContents( String stylename ) throws Exception{
		eltIndex++;
		if ( !existsStyleNames (stylename ) ) throw new Exception(stylename + " does not exist.");
		TableOfContent.addTableOfContents(basedoc.getMainDocumentPart(), stylename);
	}

	
	public void deleteBookmark( String bookmark ){
		P p = getPBookmarked(bookmark);
		if( p != null )
			((ContentAccessor)p.getParent()).getContent().remove(p);
	}
	
	public void add( DataTable  dt) throws Exception{
		eltIndex++;
		basedoc.getMainDocumentPart().addObject(dt.getTbl());
	}
	
	public void insert(String bookmark, DataTable table) throws Exception {
		eltIndex++;
		P p = getPBookmarked(bookmark);

		if( p != null ){
		    int i = ((ContentAccessor)p.getParent()).getContent().indexOf(p);
		    ((ContentAccessor)p.getParent()).getContent().remove(i);
		    ((ContentAccessor)p.getParent()).getContent().add(i, table.getTbl());
		} else throw new Exception("can't find bookmark '" + bookmark + "'." );
	}


	public void add( POT pot) {
		eltIndex++;
		for( int i = 0 ; i < pot.getLength() ; i++ )
			basedoc.getMainDocumentPart().addObject(pot.getP(i));
	}
	
	public void insert( String bookmark, POT pot) throws Exception{
		eltIndex++;
		P p = getPBookmarked(bookmark);

		if( p != null ){
		    int i = ((ContentAccessor)p.getParent()).getContent().indexOf(p);
		    ((ContentAccessor)p.getParent()).getContent().remove(i);
		    
		    for( int pid = 0 ; pid < pot.getLength() ; pid++ ) 
		    	((ContentAccessor)p.getParent()).getContent().add(i+pid, pot.getP(pid));
		} else throw new Exception("can't find bookmark '" +bookmark+"'." );
	}
	
	private P getPBookmarked( String bookmark ){
		P p = DocExplorer.traversePartForBookmark(basedoc.getMainDocumentPart(), bookmark);
		if( p == null ){
			List<SectionWrapper> sectionWrappers = basedoc.getDocumentModel().getSections();
			for (SectionWrapper sw : sectionWrappers) {
				if( p != null ) break;
				HeaderFooterPolicy hfp = sw.getHeaderFooterPolicy();
				if (p == null && hfp.getFirstHeader() != null)
					p = DocExplorer.traversePartForBookmark(hfp.getFirstHeader(), bookmark);
				if (p == null && hfp.getDefaultHeader() != null)
					p = DocExplorer.traversePartForBookmark(hfp.getDefaultHeader(), bookmark);
				if (p == null && hfp.getEvenHeader() != null)
					p = DocExplorer.traversePartForBookmark(hfp.getEvenHeader(), bookmark);
				if (p == null && hfp.getFirstFooter() != null)
					p = DocExplorer.traversePartForBookmark(hfp.getFirstFooter(), bookmark);
				if (p == null && hfp.getDefaultFooter() != null)
					p = DocExplorer.traversePartForBookmark(hfp.getDefaultFooter(), bookmark);
				if (p == null && hfp.getEvenFooter() != null)
					p = DocExplorer.traversePartForBookmark(hfp.getEvenFooter(), bookmark);
				
			}
		}
		return p;
	}

	
	public void addImage ( String[] filename, int[] dims, String textalign, int paddingbottom
			, int paddingtop, int paddingleft, int paddingright ) throws Exception {
		int width = dims[0];
		int height = dims[1];
		PPr ppr = Format.getParProperties(textalign, paddingbottom, paddingtop, paddingleft, paddingright);

	    for( int f = 0 ; f < filename.length ; f++ ){
	    	basedoc.getMainDocumentPart().addObject(Image.addImageToPackage(filename[f], basedoc, eltIndex+1, eltIndex + 2, width, height, ppr));
	    	eltIndex = eltIndex + 2;
	    }		
	}

	public void insertImage ( String bookmark, String[] filename, int[] dims, String textalign, int paddingbottom
			, int paddingtop, int paddingleft, int paddingright ) throws Exception {
		P p = getPBookmarked(bookmark);
		int width = dims[0];
		int height = dims[1];
		PPr ppr = Format.getParProperties(textalign, paddingbottom, paddingtop, paddingleft, paddingright);

		if( p != null ){
		    int i = ((ContentAccessor)p.getParent()).getContent().indexOf(p);
		    ((ContentAccessor)p.getParent()).getContent().remove(i);
		    for( int f = 0 ; f < filename.length ; f++ ){
		    	((ContentAccessor)p.getParent()).getContent().add(i+f, Image.addImageToPackage(filename[f], basedoc, eltIndex+1, eltIndex + 2, width, height, ppr));
		    	eltIndex = eltIndex + 2;
		    }
		} else throw new Exception("can't find bookmark '" +bookmark+"'." );
	}

	
	public void addDML ( String[] filename, int[] dims, String textalign, int paddingbottom
			, int paddingtop, int paddingleft, int paddingright ) throws Exception {
		int width = dims[0];
		int height = dims[1];
		PPr ppr = Format.getParProperties(textalign, paddingbottom, paddingtop, paddingleft, paddingright);
	    for( int f = 0 ; f < filename.length ; f++ ){
			DrawingMLPlot dml = new DrawingMLPlot(filename[f]);
			P altp = dml.getP(width, height, eltIndex, ppr);			
			this.add(altp);
	    	eltIndex = eltIndex + 2;
	    }		
	}

	public void insertDML ( String bookmark, String[] filename, int[] dims, String textalign, int paddingbottom
			, int paddingtop, int paddingleft, int paddingright ) throws Exception {
		P p = getPBookmarked(bookmark);
		PPr ppr = Format.getParProperties(textalign, paddingbottom, paddingtop, paddingleft, paddingright);
		if( p != null ){
			int width = dims[0];
			int height = dims[1];
		    int i = ((ContentAccessor)p.getParent()).getContent().indexOf(p);
		    ((ContentAccessor)p.getParent()).getContent().remove(i);

		    for( int f = 0 ; f < filename.length ; f++ ){
				DrawingMLPlot dml = new DrawingMLPlot(filename[f]);
		    	((ContentAccessor)p.getParent()).getContent().add(i+f, dml.getP(width, height, eltIndex, ppr));
		    	eltIndex = eltIndex + 2;
		    }
		} else throw new Exception("can't find bookmark '" +bookmark+"'." );
	}

}

