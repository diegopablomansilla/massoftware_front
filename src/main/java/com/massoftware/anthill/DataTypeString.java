package com.massoftware.anthill;

class DataTypeString extends DataType {

	public DataTypeString() {
		super(String.class.getCanonicalName());
	}

	@Override
	public String getNameSQL() {
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

}
