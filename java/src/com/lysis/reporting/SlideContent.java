package com.lysis.reporting;

import org.docx4j.dml.CTTransform2D;
import org.docx4j.openpackaging.parts.PresentationML.SlidePart;
import org.pptx4j.pml.CTGraphicalObjectFrame;
import org.pptx4j.pml.Pic;
import org.pptx4j.pml.Shape;

import com.lysis.pptx4r.elements.DataTable;
import com.lysis.pptx4r.elements.Date;
import com.lysis.pptx4r.elements.DrawingMLPlot;
import com.lysis.pptx4r.elements.Footer;
import com.lysis.pptx4r.elements.Image;
import com.lysis.pptx4r.elements.POT;
import com.lysis.pptx4r.elements.SlideNumber;
import com.lysis.pptx4r.elements.SubTitle;
import com.lysis.pptx4r.elements.Title;
import com.lysis.pptx4r.elements.layouts.SlideLayout;

public class SlideContent {
	
	public static int undefined = -1;
	public static int donotexists = 0;
	public static int isfilled = 1;
	public static int noproblem = 2;
	public static int noroomleft = 3;
	public static int undefdimension = 4;

	private SlidePart slidePart;
	private pptx4R itsPPTX;
	private long uidShape;	
	private String layoutName;
	private SlideLayout slideLayout;
	private int slideIndex;
	public SlideContent( String masterName, pptx4R doc ) throws Exception{
		this.layoutName = masterName;
		this.slidePart = doc.getNewSlide(masterName);
		itsPPTX = doc;
		uidShape = -1;
		slideLayout = new SlideLayout( doc.getLayoutProperties(masterName), doc.getMasterLayout());
		slideIndex = doc.getSlideNumber()+1;
	}

	public SlideContent( String masterName, pptx4R doc, int slideIndex ) throws Exception{
		this.layoutName = masterName;
		this.slidePart = doc.getAndReInitExistingSlide(masterName, slideIndex);
		itsPPTX = doc;
		uidShape = -1;
		slideLayout = new SlideLayout( doc.getLayoutProperties(masterName), doc.getMasterLayout());
		this.slideIndex = slideIndex;
	}

	public int getmax_shape(){
		return slideLayout.getContentSize();
	}

	private void setShapeID() {
		uidShape++;
	}

	public int getNextShapeID(){
		long idx = slideLayout.idContent( slideLayout.getContentFilled()  );
		return (int)idx;
	}

	public int getNextIndex(){
		return slideLayout.getContentFilled();
	}
	
	private void setXfrm(CTTransform2D xfrm, CTTransform2D ref) {
		if( ref != null ) {
			xfrm.setOff(ref.getOff());
			xfrm.setExt(ref.getExt());
		} 
	}
	

	
	public int addTitle( String title ) {

		boolean isCRT = false;
		if( !slideLayout.contains(SlideLayout.TITLE) && slideLayout.contains(SlideLayout.CRTTITLE) ) isCRT=true;

		if( !isCRT ){
		
			if( !slideLayout.contains(SlideLayout.TITLE) ) return donotexists;
			else if( slideLayout.isFilled(SlideLayout.TITLE) ) return isfilled;
			else if( slideLayout.contains(SlideLayout.TITLE) && !slideLayout.isFilled(SlideLayout.TITLE)){
				try{
					Shape sTitle = (Shape)Title.getShape(slideLayout.id(SlideLayout.TITLE), uidShape+1, title);
					slidePart.getJaxbElement().getCSld().getSpTree().getSpOrGrpSpOrGraphicFrame().add(sTitle);
					slideLayout.setFilled(SlideLayout.TITLE);
					setShapeID();
					return noproblem;
				} catch(Exception e ) {
					return undefined;
				}
			}
			return undefined;
		} else {
			if( slideLayout.isFilled(SlideLayout.CRTTITLE) ) return isfilled;
			else if( slideLayout.contains(SlideLayout.CRTTITLE) && !slideLayout.isFilled(SlideLayout.CRTTITLE)){
				try{
					Shape sTitle = (Shape)Title.getShape(slideLayout.id(SlideLayout.CRTTITLE), uidShape+1, title);
					slidePart.getJaxbElement().getCSld().getSpTree().getSpOrGrpSpOrGraphicFrame().add(sTitle);
					slideLayout.setFilled(SlideLayout.CRTTITLE);
					setShapeID();
					return noproblem;
				} catch(Exception e ) {
					return undefined;
				}
			}
			return undefined;
		}
	}

