package a.convention1.pg;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.cendra.jdbc.ConnectionWrapper;
import org.cendra.jdbc.DataSourceWrapper;

import a.convention1.anotations.Identifiable;

public class DataBasePG {

	private UpdateDAO updateDAO;
	private InsertDAO insertDAO;
	private QueryDAO queryDAO;
	private DeleteDAO deleteDAO;

	// -----------------------------------------------------

	private DataSourceWrapper dataSourceWrapper;
	private String schema;

	private ConnectionWrapper connectionWrapper;

	public DataBasePG(DataSourceWrapper dataSourceWrapper, String schema) {
		super();
		this.dataSourceWrapper = dataSourceWrapper;
		this.schema = schema;
		updateDAO = new UpdateDAO(this.schema);
		insertDAO = new InsertDAO(this.schema);
		queryDAO = new QueryDAO(this.schema);
		deleteDAO = new DeleteDAO(this.schema);
	}

	// -------------------------------------------------------------------------------

	public void begint() throws SQLException, Exception {
		if (connectionWrapper != null) {
			throw new IllegalStateException(
					"Debe hacer close() la conexión primero, debido a que ya ha realizado un begint().");
		}
		connectionWrapper = dataSourceWrapper.getConnectionWrapper();
		connectionWrapper.begin();
	}

	public void commit() throws SQLException, Exception {
		connectionWrapper.commit();
	}

	public void rollBack() throws SQLException, Exception {
		connectionWrapper.rollBack();
	}

	public void close() throws SQLException, Exception {
		connectionWrapper.close();
		connectionWrapper = null;
	}

	// -------------------------------------------------------------------------------

	public boolean insertObject(Object obj) throws Exception {
		if (obj instanceof Identifiable == false) {
			throw new IllegalArgumentException(
					"INSERT: Se esperaba un objeto tipo " + Identifiable.class.getSimpleName());
		}
		return insertDAO.insertObject(connectionWrapper, (Identifiable) obj);
	}

