package com.lysis.reporters.tables;


import java.io.IOException;
import java.util.LinkedHashMap;

import com.lysis.html4r.tools.Format;

public class TableLayoutHTML extends TableLayoutBase implements com.lysis.reporters.tables.TableFormat{
	public TableLayoutHTML(String percentAddsymbol, int fractionDoubleDigit,
			int fractionPercentDigit, String datePattern, String timePattern,
			String datetimePattern, String lang, String reg) {
		super(percentAddsymbol, fractionDoubleDigit, fractionPercentDigit, datePattern,
				timePattern, datetimePattern, lang, reg);
	}

	private LinkedHashMap<String, String> headerText;
	private LinkedHashMap<String, String> headerPar;
	private LinkedHashMap<String, String> headerCell;

	private LinkedHashMap<String, String> groupedheaderText;
	private LinkedHashMap<String, String> groupedheaderPar;
	private LinkedHashMap<String, String> groupedheaderCell;

	private LinkedHashMap<String, String> doubleText;
	private LinkedHashMap<String, String> doublePar;
	private LinkedHashMap<String, String> doubleCell;

	private LinkedHashMap<String, String> integerText;
	private LinkedHashMap<String, String> integerPar;
	private LinkedHashMap<String, String> integerCell;


	private LinkedHashMap<String, String> percentText;
	private LinkedHashMap<String, String> percentPar;
	private LinkedHashMap<String, String> percentCell;

	private LinkedHashMap<String, String> characterText;
	private LinkedHashMap<String, String> characterPar;
	private LinkedHashMap<String, String> characterCell;

	private LinkedHashMap<String, String> dateText;
	private LinkedHashMap<String, String> datePar;
	private LinkedHashMap<String, String> dateCell;

	private LinkedHashMap<String, String> datetimeText;
	private LinkedHashMap<String, String> datetimePar;
	private LinkedHashMap<String, String> datetimeCell;

	private LinkedHashMap<String, String> logicalText;
	private LinkedHashMap<String, String> logicalPar;
	private LinkedHashMap<String, String> logicalCell;





	
	public void setHeaderText(String color,int fontsize, boolean strbold, boolean italic, boolean underlined, String fontfamily) throws IOException{
		this.headerText = Format.getTextProperties(color, fontsize, strbold, italic, underlined, fontfamily);
	}

	public void setGroupedheaderText(String color,int fontsize, boolean strbold, boolean italic, boolean underlined, String fontfamily) throws IOException{
		this.groupedheaderText = Format.getTextProperties(color, fontsize, strbold, italic, underlined, fontfamily);
	}

	public void setDoubleText(String color,int fontsize, boolean strbold, boolean italic, boolean underlined, String fontfamily) throws IOException{
		this.doubleText = Format.getTextProperties(color, fontsize, strbold, italic, underlined, fontfamily);
	}

	public void setIntegerText(String color,int fontsize, boolean strbold, boolean italic, boolean underlined, String fontfamily) throws IOException{
		this.integerText = Format.getTextProperties(color, fontsize, strbold, italic, underlined, fontfamily);
	}

	public void setPercentText(String color,int fontsize, boolean strbold, boolean italic, boolean underlined, String fontfamily) throws IOException{
		this.percentText = Format.getTextProperties(color, fontsize, strbold, italic, underlined, fontfamily);
	}

	public void setCharacterText(String color,int fontsize, boolean strbold, boolean italic, boolean underlined, String fontfamily) throws IOException{
		this.characterText = Format.getTextProperties(color, fontsize, strbold, italic, underlined, fontfamily);
	}

	public void setDateText(String color,int fontsize, boolean strbold, boolean italic, boolean underlined, String fontfamily) throws IOException{
		this.dateText = Format.getTextProperties(color, fontsize, strbold, italic, underlined, fontfamily);
	}

	public void setDatetimeText(String color,int fontsize, boolean strbold, boolean italic, boolean underlined, String fontfamily) throws IOException{
		this.datetimeText = Format.getTextProperties(color, fontsize, strbold, italic, underlined, fontfamily);
	}

	public void setLogicalText(String color,int fontsize, boolean strbold, boolean italic, boolean underlined, String fontfamily) throws IOException{
		this.logicalText = Format.getTextProperties(color, fontsize, strbold, italic, underlined, fontfamily);
	}

