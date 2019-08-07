package a.dao.pg.wrapperds.massoftware;

import java.util.UUID;

import org.cendra.jdbc.ConnectionWrapper;

import a.Continent;
import a.dao.InsertDAO;

public class ContinentInsertDAO implements InsertDAO {

	private ConnectionWrapper connectionWrapper;

	public ContinentInsertDAO(ConnectionWrapper connectionWrapper) {
		this.connectionWrapper = connectionWrapper;
	}

	@Override
	public boolean insert(Object objArg) throws Exception {

		if (objArg == null) {
			throw new IllegalArgumentException("INSERT: Se esperaba un objeto " + Continent.class.getSimpleName() + " no nulo.");
		}

		if (objArg instanceof Continent == false) {
			throw new IllegalArgumentException(
					"INSERT: Se esperaba un objeto de tipo " + Continent.class.getSimpleName());
		}

		Continent obj = (Continent) objArg;
		obj.setId(UUID.randomUUID().toString());

		String sql = "INSERT INTO geo.Continent (Id, Code, Name) VALUES (?, ?, ?)";

		Object id = (obj.getId() == null) ? String.class : obj.getId();
		Object code = (obj.getCode() == null) ? String.class : obj.getCode();
		Object name = (obj.getName() == null) ? String.class : obj.getName();

		Object[] args = new Object[] { id, code, name };

		int rows = connectionWrapper.insert(sql, args);

		if (rows != 1) {
			throw new IllegalStateException("No se esperaba que la sentencia no insertara en la base de datos.");
		}
		
		return true;

	}

	@SuppressWarnings("rawtypes")
	@Override
	public boolean insert(Object objArg, Class persistentClass) throws Exception {

		return insert(objArg);
	}

}
