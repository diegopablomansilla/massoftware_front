package a.dao;

public interface InsertDAO extends GranularDAO {

	public boolean insert(Object obj) throws Exception;

	public boolean insert(Object obj, @SuppressWarnings("rawtypes") Class mappingClass) throws Exception;

}
