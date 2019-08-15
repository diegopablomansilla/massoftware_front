package a.convention1.pg.stm;

import java.util.Arrays;

public class StatementParam extends Statement {

	private Object[] args;

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

		s += "\n" + this.getSql();
		s += "\n";

		if (args == null) {
			args = new Object[0][0];
		}

		s += "\n" + Arrays.toString(args);

		return s;
	}

	@SuppressWarnings("rawtypes")
	public Object buildArg(Object arg, Class c) {
		return (arg == null || arg.toString().trim().isEmpty()) ? c : arg;
	}



}
