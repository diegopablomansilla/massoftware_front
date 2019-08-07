package a.dao.convention1.pg.wrapperds;

import org.cendra.jdbc.ConnectionWrapper;

import a.dao.DeleteAllDAO;
import a.dao.Statement;
import a.dao.convention1.anotations.PersistentMapping;

public class DeleteAllDAOPG extends AbstractDAOPG implements DeleteAllDAO {

	private ConnectionWrapper connectionWrapper;

	public DeleteAllDAOPG(ConnectionWrapper connectionWrapper) {
		this.connectionWrapper = connectionWrapper;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public boolean delete(Class mappingClass) throws Exception {

		Statement statement = buildStatement(mappingClass);

		connectionWrapper.delete(statement.getSql());

//		if (rows == 0) {
//			throw new IllegalStateException("No se esperaba que la sentencia no eliminara en la base de datos.");
//		}

		// --------------------------------------------------------

		Statement statementCount = buildStatementCount(mappingClass);

		Object[][] table = connectionWrapper.findToTable(statementCount.getSql());

		if (table.length == 1) {

			Object[] row = table[0];

			return row[0].equals(false);

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

		statement.setSql("SELECT COUNT(*) > 0 FROM " + schema + mappingClass.getSimpleName());

		return statement;

	}

	@SuppressWarnings("rawtypes")
	private Statement buildStatement(Class mappingClass) throws Exception {

		if (mappingClass == null) {
			throw new IllegalArgumentException("DELETE: Se esperaba una objeto Class no nulo.");
		}

		if (isPersistent(mappingClass) == false) {
			throw new IllegalArgumentException(
					"DELETE: Se esperaba un objeto Class anotado con " + PersistentMapping.class.getCanonicalName());
		}

		Statement statement = new Statement();

		String schema = getSchemaName(mappingClass);

		statement.setSql("DELETE FROM " + schema + mappingClass.getSimpleName());

		return statement;

	}

}
