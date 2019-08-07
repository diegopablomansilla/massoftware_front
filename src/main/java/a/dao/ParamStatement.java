package a.dao;

import java.util.Arrays;

public class ParamStatement {

	private String sql;
	private Object[] args;

	public String getSql() {
		return sql;
	}

	public void setSql(String sql) {
		this.sql = sql;
	}

	public Object[] getArgs() {
		if (args == null) {
			args = new Object[0];
		}
		return args;
	}

	public void setArgs(Object[] args) {
		this.args = args;
	}

	public boolean addArg(Object newArg) {
		if (args == null) {
			args = new Object[0];
		}

		Object[] args = new Object[this.args.length + 1];

		for (int i = 0; i < this.args.length; i++) {
			args[i] = this.args[i];
		}

		args[args.length - 1] = newArg;
		this.args = args;

		return true;
	}
	
	public String toString() {
		String s = "";

		s += "\n" + sql;
		s += "\n";

		if (args == null) {
			args = new Object[0][0];
		}

		s += "\n" + Arrays.toString(args);

		return s;
	}

}
