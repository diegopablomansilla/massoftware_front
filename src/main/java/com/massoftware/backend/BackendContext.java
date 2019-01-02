package com.massoftware.backend;

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
import com.microsoft.sqlserver.jdbc.SQLServerDataSource;

public class BackendContext extends AbstractContext {

	public final static String MS = "sqlserver";
	public final static String PG = "Postgresql";

	private DataSourceWrapper dataSourceWrapper;

	private static BackendContext backendContext;

	private BackendContext(String engineDB) {
		Properties propertiesMS = new Properties();

		propertiesMS.put("jdbc.driverClassName", "com.microsoft.sqlserver.jdbc.SQLServerDriver");
		propertiesMS.put("jdbc.userName", "sa");
		propertiesMS.put("jdbc.userPassword", "cordoba");
		// properties.put("jdbc.url", ds.getURL());
		propertiesMS.put("jdbc.maxActive", "10");
		propertiesMS.put("jdbc.initialSize", "5");
		propertiesMS.put("jdbc.maxIdle", "5");
		propertiesMS.put("jdbc.validationQuery", "SELECT 1");
		propertiesMS.put("jdbc.verbose", "true");
		propertiesMS.put("jdbc.serverName", "localhost");
		propertiesMS.put("jdbc.databaseName", "VetaroRep");
		propertiesMS.put("jdbc.portNumber", "1433");

		Properties propertiesPG = new Properties();

		propertiesPG.put("jdbc.driverClassName", "org.postgresql.Driver");
		propertiesPG.put("jdbc.userName", "postgres");
		propertiesPG.put("jdbc.userPassword", "cordoba");
		propertiesPG.put("jdbc.url", "jdbc:postgresql://localhost:5432/massoftware?searchpath=massoftware");
		propertiesPG.put("jdbc.maxActive", "10");
		propertiesPG.put("jdbc.initialSize", "5");
		propertiesPG.put("jdbc.maxIdle", "5");
		propertiesPG.put("jdbc.validationQuery", "SELECT 1");
		propertiesPG.put("jdbc.verbose", "true");

		start(engineDB, propertiesPG);

	}

	public static synchronized BackendContext get() {
		if (backendContext == null) {
			backendContext = new BackendContext(PG);
		}

		return backendContext;
	}

	private void start(String type, Properties properties) {

		try {

			init(type, properties);

		} catch (Exception e) {
			printFatal(e);
		}

	}

	private void init(String dbType, Properties properties) throws Exception {

		if (dbType.equals(PG)) {
			initContextDbPostgreSql(properties);
		} else if (dbType.equals(MS)) {
			initContextDbMsSqlServer(properties);
		}
	}

	private void initContextDbMsSqlServer(Properties properties) throws Exception {

		String path = "jdbc.";

		SQLServerDataSource ds = new SQLServerDataSource();
		// ds.setIntegratedSecurity(true);
		ds.setServerName(properties.getProperty(path + "serverName"));
		ds.setPortNumber(new Integer(properties.getProperty(path + "portNumber")));
		ds.setDatabaseName(properties.getProperty(path + "databaseName"));
		ds.setUser(properties.getProperty(path + "userName"));
		ds.setPassword(properties.getProperty(path + "userPassword"));

		properties.put("jdbc.url", ds.getURL());

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

		// dataSource = ds;

		dataSourceWrapper = new DataSourceWrapper(ds, dataSourceProperties);

	}

	private void initContextDbPostgreSql(Properties properties) throws Exception {

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

		// dataSource = ds;

		dataSourceWrapper = new DataSourceWrapper(ds, dataSourceProperties);

	}

	// -------------------------------------------------------------

	// public ResourceBundle getMessages() {
	// return loadResourceBundle("MessagesBundle");
	// }
	//
	// public String getMessage(String key) {
	// return loadResourceBundle("MessagesBundle").getString(key);
	// }

	// -------------------------------------------------------------

	// ================================================================================

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

	public boolean insertByReflection(Object dto) throws Exception {

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

	public boolean updateByReflection(Object dto) throws Exception {

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

		update(nameTableDB, nameAtts, args, "id = ?");

		return insert(nameTableDB, nameAtts, args);
	}
	
	public void checkUnique(EntityId dto, String attName, String label, Object originalValue, Object newValue) throws Exception {

		if (originalValue != null && originalValue.equals(newValue) == false) {

			if (ifExists(dto, attName, newValue)) {
				throw new UniqueException(label);
			}

		} else if (originalValue == null) {

			if (ifExists(dto, attName, newValue)) {
				throw new UniqueException(label);
			}
		}

	}

	private boolean ifExists(EntityId dto, String attName, Object arg) throws Exception {

		String tableSQL = dto.getClass().getSimpleName();

		String attsSQL = "COUNT(" + attName + ") ";
		String orderBySQL = null;
		String whereSQL = "";

		ArrayList<Object> filtros = new ArrayList<Object>();

		filtros.add(arg);
		if (arg instanceof String) {
			whereSQL += "LOWER(TRIM(massoftware.TRASLATE(" + attName + ")))::VARCHAR = LOWER(TRIM(massoftware.TRASLATE(?)))::VARCHAR";
		} else {
			whereSQL += attName + " = ?";
		}

		// ==================================================================

		Object[][] table = BackendContext.get().find(tableSQL, attsSQL, orderBySQL, whereSQL, -1, -1,
				filtros.toArray());

		return (Long) table[0][0] > 0;

	}

	@SuppressWarnings("rawtypes")
	private boolean isPrimitive(Class c) {

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
