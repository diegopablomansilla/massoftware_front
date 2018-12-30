package com.massoftware.model;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.UUID;

import org.cendra.ex.crud.NullFieldException;

import com.massoftware.backend.BackendContext;

public class EntityId extends Entity implements Comparable<EntityId> {

	protected String id;

	public EntityId _originalDTO;

	public void loadById() throws Exception {

		loadById(getId(), false);
	}

	public void loadById(boolean loadLevel1LeftScalar) throws Exception {

		loadById(getId(), loadLevel1LeftScalar);
	}

	public void loadById(String id) throws Exception {
		loadById(id, false);
	}

	public void loadById(String id, boolean loadLevel1LeftScalar) throws Exception {

		if (id != null && id.trim().length() > 0) {

			Object[] row = BackendContext.get().findById(this.getClass().getSimpleName(), id);

			setter(row, true);
		}

	}

	public void setter(Object[] row) throws Exception {
		setter(row, false);
	}

	public void setter(Object[] row, boolean loadLevel1LeftScalar) throws Exception {

		Field[] fields = getClass().getDeclaredFields();

		for (int i = 0; i < fields.length; i++) {

			Field field = fields[i];

			@SuppressWarnings("rawtypes")
			Class[] argTypes = new Class[] { field.getType() };

			Method methodSet = this.getClass().getDeclaredMethod("set" + toCamelCase(field.getName()), argTypes);

			methodSet.invoke(this, new Object[] { null }); // para limpiar el objeto

			if (isScalar(field.getType())) {

				methodSet.invoke(this, row[i]);

			} else if (row[i] != null) {

				EntityId other = (EntityId) field.getType().newInstance();

				if (loadLevel1LeftScalar) {
					Object[] rowOther = BackendContext.get().findById(field.getType().getSimpleName(),
							row[i].toString());
					other.setter(rowOther, false);
				} else {
					other.setId(row[i].toString());
				}

				methodSet.invoke(this, other);
			}

		}

		_originalDTO = (EntityId) this.clone();

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

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((getId() == null) ? 0 : getId().hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {

		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;

		EntityId other = (EntityId) obj;

		if (this.getId() == null) {
			if (other.getId() != null)
				return false;
		} else if (!this.getId().equals(other.getId()))
			return false;

		return true;
	}

	@Override
	public int compareTo(EntityId entityId) {

		return this.getId().compareTo(entityId.getId());
	}

	@Override
	public String toString() {

		if (this.getId() != null) {
			return this.getId();
		}

		return "";
	}

	public String insert() throws Exception {

		if(this.getId() == null || this.getId().trim().length() == 0) {
			this.setId(UUID.randomUUID().toString());			
		}
		
		Field[] fields = getClass().getDeclaredFields();

		String[] nameAtts = new String[fields.length];
		Object[] args = new Object[fields.length];

		for (int i = 0; i < fields.length; i++) {

			Field field = fields[i];

			String nameAttDB = fields[i].getName();
			nameAtts[i] = nameAttDB;

			Method methodGet = getClass().getDeclaredMethod("get" + toCamelCase(field.getName()));

			args[i] = methodGet.invoke(this);

			if (args[i] == null) {
				args[i] = fields[i].getType();
			} else if (args[i] != null && isScalar(fields[i].getType()) == false) {

				methodGet = fields[i].getType().getMethod("getId");
				args[i] = methodGet.invoke(args[i]);
				if (args[i] == null) {
					args[i] = String.class;
				}
			}
		}		

		BackendContext.get().insert(getClass().getSimpleName(), nameAtts, args);

		return getId();
	}

	public String update() throws Exception {

		Field[] fields = getClass().getDeclaredFields();

		String[] nameAtts = new String[fields.length];
		Object[] args = new Object[fields.length + 1];

		for (int i = 0; i < fields.length; i++) {

			Field field = fields[i];

			String nameAttDB = field.getName();
			nameAtts[i] = nameAttDB;

			Method methodGet = getClass().getDeclaredMethod("get" + toCamelCase(field.getName()));

			args[i] = methodGet.invoke(this);

			if (args[i] == null) {
				args[i] = field.getType();
			} else if (args[i] != null && isScalar(fields[i].getType()) == false) {

				methodGet = field.getType().getMethod("getId");
				args[i] = methodGet.invoke(args[i]);
				if (args[i] == null) {
					args[i] = String.class;
				}
			}
		}

		args[fields.length] = this._originalDTO.getId();

		BackendContext.get().update(getClass().getSimpleName(), nameAtts, args, "id = ?");

		return this.getId();
	}

	public void checkUnique(String attName, String label, boolean ignoreOriginal) throws Exception {

		Object valueOriginal = null;

		if (_originalDTO != null && ignoreOriginal == false) {

			Field fieldOriginal = _originalDTO.getClass().getDeclaredField(attName);

			Method methodGetOriginal = this.getClass().getDeclaredMethod("get" + toCamelCase(fieldOriginal.getName()));

			valueOriginal = methodGetOriginal.invoke(this);

		}

		Field field = this.getClass().getDeclaredField(attName);

		Method methodGet = this.getClass().getDeclaredMethod("get" + toCamelCase(field.getName()));

		Object value = methodGet.invoke(this);

		if (value != null) {
			BackendContext.get().checkUnique(this, attName, label, valueOriginal, value);
		}

	}

	public void checkNull(String attName) throws Exception {

		Field field = this.getClass().getDeclaredField(attName);

		Method methodGet = this.getClass().getDeclaredMethod("get" + toCamelCase(field.getName()));

		Object value = methodGet.invoke(this);

		if (value == null) {
			throw new NullFieldException(attName);
		}
	}

}