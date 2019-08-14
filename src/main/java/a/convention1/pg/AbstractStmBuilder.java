package a.convention1.pg;

public abstract class AbstractStmBuilder {

	protected String schema;
	protected Util util;

	public AbstractStmBuilder(String schema) {
		this.schema = schema;
		util = new Util();
	}

}
