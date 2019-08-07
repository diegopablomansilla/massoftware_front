package a.dao.convention1.pg.wrapperds;

import java.lang.reflect.Method;

import org.cendra.jdbc.ConnectionWrapper;

import a.dao.ParamStatement;
import a.dao.UpdateDAO;
import a.dao.convention1.anotations.Identifiable;
import a.dao.convention1.anotations.PersistentMapping;

public class UpdateDAOPG extends AbstractDAOPG implements UpdateDAO {

	private ConnectionWrapper connectionWrapper;

	public UpdateDAOPG(ConnectionWrapper connectionWrapper) {
		this.connectionWrapper = connectionWrapper;
	}

	@Override
	public boolean update(Object obj) throws Exception {

		ParamStatement statement = buildStatement(obj);

		int rows = connectionWrapper.update(statement.getSql(), statement.getArgs());

		if (rows == 0) {
			throw new IllegalStateException("No se esperaba que la sentencia no actualizara en la base de datos.");
		} else if (rows > 1) {
			throw new IllegalStateException(
					"No se esperaba que la sentencia actualizara a mas de un registro en la base de datos. Registros: "
							+ rows);
		}

		return true;
	}

	@Override
	public boolean update(Object obj, @SuppressWarnings("rawtypes") Class mappingClass) throws Exception {

		ParamStatement statement = buildStatement((Identifiable) obj, mappingClass);

		int rows = connectionWrapper.update(statement.getSql(), statement.getArgs());

		if (rows == 0) {
			throw new IllegalStateException("No se esperaba que la sentencia no actualizara en la base de datos.");
		} else if (rows > 1) {
			throw new IllegalStateException(
					"No se esperaba que la sentencia actualizara a mas de un registro en la base de datos. Registros: "
							+ rows);
		}

		return true;

	}

	// --------------------------------------------------------------------------------------------------------

	private ParamStatement buildStatement(Object entity) throws Exception {
		if (entity == null) {
			throw new IllegalArgumentException("UPDATE: Se esperaba un objeto no nulo.");
		}
		return buildStatement(entity, entity.getClass());
	}

	@SuppressWarnings("rawtypes")
	private ParamStatement buildStatement(Object entity, Class mappingClass) throws Exception {

		if (entity == null) {
			throw new IllegalArgumentException("UPDATE: Se esperaba un objeto no nulo.");
		}

		if (mappingClass == null) {
			throw new IllegalArgumentException("UPDATE: Se esperaba una objeto Class no nulo.");
		}

		if (isPersistent(mappingClass) == false) {
			throw new IllegalArgumentException(
					"UPDATE: Se esperaba un objeto Class anotado con " + PersistentMapping.class.getCanonicalName());
		}

		if (entity instanceof Identifiable == false) {
			throw new IllegalArgumentException(
					"UPDATE: Se esperaba una lista objetos, con objetos tipo " + Identifiable.class.getSimpleName());
		}

		if (((Identifiable) entity).getId() == null || ((Identifiable) entity).getId().isEmpty()) {
			throw new IllegalArgumentException("UPDATE: Se esperaba un objeto id no nulo.");
		}

		ParamStatement statement = new ParamStatement();

		String schema = getSchemaName(mappingClass);
		String attributeName = "";

		for (Method method : mappingClass.getMethods()) {

			if (method.getName().startsWith("get") && method.getName().equals("getClass") == false
					&& method.getName().equals("getId") == false) {

				Class clazz = method.getReturnType();

				if (isList(clazz) == false) {

					attributeName += ", " + method.getName().replaceFirst("get", "") + " = ?";

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

		statement.addArg(((Identifiable) entity).getId().trim());

		attributeName = attributeName.replaceFirst(",", "").trim();

		statement.setSql(
				"UPDATE " + schema + entity.getClass().getSimpleName() + " SET " + attributeName + " WHERE id = ?");

		return statement;

	}

//	private ParamStatement buildStatementCount(Object entity) throws Exception {
//
//		if (entity == null) {
//			throw new IllegalArgumentException("DELETE: Se esperaba un objeto no nulo.");
//		}
//
//		if (isPersistent(entity) == false) {
//			throw new IllegalArgumentException(
//					"DELETE: Se esperaba un objeto anotado con " + PersistentMapping.class.getCanonicalName());
//		}
//
//		if (entity instanceof Identifiable == false) {
//			throw new IllegalArgumentException(
//					"DELETE: Se esperaba un objeto con tipo " + Identifiable.class.getSimpleName());
//		}
//
//		if (((Identifiable) entity).getId() == null || ((Identifiable) entity).getId().trim().isEmpty()) {
//			throw new IllegalArgumentException("DELETE: Se esperaba un objeto, con id no nulo o vacio.");
//		}
//
//		ParamStatement statement = new ParamStatement();
//
//		String schema = getSchemaName(entity);
//
//		statement.addArg(((Identifiable) entity).getId().trim());
//
//		statement.setSql("SELECT COUNT(*) > 0 FROM " + schema + entity.getClass().getSimpleName() + " WHERE id = ?");
//
//		return statement;
//
//	}
//
//	@SuppressWarnings("rawtypes")
//	private ParamStatement buildStatementCount(Object entity, Class mappingClass) throws Exception {
//
//		if (entity == null) {
//			throw new IllegalArgumentException("DELETE: Se esperaba un objeto no nulo.");
//		}
//
//		if (mappingClass == null) {
//			throw new IllegalArgumentException("DELETE: Se esperaba una objeto Class no nulo.");
//		}
//
//		if (isPersistent(mappingClass) == false) {
//			throw new IllegalArgumentException(
//					"DELETE: Se esperaba un objeto Class anotado con " + PersistentMapping.class.getCanonicalName());
//		}
//
//		ParamStatement statement = new ParamStatement();
//
//		String schema = getSchemaName(mappingClass);
//
//		statement.addArg(((Identifiable) entity).getId().trim());
//
//		statement.setSql("SELECT COUNT(*) > 0 FROM " + schema + mappingClass.getSimpleName() + " WHERE id = ?");
//
//		return statement;
//
//	}

}
