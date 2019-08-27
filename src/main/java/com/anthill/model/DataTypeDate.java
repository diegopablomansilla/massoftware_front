package com.anthill.model;

import java.time.LocalDate;
import java.util.Date;

class DataTypeDate extends DataType {

	public DataTypeDate() {
//		super(Date.class.getCanonicalName());
		super(LocalDate.class.getCanonicalName());
	}

	@Override
	public String getNameSQL() {
		return "DATE";
	}
	
	@Override
	public String getNameJava() {		
//		return Date.class.getSimpleName();
		return LocalDate.class.getSimpleName();
		
	}

	@Override
	public boolean isSimple() {
		return true;
	}

}
