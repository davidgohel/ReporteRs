package com.lysis.reporters.tables;

public interface TableFormat {
	public void setHeaderText(String color,int fontsize, boolean strbold, boolean italic, boolean underlined, String fontfamily) throws Exception;
	public void setGroupedheaderText(String color,int fontsize, boolean strbold, boolean italic, boolean underlined, String fontfamily) throws Exception;
	public void setDoubleText(String color,int fontsize, boolean strbold, boolean italic, boolean underlined, String fontfamily) throws Exception;
	public void setIntegerText(String color,int fontsize, boolean strbold, boolean italic, boolean underlined, String fontfamily) throws Exception;
	public void setPercentText(String color,int fontsize, boolean strbold, boolean italic, boolean underlined, String fontfamily) throws Exception;
	public void setCharacterText(String color,int fontsize, boolean strbold, boolean italic, boolean underlined, String fontfamily) throws Exception;
	public void setDateText(String color,int fontsize, boolean strbold, boolean italic, boolean underlined, String fontfamily) throws Exception;
	public void setDatetimeText(String color,int fontsize, boolean strbold, boolean italic, boolean underlined, String fontfamily) throws Exception;	
	public void setLogicalText(String color,int fontsize, boolean strbold, boolean italic, boolean underlined, String fontfamily) throws Exception;	

	public void setHeaderPar(String textalign,int paddingbottom, int paddingtop, int paddingleft, int paddingright) throws Exception;
	public void setGroupedheaderPar(String textalign,int paddingbottom, int paddingtop, int paddingleft, int paddingright) throws Exception;
	public void setDoublePar(String textalign,int paddingbottom, int paddingtop, int paddingleft, int paddingright) throws Exception;
	public void setIntegerPar(String textalign,int paddingbottom, int paddingtop, int paddingleft, int paddingright) throws Exception;
	public void setPercentPar(String textalign,int paddingbottom, int paddingtop, int paddingleft, int paddingright) throws Exception;
	public void setCharacterPar(String textalign,int paddingbottom, int paddingtop, int paddingleft, int paddingright) throws Exception;
	public void setDatePar(String textalign,int paddingbottom, int paddingtop, int paddingleft, int paddingright) throws Exception;
	public void setDatetimePar(String textalign,int paddingbottom, int paddingtop, int paddingleft, int paddingright) throws Exception;
	public void setLogicalPar(String textalign,int paddingbottom, int paddingtop, int paddingleft, int paddingright) throws Exception;
	
	public void setHeaderCell(String borderBottomColor, String borderBottomStyle, int borderBottomWidth
			, String borderLeftColor, String borderLeftStyle, int borderLeftWidth
			, String borderTopColor, String borderTopStyle, int borderTopWidth
			, String borderRightColor, String borderRightStyle, int borderRightWidth, 
			String verticalAlign, int paddingBottom, int paddingTop, int paddingLeft, int paddingRight
			, String backgroundColor
			) throws Exception;

	public void setGroupedheaderCell(String borderBottomColor, String borderBottomStyle, int borderBottomWidth
			, String borderLeftColor, String borderLeftStyle, int borderLeftWidth
			, String borderTopColor, String borderTopStyle, int borderTopWidth
			, String borderRightColor, String borderRightStyle, int borderRightWidth, 
			String verticalAlign, int paddingBottom, int paddingTop, int paddingLeft, int paddingRight
			, String backgroundColor
			) throws Exception;

	public void setDoubleCell(String borderBottomColor, String borderBottomStyle, int borderBottomWidth
			, String borderLeftColor, String borderLeftStyle, int borderLeftWidth
			, String borderTopColor, String borderTopStyle, int borderTopWidth
			, String borderRightColor, String borderRightStyle, int borderRightWidth, 
			String verticalAlign, int paddingBottom, int paddingTop, int paddingLeft, int paddingRight
			, String backgroundColor
			) throws Exception;

	public void setIntegerCell(String borderBottomColor, String borderBottomStyle, int borderBottomWidth
			, String borderLeftColor, String borderLeftStyle, int borderLeftWidth
			, String borderTopColor, String borderTopStyle, int borderTopWidth
			, String borderRightColor, String borderRightStyle, int borderRightWidth, 
			String verticalAlign, int paddingBottom, int paddingTop, int paddingLeft, int paddingRight
			, String backgroundColor
			) throws Exception;
	public void setPercentCell(String borderBottomColor, String borderBottomStyle, int borderBottomWidth
			, String borderLeftColor, String borderLeftStyle, int borderLeftWidth
			, String borderTopColor, String borderTopStyle, int borderTopWidth
			, String borderRightColor, String borderRightStyle, int borderRightWidth, 
			String verticalAlign, int paddingBottom, int paddingTop, int paddingLeft, int paddingRight
			, String backgroundColor
			) throws Exception;
	public void setCharacterCell(String borderBottomColor, String borderBottomStyle, int borderBottomWidth
			, String borderLeftColor, String borderLeftStyle, int borderLeftWidth
			, String borderTopColor, String borderTopStyle, int borderTopWidth
			, String borderRightColor, String borderRightStyle, int borderRightWidth, 
			String verticalAlign, int paddingBottom, int paddingTop, int paddingLeft, int paddingRight
			, String backgroundColor
			) throws Exception;
	
	public void setDateCell(String borderBottomColor, String borderBottomStyle, int borderBottomWidth
			, String borderLeftColor, String borderLeftStyle, int borderLeftWidth
			, String borderTopColor, String borderTopStyle, int borderTopWidth
			, String borderRightColor, String borderRightStyle, int borderRightWidth, 
			String verticalAlign, int paddingBottom, int paddingTop, int paddingLeft, int paddingRight
			, String backgroundColor
			) throws Exception;
	
	public void setDatetimeCell(String borderBottomColor, String borderBottomStyle, int borderBottomWidth
			, String borderLeftColor, String borderLeftStyle, int borderLeftWidth
			, String borderTopColor, String borderTopStyle, int borderTopWidth
			, String borderRightColor, String borderRightStyle, int borderRightWidth, 
			String verticalAlign, int paddingBottom, int paddingTop, int paddingLeft, int paddingRight
			, String backgroundColor
			) throws Exception;

	public void setLogicalCell(String borderBottomColor, String borderBottomStyle, int borderBottomWidth
			, String borderLeftColor, String borderLeftStyle, int borderLeftWidth
			, String borderTopColor, String borderTopStyle, int borderTopWidth
			, String borderRightColor, String borderRightStyle, int borderRightWidth, 
			String verticalAlign, int paddingBottom, int paddingTop, int paddingLeft, int paddingRight
			, String backgroundColor
			) throws Exception;

	
	
}
