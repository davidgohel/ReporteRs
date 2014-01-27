package com.lysis.reporting;

import java.io.File;
import java.util.HashMap;
import java.util.Iterator;

import javax.xml.bind.JAXBException;

import org.docx4j.openpackaging.exceptions.Docx4JException;
import org.docx4j.openpackaging.exceptions.InvalidFormatException;
import org.docx4j.openpackaging.packages.PresentationMLPackage;
import org.docx4j.openpackaging.parts.Part;
import org.docx4j.openpackaging.parts.PartName;
import org.docx4j.openpackaging.parts.PresentationML.MainPresentationPart;
import org.docx4j.openpackaging.parts.PresentationML.SlideLayoutPart;
import org.docx4j.openpackaging.parts.PresentationML.SlidePart;
import org.docx4j.relationships.Relationship;
import org.pptx4j.pml.Presentation.SldIdLst;

import com.lysis.pptx4r.elements.layouts.LayoutProperties;
import com.lysis.pptx4r.elements.layouts.ShapeDescription;
import com.lysis.pptx4r.elements.layouts.SlideLayout;
import com.lysis.pptx4r.tools.DocExplorer;

public class pptx4R {

	public static int NO_ERROR = 0;
	public static int READDOC_ERROR = 1;
	public static int LOADDOC_ERROR = 2;
	public static int LAYOUT_ERROR = 3;
	public static int SAVE_ERROR = 4;
	public static int PARTNAME_ERROR = 5;
	public static int SLIDECREATION_ERROR = 6;
	// public static int slidedimensions_error = 7;
	public static int UNDEFINED_ERROR = -1;

	private PresentationMLPackage baseDocument;
	private int slideIndex;
	private HashMap<String, LayoutProperties> layoutList;
	private int width, height;
	private HashMap<Integer, ShapeDescription> masterLayout;
	public pptx4R() {
		slideIndex = 0;
	}

	private int getNewUIDSlide() {
		slideIndex++;
		return slideIndex;
	}



	public int[] readSlideDimensions( ){
		PartName presentationPartname = null;
		int[] dims = new int[2];
		dims[0] = dims[1] = -1;
		
		try {
			presentationPartname = new PartName("/ppt/presentation.xml");
			MainPresentationPart mainPresentationPart = (MainPresentationPart) baseDocument.getParts().getParts().get(presentationPartname);
			dims[0] = mainPresentationPart.getJaxbElement().getSldSz().getCx();
			dims[1] = mainPresentationPart.getJaxbElement().getSldSz().getCy();
		} catch (InvalidFormatException e) {
			System.err.println("unable to read presentation.xml.");
		}
		return dims;
	}
	
	public int setBaseDocument(String baseDocFileName) {
		File baseDocFile = null;

		try {
			baseDocFile = new File(baseDocFileName);
		} catch (Exception e) {
			return READDOC_ERROR;
		}
		try {
			baseDocument = PresentationMLPackage.load(baseDocFile);
		} catch (Docx4JException e) {
			return LOADDOC_ERROR;
		}
		slideIndex = DocExplorer.countExistingSlides(baseDocument);// How much
																	// existing
																	// slides
		try {
			layoutList = DocExplorer.browseLayouts(baseDocument);// read available layouts
			masterLayout = DocExplorer.browseMasterLayout(baseDocument);
		} catch (InvalidFormatException e) {
			System.out.println("LAYOUT_ERROR");
			return LAYOUT_ERROR;

		}
		return NO_ERROR;
	}

	public int writePptxToStream(String target) throws Exception {
		File f = new File(target);
		try {
			baseDocument.save(f);
			return NO_ERROR;
		} catch (Docx4JException e) {
			return SAVE_ERROR;
		}
	}

	public String[] getStyleNames() {
		String[] stylenames = new String[layoutList.size()];
		int i = 0;
		for (Iterator<String> it1 = layoutList.keySet().iterator(); it1
				.hasNext();) {
			stylenames[i] = it1.next();
			i++;
		}
		return stylenames;
	}

	public int getSlideNumber() {
		return slideIndex;
	}

