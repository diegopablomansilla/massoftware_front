package a.dao;

public interface DeleteAllDAO extends GranularDAO {

	public boolean delete(@SuppressWarnings("rawtypes") Class mappingClass) throws Exception;

}
