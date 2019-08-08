package a.dao.op.query;

import a.dao.op.GranularDAO;

public interface CountDAO extends GranularDAO {

	public long count(@SuppressWarnings("rawtypes") Class mappingClass) throws Exception;

}
