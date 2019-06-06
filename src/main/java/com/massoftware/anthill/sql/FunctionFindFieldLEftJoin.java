package com.massoftware.anthill.sql;

public class FunctionFindFieldLEftJoin {

	private Boolean fk = false;
	private String table;
	private String tableFk;
	private String tableFkAlias;
	private String name;
	private Integer level;
	private Integer index;

	
	
	public Boolean getFk() {
		return fk;
	}

	public void setFk(Boolean fk) {
		this.fk = (fk == null) ? false : fk;
	}

	public String getTable() {
		return table;
	}

	public void setTable(String table) {
		table = (table != null) ? table.trim() : null;
		this.table = (table != null && table.length() == 0) ? null : table;
	}

	public String getTableFk() {
		return tableFk;
	}

	public void setTableFk(String tableFk) {
		tableFk = (tableFk != null) ? tableFk.trim() : null;
		this.tableFk = (tableFk != null && tableFk.length() == 0) ? null : tableFk;
	}
	
	public String getTableFkAlias() {
		return tableFkAlias;
	}

	public void setTableFkAlias(String tableFkAlias) {
		tableFkAlias = (tableFkAlias != null) ? tableFkAlias.trim() : null;
		this.tableFkAlias = (tableFkAlias != null && tableFkAlias.length() == 0) ? null : tableFkAlias;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		name = (name != null) ? name.trim() : null;
		this.name = (name != null && name.length() == 0) ? null : name;
	}

	public Integer getLevel() {
		return level;
	}

	public void setLevel(Integer level) {
		this.level = (level == null || level < 0) ? 0: level;
	}

	public Integer getIndex() {
		return index;
	}

	public void setIndex(Integer index) {
		this.index = (index == null || index < 0) ? 0: index;
	}
	
	
	
	

}
