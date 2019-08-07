package a.dao;

import java.sql.SQLException;
import java.util.List;

public interface DataBase {

	public void begint() throws SQLException, Exception;

	public void commit() throws SQLException, Exception;

	public void rollBack() throws SQLException, Exception;

	public void close() throws SQLException, Exception;

	// -------------------------------------------------------

	public boolean insert(Object obj) throws Exception;

	@SuppressWarnings("rawtypes")
	public boolean insert(Object obj, Class mappingClass) throws Exception;

	// -------------------------------------------------

	@SuppressWarnings("rawtypes")
	public boolean[] insertAll(List objs) throws Exception;

	@SuppressWarnings("rawtypes")
	public boolean[] insertAll(List objs, Class mappingClass) throws Exception;

	// -------------------------------------------------

	public boolean update(Object obj) throws Exception;

	@SuppressWarnings("rawtypes")
	public boolean update(Object obj, Class mappingClass) throws Exception;

	// -------------------------------------------------

	@SuppressWarnings("rawtypes")
	public boolean[] updateAll(List objs) throws Exception;

	@SuppressWarnings("rawtypes")
	public boolean[] updateAll(List objs, Class mappingClass) throws Exception;

	// -------------------------------------------------

	public boolean delete(Object obj) throws Exception;

	@SuppressWarnings("rawtypes")
	public boolean deleteById(String id, Class mappingClass) throws Exception;

	// -------------------------------------------------

	@SuppressWarnings("rawtypes")
	public boolean[] deleteAll(List objs) throws Exception;

	@SuppressWarnings("rawtypes")
	public boolean[] deleteAllById(List<String> ids, Class mappingClass) throws Exception;

	// -------------------------------------------------

	public boolean exists(Object obj) throws Exception;

	@SuppressWarnings("rawtypes")
	public boolean existsById(String id, Class mappingClass) throws Exception;

	// -------------------------------------------------

	@SuppressWarnings("rawtypes")
	public boolean deleteAll(Class mappingClass) throws Exception;

	// -------------------------------------------------

	@SuppressWarnings("rawtypes")
	public long count(Class mappingClass) throws Exception;

	// -------------------------------------------------

}
