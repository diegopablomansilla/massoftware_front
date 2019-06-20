package com.massoftware.x.util.validator;

import org.cendra.ex.crud.UniqueException;

import com.massoftware.model.Entity;
import com.massoftware.model.EntityId;
import com.massoftware.x.util.windows.LogAndNotification;
import com.massoftware.x.util.windows.WindowForm;
import com.vaadin.data.util.BeanItem;
import com.vaadin.data.validator.AbstractValidator;

public class UniqueValidator extends AbstractValidator<Object> {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -1435601608143548684L;

	@SuppressWarnings("rawtypes")
	private Class clazz;
	private String mode;
	private String attName;
	private String caption;
	@SuppressWarnings("rawtypes")
	private BeanItem dtoBI;

	@SuppressWarnings("rawtypes")
	public UniqueValidator(Class clazz, String mode, String attName, String caption, BeanItem dtoBI) {
		super("");
		this.clazz = clazz;
		this.mode = mode;
		this.attName = attName;
		this.caption = caption;
		this.dtoBI = dtoBI;
	}

	@SuppressWarnings("rawtypes")
	public UniqueValidator(Class clazz, String mode, String attName, BeanItem dtoBI) throws Exception {
		super("");
		this.clazz = clazz;
		this.mode = mode;
		this.attName = attName;
		this.caption = null;
		this.dtoBI = dtoBI;

		if (dtoBI.getBean() instanceof Entity) {
			String lbl = ((Entity) dtoBI.getBean()).label(attName);
			if (lbl != null) {
				caption = lbl;
			}
		}

	}

	@Override
	protected boolean isValidValue(Object value) {

		try {

			Object valueOriginal = null;

			if (WindowForm.COPY_MODE.equals(mode)) {

				// ((EntityId) dtoBI.getBean()).checkUnique(value, attName, caption, true);

				valueOriginal = ((EntityId) dtoBI.getBean()).checkUniqueValueOriginal(value, attName, true);
				value = ((EntityId) dtoBI.getBean()).checkUniqueValue(value, attName);

				if (value != null) {
					checkUnique(caption, valueOriginal, value);
				}

			} else {

				// ((EntityId) dtoBI.getBean()).checkUnique(value, attName, caption, false);

				valueOriginal = ((EntityId) dtoBI.getBean()).checkUniqueValueOriginal(value, attName, false);
				value = ((EntityId) dtoBI.getBean()).checkUniqueValue(value, attName);

				if (value != null) {
					checkUnique(caption, valueOriginal, value);
				}

			}

			return true;

		} catch (Exception e) {
			LogAndNotification.print(e);
			this.setErrorMessage(e.getMessage());
			return false;
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public Class<Object> getType() {

		return clazz;
	}

	private void checkUnique(String label, Object originalValue, Object newValue) throws Exception {

		if (originalValue != null && originalValue.equals(newValue) == false) {

			if (ifExistsObject(newValue)) {
				throw new UniqueException(label);
			}

		} else if (originalValue == null) {

			if (ifExistsObject(newValue)) {
				throw new UniqueException(label);
			}
		}

	}

	protected boolean ifExistsObject(Object arg) throws Exception {	

		return false;
	}

}
