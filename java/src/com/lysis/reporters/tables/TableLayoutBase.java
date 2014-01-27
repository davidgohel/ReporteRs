package com.lysis.reporters.tables;

public class TableLayoutBase {

	protected String percentAddsymbol;
	protected int fractionDoubleDigit;
	protected int fractionPercentDigit;
	protected String datePattern;
	protected String timePattern;
	protected String datetimePattern;
	protected String locale_language;
	protected String locale_region;

	public TableLayoutBase(String percentAddsymbol, 
			int fractionDoubleDigit, int fractionPercentDigit,
			String datePattern, String timePattern, String datetimePattern, String lang, String reg) {
		super();
		this.percentAddsymbol = percentAddsymbol;
		this.fractionDoubleDigit = fractionDoubleDigit;
		this.fractionPercentDigit = fractionPercentDigit;
		this.datePattern = datePattern;
		this.timePattern = timePattern;
		this.datetimePattern = datetimePattern;
		this.locale_language = lang;
		this.locale_region = reg;
	}
	
	public String getPercentAddsymbol() {
		return percentAddsymbol;
	}

	public int getFractionDoubleDigit() {
		return fractionDoubleDigit;
	}

	public int getFractionPercentDigit() {
		return fractionPercentDigit;
	}

	public String getDatePattern() {
		return datePattern;
	}

	public String getTimePattern() {
		return timePattern;
	}

	public String getDatetimePattern() {
		return datetimePattern;
	}


	public String getLocale_language() {
		return locale_language;
	}


	public String getLocale_region() {
		return locale_region;
	}
	
}
