package com.massoftware.backend.populate;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Random;

public class UtilPopulate {

	public static String getStringRandomFull(Integer min, Integer max, boolean required) {

		int leftLimit = 97; // letter 'a'
		int rightLimit = 122; // letter 'z'
		int targetStringLength = 30;

		if (min != null && max != null) {
			targetStringLength = max;
		} else if (min != null && max == null) {
			targetStringLength = min;
		} else if (min == null && max != null) {
			targetStringLength = max;
		}

		Random r = new Random();

		StringBuilder buffer = new StringBuilder(targetStringLength);

		for (int i = 0; i < targetStringLength; i++) {

			int randomLimitedInt = leftLimit + (int) (r.nextFloat() * (rightLimit - leftLimit + 1));
			buffer.append((char) randomLimitedInt);

		}

		String value = buffer.toString();

		if (required == false) {
			value = (r.nextBoolean()) ? value : null;
		}

		return value;
	}

	public static String getStringRandom(Integer min, Integer max, boolean required) {

		int leftLimit = 97; // letter 'a'
		int rightLimit = 122; // letter 'z'
		int targetStringLength = 30;

		if (min != null && max != null) {
			targetStringLength = getIntegerRandom(min, max, true);
		} else if (min != null && max == null) {
			targetStringLength = getIntegerRandom(min, 50, true);
		} else if (min == null && max != null) {
			targetStringLength = getIntegerRandom(0, max, true);
		}

		Random r = new Random();

		StringBuilder buffer = new StringBuilder(targetStringLength);

		for (int i = 0; i < targetStringLength; i++) {

			if (i < 1) {
				int randomLimitedInt = leftLimit + (int) (r.nextFloat() * (rightLimit - leftLimit + 1));
				buffer.append( ((char) randomLimitedInt + "").toUpperCase());
			} else {
				int randomLimitedInt = getIntegerRandom(0, 9, true);
				buffer.append(randomLimitedInt);
			}

		}

		String value = buffer.toString();

		if (required == false) {
			value = (r.nextBoolean()) ? value : null;
		}

		return value;
	}

	public static Integer getIntegerRandom(Integer min, Integer max) {

		return getIntegerRandom(min, max, true);

	}

	public static Integer getIntegerRandom(Integer min, Integer max, boolean required) {

		Random r = new Random();

		Integer value = null;

		if (max != null && min != null) {
			value = r.nextInt((max - min) + 1) + min;
		} else if (max != null && min == null) {
			value = r.nextInt((max - Integer.MIN_VALUE) + 1) + Integer.MIN_VALUE;
		} else if (max == null && min != null) {
			value = r.nextInt((Integer.MAX_VALUE - min) + 1) + min;
		} else if (max == null && min == null) {
			value = r.nextInt((Integer.MAX_VALUE - Integer.MIN_VALUE) + 1) + Integer.MIN_VALUE;
		}

		if (required == false) {
			value = (r.nextBoolean()) ? value : null;
		}

		return value;

	}

	public static Long getLongRandom(Long min, Long max) {
		return getLongRandom(min, max, true);
	}

	public static Long getLongRandom(Long min, Long max, boolean required) {

		Random r = new Random();

		Long value = null;

		if (max != null && min != null) {
			value = min + (long) (Math.random() * (max - min));
		} else if (max != null && min == null) {
			value = Long.MIN_VALUE + (long) (Math.random() * (max - Long.MIN_VALUE));
		} else if (max == null && min != null) {
			value = min + (long) (Math.random() * (Long.MAX_VALUE - min));
		} else if (max == null && min == null) {
			value = Long.MIN_VALUE + (long) (Math.random() * (Long.MAX_VALUE - Long.MIN_VALUE));
		}

		if (required == false) {
			value = (r.nextBoolean()) ? value : null;
		}

		return value;

	}

	public static Double getDoubleRandom(Double min, Double max, boolean required) {

		Random r = new Random();

		Double value = null;

		if (max != null && min != null) {
			value = min + (max - min) * r.nextDouble();
		} else if (max != null && min == null) {
			value = Double.MIN_VALUE + (max - Double.MIN_VALUE) * r.nextDouble();
		} else if (max == null && min != null) {
			value = min + (Double.MAX_VALUE - min) * r.nextDouble();
		} else if (max == null && min == null) {
			value = Double.MIN_VALUE + (Double.MAX_VALUE - Double.MIN_VALUE) * r.nextDouble();
		}

		if (required == false) {
			value = (r.nextBoolean()) ? value : null;
		}

		return value;

	}

	public static Long getDateRandom(Integer min, Integer max, boolean required) {

		long offset = Timestamp.valueOf(min + "-01-01 00:00:00").getTime();
		long end = Timestamp.valueOf(max + "-01-01 00:00:00").getTime();
		long diff = end - offset + 1;
		long value = offset + (long) (Math.random() * diff);

		if (required == false) {
			value = (new Random().nextBoolean()) ? value : null;
		}

		return value;

	}

	public static BigDecimal getBigDecimalRandom(BigDecimal min, BigDecimal max, boolean required, Integer precision,
			Integer scale) {

		Random r = new Random();

		BigDecimal value = null;

		boolean b = false;

		do {

			String stringScale = "";
			String stringPrecision = "";

			int length = getIntegerRandom(1, scale - 1);

			for (int i = 0; i < length; i++) {
				stringScale += getIntegerRandom(0, 9);
			}

			length = getIntegerRandom(1, precision - scale - 1);

			for (int i = 0; i < length; i++) {
				stringPrecision += getIntegerRandom(0, 9);
			}

			value = new BigDecimal(stringPrecision + "." + stringScale);

			b = value.compareTo(min) > 0 && value.compareTo(max) < 0;

		} while (!b);

		if (required == false) {
			value = (r.nextBoolean()) ? value : null;
		}

		return value;

	}

}
