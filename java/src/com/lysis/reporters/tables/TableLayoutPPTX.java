package com.lysis.reporters.tables;

import org.docx4j.dml.CTTableCellProperties;
import org.docx4j.dml.CTTextCharacterProperties;
import org.docx4j.dml.CTTextParagraphProperties;

import com.lysis.pptx4r.tools.Format;


public class TableLayoutPPTX extends TableLayoutBase implements com.lysis.reporters.tables.TableFormat{
	public TableLayoutPPTX(String percentAddsymbol, int fractionDoubleDigit,
			int fractionPercentDigit, String datePattern, String timePattern,
			String datetimePattern, String lang, String reg) {
		super(percentAddsymbol, fractionDoubleDigit, fractionPercentDigit, datePattern,
				timePattern, datetimePattern, lang, reg);
	}

	private CTTextCharacterProperties headerText;
	private CTTextParagraphProperties headerPar;
	private CTTableCellProperties headerCell;

	private CTTextCharacterProperties groupedheaderText;
	private CTTextParagraphProperties groupedheaderPar;
	private CTTableCellProperties groupedheaderCell;

	private CTTextCharacterProperties doubleText;
	private CTTextParagraphProperties doublePar;
	private CTTableCellProperties doubleCell;

	private CTTextCharacterProperties integerText;
	private CTTextParagraphProperties integerPar;
	private CTTableCellProperties integerCell;


	private CTTextCharacterProperties percentText;
	private CTTextParagraphProperties percentPar;
	private CTTableCellProperties percentCell;

	private CTTextCharacterProperties characterText;
	private CTTextParagraphProperties characterPar;
	private CTTableCellProperties characterCell;

	private CTTextCharacterProperties dateText;
	private CTTextParagraphProperties datePar;
	private CTTableCellProperties dateCell;

	private CTTextCharacterProperties datetimeText;
	private CTTextParagraphProperties datetimePar;
	private CTTableCellProperties datetimeCell;

	private CTTextCharacterProperties logicalText;
	private CTTextParagraphProperties logicalPar;
	private CTTableCellProperties logicalCell;

	
	
	public void setHeaderText(String color,int fontsize, boolean strbold, boolean italic, boolean underlined, String fontfamily) throws Exception{
		this.headerText = Format.getTextProperties(color, fontsize, strbold, italic, underlined, fontfamily);
	}

	public void setGroupedheaderText(String color,int fontsize, boolean strbold, boolean italic, boolean underlined, String fontfamily) throws Exception{
		this.groupedheaderText = Format.getTextProperties(color, fontsize, strbold, italic, underlined, fontfamily);
	}

	public void setDoubleText(String color,int fontsize, boolean strbold, boolean italic, boolean underlined, String fontfamily) throws Exception{
		this.doubleText = Format.getTextProperties(color, fontsize, strbold, italic, underlined, fontfamily);
	}

	public void setIntegerText(String color,int fontsize, boolean strbold, boolean italic, boolean underlined, String fontfamily) throws Exception{
		this.integerText = Format.getTextProperties(color, fontsize, strbold, italic, underlined, fontfamily);
	}

	public void setPercentText(String color,int fontsize, boolean strbold, boolean italic, boolean underlined, String fontfamily) throws Exception{
		this.percentText = Format.getTextProperties(color, fontsize, strbold, italic, underlined, fontfamily);
	}

	public void setCharacterText(String color,int fontsize, boolean strbold, boolean italic, boolean underlined, String fontfamily) throws Exception{
		this.characterText = Format.getTextProperties(color, fontsize, strbold, italic, underlined, fontfamily);
	}

	public void setDateText(String color,int fontsize, boolean strbold, boolean italic, boolean underlined, String fontfamily) throws Exception{
		this.dateText = Format.getTextProperties(color, fontsize, strbold, italic, underlined, fontfamily);
	}

	public void setDatetimeText(String color,int fontsize, boolean strbold, boolean italic, boolean underlined, String fontfamily) throws Exception{
		this.datetimeText = Format.getTextProperties(color, fontsize, strbold, italic, underlined, fontfamily);
	}
	
	public void setLogicalText(String color,int fontsize, boolean strbold, boolean italic, boolean underlined, String fontfamily) throws Exception{
		this.logicalText = Format.getTextProperties(color, fontsize, strbold, italic, underlined, fontfamily);
	}

	
	public void setHeaderPar(String textalign,int paddingbottom, int paddingtop, int paddingleft, int paddingright){
		this.headerPar = Format.getParProperties(textalign, paddingbottom, paddingtop, paddingleft, paddingright);
	}

	public void setGroupedheaderPar(String textalign,int paddingbottom, int paddingtop, int paddingleft, int paddingright){
		this.groupedheaderPar = Format.getParProperties(textalign, paddingbottom, paddingtop, paddingleft, paddingright);
	}

	public void setDoublePar(String textalign,int paddingbottom, int paddingtop, int paddingleft, int paddingright){
		this.doublePar = Format.getParProperties(textalign, paddingbottom, paddingtop, paddingleft, paddingright);
	}

