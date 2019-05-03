package com.massoftware.anthill;

import java.math.BigDecimal;

public class Argument extends Att {

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

	private Att att;
	private Boolean range = false;
	private String searchOption = CONTAINS_WORDS_AND_IGNORE_CASE_TRASLATE;

	public Argument(Att att) {
		super();
		this.att = att;
	}

	public Argument(Att att, Boolean range, String searchOption) {
		super();
		this.att = att;
		this.range = range;
		this.searchOption = searchOption;
	}

	public Argument(Att att, String searchOption) {
		super();
		this.att = att;
		this.searchOption = searchOption;
	}

	public Argument(Att att, Boolean range) {
		super();
		this.att = att;
		this.range = range;
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

	public boolean isUnique() {
		return att.isUnique();
	}

	public void setUnique(boolean unique) {
		att.setUnique(unique);
	}

	public boolean isReadOnly() {
		return att.isReadOnly();
	}

	public void setReadOnly(boolean readOnly) {
		att.setReadOnly(readOnly);
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

}
