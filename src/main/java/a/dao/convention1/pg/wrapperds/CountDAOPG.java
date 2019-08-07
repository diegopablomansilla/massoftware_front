package a.dao.convention1.pg.wrapperds;

import org.cendra.jdbc.ConnectionWrapper;

import a.dao.CountDAO;
import a.dao.Statement;
import a.dao.convention1.anotations.PersistentMapping;

public class CountDAOPG extends AbstractDAOPG implements CountDAO {

	private ConnectionWrapper connectionWrapper;

	public CountDAOPG(ConnectionWrapper connectionWrapper) {
		this.connectionWrapper = connectionWrapper;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public long count(Class mappingClass) throws Exception {

		// --------------------------------------------------------

		Statement statementCount = buildStatementCount(mappingClass);

		Object[][] table = connectionWrapper.findToTable(statementCount.getSql());

		if (table.length == 1) {

			Object[] row = table[0];

			return (long) row[0];

		} else {
			throw new IllegalStateException(
					"No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

		// --------------------------------------------------------

	}

	// --------------------------------------------------------------------------------------------------------

	@SuppressWarnings("rawtypes")
	private Statement buildStatementCount(Class mappingClass) throws Exception {

		if (mappingClass == null) {
			throw new IllegalArgumentException("DELETE: Se esperaba una objeto Class no nulo.");
		}

		if (isPersistent(mappingClass) == false) {
			throw new IllegalArgumentException(
					"DELETE: Se esperaba un objeto Class anotado con " + PersistentMapping.class.getCanonicalName());
		}

		Statement statement = new Statement();

		String schema = getSchemaName(mappingClass);

		statement.setSql("SELECT COUNT(*) FROM " + schema + mappingClass.getSimpleName());

		return statement;

	}

}
