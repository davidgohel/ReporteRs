package com.lysis.docx4r.tools;

import java.math.BigInteger;


import org.docx4j.wml.BooleanDefaultTrue;
import org.docx4j.wml.CTBorder;
import org.docx4j.wml.CTShd;
import org.docx4j.wml.CTVerticalJc;
import org.docx4j.wml.HpsMeasure;
import org.docx4j.wml.Jc;
import org.docx4j.wml.JcEnumeration;
import org.docx4j.wml.PPr;
import org.docx4j.wml.PPrBase;
import org.docx4j.wml.RFonts;
import org.docx4j.wml.RPr;
import org.docx4j.wml.STVerticalJc;
import org.docx4j.wml.TblWidth;
import org.docx4j.wml.TcMar;
import org.docx4j.wml.TcPr;
import org.docx4j.wml.TcPrInner.TcBorders;
import org.docx4j.wml.U;
import org.docx4j.wml.UnderlineEnumeration;

public class Format {
	
	public static RPr getTextProperties(String color,int fontsize, boolean strbold, boolean italic, boolean underlined, String fontfamily){
		RPr runProperties = new RPr();
		
		HpsMeasure size = new HpsMeasure();
		size.setVal( BigInteger.valueOf( fontsize*2 ) );
		runProperties.setSz( size );
		
		RFonts rfonts = new RFonts();
        rfonts.setAscii(fontfamily);
        rfonts.setCs(fontfamily);
        rfonts.setHAnsi(fontfamily);
		runProperties.setRFonts(rfonts);
		
		if( strbold ){
			BooleanDefaultTrue b = new BooleanDefaultTrue();
			b.setVal(true);
	        runProperties.setB(b);
		}
		
		if( italic ){
			BooleanDefaultTrue b = new BooleanDefaultTrue();
			b.setVal(true);
	        runProperties.setI(b);
		}
		
		if( underlined ){
			U u = new U(); 
			u.setVal(UnderlineEnumeration.SINGLE);
			runProperties.setU(u);
		}
		
		
		org.docx4j.wml.Color col = new org.docx4j.wml.Color();
		col.setVal(color);
		runProperties.setColor(col);
		
		return runProperties;
	}

	public static PPr getParProperties(String textalign,int paddingbottom
			, int paddingtop, int paddingleft, int paddingright){
		PPr parProperties = new PPr();
		
		Jc alignment = new Jc();
		if( textalign.equals("left")) alignment.setVal(JcEnumeration.LEFT);
		else if( textalign.equals("center")) alignment.setVal(JcEnumeration.CENTER);
		else if( textalign.equals("right")) alignment.setVal(JcEnumeration.RIGHT);
		else if( textalign.equals("justify")) alignment.setVal(JcEnumeration.BOTH);
        parProperties.setJc(alignment); 
		
        PPrBase.Spacing space = new PPrBase.Spacing();
        space.setBefore(BigInteger.valueOf((long)paddingtop));
        space.setAfter(BigInteger.valueOf((long)paddingbottom));
        parProperties.setSpacing(space);
        
        PPrBase.Ind padding = new PPrBase.Ind();
        padding.setLeft(BigInteger.valueOf((long)paddingleft));
        padding.setRight(BigInteger.valueOf((long)paddingright));
        parProperties.setInd(padding);

        return parProperties;

	}


	
	public static TcPr getCellProperties(String borderBottomColor, String borderBottomStyle, int borderBottomWidth
			, String borderLeftColor, String borderLeftStyle, int borderLeftWidth
			, String borderTopColor, String borderTopStyle, int borderTopWidth
			, String borderRightColor, String borderRightStyle, int borderRightWidth, 
			String verticalAlign, int paddingBottom, int paddingTop, int paddingLeft, int paddingRight
			, String backgroundColor
			) {
		TcPr tcPr = new TcPr();
		
		CTShd shd = new CTShd();
		shd.setFill(backgroundColor);
		tcPr.setShd(shd);
		
		TcBorders tcb = new TcBorders();
	    tcb.setBottom(getBorder( borderBottomColor, borderBottomStyle, borderBottomWidth));
	    tcb.setLeft(getBorder( borderLeftColor, borderLeftStyle, borderLeftWidth));
	    tcb.setRight(getBorder( borderRightColor, borderRightStyle, borderRightWidth));
	    tcb.setTop(getBorder( borderTopColor, borderTopStyle, borderTopWidth));
	    tcPr.setTcBorders(tcb);
		
	    CTVerticalJc valign = new CTVerticalJc();
	    if( verticalAlign.equals("center") )
	    	valign.setVal(STVerticalJc.CENTER);
	    else if( verticalAlign.equals("middle") )
	    	valign.setVal(STVerticalJc.CENTER);
	    else if( verticalAlign.equals("top") )
	    	valign.setVal(STVerticalJc.TOP);
	    else if( verticalAlign.equals("bottom") )
	    	valign.setVal(STVerticalJc.BOTTOM);
	    else valign.setVal(STVerticalJc.CENTER);
	    tcPr.setVAlign(valign);
		
	    tcPr.setTcMar(getMargins(paddingBottom, paddingTop, paddingLeft, paddingRight) );

	    return tcPr;
	}
	