	public void setHeaderPar(String textalign,int paddingbottom, int paddingtop, int paddingleft, int paddingright) throws Exception{
		this.headerPar = Format.getParProperties(textalign, paddingbottom, paddingtop, paddingleft, paddingright);
	}

	public void setGroupedheaderPar(String textalign,int paddingbottom, int paddingtop, int paddingleft, int paddingright) throws Exception{
		this.groupedheaderPar = Format.getParProperties(textalign, paddingbottom, paddingtop, paddingleft, paddingright);
	}

	public void setDoublePar(String textalign,int paddingbottom, int paddingtop, int paddingleft, int paddingright) throws IOException{
		this.doublePar = Format.getParProperties(textalign, paddingbottom, paddingtop, paddingleft, paddingright);
	}

	public void setIntegerPar(String textalign,int paddingbottom, int paddingtop, int paddingleft, int paddingright) throws IOException{
		this.integerPar = Format.getParProperties(textalign, paddingbottom, paddingtop, paddingleft, paddingright);
	}

	public void setPercentPar(String textalign,int paddingbottom, int paddingtop, int paddingleft, int paddingright) throws IOException{
		this.percentPar = Format.getParProperties(textalign, paddingbottom, paddingtop, paddingleft, paddingright);
	}

	public void setCharacterPar(String textalign,int paddingbottom, int paddingtop, int paddingleft, int paddingright) throws IOException{
		this.characterPar = Format.getParProperties(textalign, paddingbottom, paddingtop, paddingleft, paddingright);
	}

	public void setDatePar(String textalign,int paddingbottom, int paddingtop, int paddingleft, int paddingright) throws IOException{
		this.datePar = Format.getParProperties(textalign, paddingbottom, paddingtop, paddingleft, paddingright);
	}

	public void setDatetimePar(String textalign,int paddingbottom, int paddingtop, int paddingleft, int paddingright) throws IOException{
		this.datetimePar = Format.getParProperties(textalign, paddingbottom, paddingtop, paddingleft, paddingright);
	}

	public void setLogicalPar(String textalign,int paddingbottom, int paddingtop, int paddingleft, int paddingright) throws IOException{
		this.logicalPar = Format.getParProperties(textalign, paddingbottom, paddingtop, paddingleft, paddingright);
	}	


	public void setHeaderCell(String borderBottomColor, String borderBottomStyle, int borderBottomWidth
			, String borderLeftColor, String borderLeftStyle, int borderLeftWidth
			, String borderTopColor, String borderTopStyle, int borderTopWidth
			, String borderRightColor, String borderRightStyle, int borderRightWidth, 
			String verticalAlign, int paddingBottom, int paddingTop, int paddingLeft, int paddingRight
			, String backgroundColor
			) throws IOException{
		this.headerCell = Format.getCellProperties(borderBottomColor, borderBottomStyle, borderBottomWidth, borderLeftColor, borderLeftStyle, borderLeftWidth
				, borderTopColor, borderTopStyle, borderTopWidth, borderRightColor, borderRightStyle
				, borderRightWidth, verticalAlign, paddingBottom, paddingTop, paddingLeft, paddingRight
				, backgroundColor);
	}

	public void setGroupedheaderCell(String borderBottomColor, String borderBottomStyle, int borderBottomWidth
			, String borderLeftColor, String borderLeftStyle, int borderLeftWidth
			, String borderTopColor, String borderTopStyle, int borderTopWidth
			, String borderRightColor, String borderRightStyle, int borderRightWidth, 
			String verticalAlign, int paddingBottom, int paddingTop, int paddingLeft, int paddingRight
			, String backgroundColor
			) throws IOException{
		this.groupedheaderCell = Format.getCellProperties(borderBottomColor, borderBottomStyle, borderBottomWidth, borderLeftColor, borderLeftStyle, borderLeftWidth
				, borderTopColor, borderTopStyle, borderTopWidth, borderRightColor, borderRightStyle
				, borderRightWidth, verticalAlign, paddingBottom, paddingTop, paddingLeft, paddingRight
				, backgroundColor);

	}

