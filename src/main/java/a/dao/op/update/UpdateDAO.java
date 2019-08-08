package a.dao.op.update;

import a.dao.op.GranularDAO;

public interface UpdateDAO extends GranularDAO {

	public boolean update(Object obj) throws Exception;

	public boolean update(Object obj, @SuppressWarnings("rawtypes") Class mappingClass) throws Exception;

}
