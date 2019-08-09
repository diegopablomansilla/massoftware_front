package a.convention1.pg.op.query;

import java.util.ArrayList;
import java.util.List;

import org.cendra.jdbc.ConnectionWrapper;

import a.convention1.pg.stm.FillStmBuilder;
import a.dao.op.Mapper;
import a.dao.op.StatementMapping;
import a.dao.op.query.FillAllDAO;

public class FillAllDAOPG implements FillAllDAO {

	private ConnectionWrapper connectionWrapper;

	public FillAllDAOPG(ConnectionWrapper connectionWrapper) {
		this.connectionWrapper = connectionWrapper;
	}

	@SuppressWarnings("rawtypes")
	public List fillAll(Class mappingClass) throws Exception {
		return fillAll(mappingClass, mappingClass, 2);
	}
	
	@SuppressWarnings({ "rawtypes" })
	public List fillAll(Class mappingClass, int leftLevel) throws Exception {
		return fillAll(mappingClass, mappingClass, 2);	
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List fillAll(Class instanceClass, Class mappingClass, int leftLevel) throws Exception {		
		
		List r = new ArrayList();

		StatementMapping stm = new FillStmBuilder().build(mappingClass, leftLevel);

		Object[][] table = connectionWrapper.findToTable(stm.getSql());

		if (table != null && table.length > 0) {

			Mapper mapper = new Mapper();

			for (Object[] row : table) {

				Object obj = mapper.fill(instanceClass, stm.getPathMapping(), row);
				r.add(obj);
			}
		}

		return r;
	}

	// --------------------------------------------------------------------------------------------------------

}
