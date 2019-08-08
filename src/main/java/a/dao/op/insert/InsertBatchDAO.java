package a.dao.op.insert;

import java.util.List;

import a.dao.op.GranularDAO;

public interface InsertBatchDAO extends GranularDAO {	

	public boolean[] insert(List<Object> objs) throws Exception;
	
	public boolean[] insert(List<Object> objs, @SuppressWarnings("rawtypes") Class mappingClass) throws Exception;

}
