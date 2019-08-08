package a.dao.op;

import java.util.Arrays;

public class ParamStatementBatch {

	private String sql;
	private Object[][] args;

	public String getSql() {
		return sql;
	}

	public void setSql(String sql) {
		this.sql = sql;
	}

	public Object[][] getArgs() {
		if (args == null) {
			args = new Object[0][0];
		}
		return args;
	}

	public void setArgs(Object[][] args) {
		this.args = args;
	}

	public String toString() {
		String s = "";

		s += "\n" + sql;
		s += "\n";

		if (args == null) {
			args = new Object[0][0];
		}

		for (Object[] row : args) {
			s += "\n" + Arrays.toString(row);
		}

		return s;
	}

}
