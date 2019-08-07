package a.dao;

import java.util.List;

public interface UpdateBatchDAO extends GranularDAO {	

	public boolean[] update(List<Object> objs) throws Exception;
	
	public boolean[] update(List<Object> objs, @SuppressWarnings("rawtypes") Class mappingClass) throws Exception;

}
