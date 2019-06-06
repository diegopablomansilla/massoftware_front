package com.massoftware.anthill.sql.type;

public class TypeArg {

	private String name;
	private String dataType;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		name = (name != null) ? name.trim() : null;
		this.name = (name != null && name.length() == 0) ? null : name;
	}

	public String getDataType() {
		return dataType;
	}

	public void setDataType(String dataType) {
		dataType = (dataType != null) ? dataType.trim() : null;
		this.dataType = (dataType != null && dataType.length() == 0) ? null : dataType;
	}

}