	public int addSubTitle(String title) {
		if (!slideLayout.contains(SlideLayout.SUBTITLE))
			return donotexists;
		else if (slideLayout.isFilled(SlideLayout.SUBTITLE))
			return isfilled;
		else if (slideLayout.contains(SlideLayout.SUBTITLE) && !slideLayout.isFilled(SlideLayout.SUBTITLE)) {
			try {
				Shape sTitle = (Shape) SubTitle.getShape( slideLayout.id(SlideLayout.SUBTITLE), uidShape+1, title);
				slidePart.getJaxbElement().getCSld().getSpTree().getSpOrGrpSpOrGraphicFrame().add(sTitle);
				slideLayout.setFilled(SlideLayout.SUBTITLE);
				setShapeID();
				return noproblem;
			} catch (Exception e) {
				return undefined;
			}
		}
		return undefined;
	}

	public int addDate( String date )  {
		if( !slideLayout.contains(SlideLayout.DATE) ) return donotexists;
		else if( slideLayout.isFilled(SlideLayout.DATE) ) return isfilled;
		else if( slideLayout.contains(SlideLayout.DATE) && !slideLayout.isFilled(SlideLayout.DATE)){
			try{
				Shape sDate = (Shape)Date.getShape(slideLayout.id(SlideLayout.DATE), uidShape+1, date);
				slidePart.getJaxbElement().getCSld().getSpTree().getSpOrGrpSpOrGraphicFrame().add(sDate);
				slideLayout.setFilled(SlideLayout.DATE);
				setShapeID();
				return noproblem;
			} catch (Exception e) {
				return undefined;
			}
		}
		return undefined;
	}
	
	public int addSlideNumber( String slidenumber ) {
		if( !slideLayout.contains(SlideLayout.SLIDENUMBER) ) return donotexists;
		else if( slideLayout.isFilled(SlideLayout.SLIDENUMBER) ) return isfilled;
		else if( slideLayout.contains(SlideLayout.SLIDENUMBER) && !slideLayout.isFilled(SlideLayout.SLIDENUMBER)){
			try{
				Shape sSlideNumber = (Shape)SlideNumber.getShape(slideLayout.id(SlideLayout.SLIDENUMBER), uidShape+1, slidenumber);
				slidePart.getJaxbElement().getCSld().getSpTree().getSpOrGrpSpOrGraphicFrame().add(sSlideNumber);	
				slideLayout.setFilled(SlideLayout.SLIDENUMBER);
				setShapeID();
				return noproblem;
			} catch (Exception e) {
				return undefined;
			}
		}
		return undefined;
	}
	
	public int addSlideNumber(  ) {
		return addSlideNumber(slideIndex+"");
	}
	
	public int addFooter( String footer ) {
		if( !slideLayout.contains(SlideLayout.FOOTER) ) return donotexists;
		else if( slideLayout.isFilled(SlideLayout.FOOTER) ) return isfilled;
		else if( slideLayout.contains(SlideLayout.FOOTER) && !slideLayout.isFilled(SlideLayout.FOOTER)){
			try{
				Shape sFooter = (Shape)Footer.getShape(slideLayout.id(SlideLayout.FOOTER), uidShape+1, footer);
				slidePart.getJaxbElement().getCSld().getSpTree().getSpOrGrpSpOrGraphicFrame().add(sFooter);
				slideLayout.setFilled(SlideLayout.FOOTER);
				setShapeID();
				return noproblem;
			} catch (Exception e) {
				return undefined;
			}
		}
		return undefined;
	}

