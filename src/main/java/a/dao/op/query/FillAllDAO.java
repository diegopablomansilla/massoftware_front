package a.dao.op.query;

import java.util.List;

import a.dao.op.GranularDAO;

public interface FillAllDAO extends GranularDAO {
	
	@SuppressWarnings("rawtypes")
	public List fillAll(Class mappingClass) throws Exception;

	@SuppressWarnings("rawtypes")
	public List fillAll(Class mappingClass, int leftLevel) throws Exception;
	
	@SuppressWarnings("rawtypes")
	public List fillAll(Class instanceClass, Class mappingClass, int leftLevel) throws Exception;

}
