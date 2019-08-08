package a.dao.op.delete;

import a.dao.op.GranularDAO;

public interface DeleteDAO extends GranularDAO {

	public boolean delete(Object obj) throws Exception;

	public boolean deleteById(String id, @SuppressWarnings("rawtypes") Class mappingClass) throws Exception;

}