	public int addPicture( String filename ) {
		
		int numContentFilled =slideLayout.getContentFilled();
		
		if( numContentFilled >= slideLayout.getContentSize() ) return noroomleft;
		else{
			try{
				//long idx = slideStr.idContent( numContentFilled  );
				CTTransform2D xfrm;
				try{
					xfrm = slideLayout.getXfrmContent(numContentFilled);
				} catch( NullPointerException e){
					return undefdimension;
				}
				Pic shape = (Pic)Image.getShape(itsPPTX.getBaseDocument(), slidePart, filename
						, uidShape+1, slideLayout.idContent( numContentFilled ) );
				setXfrm(shape.getSpPr().getXfrm(), xfrm);
				slidePart.getJaxbElement().getCSld().getSpTree().getSpOrGrpSpOrGraphicFrame().add(shape);
				setShapeID();
				slideLayout.setContentFilled();
				return noproblem;
			} catch(Exception e ) {
				return undefined;
			}
		}
	}
	
	public int add( DrawingMLPlot d ) {
		int numContentFilled =slideLayout.getContentFilled();
		
		if( numContentFilled >= slideLayout.getContentSize() ) return noroomleft;
		else{
			try {
				
				CTTransform2D xfrm;
				try{
					xfrm = slideLayout.getXfrmContent(numContentFilled);
				} catch( NullPointerException e){
					return undefdimension;
				}
				
				slidePart.getJaxbElement().getCSld().getSpTree().getSpOrGrpSpOrGraphicFrame()
					.addAll(d.getShape(slideLayout.idContent( numContentFilled ), uidShape+1
							, xfrm.getOff().getX(), xfrm.getOff().getY()
							, xfrm.getExt().getCx(), xfrm.getExt().getCy()
							));
				slideLayout.setContentFilled();
				setShapeID();
				return noproblem;
			} catch (Exception e) {
				return undefined;
			}
		}		
	}
	
	public int add( DataTable obj ) {
		int numContentFilled =slideLayout.getContentFilled();
		
		if( numContentFilled >= slideLayout.getContentSize() ) return noroomleft;
		else{
			try {
				long idx = slideLayout.idContent( numContentFilled  );

				CTTransform2D xfrm;
				try{
					xfrm = slideLayout.getXfrmContent(numContentFilled);
				} catch( NullPointerException e){
					return undefdimension;
				}
				
				CTGraphicalObjectFrame shape = obj.getShape(idx, uidShape+1, xfrm.getExt().getCx());
				setXfrm(shape.getXfrm(), xfrm);
				slidePart.getJaxbElement().getCSld().getSpTree().getSpOrGrpSpOrGraphicFrame().add(shape);
				setShapeID();
				slideLayout.setContentFilled();
				return noproblem;
			} catch (Exception e) {
				//e.printStackTrace();
				return undefined;
			}
		}		
	}
	

	public int add( POT obj ) {
		int numContentFilled =slideLayout.getContentFilled();
		if( numContentFilled >= slideLayout.getContentSize() ) return noroomleft;
		else{
			
			try {
				long idx = slideLayout.idContent( numContentFilled );
				Shape par = obj.getShape( uidShape + 1, idx);
				CTTransform2D XfrmContent ;
				try{
					XfrmContent = slideLayout.getXfrmContent(numContentFilled);
				} catch( NullPointerException e){
					return undefdimension;
				}
				setXfrm(par.getSpPr().getXfrm(), XfrmContent);
				slidePart.getJaxbElement().getCSld().getSpTree().getSpOrGrpSpOrGraphicFrame().add(par);
				setShapeID();
				slideLayout.setContentFilled();
				return noproblem;
			} catch (Exception e) {
				e.printStackTrace();
				return undefined;
			}
		}		
	}
	public String getLayoutName() {
		return layoutName;
	}
	
}
