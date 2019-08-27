package com.anthill.model;

public class DataTypeClazz extends DataType {

	private Clazz clazz;

	public DataTypeClazz(Clazz clazz) {
		super(clazz.getName());
		this.clazz = clazz;
	}

	public Clazz getClazz() {
		return clazz;
	}

	public void setClazz(Clazz clazz) {
		this.clazz = clazz;
	}
	
	@Override
	public String getNameJava() {		
		return clazz.getName();
	}
	
	public String getNamePlural() {
		return clazz.getNamePlural();
	}

	@Override
	public String getNameSQL() {
		return clazz.getName();
	}

	@Override
	public boolean isSimple() {
		return false;
	}

}
