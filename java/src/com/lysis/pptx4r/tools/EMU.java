package com.lysis.pptx4r.tools;

public class EMU {
	private static long inch = 914400;
	private static long centimeter = 360000;

	public static long getFromInch( double x ){
		return (new Double( x * inch )).longValue();
	}
	public static long getFromCm( double x ){
		return (new Double( x * centimeter )).longValue();
	}
}
