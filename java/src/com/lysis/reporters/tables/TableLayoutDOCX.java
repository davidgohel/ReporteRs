package com.lysis.reporters.tables;

import org.docx4j.wml.PPr;
import org.docx4j.wml.RPr;
import org.docx4j.wml.TcPr;

import com.lysis.docx4r.tools.Format;

public class TableLayoutDOCX extends TableLayoutBase implements com.lysis.reporters.tables.TableFormat{
	public TableLayoutDOCX(String percentAddsymbol, int fractionDoubleDigit,
			int fractionPercentDigit, String datePattern, String timePattern,
			String datetimePattern, String lang, String reg) {
		super(percentAddsymbol, fractionDoubleDigit, fractionPercentDigit, datePattern,
				timePattern, datetimePattern, lang, reg);
	}

	private RPr headerText;
	private PPr headerPar;
	private TcPr headerCell;

	private RPr groupedheaderText;
	private PPr groupedheaderPar;
	private TcPr groupedheaderCell;

	private RPr doubleText;
	private PPr doublePar;
	private TcPr doubleCell;

	private RPr integerText;
	private PPr integerPar;
	private TcPr integerCell;


	private RPr percentText;
	private PPr percentPar;
	private TcPr percentCell;

	private RPr characterText;
	private PPr characterPar;
	private TcPr characterCell;

	private RPr dateText;
	private PPr datePar;
	private TcPr dateCell;

	private RPr datetimeText;
	private PPr datetimePar;
	private TcPr datetimeCell;

	private RPr logicalText;
	private PPr logicalPar;
	private TcPr logicalCell;


	
	public void setHeaderText(String color,int fontsize, boolean strbold, boolean italic, boolean underlined, String fontfamily){
		this.headerText = Format.getTextProperties(color, fontsize, strbold, italic, underlined, fontfamily);
	}

	public void setGroupedheaderText(String color,int fontsize, boolean strbold, boolean italic, boolean underlined, String fontfamily){
		this.groupedheaderText = Format.getTextProperties(color, fontsize, strbold, italic, underlined, fontfamily);
	}

	public void setDoubleText(String color,int fontsize, boolean strbold, boolean italic, boolean underlined, String fontfamily){
		this.doubleText = Format.getTextProperties(color, fontsize, strbold, italic, underlined, fontfamily);
	}

	public void setIntegerText(String color,int fontsize, boolean strbold, boolean italic, boolean underlined, String fontfamily){
		this.integerText = Format.getTextProperties(color, fontsize, strbold, italic, underlined, fontfamily);
	}

	public void setPercentText(String color,int fontsize, boolean strbold, boolean italic, boolean underlined, String fontfamily){
		this.percentText = Format.getTextProperties(color, fontsize, strbold, italic, underlined, fontfamily);
	}

	public void setCharacterText(String color,int fontsize, boolean strbold, boolean italic, boolean underlined, String fontfamily){
		this.characterText = Format.getTextProperties(color, fontsize, strbold, italic, underlined, fontfamily);
	}

	public void setDateText(String color,int fontsize, boolean strbold, boolean italic, boolean underlined, String fontfamily){
		this.dateText = Format.getTextProperties(color, fontsize, strbold, italic, underlined, fontfamily);
	}

	public void setDatetimeText(String color,int fontsize, boolean strbold, boolean italic, boolean underlined, String fontfamily){
		this.datetimeText = Format.getTextProperties(color, fontsize, strbold, italic, underlined, fontfamily);
	}
	public void setLogicalText(String color,int fontsize, boolean strbold, boolean italic, boolean underlined, String fontfamily){
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

	public void setLogicalPar(String textalign,int paddingbottom, int paddingtop, int paddingleft, int paddingright){
		this.logicalPar = Format.getParProperties(textalign, paddingbottom, paddingtop, paddingleft, paddingright);
	}




	public void setHeaderCell(String borderBottomColor, String borderBottomStyle, int borderBottomWidth
			, String borderLeftColor, String borderLeftStyle, int borderLeftWidth
			, String borderTopColor, String borderTopStyle, int borderTopWidth
			, String borderRightColor, String borderRightStyle, int borderRightWidth, 
			String verticalAlign, int paddingBottom, int paddingTop, int paddingLeft, int paddingRight
			, String backgroundColor
			){
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
			){
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
			){
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
			){
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
			){
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
			){
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
			){
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
			){
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
			){
		this.logicalCell = Format.getCellProperties(borderBottomColor, borderBottomStyle, borderBottomWidth, borderLeftColor, borderLeftStyle, borderLeftWidth
				, borderTopColor, borderTopStyle, borderTopWidth, borderRightColor, borderRightStyle
				, borderRightWidth, verticalAlign, paddingBottom, paddingTop, paddingLeft, paddingRight
				, backgroundColor);

	}


	
	
	
	
	
	public RPr getHeaderText() {
		return headerText;
	}

	public PPr getHeaderPar() {
		return headerPar;
	}

	public TcPr getHeaderCell() {
		return headerCell;
	}

	public RPr getGroupedheaderText() {
		
		return groupedheaderText;
	}

	public PPr getGroupedheaderPar() {
		return groupedheaderPar;
	}

	public TcPr getGroupedheaderCell() {
		return groupedheaderCell;
	}

	public RPr getDoubleText() {
		return doubleText;
	}

	public PPr getDoublePar() {
		return doublePar;
	}

	public TcPr getDoubleCell() {
		return doubleCell;
	}

	public RPr getIntegerText() {
		return integerText;
	}

	public PPr getIntegerPar() {
		return integerPar;
	}

	public TcPr getIntegerCell() {
		return integerCell;
	}

	public RPr getPercentText() {
		return percentText;
	}

	public PPr getPercentPar() {
		return percentPar;
	}

	public TcPr getPercentCell() {
		return percentCell;
	}

	public RPr getCharacterText() {
		return characterText;
	}

	public PPr getCharacterPar() {
		return characterPar;
	}

	public TcPr getCharacterCell() {
		return characterCell;
	}

	public RPr getDateText() {
		return dateText;
	}

	public PPr getDatePar() {
		return datePar;
	}

	public TcPr getDateCell() {
		return dateCell;
	}

	public RPr getDatetimeText() {
		return datetimeText;
	}

	public PPr getDatetimePar() {
		return datetimePar;
	}

	public TcPr getDatetimeCell() {
		return datetimeCell;
	}
	
	public RPr getLogicalText() {
		return logicalText;
	}

	public PPr getLogicalPar() {
		return logicalPar;
	}

	public TcPr getLogicalCell() {
		return logicalCell;
	}


}
