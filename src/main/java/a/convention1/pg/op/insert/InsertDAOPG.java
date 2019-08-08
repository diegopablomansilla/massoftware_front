package a.convention1.pg.op.insert;

import java.lang.reflect.Method;
import java.util.UUID;

import org.cendra.jdbc.ConnectionWrapper;

import a.convention1.anotations.Identifiable;
import a.convention1.anotations.PersistentMapping;
import a.convention1.pg.AbstractDAOPG;
import a.dao.op.ParamStatement;
import a.dao.op.insert.InsertDAO;

public class InsertDAOPG extends AbstractDAOPG implements InsertDAO {

	private ConnectionWrapper connectionWrapper;

	public InsertDAOPG(ConnectionWrapper connectionWrapper) {
		this.connectionWrapper = connectionWrapper;
	}

	@Override
	public boolean insert(Object obj) throws Exception {

		ParamStatement statement = buildStatement(obj);

		int rows = connectionWrapper.insert(statement.getSql(), statement.getArgs());

		if (rows != 1) {
			throw new IllegalStateException("No se esperaba que la sentencia no insertara en la base de datos.");
		}

		return true;
	}

	@Override
	public boolean insert(Object obj, @SuppressWarnings("rawtypes") Class mappingClass) throws Exception {

		ParamStatement statement = buildStatement((Identifiable) obj, mappingClass);

		int rows = connectionWrapper.insert(statement.getSql(), statement.getArgs());

		if (rows != 1) {
			throw new IllegalStateException("No se esperaba que la sentencia no insertara en la base de datos.");
		}

		return true;

	}

	// --------------------------------------------------------------------------------------------------------

	private ParamStatement buildStatement(Object entity) throws Exception {
		if (entity == null) {
			throw new IllegalArgumentException("INSERT: Se esperaba un objeto no nulo.");
		}
		return buildStatement(entity, entity.getClass());
	}

	@SuppressWarnings("rawtypes")
	private ParamStatement buildStatement(Object entity, Class mappingClass) throws Exception {

		if (entity == null) {
			throw new IllegalArgumentException("INSERT: Se esperaba un objeto no nulo.");
		}

		if (mappingClass == null) {
			throw new IllegalArgumentException("INSERT: Se esperaba una objeto Class no nulo.");
		}

		if (isPersistent(mappingClass) == false) {
			throw new IllegalArgumentException(
					"INSERT: Se esperaba un objeto Class anotado con " + PersistentMapping.class.getCanonicalName());
		}

		if (entity instanceof Identifiable == false) {
			throw new IllegalArgumentException(
					"INSERT: Se esperaba un objeto con tipo " + Identifiable.class.getSimpleName());
		}

		((Identifiable) entity).setId(UUID.randomUUID().toString());

		ParamStatement statement = new ParamStatement();

		String schema = getSchemaName(mappingClass);
		String attributeName = "";
		String attributeParam = "";

		for (Method method : mappingClass.getMethods()) {

			if (method.getName().startsWith("get") && method.getName().equals("getClass") == false) {

				Class clazz = method.getReturnType();

				if (isList(clazz) == false) {					

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
