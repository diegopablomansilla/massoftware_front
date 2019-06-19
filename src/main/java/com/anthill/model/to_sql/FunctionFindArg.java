package com.anthill.model.to_sql;

import com.anthill.model.Argument;

public class FunctionFindArg {

	private String nameAtt;
	private String name;
	private String dataType;
	private Boolean custom = true;
	private Boolean string = false;
	private Boolean stringSplit = false;
	private String operator = "=";
	private String searchOption = Argument.CONTAINS_WORDS_AND_IGNORE_CASE_TRASLATE;

	public String getNameAtt() {
		return nameAtt;
	}

	public void setNameAtt(String nameAtt) {
		this.nameAtt = (nameAtt != null && nameAtt.trim().length() == 0) ? null : nameAtt.trim();
	}

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

	public String getOperator() {
		return operator;
	}

	public void setOperator(String operator) {
		this.operator = (operator != null && operator.trim().length() == 0) ? null : operator.trim();
	}

	public String getSearchOption() {
		return searchOption;
	}

	public void setSearchOption(String searchOption) {
		this.searchOption = (searchOption != null && searchOption.trim().length() == 0) ? null : searchOption.trim();
	}

}
