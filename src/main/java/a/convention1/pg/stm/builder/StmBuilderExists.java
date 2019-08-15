package a.convention1.pg.stm.builder;

import a.convention1.pg.AbstractStmBuilder;
import a.convention1.pg.model.Identifiable;
import a.convention1.pg.stm.StatementParam;

public class StmBuilderExists extends AbstractStmBuilder {

	public StmBuilderExists(String schema) {
		super(schema);
	}

	public StatementParam build(Identifiable obj) throws Exception {

		if (obj == null) {
			throw new IllegalArgumentException("QUERY: Se esperaba un objeto no nulo.");
		}

//		if (entity instanceof Identifiable == false) {
//			throw new IllegalArgumentException(
//					"QUERY: Se esperaba un objeto con tipo " + Identifiable.class.getSimpleName());
//		}

		return build(obj.getId(), obj.getClass());

	}

	@SuppressWarnings("rawtypes")
	public StatementParam build(String id, Class mappingClass) throws Exception {

		if (id == null) {
			throw new IllegalArgumentException("QUERY: Se esperaba un id no nulo.");
		}

		id = id.trim();

		if (id.isEmpty()) {
			throw new IllegalArgumentException("QUERY: Se esperaba un id no vacio.");
		}

		if (mappingClass == null) {
			throw new IllegalArgumentException("QUERY: Se esperaba una objeto Class (para el mapeo) no nulo.");
		}

		// if (isPersistent(mappingClass) == false) {
		// throw new IllegalArgumentException(
		// "DELETE: Se esperaba un objeto Class anotado con " +
		// PersistentMapping.class.getCanonicalName());
		// }

		StatementParam statement = new StatementParam();

		statement.addArg(id);

		statement.setSql("SELECT COUNT(*) > 0 FROM " + schema + "." + mappingClass.getSimpleName() + " WHERE id = ?");

		return statement;

	}

}
