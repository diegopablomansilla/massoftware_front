package com.massoftware.anthill;

class DataTypeBoolean extends DataType {

	public DataTypeBoolean() {
		super(Boolean.class.getCanonicalName());
	}

	@Override
	public String getNameSQL() {
		return "BOOLEAN";
	}
	
	@Override
	public String getNameJava() {		
		return Boolean.class.getSimpleName();
	}

	@Override
	public boolean isSimple() {
		return true;
	}

}
