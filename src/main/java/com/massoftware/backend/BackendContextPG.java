package com.massoftware.backend;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Properties;

import org.apache.commons.dbcp.BasicDataSource;
import org.cendra.cx.AbstractContext;
import org.cendra.ex.crud.UniqueException;
import org.cendra.jdbc.ConnectionWrapper;
import org.cendra.jdbc.DataSourceProperties;
import org.cendra.jdbc.DataSourceWrapper;

import com.massoftware.model.EntityId;

public class BackendContextPG extends AbstractContext {
	
//	C:\Program Files\Java\jre1.8.0_141\bin\server\jvm.dll

	public final static String PG = "Postgresql";

	private DataSourceWrapper dataSourceWrapper;

	private static BackendContextPG backendContext;

	private String dbFilesPath;
	private String iconosPath;

	private BackendContextPG() {
		try {

			init();

		} catch (Exception e) {
			printFatal(e);
		}
	}

	public static synchronized BackendContextPG get() {
		if (backendContext == null) {
			backendContext = new BackendContextPG();
		}

		return backendContext;
	}

	public synchronized String getIconosPath() {
		return iconosPath;
	}

//	private Properties loadProperties() {
//
//		Properties properties = new Properties();
//
//		properties.put("jdbc.driverClassName", "org.postgresql.Driver");
//		properties.put("jdbc.userName", "postgres");
//		properties.put("jdbc.userPassword", "cordoba");
//		properties.put("jdbc.url", "jdbc:postgresql://localhost:5432/massoftware?searchpath=massoftware");
//		properties.put("jdbc.maxActive", "10");
//		properties.put("jdbc.initialSize", "5");
//		properties.put("jdbc.maxIdle", "5");
//		properties.put("jdbc.validationQuery", "SELECT 1");
//		properties.put("jdbc.verbose", "true");
//		properties.put("file.path", "D:\\dev\\source\\\\massoftware_front\\files_db");
//
//		return properties;
//	}


	
	private void init() throws Exception {

//		massoftware.properties
//		Properties properties = loadProperties(
//				System.getProperty("user.dir") + File.separatorChar + "massoftware.conf");
		
		Properties properties = loadProperties("massoftware.properties");

		// -------------------------------------------------------------------

		dbFilesPath = properties.getProperty("file.path");

		iconosPath = dbFilesPath + File.separatorChar + "iconos";

		String path = "jdbc.";

		DataSourceProperties dataSourceProperties = new DataSourceProperties();

		dataSourceProperties.setDriverClassName(properties.getProperty(path + "driverClassName"));
		dataSourceProperties.setUrl(properties.getProperty(path + "url"));
		dataSourceProperties.setUserName(properties.getProperty(path + "userName"));
		dataSourceProperties.setUserPassword(properties.getProperty(path + "userPassword"));
		dataSourceProperties.setInitialSize(new Integer(properties.getProperty(path + "initialSize")));
		dataSourceProperties.setMaxActive(new Integer(properties.getProperty(path + "maxActive")));
		dataSourceProperties.setMaxIdle((new Integer(properties.getProperty(path + "maxIdle"))));
		dataSourceProperties.setValidationQuery(properties.getProperty(path + "validationQuery"));
		dataSourceProperties.setVerbose((new Boolean(properties.getProperty(path + "verbose"))));

		BasicDataSource ds = new BasicDataSource();
		ds.setDriverClassName(dataSourceProperties.getDriverClassName());
		ds.setUrl(dataSourceProperties.getUrl());
		ds.setUsername(dataSourceProperties.getUserName());
		ds.setPassword(dataSourceProperties.getUserPassword());
		ds.setInitialSize(dataSourceProperties.getInitialSize());
		ds.setMaxActive(dataSourceProperties.getMaxActive());
		ds.setMaxIdle(dataSourceProperties.getMaxIdle());
		ds.setValidationQuery(dataSourceProperties.getValidationQuery());

		dataSourceWrapper = new DataSourceWrapper(ds, dataSourceProperties);

	}

	// ================================================================================

	public synchronized Object[][] findAll(String tableName) throws Exception {
		Object[][] table = find(tableName, "*", null, null, -1, -1, null);

		return table;

	}

	public synchronized Object[] findById(String tableName, String id) throws Exception {
		Object[][] table = find(tableName, "*", null, "id = ?", -1, -1, new Object[] { id });

		return table[0];

	}

