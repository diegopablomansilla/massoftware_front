package com.massoftware.anthill;

class DataTypeInteger extends DataType {

	private Integer minValue;
	private Integer maxValue;	

	public DataTypeInteger() {
		super(Integer.class.getCanonicalName());
	}

	@Override
	public String getNameSQL() {
		return "INTEGER";
	}

	@Override
	public String getNameJava() {		
		return Integer.class.getSimpleName();
	}
	
	@Override
	public boolean isSimple() {
		return true;
	}

	public Integer getMinValue() {
		return minValue;
	}

	public void setMinValue(Integer minValue) {

		if (minValue != null && minValue != Integer.MIN_VALUE) {
			this.minValue = minValue;
		} else {
			this.minValue = minValue;
		}

	}

	public Integer getMaxValue() {
		return maxValue;
	}

	public void setMaxValue(Integer maxValue) {

		if (maxValue != null && maxValue != Integer.MAX_VALUE) {
			this.maxValue = maxValue;
		} else {
			this.maxValue = maxValue;
		}

	}

	@Override
	public String toString() {
		return "TipoDatoInteger [minValue=" + minValue + ", maxValue=" + maxValue + "]";
	}

}
