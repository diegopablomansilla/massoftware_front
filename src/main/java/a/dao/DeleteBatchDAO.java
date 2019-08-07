package a.dao;

import java.util.List;

public interface DeleteBatchDAO extends GranularDAO {	

	public boolean[] delete(List<Object> objs) throws Exception;
	
	public boolean[] deleteById(List<String> ids, @SuppressWarnings("rawtypes") Class mappingClass) throws Exception;

}