	public SlidePart getNewSlide(String layoutName) throws Exception {
		PartName presentationPartname = null;
		PartName LayoutPartname = null;
		PartName slidePartname = null;

		SlidePart slidePart = null;
		int UIDSlide = getNewUIDSlide();
		try {
			presentationPartname = new PartName("/ppt/presentation.xml");
			LayoutPartname = new PartName(layoutList.get(layoutName).getKey());
			slidePartname = new PartName("/ppt/slides/slide" + UIDSlide
					+ ".xml");
		} catch (InvalidFormatException e) {
			System.err.println("unable to create one of the partnames.");
		}

		MainPresentationPart mainPresentationPart = (MainPresentationPart) baseDocument
				.getParts().getParts().get(presentationPartname);
		SlideLayoutPart layoutPart = (SlideLayoutPart) baseDocument.getParts()
				.getParts().get(LayoutPartname);
		
		width= mainPresentationPart.getJaxbElement().getSldSz().getCx();
		height= mainPresentationPart.getJaxbElement().getSldSz().getCy();
		
		try {
			if (slideIndex < 2) {
				mainPresentationPart.getJaxbElement().setSldIdLst(
						new SldIdLst());
			}

			// OK, now we can create a slide
			slidePart = new SlidePart(slidePartname);
			slidePart.setContents( SlidePart.createSld() );		
			mainPresentationPart.addSlide(slidePart);
			
			// Slide layout part
			slidePart.addTargetPart(layoutPart);

		} catch (InvalidFormatException e) {
			System.err.println("unable to create a new slide.");
		} catch (JAXBException e) {
			System.err.println("unable to create a new slide.");
		}

		return slidePart;
	}
	
	
	public SlidePart getAndReInitExistingSlide(String layoutName, int UIDSlide) throws Exception {
		PartName presentationPartname = null;
		PartName LayoutPartname = null;
		PartName slidePartname = null;

		MainPresentationPart presentation = baseDocument.getMainPresentationPart();
		try {
			presentationPartname = new PartName("/ppt/presentation.xml");
			LayoutPartname = new PartName(layoutList.get(layoutName).getKey());
			slidePartname = new PartName("/ppt/slides/slide" + UIDSlide
					+ ".xml");
		} catch (InvalidFormatException e) {
			System.err.println("unable to create one of the partnames.");
		}

		MainPresentationPart mainPresentationPart = (MainPresentationPart) baseDocument
				.getParts().getParts().get(presentationPartname);
		SlideLayoutPart layoutPart = (SlideLayoutPart) baseDocument.getParts()
				.getParts().get(LayoutPartname);
		
		width= mainPresentationPart.getJaxbElement().getSldSz().getCx();
		height= mainPresentationPart.getJaxbElement().getSldSz().getCy();
		
		Part part = baseDocument.getParts().get(slidePartname);
		Relationship rel = part.getSourceRelationships().get(0);
		presentation.removeSlide(rel);
		
		slideIndex--;
		
		SlidePart slidePart = null;
		try {
			if (slideIndex < 2) {
				mainPresentationPart.getJaxbElement().setSldIdLst(
						new SldIdLst());
			}
			
			// OK, now we can create a slide
			slidePart  = new SlidePart(slidePartname);
			slidePart.setContents( SlidePart.createSld() );		
			mainPresentationPart.addSlide(UIDSlide-1, slidePart);
			
			// Slide layout part
			slidePart.addTargetPart(layoutPart);

		} catch (InvalidFormatException e) {
			System.err.println("unable to create a new slide.");
		} catch (JAXBException e) {
			System.err.println("unable to create a new slide.");
		}

		return slidePart;
	}
	
	public SlideLayout getSlideLayout(String masterName){
		SlideLayout sl = new SlideLayout( getLayoutProperties(masterName), getMasterLayout());
		return sl;
	}
	
   public int getDocWidth() {
		return width;
	}
   
	public int getDocHeight() {
		return height;
	}
			
	protected LayoutProperties getLayoutProperties(String slideName) {
		return layoutList.get(slideName);
	}
	//HashMap<Integer, ShapeDescription> 
	protected HashMap<Integer, ShapeDescription> getMasterLayout() {
		return masterLayout;
	}
	protected PresentationMLPackage getBaseDocument() {
		return baseDocument;
	}
	
}
