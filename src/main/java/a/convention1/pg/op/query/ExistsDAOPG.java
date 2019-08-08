package a.convention1.pg.op.query;

import org.cendra.jdbc.ConnectionWrapper;

import a.convention1.anotations.Identifiable;
import a.convention1.anotations.PersistentMapping;
import a.convention1.pg.AbstractDAOPG;
import a.dao.op.ParamStatement;
import a.dao.op.query.ExistsDAO;

public class ExistsDAOPG extends AbstractDAOPG implements ExistsDAO {

	private ConnectionWrapper connectionWrapper;

	public ExistsDAOPG(ConnectionWrapper connectionWrapper) {
		this.connectionWrapper = connectionWrapper;
	}

	@Override
	public boolean exists(Object obj) throws Exception {

		ParamStatement statementCount = buildStatementCount(obj);

		Object[][] table = connectionWrapper.findToTable(statementCount.getSql(), statementCount.getArgs());

		if (table.length == 1) {

			Object[] row = table[0];

			return row[0].equals(true);

		} else {
			throw new IllegalStateException(
					"No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

	}

	@SuppressWarnings("rawtypes")
	@Override
	public boolean existsById(String id, Class mappingClass) throws Exception {

		ParamStatement statementCount = buildStatementCount(id, mappingClass);

		Object[][] table = connectionWrapper.findToTable(statementCount.getSql(), statementCount.getArgs());

		if (table.length == 1) {

			Object[] row = table[0];

			return row[0].equals(true);

		} else {
			throw new IllegalStateException(
					"No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

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

}
