package a.dao.convention1.pg.wrapperds;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import a.dao.convention1.anotations.PersistentMapping;
import a.dao.convention1.anotations.Schema;
import a.dao.convention1.constraints.NotNull;

public abstract class AbstractDAOPG {

	protected boolean isPersistent(Object obj) {

		Annotation anotation = obj.getClass().getAnnotation(PersistentMapping.class);

		return (anotation != null && anotation instanceof PersistentMapping);
	}

	protected boolean isPersistent(@SuppressWarnings("rawtypes") Class persistentClass) {

		@SuppressWarnings("unchecked")
		Annotation anotation = persistentClass.getAnnotation(PersistentMapping.class);

		return (anotation != null && anotation instanceof PersistentMapping);
	}

	protected String getSchemaName(Object obj) {

		Annotation anotation = obj.getClass().getAnnotation(Schema.class);

		if (anotation != null && anotation instanceof Schema) {
			final Schema schema = (Schema) anotation;
			return schema.name() + ".";
		}
		return "";
	}

	protected String getSchemaName(@SuppressWarnings("rawtypes") Class persistentClass) {

		@SuppressWarnings("unchecked")
		Annotation anotation = persistentClass.getAnnotation(Schema.class);

		if (anotation != null && anotation instanceof Schema) {
			final Schema schema = (Schema) anotation;
			return schema.name() + ".";
		}
		return "";
	}

	protected boolean validateNotNull(Object obj, Object entity, Method method) {

		if (obj == null) {

			Annotation anotation = method.getAnnotation(NotNull.class);

			if (anotation != null && anotation instanceof NotNull) {
				throw new IllegalArgumentException("INSERT: El método " + entity.getClass().getCanonicalName() + "."
						+ method.getName() + " retornó un valor nulo, y debe devolver un valor no nulo.");
			}
		}

		return true;
	}

	@SuppressWarnings("rawtypes")
	protected boolean isSimple(Class clazz) throws SQLException {

		// if (clazz != null) {

		if (clazz == String.class) {
			return true;
		} else if (clazz == Boolean.class) {
			return true;
		} else if (clazz == Short.class) {
			return true;
		} else if (clazz == Integer.class) {
			return true;
		} else if (clazz == Long.class) {
			return true;
		} else if (clazz == Float.class) {
			return true;
		} else if (clazz == Double.class) {
			return true;
		} else if (clazz == BigDecimal.class) {
			return true;
		} else if (clazz == Date.class) {
			return true;
		} else if (clazz == java.util.Date.class) {
			return true;
		} else if (clazz == Timestamp.class) {
			return true;
		} else if (clazz == Time.class) {
			return true;
		} else {
			return false;
		}
		// }
		//
		// return false;
	}

	@SuppressWarnings("rawtypes")
	protected boolean isList(Class clazz) throws SQLException {

		return (clazz == List.class || clazz == ArrayList.class);
	}

}
