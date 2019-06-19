package com.anthill.model;

import java.math.BigDecimal;

public class Argument extends Att {	
	
	public static String TRASLATE_A = "'/\\\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'";
	public static String TRASLATE_B = "'         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'";

	public static String EQUALS = "EQUALS";
	public static String EQUALS_TRASLATE = "EQUALS_TRASLATE";
	public static String EQUALS_IGNORE_CASE = "EQUALS_IGNORE_CASE";
	public static String EQUALS_IGNORE_CASE_TRASLATE = "EQUALS_IGNORE_CASE_TRASLATE";

	public static String STARTS_WITCH = "STARTS_WITCH";
	public static String STARTS_WITCH_TRASLATE = "STARTS_WITCH_TRASLATE";
	public static String STARTS_WITCH_IGNORE_CASE = "STARTS_WITCH_IGNORE_CASE";
	public static String STARTS_WITCH_IGNORE_CASE_TRASLATE = "STARTS_WITCH_IGNORE_CASE_TRASLATE";

	public static String ENDS_WITCH = "ENDS_WITCH";
	public static String ENDS_WITCH_TRASLATE = "ENDS_WITCH_TRASLATE";
	public static String ENDS_WITCH_IGNORE_CASE = "ENDS_WITCH_IGNORE_CASE";
	public static String ENDS_WITCH_IGNORE_CASE_TRASLATE = "ENDS_WITCH_IGNORE_CASE_TRASLATE";

	public static String CONTAINS = "CONTAINS";
	public static String CONTAINS_TRASLATE = "CONTAINS_TRASLATE";
	public static String CONTAINS_IGNORE_CASE = "CONTAINS_IGNORE_CASE";
	public static String CONTAINS_IGNORE_CASE_TRASLATE = "CONTAINS_IGNORE_CASE_TRASLATE";

	public static String CONTAINS_WORDS_OR = "CONTAINS_WORDS_OR";
	public static String CONTAINS_WORDS_OR_TRASLATE = "CONTAINS_WORDS_OR_TRASLATE";
	public static String CONTAINS_WORDS_OR_IGNORE_CASE = "CONTAINS_WORDS_OR_IGNORE_CASE";
	public static String CONTAINS_WORDS_OR_IGNORE_CASE_TRASLATE = "CONTAINS_WORDS_OR_IGNORE_CASE_TRASLATE";

	public static String CONTAINS_WORDS_AND = "CONTAINS_WORDS_AND";
	public static String CONTAINS_WORDS_AND_TRASLATE = "CONTAINS_WORDS_AND_TRASLATE";
	public static String CONTAINS_WORDS_AND_IGNORE_CASE = "CONTAINS_WORDS_AND_IGNORE_CASE";
	public static String CONTAINS_WORDS_AND_IGNORE_CASE_TRASLATE = "CONTAINS_WORDS_AND_IGNORE_CASE_TRASLATE";

	///////////////////////////////////////////

	public static String EQUALS_VALUE = "igual a ..";
	public static String EQUALS_TRASLATE_VALUE = "igual a ..";
	public static String EQUALS_IGNORE_CASE_VALUE = "igual a ..";
	public static String EQUALS_IGNORE_CASE_TRASLATE_VALUE = "igual a ..";

	public static String STARTS_WITCH_VALUE = "comienza con ..";
	public static String STARTS_WITCH_TRASLATE_VALUE = "comienza con ..";
	public static String STARTS_WITCH_IGNORE_CASE_VALUE = "comienza con ..";
	public static String STARTS_WITCH_IGNORE_CASE_TRASLATE_VALUE = "comienza con ..";

	public static String ENDS_WITCH_VALUE = "termina con ..";
	public static String ENDS_WITCH_TRASLATE_VALUE = "termina con ..";
	public static String ENDS_WITCH_IGNORE_CASE_VALUE = "termina con ..";
	public static String ENDS_WITCH_IGNORE_CASE_TRASLATE_VALUE = "termina con ..";

	public static String CONTAINS_VALUE = "contiene ..";
	public static String CONTAINS_TRASLATE_VALUE = "contiene ..";
	public static String CONTAINS_IGNORE_CASE_VALUE = "contiene ..";
	public static String CONTAINS_IGNORE_CASE_TRASLATE_VALUE = "contiene ..";

