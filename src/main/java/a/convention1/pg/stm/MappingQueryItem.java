package a.convention1.pg.stm;

public class MappingQueryItem {

	private Integer number;
	private String path;
	private String schema;
	private String table;
	private String tableAlias;
	private String tableJoin;
	private String attJoin;
	private String att;

	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getSchema() {
		return schema;
	}

	public void setSchema(String schema) {
		this.schema = schema;
	}

	public String getTable() {
		return table;
	}

	public void setTable(String table) {
		this.table = table;
	}

	public String getTableAlias() {
		return tableAlias;
	}

	public void setTableAlias(String tableAlias) {
		this.tableAlias = tableAlias;
	}

	public String getTableJoin() {
		return tableJoin;
	}

	public void setTableJoin(String tableJoin) {
		this.tableJoin = tableJoin;
	}

	public String getAttJoin() {
		return attJoin;
	}

	public void setAttJoin(String attJoin) {
		this.attJoin = attJoin;
	}

	public String getAtt() {
		return att;
	}

	public void setAtt(String att) {
		this.att = att;
	}

}
