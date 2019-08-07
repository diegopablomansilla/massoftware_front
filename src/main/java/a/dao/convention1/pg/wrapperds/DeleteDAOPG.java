package a.dao.convention1.pg.wrapperds;

import org.cendra.jdbc.ConnectionWrapper;

import a.dao.DeleteDAO;
import a.dao.ParamStatement;
import a.dao.convention1.anotations.Identifiable;
import a.dao.convention1.anotations.PersistentMapping;

public class DeleteDAOPG extends AbstractDAOPG implements DeleteDAO {

	private ConnectionWrapper connectionWrapper;

	public DeleteDAOPG(ConnectionWrapper connectionWrapper) {
		this.connectionWrapper = connectionWrapper;
	}

	@Override
	public boolean delete(Object obj) throws Exception {

		ParamStatement statementCount = buildStatementCount(obj);

		Object[][] table = connectionWrapper.findToTable(statementCount.getSql(), statementCount.getArgs());

		if (table.length == 1) {

			Object[] row = table[0];

			if (row[0].equals(true) == false) {
				return false;
			}

		} else {
			throw new IllegalStateException(
					"No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

		// --------------------------------------------------------

		ParamStatement statement = buildStatement(obj);

		int rows = connectionWrapper.delete(statement.getSql(), statement.getArgs());

		if (rows == 0) {
			throw new IllegalStateException("No se esperaba que la sentencia no eliminara en la base de datos.");
		} else if (rows > 1) {
			throw new IllegalStateException(
					"No se esperaba que la sentencia eliminara a mas de un registro en la base de datos. Registros: "
							+ rows);
		}

		// --------------------------------------------------------		

		table = connectionWrapper.findToTable(statementCount.getSql(), statementCount.getArgs());

		if (table.length == 1) {

			Object[] row = table[0];

			return row[0].equals(false);

		} else {
			throw new IllegalStateException(
					"No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

		// --------------------------------------------------------

	}

	@Override
	public boolean deleteById(String id, @SuppressWarnings("rawtypes") Class mappingClass) throws Exception {

		ParamStatement statementCount = buildStatementCount(id, mappingClass);

		Object[][] table = connectionWrapper.findToTable(statementCount.getSql(), statementCount.getArgs());

		if (table.length == 1) {

			Object[] row = table[0];

			if (row[0].equals(true) == false) {
				return false;
			}

		} else {
			throw new IllegalStateException(
					"No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

		// --------------------------------------------------------

		ParamStatement statement = buildStatement(id, mappingClass);

		int rows = connectionWrapper.delete(statement.getSql(), statement.getArgs());

		if (rows == 0) {
			throw new IllegalStateException("No se esperaba que la sentencia no eliminara en la base de datos.");
		} else if (rows > 1) {
			throw new IllegalStateException(
					"No se esperaba que la sentencia eliminara a mas de un registro en la base de datos. Registros: "
							+ rows);
		}

		// --------------------------------------------------------		

		table = connectionWrapper.findToTable(statementCount.getSql(), statementCount.getArgs());

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

	private ParamStatement buildStatementCount(Object entity) throws Exception {

		if (entity == null) {
			throw new IllegalArgumentException("DELETE: Se esperaba un objeto no nulo.");
		}

		if (isPersistent(entity) == false) {
			throw new IllegalArgumentException(
					"DELETE: Se esperaba un objeto anotado con " + PersistentMapping.class.getCanonicalName());
		}

		if (entity instanceof Identifiable == false) {
			throw new IllegalArgumentException(
					"DELETE: Se esperaba un objeto con tipo " + Identifiable.class.getSimpleName());
		}

		if (((Identifiable) entity).getId() == null || ((Identifiable) entity).getId().trim().isEmpty()) {
			throw new IllegalArgumentException("DELETE: Se esperaba un objeto, con id no nulo o vacio.");
		}

		ParamStatement statement = new ParamStatement();

		String schema = getSchemaName(entity);

		statement.addArg(((Identifiable) entity).getId().trim());

		statement.setSql("SELECT COUNT(*) > 0 FROM " + schema + entity.getClass().getSimpleName() + " WHERE id = ?");

		return statement;

	}

	@SuppressWarnings("rawtypes")
	private ParamStatement buildStatementCount(String id, Class mappingClass) throws Exception {

		if (id == null || id.trim().isEmpty()) {
			throw new IllegalArgumentException("DELETE: Se esperaba un objeto no nulo o no vacio.");
		}

		if (mappingClass == null) {
			throw new IllegalArgumentException("DELETE: Se esperaba una objeto Class no nulo.");
		}

		if (isPersistent(mappingClass) == false) {
			throw new IllegalArgumentException(
					"DELETE: Se esperaba un objeto Class anotado con " + PersistentMapping.class.getCanonicalName());
		}

		ParamStatement statement = new ParamStatement();

		String schema = getSchemaName(mappingClass);

		statement.addArg(id.trim());

		statement.setSql("SELECT COUNT(*) > 0 FROM " + schema + mappingClass.getSimpleName() + " WHERE id = ?");

		return statement;

	}

	private ParamStatement buildStatement(Object entity) throws Exception {

		if (entity == null) {
			throw new IllegalArgumentException("DELETE: Se esperaba un objeto no nulo.");
		}

		if (isPersistent(entity) == false) {
			throw new IllegalArgumentException(
					"DELETE: Se esperaba un objeto anotado con " + PersistentMapping.class.getCanonicalName());
		}

		if (entity instanceof Identifiable == false) {
			throw new IllegalArgumentException(
					"DELETE: Se esperaba un objeto con tipo " + Identifiable.class.getSimpleName());
		}

		if (((Identifiable) entity).getId() == null || ((Identifiable) entity).getId().trim().isEmpty()) {
			throw new IllegalArgumentException("DELETE: Se esperaba un objeto, con id no nulo o vacio.");
		}

		ParamStatement statement = new ParamStatement();

		String schema = getSchemaName(entity);

		statement.addArg(((Identifiable) entity).getId().trim());

		statement.setSql("DELETE FROM " + schema + entity.getClass().getSimpleName() + " WHERE id = ?");

		return statement;

	}

	@SuppressWarnings("rawtypes")
	private ParamStatement buildStatement(String id, Class mappingClass) throws Exception {

		if (id == null || id.isEmpty()) {
			throw new IllegalArgumentException("DELETE: Se esperaba un objeto no nulo o no vacio.");
		}

		if (mappingClass == null) {
			throw new IllegalArgumentException("DELETE: Se esperaba una objeto Class no nulo.");
		}

		if (isPersistent(mappingClass) == false) {
			throw new IllegalArgumentException(
					"DELETE: Se esperaba un objeto Class anotado con " + PersistentMapping.class.getCanonicalName());
		}

		ParamStatement statement = new ParamStatement();

		String schema = getSchemaName(mappingClass);

		statement.addArg(id.trim());

		statement.setSql("DELETE FROM " + schema + mappingClass.getSimpleName() + " WHERE id = ?");

		return statement;

	}

}
