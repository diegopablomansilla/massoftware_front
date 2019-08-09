package a.convention1.pg;

import java.lang.annotation.Annotation;
import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import a.convention1.anotations.Schema;

public class UtilConvention1Pg {

	public String toCamelCase(String s) {
		if (s == null) {
			return s;
		}

		s = s.trim();

		if (s.length() == 0) {
			return null;
		}

		if (s.length() == 1) {
			return s.toUpperCase();
		}

		if (s.length() > 1) {

			return (s.charAt(0) + "").toUpperCase() + s.substring(1, s.length());
		}

		return s;
	}

	@SuppressWarnings("rawtypes")
	public boolean isList(Class clazz) {

		return (clazz == List.class || clazz == ArrayList.class);
	}

	public String getSchemaName(@SuppressWarnings("rawtypes") Class persistentClass) {

		@SuppressWarnings("unchecked")
		Annotation anotation = persistentClass.getAnnotation(Schema.class);

		if (anotation != null && anotation instanceof Schema) {
			final Schema schema = (Schema) anotation;
			return schema.name() + ".";
		}
		return "";
	}

	public String toCamelCaseVar(String s) {
		if (s == null) {
			return s;
		}

		s = s.trim();

		if (s.length() == 0) {
			return null;
		}

		if (s.length() == 1) {
			return s.toLowerCase();
		}

		if (s.length() > 1) {

			return (s.charAt(0) + "").toLowerCase() + s.substring(1, s.length());
		}

		return s;
	}
	
	@SuppressWarnings("rawtypes")
	public boolean isScalar(Class c) {

		if (c.equals(String.class)) {
			return true;
		} else if (c.equals(Boolean.class)) {
			return true;
		} else if (c.equals(Short.class)) {
			return true;
		} else if (c.equals(Integer.class)) {
			return true;
		} else if (c.equals(Long.class)) {
			return true;
		} else if (c.equals(Float.class)) {
			return true;
		} else if (c.equals(Double.class)) {
			return true;
		} else if (c.equals(BigDecimal.class)) {
			return true;
		} else if (c.equals(Date.class)) {
			return true;
		} else if (c.equals(java.util.Date.class)) {
			return true;
		} else if (c.equals(Timestamp.class)) {
			return true;
		} else if (c.equals(Time.class)) {
			return true;
		} else {
			return false;
		}
	}

}