	@SuppressWarnings("rawtypes")
	public boolean insertObject(Object obj, Class mappingClass) throws Exception {
		if (obj instanceof Identifiable == false) {
			throw new IllegalArgumentException(
					"INSERT: Se esperaba un objeto tipo " + Identifiable.class.getSimpleName());
		}
		return insertDAO.insertObject(connectionWrapper, (Identifiable) obj, mappingClass);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public boolean[] insertObjects(List objs) throws Exception {
		return insertDAO.insertObjects(connectionWrapper, objs);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public boolean[] insertObjects(List objs, Class mappingClass) throws Exception {
		return insertDAO.insertObjects(connectionWrapper, objs, mappingClass);
	}

	// -------------------------------------------------

	public boolean updateObject(Object obj) throws Exception {
		if (obj instanceof Identifiable == false) {
			throw new IllegalArgumentException(
					"UPDATE: Se esperaba un objeto tipo " + Identifiable.class.getSimpleName());
		}
		return updateDAO.updateObject(connectionWrapper, (Identifiable) obj);
	}

	@SuppressWarnings("rawtypes")
	public boolean updateObject(Object obj, Class mappingClass) throws Exception {
		if (obj instanceof Identifiable == false) {
			throw new IllegalArgumentException(
					"UPDATE: Se esperaba un objeto tipo " + Identifiable.class.getSimpleName());
		}
		return updateDAO.updateObject(connectionWrapper, (Identifiable) obj, mappingClass);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public boolean[] updateObjects(List objs) throws Exception {
		return updateDAO.updateObjects(connectionWrapper, objs);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public boolean[] updateObjects(List objs, Class mappingClass) throws Exception {
		return updateDAO.updateObjects(connectionWrapper, objs, mappingClass);
	}

	// -------------------------------------------------

	public boolean deleteObject(Object obj) throws Exception {
		if (obj instanceof Identifiable == false) {
			throw new IllegalArgumentException(
					"DELETE: Se esperaba un objeto tipo " + Identifiable.class.getSimpleName());
		}
		return deleteDAO.deleteObject(connectionWrapper, (Identifiable) obj);
	}

	@SuppressWarnings("rawtypes")
	public boolean deleteObjectById(String id, Class mappingClass) throws Exception {
		return deleteDAO.deleteObjectById(connectionWrapper, id, mappingClass);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public boolean[] deleteObjects(List objs) throws Exception {
		return deleteDAO.deleteObjects(connectionWrapper, objs);
	}

	@SuppressWarnings({ "rawtypes" })
	public boolean[] deleteObjectsById(List<String> ids, Class mappingClass) throws Exception {
		return deleteDAO.deleteObjectsById(connectionWrapper, ids, mappingClass);
	}

	@SuppressWarnings("rawtypes")
	public boolean deleteAllObjects(Class mappingClass) throws Exception {
		return deleteDAO.deleteAllObjects(connectionWrapper, mappingClass);
	}

	// -------------------------------------------------

	public boolean objectExist(Object obj) throws Exception {

		if (obj instanceof Identifiable == false) {
			throw new IllegalArgumentException(
					"QUERY: Se esperaba un objeto tipo " + Identifiable.class.getSimpleName());
		}

		// if (obj instanceof Identifiable == false) {
		// throw new IllegalArgumentException(
		// "QUERY: Se esperaba una lista objetos, con objetos tipo " +
		// Identifiable.class.getSimpleName());
		// }

		return queryDAO.objectExist(connectionWrapper, (Identifiable) obj);
	}

	@SuppressWarnings("rawtypes")
	public boolean objectExistById(String id, Class mappingClass) throws Exception {
		return queryDAO.objectExistById(connectionWrapper, id, mappingClass);
	}

	// -------------------------------------------------

	@SuppressWarnings("rawtypes")
	public long countAllObjects(Class mappingClass) throws Exception {
		return queryDAO.countAllObjects(connectionWrapper, mappingClass);
	}

	// -------------------------------------------------

	public Object fillObject(Object obj) throws Exception {

		if (obj instanceof Identifiable == false) {
			throw new IllegalArgumentException(
					"QUERY: Se esperaba un objeto tipo " + Identifiable.class.getSimpleName());
		}

		return queryDAO.fillObject(connectionWrapper, (Identifiable) obj);
	}

	public Object fillObject(Object obj, int leftLevel) throws Exception {

		if (obj instanceof Identifiable == false) {
			throw new IllegalArgumentException(
					"QUERY: Se esperaba un objeto tipo " + Identifiable.class.getSimpleName());
		}

		return queryDAO.fillObject(connectionWrapper, (Identifiable) obj, leftLevel);
	}

	@SuppressWarnings({ "rawtypes" })
	public Object fillObject(Object obj, Class mappingClass) throws Exception {

		if (obj instanceof Identifiable == false) {
			throw new IllegalArgumentException(
					"QUERY: Se esperaba un objeto tipo " + Identifiable.class.getSimpleName());
		}

		return queryDAO.fillObject(connectionWrapper, (Identifiable) obj, mappingClass);
	}

	@SuppressWarnings({ "rawtypes" })
	public Object fillObject(Object obj, Class mappingClass, int leftLevel) throws Exception {

		if (obj instanceof Identifiable == false) {
			throw new IllegalArgumentException(
					"QUERY: Se esperaba un objeto tipo " + Identifiable.class.getSimpleName());
		}

		return queryDAO.fillObject(connectionWrapper, (Identifiable) obj, mappingClass, leftLevel);
	}

	@SuppressWarnings("rawtypes")
	public Object fillObject(Object obj, Class instanceClass, Class mappingClass, int leftLevel) throws Exception {

		if (obj instanceof Identifiable == false) {
			throw new IllegalArgumentException(
					"QUERY: Se esperaba un objeto tipo " + Identifiable.class.getSimpleName());
		}

		return queryDAO.fillObject(connectionWrapper, (Identifiable) obj, instanceClass, mappingClass, leftLevel);
	}

	@SuppressWarnings({ "rawtypes" })
	public Object fillObjectById(String id, Class mappingClass) throws Exception {
		return queryDAO.fillObject(connectionWrapper, id, mappingClass);
	}

	@SuppressWarnings({ "rawtypes" })
	public Object fillObjectById(String id, Class mappingClass, int leftLevel) throws Exception {
		return queryDAO.fillObject(connectionWrapper, id, mappingClass, leftLevel);
	}

	@SuppressWarnings({ "rawtypes" })
	public Object fillObjectById(String id, Class instanceClass, Class mappingClass, int leftLevel) throws Exception {
		return queryDAO.fillObject(connectionWrapper, id, instanceClass, mappingClass, leftLevel);

	}

	@SuppressWarnings("rawtypes")
	public List fillAllObjects(Class mappingClass) throws Exception {
		return queryDAO.fillAllObjects(connectionWrapper, mappingClass);
	}

	@SuppressWarnings("rawtypes")
	public List fillAllObjects(Class mappingClass, int leftLevel) throws Exception {
		return queryDAO.fillAllObjects(connectionWrapper, mappingClass, leftLevel);
	}

	@SuppressWarnings("rawtypes")
	public List fillAllObjects(Class instanceClass, Class mappingClass, int leftLevel) throws Exception {
		return queryDAO.fillAllObjects(connectionWrapper, instanceClass, mappingClass, leftLevel);
	}

	// -------------------------------------------------

	@SuppressWarnings("rawtypes")
	public List<String> utilExtractsIds(List objs) {

		if (objs == null) {
			throw new IllegalArgumentException("Se esperaba una lista de objetos no nulo.");
		}

		if (objs.size() == 0) {
			throw new IllegalArgumentException("Se esperaba una lista objetos no vacia.");
		}

		List<String> ids = new ArrayList<String>();

		for (Object obj : objs) {

			if (obj == null) {
				throw new IllegalArgumentException("Se esperaba una lista objetos con objetos no nulos.");
			}

			if (obj != null && obj instanceof Identifiable && ((Identifiable) obj).getId() != null
					&& ((Identifiable) obj).getId().trim().isEmpty() == false) {
				ids.add(((Identifiable) obj).getId());
			}
		}

		return ids;
	}

	// -------------------------------------------------

	// fill rigthLevel
	// mejorar el isList
	// implementar DML por atributos
	// mejorar el batch en dsw

	// save

	// findById

	// todo
	// repository CRUD

}