	public void setDoubleCell(String borderBottomColor, String borderBottomStyle, int borderBottomWidth
			, String borderLeftColor, String borderLeftStyle, int borderLeftWidth
			, String borderTopColor, String borderTopStyle, int borderTopWidth
			, String borderRightColor, String borderRightStyle, int borderRightWidth, 
			String verticalAlign, int paddingBottom, int paddingTop, int paddingLeft, int paddingRight
			, String backgroundColor
			) throws IOException{
		this.doubleCell = Format.getCellProperties(borderBottomColor, borderBottomStyle, borderBottomWidth, borderLeftColor, borderLeftStyle, borderLeftWidth
				, borderTopColor, borderTopStyle, borderTopWidth, borderRightColor, borderRightStyle
				, borderRightWidth, verticalAlign, paddingBottom, paddingTop, paddingLeft, paddingRight
				, backgroundColor);

	}

	public void setIntegerCell(String borderBottomColor, String borderBottomStyle, int borderBottomWidth
			, String borderLeftColor, String borderLeftStyle, int borderLeftWidth
			, String borderTopColor, String borderTopStyle, int borderTopWidth
			, String borderRightColor, String borderRightStyle, int borderRightWidth, 
			String verticalAlign, int paddingBottom, int paddingTop, int paddingLeft, int paddingRight
			, String backgroundColor
			) throws IOException{
		this.integerCell = Format.getCellProperties(borderBottomColor, borderBottomStyle, borderBottomWidth, borderLeftColor, borderLeftStyle, borderLeftWidth
				, borderTopColor, borderTopStyle, borderTopWidth, borderRightColor, borderRightStyle
				, borderRightWidth, verticalAlign, paddingBottom, paddingTop, paddingLeft, paddingRight
				, backgroundColor);

	}

	public void setPercentCell(String borderBottomColor, String borderBottomStyle, int borderBottomWidth
			, String borderLeftColor, String borderLeftStyle, int borderLeftWidth
			, String borderTopColor, String borderTopStyle, int borderTopWidth
			, String borderRightColor, String borderRightStyle, int borderRightWidth, 
			String verticalAlign, int paddingBottom, int paddingTop, int paddingLeft, int paddingRight
			, String backgroundColor
			) throws IOException{
		this.percentCell = Format.getCellProperties(borderBottomColor, borderBottomStyle, borderBottomWidth, borderLeftColor, borderLeftStyle, borderLeftWidth
				, borderTopColor, borderTopStyle, borderTopWidth, borderRightColor, borderRightStyle
				, borderRightWidth, verticalAlign, paddingBottom, paddingTop, paddingLeft, paddingRight
				, backgroundColor);

	}

	public void setCharacterCell(String borderBottomColor, String borderBottomStyle, int borderBottomWidth
			, String borderLeftColor, String borderLeftStyle, int borderLeftWidth
			, String borderTopColor, String borderTopStyle, int borderTopWidth
			, String borderRightColor, String borderRightStyle, int borderRightWidth, 
			String verticalAlign, int paddingBottom, int paddingTop, int paddingLeft, int paddingRight
			, String backgroundColor
			) throws IOException{
		this.characterCell = Format.getCellProperties(borderBottomColor, borderBottomStyle, borderBottomWidth, borderLeftColor, borderLeftStyle, borderLeftWidth
				, borderTopColor, borderTopStyle, borderTopWidth, borderRightColor, borderRightStyle
				, borderRightWidth, verticalAlign, paddingBottom, paddingTop, paddingLeft, paddingRight
				, backgroundColor);

	}

	public void setDateCell(String borderBottomColor, String borderBottomStyle, int borderBottomWidth
			, String borderLeftColor, String borderLeftStyle, int borderLeftWidth
			, String borderTopColor, String borderTopStyle, int borderTopWidth
			, String borderRightColor, String borderRightStyle, int borderRightWidth, 
			String verticalAlign, int paddingBottom, int paddingTop, int paddingLeft, int paddingRight
			, String backgroundColor
			) throws IOException{
		this.dateCell = Format.getCellProperties(borderBottomColor, borderBottomStyle, borderBottomWidth, borderLeftColor, borderLeftStyle, borderLeftWidth
				, borderTopColor, borderTopStyle, borderTopWidth, borderRightColor, borderRightStyle
				, borderRightWidth, verticalAlign, paddingBottom, paddingTop, paddingLeft, paddingRight
				, backgroundColor);

	}

