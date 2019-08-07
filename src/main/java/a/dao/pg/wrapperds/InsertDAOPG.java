package a.dao.pg.wrapperds;

import java.lang.reflect.Method;
import java.util.UUID;

import org.cendra.jdbc.ConnectionWrapper;

import a.anotations.Persistent;
import a.dao.InsertDAO;
import a.dao.Statement;
import a.model.Identifiable;

public class InsertDAOPG extends AbstractInsertDAOPG implements InsertDAO {

	private ConnectionWrapper connectionWrapper;

	public InsertDAOPG(ConnectionWrapper connectionWrapper) {
		this.connectionWrapper = connectionWrapper;
	}

	@Override
	public Object insert(Object obj) throws Exception {

		Statement statement = buildStatement(obj);

		int rows = connectionWrapper.insert(statement.getSql(), statement.getArgs());

		if (rows != 1) {
			throw new IllegalStateException("No se esperaba que la sentencia no insertara en la base de datos.");
		}

		return obj;
	}

	@Override
	public Object insert(Object obj, @SuppressWarnings("rawtypes") Class persistentClass) throws Exception {

		Statement statement = buildStatement((Identifiable) obj, persistentClass);

		int rows = connectionWrapper.insert(statement.getSql(), statement.getArgs());

		if (rows != 1) {
			throw new IllegalStateException("No se esperaba que la sentencia no insertara en la base de datos.");
		}

		return obj;

	}

	// --------------------------------------------------------------------------------------------------------

	private Statement buildStatement(Object entity) throws Exception {
		if (entity == null) {
			throw new IllegalArgumentException("INSERT: Se esperaba un objeto no nulo.");
		}
		return buildStatement(entity, entity.getClass());
	}

	@SuppressWarnings("rawtypes")
	private Statement buildStatement(Object entity, Class persistentClass) throws Exception {

		if (entity == null) {
			throw new IllegalArgumentException("INSERT: Se esperaba un objeto no nulo.");
		}

		if (persistentClass == null) {
			throw new IllegalArgumentException("INSERT: Se esperaba una objeto Class no nulo.");
		}

		if (isPersistent(persistentClass) == false) {
			throw new IllegalArgumentException(
					"INSERT: Se esperaba una objeto Class anotado con " + Persistent.class.getCanonicalName());
		}

		if (entity instanceof Identifiable == false) {
			throw new IllegalArgumentException(
					"INSERT: Se esperaba una lista objetos, con objetos tipo " + Identifiable.class.getSimpleName());
		}

		((Identifiable) entity).setId(UUID.randomUUID().toString());

		Statement statement = new Statement();

		String schema = getSchemaName(persistentClass);
		String attributeName = "";
		String attributeParam = "";

		for (Method method : persistentClass.getMethods()) {

			if (method.getName().startsWith("get") && method.getName().equals("getClass") == false) {

				Class clazz = method.getReturnType();

				if (isList(clazz) == false) {

					System.out.println(method.getName() + " = " + clazz + " :: " + isList(clazz));

					attributeName += ", " + method.getName().replaceFirst("get", "");
					attributeParam += ", ?";

					Object obj = method.invoke(entity);

					if (isSimple(clazz) == false) {
						clazz = String.class;
						if (obj != null) {
							Identifiable objFK = (Identifiable) obj;
							obj = objFK.getId();
						}

					}

					validateNotNull(obj, entity, method);

					obj = (obj != null) ? obj : clazz;

					statement.addArg(obj);

				}

			}
		}

		attributeName = attributeName.replaceFirst(",", "").trim();
		attributeParam = attributeParam.replaceFirst(",", "").trim();

		statement.setSql("INSERT INTO " + schema + entity.getClass().getSimpleName() + " (" + attributeName
				+ ") VALUES (" + attributeParam + ")");

		return statement;

	}

}
