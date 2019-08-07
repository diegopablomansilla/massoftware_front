package a.dao;

import java.sql.SQLException;
import java.util.List;

public interface DataBase {

	public void begint() throws SQLException, Exception;

	public void commit() throws SQLException, Exception;

	public void rollBack() throws SQLException, Exception;

	public void close() throws SQLException, Exception;

	// -------------------------------------------------------

	public Object insert(Object obj) throws Exception;

	@SuppressWarnings({ "rawtypes" })
	public List insertList(List objs) throws Exception;

}
