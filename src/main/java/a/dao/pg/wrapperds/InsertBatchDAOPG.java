package a.dao.pg.wrapperds;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.cendra.jdbc.ConnectionWrapper;

import a.anotations.Persistent;
import a.dao.InsertBatchDAO;
import a.dao.StatementBatch;
import a.model.Identifiable;

public class InsertBatchDAOPG extends AbstractInsertDAOPG implements InsertBatchDAO {

	private ConnectionWrapper connectionWrapper;

	public InsertBatchDAOPG() {
		super();
	}

	public InsertBatchDAOPG(ConnectionWrapper connectionWrapper) {
		this.connectionWrapper = connectionWrapper;
	}

	@Override
	public List<Object> insert(List<Object> objs) throws Exception {

		StatementBatch statement = buildStatementBatch(objs);

		for (Object[] args : statement.getArgs()) {

			int rows = connectionWrapper.insert(statement.getSql(), args);

			if (rows != 1) {
				throw new IllegalStateException("No se esperaba que la sentencia no insertara en la base de datos.");
			}
		}

		return objs;

	}

	// --------------------------------------------------------------------------------------------------------

	private StatementBatch buildStatementBatch(List<Object> entities) throws Exception {
		if (entities == null) {
			throw new IllegalArgumentException("INSERT: Se esperaba una lista de objetos no nulo.");
		}

		if (entities.size() == 0) {
			throw new IllegalArgumentException("INSERT: Se esperaba una lista objetos no vacia.");
		}

		if (entities.get(0) == null) {
			throw new IllegalArgumentException("INSERT: Se esperaba una lista objetos, con objetos no nulos.");
		}

		return buildStatementBatch(entities, entities.get(0).getClass());
	}

	private StatementBatch buildStatementBatch(List<Object> entities,
			@SuppressWarnings("rawtypes") Class persistentClass) throws Exception {

		if (entities == null) {
			throw new IllegalArgumentException("INSERT: Se esperaba una lista de objetos no nulo.");
		}

		if (entities.size() == 0) {
			throw new IllegalArgumentException("INSERT: Se esperaba una lista objetos no vacia.");
		}

		if (persistentClass == null) {
			throw new IllegalArgumentException("INSERT: Se esperaba una objeto Class no nulo.");
		}

		if (isPersistent(persistentClass) == false) {
			throw new IllegalArgumentException(
					"INSERT: Se esperaba una objeto Class anotado con " + Persistent.class.getCanonicalName());
		}

		StatementBatch statement = new StatementBatch();

		String schema = getSchemaName(persistentClass);
		String attributeName = "";
		String attributeParam = "";
		List<List<Object>> args = new ArrayList<List<Object>>();

		int c = 0;

		for (Object entity : entities) {

			if (entity == null) {
				throw new IllegalArgumentException("INSERT: Se esperaba una lista objetos, con objetos no nulos.");
			}

			if (entity instanceof Identifiable == false) {
				throw new IllegalArgumentException("INSERT: Se esperaba una lista objetos, con objetos tipo "
						+ Identifiable.class.getSimpleName());
			}

			((Identifiable) entity).setId(UUID.randomUUID().toString());

			List<Object> argsRow = new ArrayList<Object>();

			for (Method method : persistentClass.getMethods()) {

				if (method.getName().startsWith("get") && method.getName().equals("getClass") == false) {

					@SuppressWarnings("rawtypes")
					Class clazz = method.getReturnType();

					if (isList(clazz) == false) {

						if (c == 0) {
							attributeName += ", " + method.getName().replaceFirst("get", "");
							attributeParam += ", ?";
						}

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

						argsRow.add(obj);

					}

				}
			}

			c++;

			args.add(argsRow);

		}

		attributeName = attributeName.replaceFirst(",", "").trim();
		attributeParam = attributeParam.replaceFirst(",", "").trim();

		statement.setSql("INSERT INTO " + schema + entities.get(0).getClass().getSimpleName() + " (" + attributeName
				+ ") VALUES (" + attributeParam + ")");

		Object[][] array = new Object[entities.size()][args.get(0).size()];

		for (int i = 0; i < args.size(); i++) {
			array[i] = args.get(i).toArray();
		}

		statement.setArgs(array);

		return statement;

	}

}