	public synchronized Object[][] find(String tableName, String atts, String orderBy, String where, int limit,
			int offset, Object[] args) throws Exception {

		if (args == null) {
			args = new Object[0];
		}

		String sql = "SELECT " + atts + " FROM " + "massoftware." + tableName;

		if (where != null && where.trim().length() > 0) {
			sql += " WHERE " + where;
		}

		// if (orderBy == null || orderBy.trim().length() == 0) {
		// throw new Exception("orderBy not found.");
		// }

		if (orderBy != null && orderBy.trim().length() > 0) {
			sql += " ORDER BY " + orderBy;
		} else {
			sql += " ORDER BY " + 1;
		}

		if (offset > -1 && limit > -1) {

			sql += " OFFSET " + offset + " LIMIT " + limit;
		}

		// sql += ";";

		return find(sql, limit, offset, args);
	}

	public synchronized Object[][] find(String sql, int limit, int offset, Object[] args) throws Exception {

		if (args == null) {
			args = new Object[0];
		}

		ConnectionWrapper connectionWrapper = dataSourceWrapper.getConnectionWrapper();

		try {

			Object[][] table = null;

			if (args.length == 0) {
				table = connectionWrapper.findToTable(sql);
			} else {
				table = connectionWrapper.findToTable(sql, args);
			}

			// for (Object item : list) {
			// if (item instanceof Valuable) {
			// ((Valuable) item).validate();
			// }
			// }

			return table;

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			connectionWrapper.close(connectionWrapper);
		}

	}

	@SuppressWarnings("rawtypes")
	public synchronized boolean delete(Class clazz, String id) throws Exception {

		String tableSQL = "massoftware." + clazz.getSimpleName();
		String whereSQL = "";

		ArrayList<Object> args = new ArrayList<Object>();

		args.add(id);
		whereSQL += "id = ?";

		return BackendContextPG.get().delete(tableSQL, whereSQL, args.toArray());
	}

	public synchronized boolean delete(String nameTableDB, String where, Object... args) throws Exception {

		if (args == null) {
			args = new Object[0];
		}

		String sql = "DELETE FROM " + nameTableDB;

		if (where != null && where.trim().length() > 0) {
			sql += " WHERE " + where;
		}

		// sql += ";";

		ConnectionWrapper connectionWrapper = dataSourceWrapper.getConnectionWrapper();

		try {

			connectionWrapper.begin();

			int rows = -1;

			rows = connectionWrapper.delete(sql, args);

			if (rows != 1) {
				throw new Exception(
						"La sentencia debería afectar un solo registro, la sentencia afecto " + rows + " registros.");
			}

			connectionWrapper.commit();

			return true;

		} catch (Exception e) {
			connectionWrapper.rollBack();
			throw e;
		} finally {
			connectionWrapper.close(connectionWrapper);
		}

	}

	public synchronized Integer maxValueInteger(String attName, String tableName) throws Exception {

		String sql = "SELECT MAX(" + attName + ") + 1 FROM massoftware." + tableName;

		ConnectionWrapper connectionWrapper = dataSourceWrapper.getConnectionWrapper();

		try {

			Object[][] table = connectionWrapper.findToTable(sql);

			return (Integer) table[0][0];

		} catch (Exception e) {
			throw e;
		} finally {
			connectionWrapper.close(connectionWrapper);
		}

	}

	public synchronized Integer maxValueInteger(String tableName, String[] attNames, String attNameCount, Object[] args)
			throws Exception {

		String tableSQL = tableName;

		String attsSQL = "MAX(" + attNameCount + ") + 1";
		String orderBySQL = null;
		String whereSQL = "";

		ArrayList<Object> filtros = new ArrayList<Object>();

		for (int i = 0; i < attNames.length; i++) {
			Object arg = args[i];
			String attName = attNames[i];

			filtros.add(arg);
			whereSQL += attName + " = ? AND ";

		}

		// ==================================================================

		whereSQL = whereSQL.trim();
		if (whereSQL.length() > 0) {
			whereSQL = whereSQL.substring(0, whereSQL.length() - 4);
		} else {
			whereSQL = null;
		}

		// ==================================================================

		Object[][] table = BackendContextPG.get().find(tableSQL, attsSQL, orderBySQL, whereSQL, -1, -1,
				filtros.toArray());

		return (Integer) table[0][0];

	}

