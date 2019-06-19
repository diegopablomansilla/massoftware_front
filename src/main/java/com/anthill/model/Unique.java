package com.anthill.model;

public class Unique {

	public static String EQUALS = "EQUALS";
	public static String EQUALS_TRASLATE = "EQUALS_TRASLATE";
	public static String EQUALS_IGNORE_CASE = "EQUALS_IGNORE_CASE";
	public static String EQUALS_IGNORE_CASE_TRASLATE = "EQUALS_IGNORE_CASE_TRASLATE";

	private Att att;
	private String searchOption = EQUALS_IGNORE_CASE_TRASLATE;

	public Unique(Att att) {
		this(att, null);
	}

	public Unique(Att att, String searchOption) {
		super();
		this.att = att;

		if (this.att.isSimple()) {

			if (this.att.isNumber()) {
				this.searchOption = EQUALS;
			} else if (this.att.isBoolean()) {
				this.searchOption = EQUALS;
			} else if (this.att.isDate()) {
				this.searchOption = EQUALS;
			} else if (this.att.isTimestamp()) {
				this.searchOption = EQUALS;
			} else if (this.att.isString()) {
				if (searchOption != null && searchOption.trim().length() > 0) {
					this.searchOption = searchOption;
				} else {
					this.searchOption = EQUALS_IGNORE_CASE_TRASLATE;
				}
			}
		} else {
			this.searchOption = EQUALS;
		}

	}

	public Att getAtt() {
		return att;
	}

	public String getSearchOption() {
		return searchOption;
	}

}
