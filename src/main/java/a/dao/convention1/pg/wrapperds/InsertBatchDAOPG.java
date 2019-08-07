package a.dao.convention1.pg.wrapperds;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.cendra.jdbc.ConnectionWrapper;

import a.dao.InsertBatchDAO;
import a.dao.ParamStatementBatch;
import a.dao.convention1.anotations.Identifiable;
import a.dao.convention1.anotations.PersistentMapping;

public class InsertBatchDAOPG extends AbstractDAOPG implements InsertBatchDAO {

	private ConnectionWrapper connectionWrapper;

	public InsertBatchDAOPG() {
		super();
	}

	public InsertBatchDAOPG(ConnectionWrapper connectionWrapper) {
		this.connectionWrapper = connectionWrapper;
	}

	@Override
	public boolean[] insert(List<Object> objs) throws Exception {

		ParamStatementBatch statement = buildStatementBatch(objs);

		boolean[] r = new boolean[statement.getArgs().length];

		for (int i = 0; i < statement.getArgs().length; i++) {

			Object[] args = statement.getArgs()[i];

			int rows = connectionWrapper.insert(statement.getSql(), args);

			if (rows != 1) {
				throw new IllegalStateException("No se esperaba que la sentencia no insertara en la base de datos.");
			}

			r[i] = true;
		}

		return r;

	}

	@Override
	public boolean[] insert(List<Object> objs, @SuppressWarnings("rawtypes") Class mappingClass) throws Exception {

		ParamStatementBatch statement = buildStatementBatch(objs, mappingClass);

		boolean[] r = new boolean[statement.getArgs().length];

		for (int i = 0; i < statement.getArgs().length; i++) {

			Object[] args = statement.getArgs()[i];

			int rows = connectionWrapper.insert(statement.getSql(), args);

			if (rows != 1) {
				throw new IllegalStateException("No se esperaba que la sentencia no insertara en la base de datos.");
			}

			r[i] = true;
		}

		return r;

	}

	// --------------------------------------------------------------------------------------------------------

	private ParamStatementBatch buildStatementBatch(List<Object> entities) throws Exception {
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

	private ParamStatementBatch buildStatementBatch(List<Object> entities,
			@SuppressWarnings("rawtypes") Class mappingClass) throws Exception {

		if (entities == null) {
			throw new IllegalArgumentException("INSERT: Se esperaba una lista de objetos no nulo.");
		}

		if (entities.size() == 0) {
			throw new IllegalArgumentException("INSERT: Se esperaba una lista objetos no vacia.");
		}

		if (mappingClass == null) {
			throw new IllegalArgumentException("INSERT: Se esperaba una objeto Class no nulo.");
		}

		if (isPersistent(mappingClass) == false) {
			throw new IllegalArgumentException(
					"INSERT: Se esperaba una objeto Class anotado con " + PersistentMapping.class.getCanonicalName());
		}

		ParamStatementBatch statement = new ParamStatementBatch();

		String schema = getSchemaName(mappingClass);
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

			for (Method method : mappingClass.getMethods()) {

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
