package a.convention1.pg;

import java.util.List;

import org.cendra.jdbc.ConnectionWrapper;

import a.convention1.pg.model.Identifiable;
import a.convention1.pg.stm.StatementParam;
import a.convention1.pg.stm.builder.StmBuilderInsert;

public class InsertDAO {

	private StmBuilderInsert builderStmInsert;

	public InsertDAO(String schema) {
		builderStmInsert = new StmBuilderInsert(schema);
	}

	public boolean insertObject(ConnectionWrapper connectionWrapper, Identifiable obj) throws Exception {
		return insertObject(connectionWrapper, builderStmInsert.build(obj));
	}

	@SuppressWarnings("rawtypes")
	public boolean insertObject(ConnectionWrapper connectionWrapper, Identifiable obj, Class mappingClass)
			throws Exception {
		return insertObject(connectionWrapper, builderStmInsert.build(obj, mappingClass));
	}

	public boolean[] insertObjects(ConnectionWrapper connectionWrapper, List<Identifiable> objs) throws Exception {

		if (objs == null) {
			throw new IllegalArgumentException("UPDATE: Se esperaba una lista de objetos no nulo.");
		}

		if (objs.size() == 0) {
			throw new IllegalArgumentException("UPDATE: Se esperaba una lista objetos no vacia.");
		}

		boolean[] r = new boolean[objs.size()];

		for (int i = 0; i < objs.size(); i++) {

			if (objs.get(i) == null) {
				throw new IllegalArgumentException("INSERT: Se esperaba una lista objetos, con objetos no nulos.");
			}

			r[i] = insertObject(connectionWrapper, objs.get(i));
		}

		return r;

	}

	@SuppressWarnings("rawtypes")
	public boolean[] insertObjects(ConnectionWrapper connectionWrapper, List<Identifiable> objs, Class mappingClass)
			throws Exception {

		if (objs == null) {
			throw new IllegalArgumentException("INSERT: Se esperaba una lista de objetos no nulo.");
		}

		if (objs.size() == 0) {
			throw new IllegalArgumentException("INSERT: Se esperaba una lista objetos no vacia.");
		}

		boolean[] r = new boolean[objs.size()];

		for (int i = 0; i < objs.size(); i++) {

			if (objs.get(i) == null) {
				throw new IllegalArgumentException("INSERT: Se esperaba una lista objetos, con objetos no nulos.");
			}

			r[i] = insertObject(connectionWrapper, objs.get(i), mappingClass);
		}

		return r;

	}

	private boolean insertObject(ConnectionWrapper connectionWrapper, StatementParam statement) throws Exception {

		int rows = connectionWrapper.insert(statement.getSql(), statement.getArgs());

		if (rows != 1) {
			throw new IllegalStateException(
					"INSERT: No se esperaba que la sentencia no insertara en la base de datos.");
		}

		return true;
	}

}
