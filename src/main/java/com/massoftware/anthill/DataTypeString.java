package com.massoftware.anthill;

class DataTypeString extends DataType {
	
	private Integer maxLength;

	public DataTypeString() {
		super(String.class.getCanonicalName());
	}

	@Override
	public String getNameSQL() {
		if(maxLength > 0) {
			return "VARCHAR(" + maxLength + ")";
		}
		return "VARCHAR";
	}
	
	@Override
	public String getNameJava() {		
		return String.class.getSimpleName();
	}

	@Override
	public boolean isSimple() {
		return true;
	}
	
	public Integer getMaxLength() {
		return maxLength;
	}

	public void setMaxLength(Integer maxLength) {
		if (maxLength != null && maxLength < 1) {
			throw new IllegalArgumentException("maxLength debe ser mayor a 0.");
		}
		this.maxLength = maxLength;
	}

}
