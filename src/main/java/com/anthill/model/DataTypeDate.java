package com.anthill.model;

import java.util.Date;

class DataTypeDate extends DataType {

	public DataTypeDate() {
		super(Date.class.getCanonicalName());
	}

	@Override
	public String getNameSQL() {
		return "DATE";
	}
	
	@Override
	public String getNameJava() {		
		return Date.class.getSimpleName();
	}

	@Override
	public boolean isSimple() {
		return true;
	}

}
