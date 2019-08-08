package a.dao.op.delete;

import a.dao.op.GranularDAO;

public interface DeleteAllDAO extends GranularDAO {

	public boolean delete(@SuppressWarnings("rawtypes") Class mappingClass) throws Exception;

}
