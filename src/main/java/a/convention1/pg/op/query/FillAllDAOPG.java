package a.convention1.pg.op.query;

import java.util.List;

import org.cendra.jdbc.ConnectionWrapper;

import a.convention1.pg.stm.FillStmBuilder;
import a.dao.op.StatementMapping;
import a.dao.op.query.FillAllDAO;

public class FillAllDAOPG implements FillAllDAO {

	private ConnectionWrapper connectionWrapper;

	public FillAllDAOPG(ConnectionWrapper connectionWrapper) {
		this.connectionWrapper = connectionWrapper;
	}
	
	@SuppressWarnings("rawtypes")
	public List fillAll(Class mappingClass) throws Exception {
		return fillAll(mappingClass, 0);
	}

	@SuppressWarnings("rawtypes")
	public List fillAll(Class mappingClass, int leftLevel) throws Exception {

		StatementMapping stm = new FillStmBuilder().build(mappingClass, leftLevel);

		Object[][] table = connectionWrapper.findToTable(stm.getSql());
		
		System.out.println(table);

		return null;
	}

	// --------------------------------------------------------------------------------------------------------

}
