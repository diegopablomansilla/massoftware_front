package com.massoftware.anthill;

import java.sql.Timestamp;

class DataTypeTimestamp extends DataType {

	private Boolean defNowInsert = false;
	private Boolean defNowUpdate = false;

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

	public Boolean getDefNowInsert() {
		return defNowInsert;
	}

	public void setDefNowInsert(Boolean defNowInsert) {
		this.defNowInsert = defNowInsert;
	}

	public Boolean getDefNowUpdate() {
		return defNowUpdate;
	}

	public void setDefNowUpdate(Boolean defNowUpdate) {
		this.defNowUpdate = defNowUpdate;
	}

}
