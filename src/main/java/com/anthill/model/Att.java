package com.anthill.model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class Att {

	private Clazz clazz;
	private String name;
	private DataType dataType = new DataTypeString();

	private String label;
	private String labelError;

	private boolean unique;
	private String searchOptionUnique = Unique.EQUALS_IGNORE_CASE_TRASLATE;
	private boolean readOnlyGUI;
	private boolean required;

	private Float columns = 20F;

	private Integer minLength;
	private Integer maxLength;

	private String mask;

	public Att() {
		super();
	}

	public Att(String name, String label) {
		super();
		this.name = name;
		this.label = label;
	}

	public Clazz getClazz() {
		return clazz;
	}

	public void setClazz(Clazz clazz) {
		this.clazz = clazz;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNameJavaUperCase() {
		return convertToTitleCaseIteratingChars(getName());
	}

	public DataType getDataType() {
		return dataType;
	}

	public void setDataType(DataType dataType) {
		this.dataType = dataType;
	}

	public void setDataTypeClazz(Clazz clazz) {
		this.dataType = new DataTypeClazz(clazz);
	}

	public void setDataTypeInteger(Integer minValue, Integer maxValue) {
		this.dataType = new DataTypeInteger();
		((DataTypeInteger) this.dataType).setMinValue(minValue);
		((DataTypeInteger) this.dataType).setMaxValue(maxValue);
	}

	public void setDataTypeLong(Long minValue, Long maxValue) {
		this.dataType = new DataTypeLong();
		((DataTypeLong) this.dataType).setMinValue(minValue);
		((DataTypeLong) this.dataType).setMaxValue(maxValue);
	}

	public void setDataTypeBigDecimal(BigDecimal minValue, BigDecimal maxValue, Integer precision, Integer scale) {
		this.dataType = new DataTypeBigDecimal();
		((DataTypeBigDecimal) this.dataType).setMinValue(minValue);
		((DataTypeBigDecimal) this.dataType).setMaxValue(maxValue);
		((DataTypeBigDecimal) this.dataType).setPrecision(precision);
		((DataTypeBigDecimal) this.dataType).setScale(scale);
	}

	public void setDataTypeBoolean() {
		this.dataType = new DataTypeBoolean();
	}

	public void setDataTypeTimestamp() {
		this.dataType = new DataTypeTimestamp();
	}
	
	public void setDataTypeDate() {
		this.dataType = new DataTypeDate();
	}

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public String getLabelError() {
		return labelError;
	}

	public void setLabelError(String labelError) {
		this.labelError = labelError;
	}

	public boolean isUnique() {
		return unique;
	}

	public void setUnique(boolean unique) {
		this.unique = unique;
	}

	public String getSearchOptionUnique() {
		return searchOptionUnique;
	}

	public void setSearchOptionUnique(String searchOptionUnique) {
		this.searchOptionUnique = searchOptionUnique;
	}

	public boolean isReadOnlyGUI() {
		return readOnlyGUI;
	}

	public void setReadOnlyGUI(boolean readOnlyGUI) {
		this.readOnlyGUI = readOnlyGUI;
	}

	public boolean isRequired() {
		return required;
	}

	public void setRequired(boolean required) {
		this.required = required;
	}

	public Float getColumns() {
		return columns;
	}

	public void setColumns(Float columns) {
		this.columns = columns;
	}

	public Integer getMinLength() {
		return minLength;
	}

	public void setMinLength(Integer minLength) {
		if (minLength != null && minLength < 1) {
			throw new IllegalArgumentException("minLength debe ser mayor a 0.");
		}
		this.minLength = minLength;
	}

	public Integer getMaxLength() {
		return maxLength;
	}

	public void setMaxLength(Integer maxLength) {
		if (maxLength != null && maxLength < 1) {
			throw new IllegalArgumentException("maxLength debe ser mayor a 0.");
		}
		this.maxLength = maxLength;
		
		if(this.getDataType() instanceof DataTypeString) {
			((DataTypeString)this.getDataType()).setMaxLength(this.maxLength);
		}		
		 
	}

	public void setLength(Integer minLength, Integer maxLength) {
		setMinLength(minLength);
		setMaxLength(maxLength);
	}

	public String getMask() {
		return mask;
	}

	public void setMask(String mask) {
		this.mask = mask;
	}

	public boolean isSimple() {
		return dataType.isSimple();
	}

	public boolean isString() {
		return dataType.isString();
	}

	public boolean isNumber() {
		return dataType.isNumber();
	}

	public boolean isNumberDecimal() {
		return dataType.isNumberDecimal();
	}

	public boolean isInteger() {
		return dataType.isInteger();
	}

	public boolean isLong() {
		return dataType.isLong();
	}

	public boolean isBoolean() {
		return dataType.isBoolean();
	}

	public boolean isDouble() {
		return dataType.isDouble();
	}

	public boolean isBigDecimal() {
		return dataType.isBigDecimal();
	}

	public boolean isTimestamp() {
		return dataType.isTimestamp();
	}

	public boolean isDate() {
		return dataType.isDate();
	}

	public String getNameSQL() {
		return dataType.getNameSQL();
	}

	public String toSQL() {

		String sql = "\n\t-- " + this.getLabel();

		if (this.isSimple()) {

			sql += "\n\t" + this.getName() + " " + this.getNameSQL();

			if (this.isString() && this.getMaxLength() != null) {

				//sql += "(" + this.getMaxLength() + ")";

			}

			if (this.isBigDecimal()) {

//				sql += "(" + ((DataTypeBigDecimal) this.getDataType()).getPrecision() + ", "
//						+ ((DataTypeBigDecimal) this.getDataType()).getScale() + ")";

			}			

			if (this.isRequired() || this.isBoolean()) {
				sql += " NOT NULL ";
			}
//			if (this.isRequired()) {
//				sql += " NOT NULL ";
//			}
			
//			if (this.isBoolean()) {
//				if (this.isRequired()) {
//					sql += " DEFAULT false ";
//				} else {
//					sql += " NOT NULL DEFAULT false ";					
//				}
//				
//				sql += " NOT NULL ";
//			}

			if (this.isUnique()) {

				if (this.isNumber()) {
					sql += " UNIQUE ";
				} else if (this.isString()) {

					if (Unique.EQUALS.equals(getSearchOptionUnique())) {
						sql += " UNIQUE ";
					}

				} else if (this.isDate()) {
					sql += " UNIQUE ";
				} else if (this.isTimestamp()) {
					sql += " UNIQUE ";
				}
			}
			
//			if (this.isRequired()) {
//				if(this.isTimestamp()) {
//					DataTypeTimestamp dt = (DataTypeTimestamp) this.getDataType();
//					if(dt.getDefNow() == true) {
//						sql += " DEFAULT now() ";
//					}
//				} else if(this.isBigDecimal()) {
//					DataTypeBigDecimal dt = (DataTypeBigDecimal) this.getDataType();
//					if(dt.getDefValue() != null) {
//						sql += " DEFAULT " + dt.getDefValue() + " ";
//					}
//				}
//			}
			
			

			sql += this.constraintSQL();

		} else {
			sql += "\n\t" + this.getName() + " VARCHAR(36) ";
			if (this.isRequired()) {
				sql += " NOT NULL ";
			}
			sql += " REFERENCES massoftware." + this.getNameSQL() + " (id) ";
		}

		sql = "\n\t" + sql.trim();

		sql += ", ";

		return sql;
	}

	private String constraintSQL() {

		String constraintSQL = " CONSTRAINT " + this.getClazz().getName() + "_" + this.getName() + "_chk CHECK (";
		String expString = "";

		List<String> exps = new ArrayList<String>();

		if (this.getDataType().isInteger()) {

			if (((DataTypeInteger) this.getDataType()).getMinValue() != null) {
				exps.add(" " + this.getName() + " >= " + ((DataTypeInteger) this.getDataType()).getMinValue());
			}

			if (((DataTypeInteger) this.getDataType()).getMaxValue() != null) {
				exps.add(" " + this.getName() + " <= " + ((DataTypeInteger) this.getDataType()).getMaxValue());
			}

		} else if (this.getDataType().isLong()) {

			if (((DataTypeLong) this.getDataType()).getMinValue() != null) {
				exps.add(" " + this.getName() + " >= " + ((DataTypeLong) this.getDataType()).getMinValue());
			}

			if (((DataTypeLong) this.getDataType()).getMaxValue() != null) {
				exps.add(" " + this.getName() + " <= " + ((DataTypeLong) this.getDataType()).getMaxValue());
			}

		} else if (this.getDataType().isBigDecimal()) {

			if (((DataTypeBigDecimal) this.getDataType()).getMinValue() != null) {
				exps.add(" " + this.getName() + " >= " + ((DataTypeBigDecimal) this.getDataType()).getMinValue());
			}

			if (((DataTypeBigDecimal) this.getDataType()).getMaxValue() != null) {
				exps.add(" " + this.getName() + " <= " + ((DataTypeBigDecimal) this.getDataType()).getMaxValue());
			}

		}

		if (minLength != null) {
			exps.add(" char_length(" + this.getName() + "::VARCHAR) >= " + minLength);
		}

		if (maxLength != null && this.isString() == false) {
			exps.add(" char_length(" + this.getName() + "::VARCHAR) <= " + maxLength);
		}

		for (String exp : exps) {

			expString += exp + " AND";
		}

		expString = expString.trim();

		if (exps.size() > 0) {
			expString = expString.substring(0, expString.length() - 3);
		}

		if (expString.trim().length() > 0) {
			return constraintSQL + " " + expString + " )";
		}

		return "";

	}

	// private String convertToTitleCaseIteratingChars(String text) {
	// if (text == null || text.isEmpty()) {
	// return text;
	// }
	//
	// StringBuilder converted = new StringBuilder();
	//
	// boolean convertNext = true;
	// for (char ch : text.toCharArray()) {
	// if (Character.isSpaceChar(ch)) {
	// convertNext = true;
	// } else if (convertNext) {
	// ch = Character.toTitleCase(ch);
	// convertNext = false;
	// } else {
	// ch = Character.toLowerCase(ch);
	// }
	// converted.append(ch);
	// }
	//
	// return converted.toString();
	// }

	private String convertToTitleCaseIteratingChars(String text) {
		if (text == null || text.isEmpty()) {
			return text;
		}

		return text.substring(0, 1).toUpperCase() + text.substring(1, text.length());
	}

	@Override
	protected Object clone() throws CloneNotSupportedException {

		Att other = new Att();
		other.setClazz(getClazz());
		other.setName(getName());
		other.setDataType(getDataType());
		other.setLabel(getLabel());
		other.setLabelError(getLabelError());
		other.setUnique(isUnique());
		other.setReadOnlyGUI(isReadOnlyGUI());
		other.setRequired(isRequired());
		other.setColumns(getColumns());
		other.setMinLength(getMinLength());
		other.setMaxLength(getMaxLength());
		other.setMask(getMask());

		return other;
	}

}
