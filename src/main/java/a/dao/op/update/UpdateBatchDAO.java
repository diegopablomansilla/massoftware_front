package a.dao.op.update;

import java.util.List;

import a.dao.op.GranularDAO;

public interface UpdateBatchDAO extends GranularDAO {	

	public boolean[] update(List<Object> objs) throws Exception;
	
	public boolean[] update(List<Object> objs, @SuppressWarnings("rawtypes") Class mappingClass) throws Exception;

}
