package a.convention1.pg;

import java.sql.SQLException;
import java.util.List;

import org.cendra.jdbc.ConnectionWrapper;
import org.cendra.jdbc.DataSourceWrapper;

import a.convention1.pg.op.delete.DeleteAllDAOPG;
import a.convention1.pg.op.delete.DeleteBatchDAOPG;
import a.convention1.pg.op.delete.DeleteDAOPG;
import a.convention1.pg.op.insert.InsertBatchDAOPG;
import a.convention1.pg.op.insert.InsertDAOPG;
import a.convention1.pg.op.query.CountDAOPG;
import a.convention1.pg.op.query.ExistsDAOPG;
import a.convention1.pg.op.query.FillAllDAOPG;
import a.convention1.pg.op.update.UpdateBatchDAOPG;
import a.convention1.pg.op.update.UpdateDAOPG;
import a.dao.DataBase;
import a.dao.op.delete.DeleteAllDAO;
import a.dao.op.delete.DeleteBatchDAO;
import a.dao.op.delete.DeleteDAO;
import a.dao.op.insert.InsertBatchDAO;
import a.dao.op.insert.InsertDAO;
import a.dao.op.query.CountDAO;
import a.dao.op.query.ExistsDAO;
import a.dao.op.query.FillAllDAO;
import a.dao.op.update.UpdateBatchDAO;
import a.dao.op.update.UpdateDAO;

public class DataBasePG implements DataBase {

	private DataSourceWrapper dataSourceWrapper;

	private ConnectionWrapper connectionWrapper;

	public DataBasePG(DataSourceWrapper dataSourceWrapper) {
		super();
		this.dataSourceWrapper = dataSourceWrapper;
	}

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

	public boolean insert(Object obj) throws Exception {

		// if (obj instanceof Continent) {
		// InsertDAO insertDAO = new ContinentInsertDAO(connectionWrapper);
		//
		// return insertDAO.insert(obj);
		// }

		InsertDAO dao = new InsertDAOPG(connectionWrapper);

		return dao.insert(obj);
	}

	@SuppressWarnings("rawtypes")
	public boolean insert(Object obj, Class mappingClass) throws Exception {

		InsertDAO dao = new InsertDAOPG(connectionWrapper);

		return dao.insert(obj, mappingClass);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public boolean[] insertAll(List objs) throws Exception {

		InsertBatchDAO dao = new InsertBatchDAOPG(connectionWrapper);

		return dao.insert(objs);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public boolean[] insertAll(List objs, Class mappingClass) throws Exception {

		InsertBatchDAO dao = new InsertBatchDAOPG(connectionWrapper);

		return dao.insert(objs, mappingClass);
	}

	// -------------------------------------------------

	public boolean update(Object obj) throws Exception {

		UpdateDAO dao = new UpdateDAOPG(connectionWrapper);

		return dao.update(obj);
	}

	@SuppressWarnings("rawtypes")
	public boolean update(Object obj, Class mappingClass) throws Exception {

		UpdateDAO dao = new UpdateDAOPG(connectionWrapper);

		return dao.update(obj, mappingClass);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public boolean[] updateAll(List objs) throws Exception {

		UpdateBatchDAO dao = new UpdateBatchDAOPG(connectionWrapper);

		return dao.update(objs);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public boolean[] updateAll(List objs, Class mappingClass) throws Exception {

		UpdateBatchDAO dao = new UpdateBatchDAOPG(connectionWrapper);

		return dao.update(objs, mappingClass);
	}

	// -------------------------------------------------

	public boolean delete(Object obj) throws Exception {

		DeleteDAO dao = new DeleteDAOPG(connectionWrapper);

		return dao.delete(obj);
	}

	@SuppressWarnings("rawtypes")
	public boolean deleteById(String id, Class mappingClass) throws Exception {

		DeleteDAO dao = new DeleteDAOPG(connectionWrapper);

		return dao.deleteById(id, mappingClass);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public boolean[] deleteAll(List objs) throws Exception {

		DeleteBatchDAO dao = new DeleteBatchDAOPG(connectionWrapper);

		return dao.delete(objs);
	}

	@SuppressWarnings({ "rawtypes" })
	public boolean[] deleteAllById(List<String> ids, Class mappingClass) throws Exception {

		DeleteBatchDAO dao = new DeleteBatchDAOPG(connectionWrapper);

		return dao.deleteById(ids, mappingClass);
	}

	@SuppressWarnings("rawtypes")
	public boolean deleteAll(Class mappingClass) throws Exception {

		DeleteAllDAO dao = new DeleteAllDAOPG(connectionWrapper);

		return dao.delete(mappingClass);
	}

	// -------------------------------------------------

	public boolean exists(Object obj) throws Exception {

		ExistsDAO dao = new ExistsDAOPG(connectionWrapper);

		return dao.exists(obj);
	}

	@SuppressWarnings("rawtypes")
	public boolean existsById(String id, Class mappingClass) throws Exception {

		ExistsDAO dao = new ExistsDAOPG(connectionWrapper);

		return dao.existsById(id, mappingClass);
	}

	// -------------------------------------------------

	@SuppressWarnings("rawtypes")
	public long count(Class mappingClass) throws Exception {

		CountDAO dao = new CountDAOPG(connectionWrapper);

		return dao.count(mappingClass);
	}

	// -------------------------------------------------

	@SuppressWarnings("rawtypes")
	public List fillAll(Class mappingClass) throws Exception {

		FillAllDAO dao = new FillAllDAOPG(connectionWrapper);

		return dao.fillAll(mappingClass);
	}

	@SuppressWarnings("rawtypes")
	public List fillAll(Class mappingClass, int leftLevel) throws Exception {

		FillAllDAO dao = new FillAllDAOPG(connectionWrapper);

		return dao.fillAll(mappingClass, leftLevel);
	}

	@SuppressWarnings("rawtypes")
	public List fillAll(Class instanceClass, Class mappingClass, int leftLevel) throws Exception {

		FillAllDAO dao = new FillAllDAOPG(connectionWrapper);

		return dao.fillAll(instanceClass, mappingClass, leftLevel);
	}
	
	// -------------------------------------------------

	// mejorar el isList
	// implementar DML por atributos
	// mejorar el batch en dsw

	// save

	// findById

	// todo
	// repository CRUD

}
