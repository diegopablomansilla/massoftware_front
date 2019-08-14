package a.convention1.pg;

import java.util.List;

import org.cendra.jdbc.ConnectionWrapper;

import a.convention1.anotations.Identifiable;
import a.convention1.pg.stm.StatementParam;
import a.convention1.pg.stm.builder.StmBuilderUpdate;

public class UpdateDAO {

	private StmBuilderUpdate builderStmUpdate;

	public UpdateDAO(String schema) {
		builderStmUpdate = new StmBuilderUpdate(schema);
	}

	public boolean updateObject(ConnectionWrapper connectionWrapper, Identifiable obj) throws Exception {
		return updateObject(connectionWrapper, builderStmUpdate.build(obj));
	}

	@SuppressWarnings("rawtypes")
	public boolean updateObject(ConnectionWrapper connectionWrapper, Identifiable obj, Class mappingClass)
			throws Exception {
		return updateObject(connectionWrapper, builderStmUpdate.build(obj, mappingClass));
	}

	public boolean[] updateObjects(ConnectionWrapper connectionWrapper, List<Identifiable> objs) throws Exception {

		if (objs == null) {
			throw new IllegalArgumentException("UPDATE: Se esperaba una lista de objetos no nulo.");
		}

		if (objs.size() == 0) {
			throw new IllegalArgumentException("UPDATE: Se esperaba una lista objetos no vacia.");
		}

		boolean[] r = new boolean[objs.size()];

		for (int i = 0; i < objs.size(); i++) {

			if (objs.get(i) == null) {
				throw new IllegalArgumentException("UPDATE: Se esperaba una lista objetos, con objetos no nulos.");
			}

			r[i] = updateObject(connectionWrapper, objs.get(i));
		}

		return r;

	}

	@SuppressWarnings("rawtypes")
	public boolean[] updateObjects(ConnectionWrapper connectionWrapper, List<Identifiable> objs, Class mappingClass)
			throws Exception {

		if (objs == null) {
			throw new IllegalArgumentException("UPDATE: Se esperaba una lista de objetos no nulo.");
		}

		if (objs.size() == 0) {
			throw new IllegalArgumentException("UPDATE: Se esperaba una lista objetos no vacia.");
		}

		boolean[] r = new boolean[objs.size()];

		for (int i = 0; i < objs.size(); i++) {

			if (objs.get(i) == null) {
				throw new IllegalArgumentException("UPDATE: Se esperaba una lista objetos, con objetos no nulos.");
			}

			r[i] = updateObject(connectionWrapper, objs.get(i), mappingClass);
		}

		return r;

	}

	private boolean updateObject(ConnectionWrapper connectionWrapper, StatementParam statement) throws Exception {

		int rows = connectionWrapper.update(statement.getSql(), statement.getArgs());

		if (rows == 0) {
			throw new IllegalStateException(
					"UPDATE: No se esperaba que la sentencia no actualizara en la base de datos.");
		} else if (rows > 1) {
			throw new IllegalStateException(
					"UPDATE: No se esperaba que la sentencia actualizara a mas de un registro en la base de datos. Registros: "
							+ rows);
		}

		return true;

	}

	// --------------------------------------------------------------------------------------------------------

}