	// public static String CONTAINS_WORDS_OR_VALUE = "CONTAINS_WORDS_OR";
	// public static String CONTAINS_WORDS_OR_TRASLATE_VALUE =
	// "CONTAINS_WORDS_OR_TRASLATE";
	// public static String CONTAINS_WORDS_OR_IGNORE_CASE_VALUE =
	// "CONTAINS_WORDS_OR_IGNORE_CASE";
	// public static String CONTAINS_WORDS_OR_IGNORE_CASE_TRASLATE_VALUE =
	// "CONTAINS_WORDS_OR_IGNORE_CASE_TRASLATE";
	
	public static String CONTAINS_WORDS_OR_VALUE = "contiene alguna de las palabras ..";
	public static String CONTAINS_WORDS_OR_TRASLATE_VALUE = "contiene alguna de las palabras ..";
	public static String CONTAINS_WORDS_OR_IGNORE_CASE_VALUE = "contiene alguna de las palabras ..";
	public static String CONTAINS_WORDS_OR_IGNORE_CASE_TRASLATE_VALUE = "contiene alguna de las palabras ..";


	public static String CONTAINS_WORDS_AND_VALUE = "contiene las palabras ..";
	public static String CONTAINS_WORDS_AND_TRASLATE_VALUE = "contiene las palabras ..";
	public static String CONTAINS_WORDS_AND_IGNORE_CASE_VALUE = "contiene las palabras ..";
	public static String CONTAINS_WORDS_AND_IGNORE_CASE_TRASLATE_VALUE = "contiene las palabras ..";

	///////////////////////////////////////////

	private Att att;
	private Boolean range = false;
	private String searchOption = CONTAINS_WORDS_AND_IGNORE_CASE_TRASLATE;
	private Boolean onlyVisual = false;

	public Argument(Att att) throws CloneNotSupportedException {
		super();
		this.att = (Att) att.clone();
	}

	public Argument(Att att, Boolean range, String searchOption) throws CloneNotSupportedException {
		super();
		this.att = (Att) att.clone();
		this.range = range;
		this.searchOption = searchOption;
	}

	public Argument(Att att, String searchOption) throws CloneNotSupportedException {
		super();
		this.att = (Att) att.clone();
		this.searchOption = searchOption;
	}

	public Argument(Att att, Boolean range) throws CloneNotSupportedException {
		super();
		this.att = (Att) att.clone();
		this.range = range;
	}

	public Boolean getOnlyVisual() {
		return onlyVisual;
	}

	public void setOnlyVisual(Boolean onlyVisual) {
		this.onlyVisual = onlyVisual;
	}

	public Clazz getClazz() {
		return att.getClazz();
	}

	public void setClazz(Clazz clazz) {
		att.setClazz(clazz);
	}

	public String getName() {
		return att.getName();
	}

	public void setName(String name) {
		att.setName(name);
	}

	public String getNameJavaUperCase() {
		return att.getNameJavaUperCase();
	}

	public DataType getDataType() {
		return att.getDataType();
	}

	public void setDataType(DataType dataType) {
		att.setDataType(dataType);
	}

	public void setDataTypeClazz(Clazz clazz) {
		att.setDataTypeClazz(clazz);
	}

	public void setDataTypeInteger(Integer minValue, Integer maxValue) {
		att.setDataTypeInteger(minValue, maxValue);
	}

	public void setDataTypeLong(Long minValue, Long maxValue) {
		att.setDataTypeLong(minValue, maxValue);
	}

	public void setDataTypeBigDecimal(BigDecimal minValue, BigDecimal maxValue, Integer precision, Integer scale) {
		att.setDataTypeBigDecimal(minValue, maxValue, precision, scale);
	}

	public void setDataTypeBoolean() {
		att.setDataTypeBoolean();
	}

	public void setDataTypeTimestamp() {
		att.setDataTypeTimestamp();
	}

	public String getLabel() {
		return att.getLabel();
	}

	public void setLabel(String label) {
		att.setLabel(label);
	}

	public String getLabelError() {
		return att.getLabelError();
	}

	public void setLabelError(String labelError) {
		att.setLabelError(labelError);
	}

	// public boolean isUnique() {
	// return att.isUnique();
	// }
	//
	// public void setUnique(boolean unique) {
	// att.setUnique(unique);
	// }

	public boolean isReadOnlyGUI() {
		return att.isReadOnlyGUI();
	}

	public void setReadOnlyGUI(boolean readOnly) {
		att.setReadOnlyGUI(readOnly);
	}

	public boolean isRequired() {
		return att.isRequired();
	}

	public void setRequired(boolean required) {
		att.setRequired(required);
	}

	public Float getColumns() {
		return att.getColumns();
	}

	public void setColumns(Float columns) {
		att.setColumns(columns);
	}

	public Integer getMinLength() {
		return att.getMinLength();
	}

	public void setMinLength(Integer minLength) {
		att.setMinLength(minLength);
	}

