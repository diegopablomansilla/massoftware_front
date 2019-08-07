package a.dao;

public interface CountDAO extends GranularDAO {

	public long count(@SuppressWarnings("rawtypes") Class mappingClass) throws Exception;

}
