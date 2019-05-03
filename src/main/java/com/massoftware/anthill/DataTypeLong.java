package com.massoftware.anthill;

class DataTypeLong extends DataType {

	private Long minValue;
	private Long maxValue;

	public DataTypeLong() {
		super(Long.class.getCanonicalName());
	}

	@Override
	public String getNameSQL() {
		return "BIGINT";
	}
	
	@Override
	public String getNameJava() {		
		return Long.class.getSimpleName();
	}

	@Override
	public boolean isSimple() {
		return true;
	}

	public Long getMinValue() {
		return minValue;
	}

	public void setMinValue(Long minValue) {

		if (minValue != null && minValue != Long.MIN_VALUE) {
			this.minValue = minValue;
		} else {
			this.minValue = minValue;
		}

	}

	public Long getMaxValue() {
		return maxValue;
	}

	public void setMaxValue(Long maxValue) {

		if (maxValue != null && maxValue != Long.MAX_VALUE) {
			this.maxValue = maxValue;
		} else {
			this.maxValue = maxValue;
		}

	}

	@Override
	public String toString() {
		return "TipoDatoLong [minValue=" + minValue + ", maxValue=" + maxValue + "]";
	}

}
