package a.dao;

public interface InsertDAO extends IGranularDAO {

	public Object insert(Object obj) throws Exception;

	public Object insert(Object obj, @SuppressWarnings("rawtypes") Class persistentClass) throws Exception;

}
