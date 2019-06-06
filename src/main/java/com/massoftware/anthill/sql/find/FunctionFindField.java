package com.massoftware.anthill.sql.find;

public class FunctionFindField {

	private String table;
	private String name;
	private String dataType;
	private Integer level;
	private String path;

	public String getTable() {
		return table;
	}

	public void setTable(String table) {
		table = (table != null) ? table.trim() : null;
		this.table = (table != null && table.length() == 0) ? null : table;
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

	public Integer getLevel() {
		return level;
	}

	public void setLevel(Integer level) {
		this.level = (level == null || level < 0) ? 0 : level;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		path = (path != null) ? path.trim() : null;
		this.path = (path != null && path.length() == 0) ? null : path;
	}

}