	private static TcMar getMargins (int paddingBottom, int paddingTop, int paddingLeft, int paddingRight){
	    TcMar mar = new TcMar();
	    
	    TblWidth bottomWidth = new TblWidth();
	    bottomWidth.setW(BigInteger.valueOf( (long)(paddingBottom*20)) );
	    bottomWidth.setType("dxa");
	    mar.setBottom(bottomWidth);
	    
	    TblWidth topWidth = new TblWidth();
	    topWidth.setW(BigInteger.valueOf( (long)(paddingTop*20)) );
	    topWidth.setType("dxa");
	    mar.setTop(topWidth);

	    TblWidth leftWidth = new TblWidth();
	    leftWidth.setW(BigInteger.valueOf( (long)(paddingLeft*20)) );
	    leftWidth.setType("dxa");
	    mar.setLeft(leftWidth);
	    
	    TblWidth rightWidth = new TblWidth();
	    rightWidth.setW(BigInteger.valueOf( (long)(paddingRight*20)) );
	    rightWidth.setType("dxa");
	    mar.setRight(rightWidth);
	    
	    return mar;
	}
	private static CTBorder getBorder (String borderColor, String borderStyle, int borderWidth){
		CTBorder border = new CTBorder();
		if( borderWidth > 0 ){
			border.setColor(borderColor);
		    border.setSz(BigInteger.valueOf((long)( borderWidth * 4 )));
		    //c( "groove", "ridge" )
		    if( borderStyle.equals("single") )
		    	border.setVal(org.docx4j.wml.STBorder.SINGLE);
		    else if( borderStyle.equals("none") )
		    	border.setVal(org.docx4j.wml.STBorder.NONE);
		    else if( borderStyle.equals("hidden") )
		    	border.setVal(org.docx4j.wml.STBorder.NONE);
		    else if( borderStyle.equals("double") )
		    	border.setVal(org.docx4j.wml.STBorder.DOUBLE);
		    else if( borderStyle.equals("dotted") )
		    	border.setVal(org.docx4j.wml.STBorder.DOTTED);
		    else if( borderStyle.equals("dashed") )
		    	border.setVal(org.docx4j.wml.STBorder.DASHED);
		    else if( borderStyle.equals("inset") )
		    	border.setVal(org.docx4j.wml.STBorder.INSET);
		    else if( borderStyle.equals("outset") )
		    	border.setVal(org.docx4j.wml.STBorder.OUTSET);
		    else border.setVal(org.docx4j.wml.STBorder.SINGLE);
		} else border.setVal(org.docx4j.wml.STBorder.NONE);
	    return border;
	}
}
