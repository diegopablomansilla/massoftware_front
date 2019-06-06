package com.massoftware.anthill.sql.find;

public class FunctionFindArg {

	private String name;
	private String dataType;
	private Boolean custom = true;
	private Boolean string = false;
	private Boolean stringSplit = false;

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

	public Boolean getCustom() {
		return custom;
	}

	public void setCustom(Boolean custom) {
		this.custom = (custom == null) ? false : custom;
	}

	public Boolean getString() {
		return string;
	}

	public void setString(Boolean string) {
		this.string = (string == null) ? false : string;
	}

	public Boolean getStringSplit() {
		return stringSplit;
	}

	public void setStringSplit(Boolean stringSplit) {
		this.stringSplit = (stringSplit == null) ? false : stringSplit;
	}
	
	

}
