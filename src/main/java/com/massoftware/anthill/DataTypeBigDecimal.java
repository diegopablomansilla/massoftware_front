package com.massoftware.anthill;

import java.math.BigDecimal;

class DataTypeBigDecimal extends DataType {

	private BigDecimal minValue;
	private BigDecimal maxValue;

	private Integer precision;
	private Integer scale;

	public DataTypeBigDecimal() {
		super(BigDecimal.class.getCanonicalName());
	}

	@Override
	public String getNameSQL() {
		return "DECIMAL";
	}

	@Override
	public String getNameJava() {
		return BigDecimal.class.getSimpleName();
	}

	@Override
	public boolean isSimple() {
		return true;
	}

	public BigDecimal getMinValue() {
		return minValue;
	}

	public void setMinValue(BigDecimal minValue) {
		this.minValue = minValue;
	}

	public BigDecimal getMaxValue() {
		return maxValue;
	}

	public void setMaxValue(BigDecimal maxValue) {
		this.maxValue = maxValue;
	}

	public Integer getPrecision() {
		return precision;
	}

	public void setPrecision(Integer precision) {
		this.precision = precision;
	}

	public Integer getScale() {
		return scale;
	}

	public void setScale(Integer scale) {
		this.scale = scale;
	}

	@Override
	public String toString() {
		return "DataTypeBigDecimal [minValue=" + minValue + ", maxValue=" + maxValue + ", precision=" + precision
				+ ", scale=" + scale + "]";
	}

}