	public synchronized boolean update(String nameTableDB, String[] nameAtts, Object[] args, String where)
			throws Exception {

		if (args == null) {
			args = new Object[0];
		}

		String sql = buildUpdate(nameTableDB, nameAtts, where);

		ConnectionWrapper connectionWrapper = dataSourceWrapper.getConnectionWrapper();

		try {

			connectionWrapper.begin();

			int rows = connectionWrapper.update(sql, args);

			if (rows != 1) {
				throw new Exception(
						"La sentencia debería afectar un registro, la sentencia afecto " + rows + " registros.");
			}

			connectionWrapper.commit();

			return true;

		} catch (Exception e) {
			connectionWrapper.rollBack();
			throw e;
		} finally {
			connectionWrapper.close(connectionWrapper);
		}
	}

	private synchronized String buildUpdate(String tableName, String[] nameAtts, String where) throws Exception {

		String sql = "UPDATE " + "massoftware." + tableName + " SET ";

		for (int i = 0; i < nameAtts.length; i++) {
			sql += nameAtts[i] + " = ?";
			if (i < nameAtts.length - 1) {
				sql += ", ";
			}
		}

		sql += " WHERE " + where + ";";

		return sql;
	}

	public synchronized boolean insert(String tableName, String[] nameAtts, Object[] args) throws Exception {

		if (args == null) {
			args = new Object[0];
		}

		String sql = "INSERT INTO " + "massoftware." + tableName + " (";

		for (int i = 0; i < nameAtts.length; i++) {
			sql += nameAtts[i];
			if (i < nameAtts.length - 1) {
				sql += ", ";
			}
		}

		sql += ") VALUES (";

		for (int i = 0; i < args.length; i++) {
			sql += "?";
			if (i < args.length - 1) {
				sql += ", ";
			}
		}

		sql += ")";

		ConnectionWrapper connectionWrapper = dataSourceWrapper.getConnectionWrapper();

		try {

			connectionWrapper.begin();

			int rows = connectionWrapper.insert(sql, args);

			if (rows != 1) {
				throw new Exception(
						"La sentencia debería afectar un registro, la sentencia afecto " + rows + " registros.");
			}

			connectionWrapper.commit();

			return true;

		} catch (Exception e) {
			connectionWrapper.rollBack();
			throw e;
		} finally {
			connectionWrapper.close(connectionWrapper);
		}
	}

	public synchronized boolean insertByReflection(Object dto) throws Exception {

		Field[] fields = dto.getClass().getDeclaredFields();

		String[] nameAtts = new String[fields.length];
		Object[] args = new Object[fields.length];

		for (int i = 0; i < fields.length; i++) {

			String nameAttDB = fields[i].getName();
			nameAtts[i] = nameAttDB;

			String methodName = "get" + fields[i].getName().substring(0, 1).toUpperCase()
					+ fields[i].getName().substring(1, fields[i].getName().length());

			Method method = dto.getClass().getMethod(methodName);

			args[i] = method.invoke(dto);

			if (args[i] == null) {
				args[i] = fields[i].getType();
			} else if (args[i] != null && isPrimitive(fields[i].getType()) == false) {

				method = fields[i].getType().getMethod("getId");
				args[i] = method.invoke(args[i]);
				if (args[i] == null) {
					args[i] = String.class;
				}
			}
		}

		String nameTableDB = "massoftware." + dto.getClass().getSimpleName();

		return insert(nameTableDB, nameAtts, args);
	}

	public synchronized boolean updateByReflection(Object dto) throws Exception {

		Field[] fields = dto.getClass().getDeclaredFields();

		String[] nameAtts = new String[fields.length];
		Object[] args = new Object[fields.length + 1];

		for (int i = 0; i < fields.length; i++) {

			String nameAttDB = fields[i].getName();
			nameAtts[i] = nameAttDB;

			String methodName = "get" + fields[i].getName().substring(0, 1).toUpperCase()
					+ fields[i].getName().substring(1, fields[i].getName().length());

			Method method = dto.getClass().getMethod(methodName);

			args[i] = method.invoke(dto);

			if (args[i] == null) {
				args[i] = fields[i].getType();
			} else if (args[i] != null && isPrimitive(fields[i].getType()) == false) {

				method = fields[i].getType().getMethod("getId");
				args[i] = method.invoke(args[i]);
				if (args[i] == null) {
					args[i] = String.class;
				}
			}
		}

		args[fields.length] = args[0];

		String nameTableDB = "massoftware." + dto.getClass().getSimpleName();

		return update(nameTableDB, nameAtts, args, "id = ?");
	}

