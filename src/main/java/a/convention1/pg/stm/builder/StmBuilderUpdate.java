package a.convention1.pg.stm.builder;

import java.lang.reflect.Method;

import a.convention1.pg.AbstractStmBuilder;
import a.convention1.pg.model.Identifiable;
import a.convention1.pg.stm.StatementParam;

public class StmBuilderUpdate extends AbstractStmBuilder {

	public StmBuilderUpdate(String schema) {
		super(schema);
	}

	public StatementParam build(Identifiable obj) throws Exception {
		if (obj == null) {
			throw new IllegalArgumentException("UPDATE: Se esperaba un objeto no nulo.");
		}
		return build(obj, obj.getClass());
	}

	@SuppressWarnings("rawtypes")
	public StatementParam build(Identifiable obj, Class mappingClass) throws Exception {

		if (obj == null) {
			throw new IllegalArgumentException("UPDATE: Se esperaba un objeto no nulo.");
		}

		if (mappingClass == null) {
			throw new IllegalArgumentException("UPDATE: Se esperaba una objeto Class (para el mapeo) no nulo.");
		}

		// if (isPersistent(mappingClass) == false) {
		// throw new IllegalArgumentException(
		// "UPDATE: Se esperaba un objeto Class anotado con " +
		// PersistentMapping.class.getCanonicalName());
		// }

//		if (obj instanceof Identifiable == false) {
//			throw new IllegalArgumentException(
//					"UPDATE: Se esperaba una lista objetos, con objetos tipo " + Identifiable.class.getSimpleName());
//		}

		if (obj.getId() == null) {
			throw new IllegalArgumentException("UPDATE: Se esperaba un objeto con id no nulo.");
		}

		if (obj.getId().trim().isEmpty()) {
			throw new IllegalArgumentException("UPDATE: Se esperaba un objeto con id no vacio.");
		}

		StatementParam statement = new StatementParam();

		String attributeName = "";

		for (Method method : mappingClass.getMethods()) {

			if (method.getName().startsWith("get") && method.getName().equals("getClass") == false
					&& method.getName().equals("getId") == false) {

				Class clazz = method.getReturnType();

				if (util.isList(clazz) == false) {

					attributeName += ", " + method.getName().replaceFirst("get", "") + " = ?";

					Object objMethodReturn = method.invoke(obj);

					if (util.isScalar(clazz) == false) {
						clazz = String.class;
						if (objMethodReturn != null) {
							Identifiable objFK = (Identifiable) objMethodReturn;
							objMethodReturn = objFK.getId();
						}

					}

					util.validateNotNull(objMethodReturn, obj, method);

					objMethodReturn = (objMethodReturn != null) ? objMethodReturn : clazz;

					statement.addArg(objMethodReturn);

				}

			}
		}

		statement.addArg(((Identifiable) obj).getId().trim());

		attributeName = attributeName.replaceFirst(",", "").trim();

		statement.setSql(
				"UPDATE " + schema + "." + obj.getClass().getSimpleName() + " SET " + attributeName + " WHERE id = ?");

		return statement;

	}

}
