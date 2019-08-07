package a.dao.pg.wrapperds;

import java.sql.SQLException;
import java.util.List;

import org.cendra.jdbc.ConnectionWrapper;
import org.cendra.jdbc.DataSourceWrapper;

import a.Continent;
import a.dao.DataBase;
import a.dao.InsertBatchDAO;
import a.dao.InsertDAO;
import a.dao.pg.wrapperds.massoftware.ContinentInsert;

public class DataBasePG implements DataBase {

	private DataSourceWrapper dataSourceWrapper;

	private ConnectionWrapper connectionWrapper;

	public DataBasePG(DataSourceWrapper dataSourceWrapper) {
		super();
		this.dataSourceWrapper = dataSourceWrapper;
	}

	public void begint() throws SQLException, Exception {
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
	}

	public Object insert(Object obj) throws Exception {

		if (obj instanceof Continent) {
			InsertDAO insertDAO = new ContinentInsert(connectionWrapper);

			return insertDAO.insert(obj);
		}

		InsertDAO insertDAO = new InsertDAOPG(connectionWrapper);

		return insertDAO.insert(obj);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List insertList(List objs) throws Exception {

		InsertBatchDAO insertDAO = new InsertBatchDAOPG(connectionWrapper);

		return insertDAO.insert(objs);
	}

//	insert con proyeccion
//	insert only id==null update*
//	save
//	delete
//	findById
//	
//	todo
//	repository CRUD

}
