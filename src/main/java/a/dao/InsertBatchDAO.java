package a.dao;

import java.util.List;

public interface InsertBatchDAO extends GranularDAO {	

	public boolean[] insert(List<Object> objs) throws Exception;
	
	public boolean[] insert(List<Object> objs, @SuppressWarnings("rawtypes") Class mappingClass) throws Exception;

}
