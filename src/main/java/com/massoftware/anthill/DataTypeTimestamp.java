package com.massoftware.anthill;

import java.sql.Timestamp;

class DataTypeTimestamp extends DataType {

	public DataTypeTimestamp() {
		super(Timestamp.class.getCanonicalName());
	}

	@Override
	public String getNameSQL() {
		return "TIMESTAMP";
	}
	
	@Override
	public String getNameJava() {		
		return Timestamp.class.getSimpleName();
	}

	@Override
	public boolean isSimple() {
		return true;
	}

}
