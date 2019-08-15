package a.convention1.pg;

import java.util.ArrayList;
import java.util.List;

import org.cendra.jdbc.ConnectionWrapper;

import a.convention1.pg.model.Identifiable;
import a.convention1.pg.stm.MapperByPaths;
import a.convention1.pg.stm.Statement;
import a.convention1.pg.stm.StatementMapping;
import a.convention1.pg.stm.StatementMappingParam;
import a.convention1.pg.stm.StatementParam;
import a.convention1.pg.stm.builder.StmBuilderCount;
import a.convention1.pg.stm.builder.StmBuilderExists;
import a.convention1.pg.stm.builder.StmBuilderFill;

public class QueryDAO {

	private StmBuilderFill builderStmFill;
	private StmBuilderExists builderStmExists;
	private StmBuilderCount builderStmCount;

	public QueryDAO(String schema) {
		this.builderStmFill = new StmBuilderFill(schema);
		this.builderStmExists = new StmBuilderExists(schema);
		this.builderStmCount = new StmBuilderCount(schema);
	}

	@SuppressWarnings("rawtypes")
	public List fillAllObjects(ConnectionWrapper connectionWrapper, Class mappingClass) throws Exception {
		return fillAllObjects(connectionWrapper, mappingClass, mappingClass, 0);
	}

	@SuppressWarnings({ "rawtypes" })
	public List fillAllObjects(ConnectionWrapper connectionWrapper, Class mappingClass, int leftLevel)
			throws Exception {
		return fillAllObjects(connectionWrapper, mappingClass, mappingClass, leftLevel);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List fillAllObjects(ConnectionWrapper connectionWrapper, Class instanceClass, Class mappingClass,
			int leftLevel) throws Exception {

		List r = new ArrayList();

		StatementMapping stm = builderStmFill.build(mappingClass, leftLevel);

		Object[][] table = connectionWrapper.findToTable(stm.getSql());

		if (table != null && table.length > 0) {

			MapperByPaths mapper = new MapperByPaths();

			for (Object[] row : table) {

				Object obj = mapper.fill(instanceClass, stm.getPathMapping(), row);
				r.add(obj);
			}
		}

		return r;
	}

	public Object fillObject(ConnectionWrapper connectionWrapper, Identifiable obj) throws Exception {

		if (obj == null) {
			throw new IllegalArgumentException("QUERY: Se esperaba un objeto no nulo.");
		}

		return fillObject(connectionWrapper, obj, obj.getClass(), obj.getClass(), 0);
	}

	public Object fillObject(ConnectionWrapper connectionWrapper, Identifiable obj, int leftLevel) throws Exception {

		if (obj == null) {
			throw new IllegalArgumentException("QUERY: Se esperaba un objeto no nulo.");
		}

		return fillObject(connectionWrapper, obj, obj.getClass(), obj.getClass(), leftLevel);
	}

	@SuppressWarnings({ "rawtypes" })
	public Object fillObject(ConnectionWrapper connectionWrapper, Identifiable obj, Class mappingClass)
			throws Exception {
		return fillObject(connectionWrapper, obj, mappingClass, mappingClass, 0);
	}

	@SuppressWarnings({ "rawtypes" })
	public Object fillObject(ConnectionWrapper connectionWrapper, Identifiable obj, Class mappingClass, int leftLevel)
			throws Exception {
		return fillObject(connectionWrapper, obj, mappingClass, mappingClass, leftLevel);
	}

	@SuppressWarnings("rawtypes")
	public Object fillObject(ConnectionWrapper connectionWrapper, Identifiable obj, Class instanceClass,
			Class mappingClass, int leftLevel) throws Exception {

		StatementMappingParam stm = builderStmFill.build(obj, mappingClass, leftLevel);

		return fillObject(connectionWrapper, instanceClass, stm);

	}

	@SuppressWarnings({ "rawtypes" })
	public Object fillObject(ConnectionWrapper connectionWrapper, String id, Class mappingClass) throws Exception {
		return fillObject(connectionWrapper, id, mappingClass, mappingClass, 0);
	}

	@SuppressWarnings({ "rawtypes" })
	public Object fillObject(ConnectionWrapper connectionWrapper, String id, Class mappingClass, int leftLevel)
			throws Exception {
		return fillObject(connectionWrapper, id, mappingClass, mappingClass, leftLevel);
	}

	@SuppressWarnings({ "rawtypes" })
	public Object fillObject(ConnectionWrapper connectionWrapper, String id, Class instanceClass, Class mappingClass,
			int leftLevel) throws Exception {

		StatementMappingParam stm = builderStmFill.build(id, mappingClass, leftLevel);

		return fillObject(connectionWrapper, instanceClass, stm);

	}

	@SuppressWarnings({ "rawtypes" })
	private Object fillObject(ConnectionWrapper connectionWrapper, Class instanceClass, StatementMappingParam stm)
			throws Exception {

		Object[][] table = connectionWrapper.findToTable(stm.getSql(), stm.getArgs());

		if (table != null && table.length == 1) {

			MapperByPaths mapper = new MapperByPaths();
			Object[] row = table[0];

			return mapper.fill(instanceClass, stm.getPathMapping(), row);

		} else {
			throw new IllegalStateException(
					"QUERY: No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	// --------------------------------------------------------------------------------------------------------

	public boolean objectExist(ConnectionWrapper connectionWrapper, Identifiable obj) throws Exception {
		return exists(connectionWrapper, builderStmExists.build(obj));
	}

	@SuppressWarnings("rawtypes")
	public boolean objectExistById(ConnectionWrapper connectionWrapper, String id, Class mappingClass)
			throws Exception {
		return exists(connectionWrapper, builderStmExists.build(id, mappingClass));
	}

	private boolean exists(ConnectionWrapper connectionWrapper, StatementParam stm) throws Exception {

		Object[][] table = connectionWrapper.findToTable(stm.getSql(), stm.getArgs());

		if (table.length == 1) {

			Object[] row = table[0];

			return row[0].equals(true);

		} else {
			throw new IllegalStateException(
					"QUERY: No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}
	}

	// --------------------------------------------------------------------------------------------------------

	@SuppressWarnings("rawtypes")
	public long countAllObjects(ConnectionWrapper connectionWrapper, Class mappingClass) throws Exception {

		Statement statementCount = builderStmCount.build(mappingClass);

		Object[][] table = connectionWrapper.findToTable(statementCount.getSql());

		if (table.length == 1) {

			Object[] row = table[0];

			return (long) row[0];

		} else {
			throw new IllegalStateException(
					"QUERY: No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

	}

	// --------------------------------------------------------------------------------------------------------

}
