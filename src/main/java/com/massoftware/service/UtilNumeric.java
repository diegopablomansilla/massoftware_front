package com.massoftware.service;

import java.math.BigDecimal;

public class UtilNumeric {

	public static boolean isInteger(String arg) {

		if (arg == null || arg.trim().length() == 0) {

			throw new IllegalArgumentException("Se esperaba un arg no nulo/vacio.");

		}

		arg = arg.trim();

		try {
			Integer.parseInt(arg);
		} catch (Exception e) {
			return false;
		}

		return true;
	}
	
	public static boolean isLong(String arg) {

		if (arg == null || arg.trim().length() == 0) {

			throw new IllegalArgumentException("Se esperaba un arg no nulo/vacio.");

		}

		arg = arg.trim();

		try {
			Long.parseLong(arg);
		} catch (Exception e) {
			return false;
		}

		return true;
	}
	
	public static boolean isDouble(String arg) {

		if (arg == null || arg.trim().length() == 0) {

			throw new IllegalArgumentException("Se esperaba un arg no nulo/vacio.");

		}

		arg = arg.trim();

		try {
			Double.parseDouble(arg);
		} catch (Exception e) {
			return false;
		}

		return true;
	}
	
	public static boolean isNumber(String arg) {

		if (arg == null || arg.trim().length() == 0) {

			throw new IllegalArgumentException("Se esperaba un arg no nulo/vacio.");

		}

		arg = arg.trim();

		try {
			new BigDecimal(arg);
		} catch (Exception e) {
			return false;
		}

		return true;
	}

}