	public synchronized void checkUnique(String tableName, String attName, String label, Object originalValue,
			Object newValue) throws Exception {

		if (originalValue != null && originalValue.equals(newValue) == false) {

			if (ifExists(tableName, attName, newValue)) {
				throw new UniqueException(label);
			}

		} else if (originalValue == null) {

			if (ifExists(tableName, attName, newValue)) {
				throw new UniqueException(label);
			}
		}

	}

	@SuppressWarnings("rawtypes")
	public synchronized Long ifExistsByFkId(Class clazz, String id) throws Exception {

		String tableSQL = clazz.getSimpleName();

		String attsSQL = "COUNT(" + clazz.getSimpleName() + ") ";
		String orderBySQL = null;
		String whereSQL = "";

		ArrayList<Object> filtros = new ArrayList<Object>();

		filtros.add(id);
		whereSQL += clazz.getSimpleName() + " = ?";

		// ==================================================================

		Object[][] table = BackendContextPG.get().find(tableSQL, attsSQL, orderBySQL, whereSQL, -1, -1,
				filtros.toArray());

		return (Long) table[0][0];

	}

	private synchronized boolean ifExists(String tableName, String attName, Object arg) throws Exception {

		String tableSQL = tableName;

		String attsSQL = "COUNT(" + "*" + ") ";
		String orderBySQL = null;
		String whereSQL = "";

		ArrayList<Object> filtros = new ArrayList<Object>();

		filtros.add(arg);
		if (arg instanceof String) {
			whereSQL += "LOWER(TRIM(massoftware.TRANSLATE(" + attName
					+ ")))::VARCHAR = LOWER(TRIM(massoftware.TRANSLATE(?)))::VARCHAR";
		} else {
			whereSQL += attName + " = ?";
		}

		// ==================================================================

		Object[][] table = BackendContextPG.get().find(tableSQL, attsSQL, orderBySQL, whereSQL, -1, -1,
				filtros.toArray());

		return (Long) table[0][0] > 0;

	}

	public synchronized boolean ifExists(EntityId dto, String[] attNames, Object[] args) throws Exception {

		String tableSQL = dto.getClass().getSimpleName();

		String attsSQL = "COUNT(" + "*" + ") ";
		String orderBySQL = null;
		String whereSQL = "";

		ArrayList<Object> filtros = new ArrayList<Object>();

		for (int i = 0; i < attNames.length; i++) {
			Object arg = args[i];
			String attName = attNames[i];

			filtros.add(arg);
			if (arg instanceof String) {
				whereSQL += "LOWER(TRIM(massoftware.TRANSLATE(" + attName
						+ ")))::VARCHAR = LOWER(TRIM(massoftware.TRANSLATE(?)))::VARCHAR AND ";
			} else {
				whereSQL += attName + " = ? AND ";
			}

		}

		// ==================================================================

		whereSQL = whereSQL.trim();
		if (whereSQL.length() > 0) {
			whereSQL = whereSQL.substring(0, whereSQL.length() - 4);
		} else {
			whereSQL = null;
		}

		// ==================================================================

		Object[][] table = BackendContextPG.get().find(tableSQL, attsSQL, orderBySQL, whereSQL, -1, -1,
				filtros.toArray());

		return (Long) table[0][0] > 0;

	}

	@SuppressWarnings("rawtypes")
	private synchronized boolean isPrimitive(Class c) {

		if (c.equals(String.class)) {
			return true;
		} else if (c.equals(Boolean.class)) {
			return true;
		} else if (c.equals(Short.class)) {
			return true;
		} else if (c.equals(Integer.class)) {
			return true;
		} else if (c.equals(Long.class)) {
			return true;
		} else if (c.equals(Float.class)) {
			return true;
		} else if (c.equals(Double.class)) {
			return true;
		} else if (c.equals(BigDecimal.class)) {
			return true;
		} else if (c.equals(Date.class)) {
			return true;
		} else if (c.equals(java.util.Date.class)) {
			return true;
		} else if (c.equals(Timestamp.class)) {
			return true;
		} else if (c.equals(Time.class)) {
			return true;
		} else {
			return false;
		}
	}

	// ================================================================================

}
