package com.massoftware.anthill;

import java.math.BigDecimal;

public class Order extends Att {

	private Att att;
//	private Boolean desc = false;

	public Order(Att att) {
		super();
		this.att = att;
	}

//	public Order(Att att, Boolean desc) {
//		super();
//		this.att = att;
//		this.desc = desc;
//	}

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

//	public Boolean getDesc() {
//		return desc;
//	}
//
//	public void setDesc(Boolean desc) {
//		this.desc = desc;
//	}

}
