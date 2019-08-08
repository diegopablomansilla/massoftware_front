package a.dao.op;

public class Statement {

	private String sql;

	public String getSql() {
		return sql;
	}

	public void setSql(String sql) {
		this.sql = sql;
	}

	public String toString() {
		String s = "";

		s += "\n" + sql;

		return s;
	}

}
