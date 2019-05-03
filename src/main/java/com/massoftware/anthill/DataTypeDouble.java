package com.massoftware.anthill;

class DataTypeDouble extends DataType {

	private Double minValue;
	private Double maxValue;

	public DataTypeDouble() {
		super(Double.class.getCanonicalName());
	}

	@Override
	public String getNameSQL() {
		return "DOUBLE PRECISION";
	}
	
	@Override
	public String getNameJava() {		
		return Double.class.getSimpleName();
	}

	@Override
	public boolean isSimple() {
		return true;
	}

	public Double getMinValue() {
		return minValue;
	}

	public void setMinValue(Double minValue) {

		if (minValue != null && minValue != Double.MIN_VALUE) {
			this.minValue = minValue;
		} else {
			this.minValue = minValue;
		}

	}

	public Double getMaxValue() {
		return maxValue;
	}

	public void setMaxValue(Double maxValue) {

		if (maxValue != null && maxValue != Double.MAX_VALUE) {
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