	public Integer getMaxLength() {
		return att.getMaxLength();
	}

	public void setMaxLength(Integer maxLength) {
		att.setMaxLength(maxLength);
	}

	public void setLength(Integer minLength, Integer maxLength) {
		att.setLength(minLength, maxLength);
	}

	public String getMask() {
		return att.getMask();
	}

	public void setMask(String mask) {
		att.setMask(mask);
	}

	public boolean isSimple() {
		return att.isSimple();
	}

	public boolean isString() {
		return att.isString();
	}

	public boolean isNumber() {
		return att.isNumber();
	}

	public boolean isNumberDecimal() {
		return att.isNumberDecimal();
	}

	public boolean isInteger() {
		return att.isInteger();
	}

	public boolean isLong() {
		return att.isLong();
	}

	public boolean isBoolean() {
		return att.isBoolean();
	}

	public boolean isDouble() {
		return att.isDouble();
	}

	public boolean isBigDecimal() {
		return att.isBigDecimal();
	}

	public boolean isTimestamp() {
		return att.isTimestamp();
	}

	public boolean isDate() {
		return att.isDate();
	}

	public String getNameSQL() {
		return att.getNameSQL();
	}

	public Boolean getRange() {
		return range;
	}

	public void setRange(Boolean range) {
		this.range = range;
	}

	public String getSearchOption() {
		return searchOption;
	}

	public void setSearchOption(String searchOption) {
		this.searchOption = searchOption;
	}

	public String getSearchOptionValue() {

		if (EQUALS.equals(searchOption)) {

			return EQUALS_VALUE;

		} else if (EQUALS_TRASLATE.equals(searchOption)) {

			return EQUALS_TRASLATE_VALUE;

		} else if (EQUALS_IGNORE_CASE.equals(searchOption)) {

			return EQUALS_IGNORE_CASE_VALUE;

		} else if (EQUALS_IGNORE_CASE_TRASLATE.equals(searchOption)) {

			return EQUALS_IGNORE_CASE_TRASLATE_VALUE;

		} else if (STARTS_WITCH.equals(searchOption)) {

			return STARTS_WITCH_VALUE;

		} else if (STARTS_WITCH_TRASLATE.equals(searchOption)) {

			return STARTS_WITCH_TRASLATE_VALUE;

		} else if (STARTS_WITCH_IGNORE_CASE.equals(searchOption)) {

			return STARTS_WITCH_IGNORE_CASE_VALUE;

		} else if (STARTS_WITCH_IGNORE_CASE_TRASLATE.equals(searchOption)) {

			return STARTS_WITCH_IGNORE_CASE_TRASLATE_VALUE;

		} else if (ENDS_WITCH.equals(searchOption)) {

			return ENDS_WITCH_VALUE;

		} else if (ENDS_WITCH_TRASLATE.equals(searchOption)) {

			return ENDS_WITCH_TRASLATE_VALUE;

		} else if (ENDS_WITCH_IGNORE_CASE.equals(searchOption)) {

			return ENDS_WITCH_IGNORE_CASE_VALUE;

		} else if (ENDS_WITCH_IGNORE_CASE_TRASLATE.equals(searchOption)) {

			return ENDS_WITCH_IGNORE_CASE_TRASLATE_VALUE;

		} else if (CONTAINS.equals(searchOption)) {

			return CONTAINS_VALUE;

		} else if (CONTAINS_TRASLATE.equals(searchOption)) {

			return CONTAINS_TRASLATE_VALUE;

		} else if (CONTAINS_IGNORE_CASE.equals(searchOption)) {

			return CONTAINS_IGNORE_CASE_VALUE;

		} else if (CONTAINS_IGNORE_CASE_TRASLATE.equals(searchOption)) {

			return CONTAINS_IGNORE_CASE_TRASLATE_VALUE;

		} else if (CONTAINS_WORDS_AND.equals(searchOption)) {

			return CONTAINS_WORDS_AND_VALUE;

		} else if (CONTAINS_WORDS_AND_TRASLATE.equals(searchOption)) {

			return CONTAINS_WORDS_AND_TRASLATE_VALUE;

		} else if (CONTAINS_WORDS_AND_IGNORE_CASE.equals(searchOption)) {

			return CONTAINS_WORDS_AND_IGNORE_CASE_VALUE;

		} else if (CONTAINS_WORDS_AND_IGNORE_CASE_TRASLATE.equals(searchOption)) {

			return CONTAINS_WORDS_AND_IGNORE_CASE_TRASLATE_VALUE;

		}

		return null;
	}

}
