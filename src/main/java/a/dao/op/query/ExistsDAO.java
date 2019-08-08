package a.dao.op.query;

import a.dao.op.GranularDAO;

public interface ExistsDAO extends GranularDAO {

	public boolean exists(Object obj) throws Exception;

	public boolean existsById(String id, @SuppressWarnings("rawtypes") Class mappingClass) throws Exception;

}
