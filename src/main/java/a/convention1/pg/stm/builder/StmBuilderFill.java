package a.convention1.pg.stm.builder;

import java.lang.reflect.Method;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import a.convention1.anotations.Identifiable;
import a.convention1.pg.AbstractStmBuilder;
import a.convention1.pg.stm.MappingQuery;
import a.convention1.pg.stm.MappingQueryItem;
import a.convention1.pg.stm.StatementMapping;
import a.convention1.pg.stm.StatementMappingParam;

public class StmBuilderFill extends AbstractStmBuilder {

	public StmBuilderFill(String schema) {
		super(schema);
	}

	@SuppressWarnings("rawtypes")
	public StatementMapping build(Class mappingClass) throws SQLException {
		return build(mappingClass, 0);
	}

	@SuppressWarnings("rawtypes")
	public StatementMapping build(Class mappingClass, int leftLevel) throws SQLException {

		if (leftLevel < 0) {
			leftLevel = 0;
		}

		if (mappingClass == null) {
			throw new IllegalArgumentException("QUERY: Se esperaba una objeto Class (para el mapeo) no nulo.");
		}

		StatementMapping stm = new StatementMapping();

		confMappingQuery(stm.getMappingQuery(), null, mappingClass, "", 0, leftLevel);

		stm.setSql(this.buildSQL(stm.getMappingQuery()));

		return stm;
	}

	@SuppressWarnings("rawtypes")
	public StatementMappingParam build(Identifiable obj, Class mappingClass) throws SQLException {
		return build(obj.getId(), mappingClass, 0);
	}

	@SuppressWarnings("rawtypes")
	public StatementMappingParam build(Identifiable obj, Class mappingClass, int leftLevel) throws SQLException {

		if (obj == null) {
			throw new IllegalArgumentException("QUERY: Se esperaba un objeto no nulo.");
		}
		
		if (obj.getId() == null) {
			throw new IllegalArgumentException("QUERY: Se esperaba un objeto con id no nulo.");
		}

		if (obj.getId().trim().isEmpty()) {
			throw new IllegalArgumentException("QUERY: Se esperaba un objeto con id no vacio.");
		}

		return build(obj.getId(), mappingClass, leftLevel);

	}

	@SuppressWarnings("rawtypes")
	public StatementMappingParam build(String id, Class mappingClass) throws SQLException {
		return build(id, mappingClass, 0);
	}

	@SuppressWarnings("rawtypes")
	public StatementMappingParam build(String id, Class mappingClass, int leftLevel) throws SQLException {

		if (id == null) {
			throw new IllegalArgumentException("QUERY: Se esperaba un id no nulo.");
		}

		id = id.trim();

		if (id.isEmpty()) {
			throw new IllegalArgumentException("QUERY: Se esperaba un id no vacio.");
		}

		StatementMapping stm = build(mappingClass, leftLevel);

		
		
		StatementMappingParam stmParam = new StatementMappingParam();
		stmParam.setSql(stm.getSql() + " WHERE " + stm.getMappingQuery().getItems().get(0).getTableAlias() + ".id = ?");
		stmParam.addArg(id);
		stmParam.setMappingQuery(stm.getMappingQuery());

		return stmParam;
	}

	@SuppressWarnings("rawtypes")
	private void confMappingQuery(MappingQuery mappingQuery, String attJoin, Class mappingClass, String path, int level,
			int maxLevel) throws SQLException {

		String table = mappingClass.getSimpleName();
		String tableAlias = mappingClass.getSimpleName() + "_" + mappingQuery.getItems().size();
		String tableJoin = null;

		if (mappingQuery.getItems().size() > 0) {
			tableJoin = mappingQuery.getItems().get(mappingQuery.getItems().size() - 1).getTableAlias();
		}

		MappingQueryItem item = new MappingQueryItem();
		item.setNumber(mappingQuery.getItems().size());
		item.setPath((path.trim().isEmpty()) ? "id" : path + ".id");
		item.setSchema(schema);
		item.setTable(table);
		item.setTableAlias(tableAlias);
		item.setTableJoin(tableJoin);
		item.setAttJoin(attJoin);
		item.setAtt("id");

		Method[] methods = mappingClass.getMethods();

		mappingQuery.addItem(item);

		for (Method method : methods) {

			if (method.getName().startsWith("get") && method.getName().equals("getClass") == false
					&& method.getName().startsWith("getId") == false) {

				Class clazz = method.getReturnType();

				if (util.isList(clazz) == false) {

					String attName = method.getName().replaceFirst("get", "");
					attName = util.toCamelCaseVar(attName);

					if (util.isScalar(clazz)) {

						String attPath = (path.trim().isEmpty()) ? attName : path + "." + attName;

						item = new MappingQueryItem();
						item.setNumber(mappingQuery.getItems().size());
						item.setPath(attPath);
						item.setSchema(schema);
						item.setTable(table);
						item.setTableAlias(tableAlias);
						item.setTableJoin(tableJoin);
						item.setAttJoin(attJoin);
						item.setAtt(attName);

						mappingQuery.addItem(item);

					} else {

						if (level < maxLevel) {
							confMappingQuery(mappingQuery, attName, clazz,
									(path.trim().isEmpty()) ? attName : path + "." + attName, level + 1, maxLevel);
						} else {

						}

					}

				}

			}
		}

	}

	private String buildSQL(MappingQuery mappingQuery) {
		String sql = "SELECT ";

		List<MappingQueryItem> joins = new ArrayList<MappingQueryItem>();

		String c = " ";
		int i = 0;

		for (MappingQueryItem item : mappingQuery.getItems()) {

			if (i > 0) {
				c = ",";
			}

			String t = "";
			int ct = item.getPath().split("[.]").length;
			for (int it = 0; it < ct; it++) {
				t += "\t";
			}

			sql += "\n" + t + c + " " + item.getTableAlias() + "." + item.getAtt() + " AS att_" + item.getNumber()
					+ " -- " + item.getPath();

			boolean add = true;
			for (MappingQueryItem join : joins) {
				if (join.getTable().equals(item.getTable())) {
					add = false;
					break;
				}
			}

			if (add) {
				joins.add(item);
			}

			i++;

		}

		sql += "\n";

		for (MappingQueryItem item : joins) {
			if (item.getTableJoin() == null) {
				sql += "\n" + "FROM\t" + item.getSchema() + "." + item.getTable() + " AS " + item.getTableAlias();
			} else {

				String t = "";
				int ct = item.getPath().split("[.]").length;
				for (int it = 0; it < ct; it++) {
					t += "\t";
				}

				sql += "\n" + t + "LEFT JOIN " + item.getSchema() + "." + item.getTable() + " AS "
						+ item.getTableAlias() + " ON " + item.getTableAlias() + ".id = " + item.getTableJoin() + "."
						+ item.getAttJoin();
			}

		}

		return sql;
	}

}