	public void setDatetimeCell(String borderBottomColor, String borderBottomStyle, int borderBottomWidth
			, String borderLeftColor, String borderLeftStyle, int borderLeftWidth
			, String borderTopColor, String borderTopStyle, int borderTopWidth
			, String borderRightColor, String borderRightStyle, int borderRightWidth, 
			String verticalAlign, int paddingBottom, int paddingTop, int paddingLeft, int paddingRight
			, String backgroundColor
			) throws IOException{
		this.datetimeCell = Format.getCellProperties(borderBottomColor, borderBottomStyle, borderBottomWidth, borderLeftColor, borderLeftStyle, borderLeftWidth
				, borderTopColor, borderTopStyle, borderTopWidth, borderRightColor, borderRightStyle
				, borderRightWidth, verticalAlign, paddingBottom, paddingTop, paddingLeft, paddingRight
				, backgroundColor);

	}

	public void setLogicalCell(String borderBottomColor, String borderBottomStyle, int borderBottomWidth
			, String borderLeftColor, String borderLeftStyle, int borderLeftWidth
			, String borderTopColor, String borderTopStyle, int borderTopWidth
			, String borderRightColor, String borderRightStyle, int borderRightWidth, 
			String verticalAlign, int paddingBottom, int paddingTop, int paddingLeft, int paddingRight
			, String backgroundColor
			) throws IOException{
		this.logicalCell = Format.getCellProperties(borderBottomColor, borderBottomStyle, borderBottomWidth, borderLeftColor, borderLeftStyle, borderLeftWidth
				, borderTopColor, borderTopStyle, borderTopWidth, borderRightColor, borderRightStyle
				, borderRightWidth, verticalAlign, paddingBottom, paddingTop, paddingLeft, paddingRight
				, backgroundColor);

	}
	
	
	
	
	
	
	
	public LinkedHashMap<String, String> getHeaderText() {
		return headerText;
	}

	public LinkedHashMap<String, String> getHeaderPar() {
		return headerPar;
	}

	public LinkedHashMap<String, String> getHeaderCell() {
		return headerCell;
	}

	public LinkedHashMap<String, String> getGroupedheaderText() {
		
		return groupedheaderText;
	}

	public LinkedHashMap<String, String> getGroupedheaderPar() {
		return groupedheaderPar;
	}

	public LinkedHashMap<String, String> getGroupedheaderCell() {
		return groupedheaderCell;
	}

	public LinkedHashMap<String, String> getDoubleText() {
		return doubleText;
	}

	public LinkedHashMap<String, String> getDoublePar() {
		return doublePar;
	}

	public LinkedHashMap<String, String> getDoubleCell() {
		return doubleCell;
	}

	public LinkedHashMap<String, String> getIntegerText() {
		return integerText;
	}

	public LinkedHashMap<String, String> getIntegerPar() {
		return integerPar;
	}

	public LinkedHashMap<String, String> getIntegerCell() {
		return integerCell;
	}

	public LinkedHashMap<String, String> getPercentText() {
		return percentText;
	}

	public LinkedHashMap<String, String> getPercentPar() {
		return percentPar;
	}

	public LinkedHashMap<String, String> getPercentCell() {
		return percentCell;
	}

	public LinkedHashMap<String, String> getCharacterText() {
		return characterText;
	}

	public LinkedHashMap<String, String> getCharacterPar() {
		return characterPar;
	}

	public LinkedHashMap<String, String> getCharacterCell() {
		return characterCell;
	}

	public LinkedHashMap<String, String> getDateText() {
		return dateText;
	}

	public LinkedHashMap<String, String> getDatePar() {
		return datePar;
	}

	public LinkedHashMap<String, String> getDateCell() {
		return dateCell;
	}

	public LinkedHashMap<String, String> getDatetimeText() {
		return datetimeText;
	}

	public LinkedHashMap<String, String> getDatetimePar() {
		return datetimePar;
	}

	public LinkedHashMap<String, String> getDatetimeCell() {
		return datetimeCell;
	}

	public LinkedHashMap<String, String> getLogicalText() {
		return logicalText;
	}

	public LinkedHashMap<String, String> getLogicalPar() {
		return logicalPar;
	}

	public LinkedHashMap<String, String> getLogicalCell() {
		return logicalCell;
	}
	


}
