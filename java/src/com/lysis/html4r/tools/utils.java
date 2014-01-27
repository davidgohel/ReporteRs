package com.lysis.html4r.tools;

import org.apache.commons.lang.RandomStringUtils;

public class utils {
	public static final int ID_LENGTH = 10;

	public static String generateUniqueId() {
	    return "UID" + RandomStringUtils.randomAlphanumeric(ID_LENGTH);
	}
}