	public void setIntegerPar(String textalign,int paddingbottom, int paddingtop, int paddingleft, int paddingright){
		this.integerPar = Format.getParProperties(textalign, paddingbottom, paddingtop, paddingleft, paddingright);
	}

	public void setPercentPar(String textalign,int paddingbottom, int paddingtop, int paddingleft, int paddingright){
		this.percentPar = Format.getParProperties(textalign, paddingbottom, paddingtop, paddingleft, paddingright);
	}

	public void setCharacterPar(String textalign,int paddingbottom, int paddingtop, int paddingleft, int paddingright){
		this.characterPar = Format.getParProperties(textalign, paddingbottom, paddingtop, paddingleft, paddingright);
	}

	public void setDatePar(String textalign,int paddingbottom, int paddingtop, int paddingleft, int paddingright){
		this.datePar = Format.getParProperties(textalign, paddingbottom, paddingtop, paddingleft, paddingright);
	}

	public void setDatetimePar(String textalign,int paddingbottom, int paddingtop, int paddingleft, int paddingright){
		this.datetimePar = Format.getParProperties(textalign, paddingbottom, paddingtop, paddingleft, paddingright);
	}

	public void setLogicalPar(String textalign,int paddingbottom, int paddingtop, int paddingleft, int paddingright) {
		this.logicalPar = Format.getParProperties(textalign, paddingbottom, paddingtop, paddingleft, paddingright);
	}


	public void setHeaderCell(String borderBottomColor, String borderBottomStyle, int borderBottomWidth
			, String borderLeftColor, String borderLeftStyle, int borderLeftWidth
			, String borderTopColor, String borderTopStyle, int borderTopWidth
			, String borderRightColor, String borderRightStyle, int borderRightWidth, 
			String verticalAlign, int paddingBottom, int paddingTop, int paddingLeft, int paddingRight
			, String backgroundColor
			) throws Exception{
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
			) throws Exception{
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
			) throws Exception{
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
			) throws Exception{
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
			) throws Exception{
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
			) throws Exception{
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
			) throws Exception{
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
			) throws Exception{
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
			) throws Exception{
		this.logicalCell = Format.getCellProperties(borderBottomColor, borderBottomStyle, borderBottomWidth, borderLeftColor, borderLeftStyle, borderLeftWidth
				, borderTopColor, borderTopStyle, borderTopWidth, borderRightColor, borderRightStyle
				, borderRightWidth, verticalAlign, paddingBottom, paddingTop, paddingLeft, paddingRight
				, backgroundColor);

	}
	
	
	
	
	
	
	
	public CTTextCharacterProperties getHeaderText() {
		return headerText;
	}

	public CTTextParagraphProperties getHeaderPar() {
		return headerPar;
	}

	public CTTableCellProperties getHeaderCell() {
		return headerCell;
	}

	public CTTextCharacterProperties getGroupedheaderText() {
		
		return groupedheaderText;
	}

	public CTTextParagraphProperties getGroupedheaderPar() {
		return groupedheaderPar;
	}

	public CTTableCellProperties getGroupedheaderCell() {
		return groupedheaderCell;
	}

	public CTTextCharacterProperties getDoubleText() {
		return doubleText;
	}

	public CTTextParagraphProperties getDoublePar() {
		return doublePar;
	}

	public CTTableCellProperties getDoubleCell() {
		return doubleCell;
	}

	public CTTextCharacterProperties getIntegerText() {
		return integerText;
	}

	public CTTextParagraphProperties getIntegerPar() {
		return integerPar;
	}

	public CTTableCellProperties getIntegerCell() {
		return integerCell;
	}

	public CTTextCharacterProperties getPercentText() {
		return percentText;
	}

	public CTTextParagraphProperties getPercentPar() {
		return percentPar;
	}

	public CTTableCellProperties getPercentCell() {
		return percentCell;
	}

	public CTTextCharacterProperties getCharacterText() {
		return characterText;
	}

	public CTTextParagraphProperties getCharacterPar() {
		return characterPar;
	}

	public CTTableCellProperties getCharacterCell() {
		return characterCell;
	}

	public CTTextCharacterProperties getDateText() {
		return dateText;
	}

	public CTTextParagraphProperties getDatePar() {
		return datePar;
	}

	public CTTableCellProperties getDateCell() {
		return dateCell;
	}

	public CTTextCharacterProperties getDatetimeText() {
		return datetimeText;
	}

	public CTTextParagraphProperties getDatetimePar() {
		return datetimePar;
	}

	public CTTableCellProperties getDatetimeCell() {
		return datetimeCell;
	}

	public CTTextCharacterProperties getLogicalText() {
		return logicalText;
	}

	public CTTextParagraphProperties getLogicalPar() {
		return logicalPar;
	}

	public CTTableCellProperties getLogicalCell() {
		return logicalCell;
	}
	


}
