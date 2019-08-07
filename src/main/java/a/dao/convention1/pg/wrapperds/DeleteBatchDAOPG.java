package a.dao.convention1.pg.wrapperds;

import java.util.ArrayList;
import java.util.List;

import org.cendra.jdbc.ConnectionWrapper;

import a.dao.DeleteBatchDAO;
import a.dao.ParamStatementBatch;
import a.dao.Statement;
import a.dao.convention1.anotations.Identifiable;
import a.dao.convention1.anotations.PersistentMapping;

public class DeleteBatchDAOPG extends AbstractDAOPG implements DeleteBatchDAO {

	private ConnectionWrapper connectionWrapper;

	public DeleteBatchDAOPG() {
		super();
	}

	public DeleteBatchDAOPG(ConnectionWrapper connectionWrapper) {
		this.connectionWrapper = connectionWrapper;
	}

	@Override
	public boolean[] delete(List<Object> objs) throws Exception {

		ParamStatementBatch statement = buildStatementBatch(objs);

		boolean[] r = new boolean[statement.getArgs().length];

		Statement statementCount = buildStatementCount(objs);

		for (int i = 0; i < statement.getArgs().length; i++) {

			Object[] args = statement.getArgs()[i];

			boolean exists = false;

			Object[][] table = connectionWrapper.findToTable(statementCount.getSql(), args);

			if (table.length == 1) {

				Object[] row = table[0];

				exists = row[0].equals(true);

			} else {
				throw new IllegalStateException(
						"No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
			}

			if (exists == false) {
				r[i] = exists;
				continue;
			}

			// --------------------------------------------------------

			int rows = connectionWrapper.delete(statement.getSql(), args);

			if (rows == 0) {
				throw new IllegalStateException("No se esperaba que la sentencia no eliminara en la base de datos.");
			} else if (rows > 1) {
				throw new IllegalStateException(
						"No se esperaba que la sentencia eliminara a mas de un registro en la base de datos. Registros: "
								+ rows);
			}

			// --------------------------------------------------------

			table = connectionWrapper.findToTable(statementCount.getSql(), args);

			if (table.length == 1) {

				Object[] row = table[0];

				r[i] = row[0].equals(false);

			} else {
				throw new IllegalStateException(
						"No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
			}
		}

		return r;

	}

	@Override
	public boolean[] deleteById(List<String> ids, @SuppressWarnings("rawtypes") Class mappingClass) throws Exception {		

		ParamStatementBatch statement = buildStatementBatch(ids, mappingClass);
		
		boolean[] r = new boolean[statement.getArgs().length];

		Statement statementCount = buildStatementCount(mappingClass);

		for (int i = 0; i < statement.getArgs().length; i++) {

			Object[] args = statement.getArgs()[i];

			boolean exists = false;

			Object[][] table = connectionWrapper.findToTable(statementCount.getSql(), args);

			if (table.length == 1) {

				Object[] row = table[0];

				exists = row[0].equals(true);

			} else {
				throw new IllegalStateException(
						"No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
			}

			if (exists == false) {
				r[i] = exists;
				continue;
			}

			// --------------------------------------------------------

			int rows = connectionWrapper.delete(statement.getSql(), args);

			if (rows == 0) {
				throw new IllegalStateException("No se esperaba que la sentencia no eliminara en la base de datos.");
			} else if (rows > 1) {
				throw new IllegalStateException(
						"No se esperaba que la sentencia eliminara a mas de un registro en la base de datos. Registros: "
								+ rows);
			}

			// --------------------------------------------------------

			table = connectionWrapper.findToTable(statementCount.getSql(), args);

			if (table.length == 1) {

				Object[] row = table[0];

				r[i] = row[0].equals(false);

			} else {
				throw new IllegalStateException(
						"No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
			}
		}

		return r;

	}

	// --------------------------------------------------------------------------------------------------------

	private ParamStatementBatch buildStatementBatch(List<Object> entities) throws Exception {

		if (entities == null) {
			throw new IllegalArgumentException("DELETE: Se esperaba una lista de objetos no nulo.");
		}

		if (entities.size() == 0) {
			throw new IllegalArgumentException("DELETE: Se esperaba una lista objetos no vacia.");
		}

		ParamStatementBatch statement = new ParamStatementBatch();

		String schema = null;
		List<String> args = new ArrayList<String>();

		int c = 0;

		for (Object entity : entities) {

			if (entity == null) {
				throw new IllegalArgumentException("DELETE: Se esperaba una lista objetos, con objetos no nulos.");
			}

			if (isPersistent(entity) == false) {
				throw new IllegalArgumentException(
						"DELETE: Se esperaba una objeto anotado con " + PersistentMapping.class.getCanonicalName());
			}

			if (entity instanceof Identifiable == false) {
				throw new IllegalArgumentException("DELETE: Se esperaba una lista objetos, con objetos tipo "
						+ Identifiable.class.getSimpleName());
			}

			if (((Identifiable) entity).getId() == null || ((Identifiable) entity).getId().isEmpty()) {
				throw new IllegalArgumentException(
						"DELETE: Se esperaba una lista de objetos, con objetos con id no nulo o vacio.");
			}

			if (c == 0) {
				schema = getSchemaName(entity);
			}

			c++;

			args.add(((Identifiable) entity).getId());

		}

		statement.setSql("DELETE FROM " + schema + entities.get(0).getClass().getSimpleName() + " WHERE id = ?");

		Object[][] array = new Object[entities.size()][1];

		for (int i = 0; i < args.size(); i++) {
			array[i][0] = args.get(i);
		}

		statement.setArgs(array);

		return statement;

	}

	private ParamStatementBatch buildStatementBatch(List<String> ids, @SuppressWarnings("rawtypes") Class mappingClass)
			throws Exception {

		if (ids == null) {
			throw new IllegalArgumentException("DELETE: Se esperaba una lista de id's no nulo.");
		}

		if (ids.size() == 0) {
			throw new IllegalArgumentException("DELETE: Se esperaba una lista de id's no vacia.");
		}

		if (mappingClass == null) {
			throw new IllegalArgumentException("DELETE: Se esperaba una objeto Class no nulo.");
		}

		if (isPersistent(mappingClass) == false) {
			throw new IllegalArgumentException(
					"DELETE: Se esperaba un objeto Class anotado con " + PersistentMapping.class.getCanonicalName());
		}

		ParamStatementBatch statement = new ParamStatementBatch();

		String schema = getSchemaName(mappingClass);

		for (String id : ids) {

			if (id == null || id.isEmpty()) {
				throw new IllegalArgumentException(
						"DELETE: Se esperaba una lista objetos, con id's no nulos o vacios.");
			}

		}

		statement.setSql("DELETE FROM " + schema + mappingClass.getSimpleName() + " WHERE id = ?");

		Object[][] array = new Object[ids.size()][1];

		for (int i = 0; i < ids.size(); i++) {
			array[i][0] = ids.get(i);
		}

		statement.setArgs(array);

		return statement;

	}

	private Statement buildStatementCount(List<Object> entities) throws Exception {

		if (entities == null) {
			throw new IllegalArgumentException("DELETE: Se esperaba una lista de objetos no nulo.");
		}

		if (entities.size() == 0) {
			throw new IllegalArgumentException("DELETE: Se esperaba una lista objetos no vacia.");
		}

		Statement statement = new Statement();

		String schema = getSchemaName(entities.get(0));

		statement.setSql(
				"SELECT COUNT(*) > 0 FROM " + schema + entities.get(0).getClass().getSimpleName() + " WHERE id = ?");

		return statement;

	}

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

		statement.setSql("SELECT COUNT(*) > 0 FROM " + schema + mappingClass.getSimpleName() + " WHERE id = ?");

		return statement;

	}

}
