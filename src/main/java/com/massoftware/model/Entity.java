package com.massoftware.model;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.Date;

import com.massoftware.backend.annotation.FieldLabelAnont;

public class Entity implements Cloneable {

	@Override
	public Object clone() throws CloneNotSupportedException {

		return clone(this.getClass());
	}

	protected Object clone(@SuppressWarnings("rawtypes") Class clazz) {

		Object other;

		try {

			other = clazz.newInstance();

			Object o = clone(this, clazz, other);

			return o;

		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}

	}

	protected Object clone(Object originalIsntance, @SuppressWarnings("rawtypes") Class clazz, Object other)
			throws Exception {

		if (clazz.getSuperclass() != null) {
			clone(originalIsntance, clazz.getSuperclass(), other);
		}

		Field[] fields = clazz.getDeclaredFields();

		for (Field field : fields) {

			if (field.getName().startsWith("_") == false) {

				@SuppressWarnings("unchecked")
				Method methodGet = clazz.getDeclaredMethod("get" + toCamelCase(field.getName()));

				@SuppressWarnings("rawtypes")
				Class[] argTypes = new Class[] { field.getType() };

				@SuppressWarnings("unchecked")
				Method methodSet = clazz.getDeclaredMethod("set" + toCamelCase(field.getName()), argTypes);

				if (field.getType() == Boolean.class) {

					Boolean value = (Boolean) methodGet.invoke(originalIsntance);
					methodSet.invoke(other, value);

				} else if (field.getType() == String.class) {

					String value = (String) methodGet.invoke(originalIsntance);
					methodSet.invoke(other, value);

				} else if (field.getType() == Byte.class) {

					Byte value = (Byte) methodGet.invoke(originalIsntance);
					methodSet.invoke(other, value);

				} else if (field.getType() == Short.class) {

					Short value = (Short) methodGet.invoke(originalIsntance);
					methodSet.invoke(other, value);

				} else if (field.getType() == Integer.class) {

					Integer value = (Integer) methodGet.invoke(originalIsntance);
					methodSet.invoke(other, value);

				} else if (field.getType() == Long.class) {

					Long value = (Long) methodGet.invoke(originalIsntance);
					methodSet.invoke(other, value);

				} else if (field.getType() == Float.class) {

					Float value = (Float) methodGet.invoke(originalIsntance);
					methodSet.invoke(other, value);

				} else if (field.getType() == Double.class) {

					Double value = (Double) methodGet.invoke(originalIsntance);
					methodSet.invoke(other, value);

				} else if (field.getType() == BigDecimal.class) {
					BigDecimal value = (BigDecimal) methodGet.invoke(originalIsntance);
					if (value != null) {
						value = new BigDecimal(value.toString());
					}

					methodSet.invoke(other, value);

				} else if (field.getType() == Date.class) {
					Date value = (Date) methodGet.invoke(originalIsntance);
					if (value != null) {
						value = new Date(value.getTime());
					}

					methodSet.invoke(other, value);

				} else if (field.getType() == Timestamp.class) {
					Timestamp value = (Timestamp) methodGet.invoke(originalIsntance);
					if (value != null) {
						value = new Timestamp(value.getTime());
					}

					methodSet.invoke(other, value);

				} else {

					Object value = methodGet.invoke(originalIsntance);

					if (value != null && value instanceof Entity) {

						value = ((Entity) value).clone();

						// Object other2 = field.getType().newInstance();
						// if (value != null) {
						// value = clone(value, field.getType(), other2,
						// full);
						// value = ((Entity) value).clone();
						// }

						methodSet.invoke(other, value);
					} else {
						if (value != null) {
							throw new RuntimeException(field.getType() + " not found.");
						}

					}
				}

			}
		}

		return other;
	}

	protected String toCamelCase(String s) {
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

	protected String toCamelCaseVar(String s) {
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

	@Override
	public String toString() {
		return "Entity [toString()=" + super.toString() + "]";
	}

	@SuppressWarnings("rawtypes")
	protected boolean isScalar(Class c) {

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

	public void setterNull() throws Exception {

		Field[] fields = getClass().getDeclaredFields();

		for (int i = 0; i < fields.length; i++) {

			Field field = fields[i];

			@SuppressWarnings("rawtypes")
			Class[] argTypes = new Class[] { field.getType() };

			Method methodSet = this.getClass().getDeclaredMethod("set" + toCamelCase(field.getName()), argTypes);

			methodSet.invoke(this, new Object[] { null });

		}
	}

	public void setterTrim() throws Exception {

		Field[] fields = getClass().getDeclaredFields();

		for (int i = 0; i < fields.length; i++) {

			Field field = fields[i];

			if (field.getType() == String.class) {

				@SuppressWarnings("rawtypes")
				Class[] argTypes = new Class[] { field.getType() };

				Method methodSet = this.getClass().getDeclaredMethod("set" + toCamelCase(field.getName()), argTypes);

				Method methodGet = getClass().getDeclaredMethod("get" + toCamelCase(field.getName()));

				Object value = methodGet.invoke(this);

				if (value != null) {
					if (value.toString().trim().length() == 0) {
						methodSet.invoke(this, new Object[] { null });
					} else {
						methodSet.invoke(this, new Object[] { value.toString().trim() });
					}

				}

			}

		}
	}

	public String label(String attNamne) throws Exception {
		return label(field(attNamne));
	}

	private Field field(String attNamne) throws SecurityException, ClassNotFoundException, NoSuchFieldException {

		return Class.forName(this.getClass().getCanonicalName()).getDeclaredField(attNamne);

	}

	private String label(Field field) {
		FieldLabelAnont[] a = field.getAnnotationsByType(FieldLabelAnont.class);
		if (a != null && a.length > 0) {
			return a[0].value();
		}

		return null;
	}

}
