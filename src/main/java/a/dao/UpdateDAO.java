package a.dao;

public interface UpdateDAO extends GranularDAO {

	public boolean update(Object obj) throws Exception;

	public boolean update(Object obj, @SuppressWarnings("rawtypes") Class mappingClass) throws Exception;

}
