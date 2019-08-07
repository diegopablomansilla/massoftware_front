package a.dao;

import java.util.List;

public interface InsertBatchDAO extends IGranularDAO {	

	public List<Object> insert(List<Object> objs) throws Exception;

}
