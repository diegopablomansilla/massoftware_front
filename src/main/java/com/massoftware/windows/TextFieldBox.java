package com.massoftware.windows;

import java.util.Collection;

import com.massoftware.model.Entity;
import com.vaadin.data.Validatable;
import com.vaadin.data.Validator;
import com.vaadin.data.util.BeanItem;
import com.vaadin.server.FontAwesome;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.Button;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.TextField;

public class TextFieldBox extends HorizontalLayout implements Validatable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2869082571369904793L;

	public TextField valueTXT;
	public Button removeFilterBTN;

	@SuppressWarnings("rawtypes")
	public TextFieldBox(WindowListado window, BeanItem dtoBI, String attName, boolean readOnly, boolean required,
			String inputPrompt) throws Exception {

		int minLength = 0;

		if (required && minLength < 0) {
			minLength = 1;
		}

		init(window, dtoBI, attName, null, readOnly, 20, minLength, 100, required, false, null, false, inputPrompt);
	}

	@SuppressWarnings("rawtypes")
	public TextFieldBox(WindowListado window, BeanItem dtoBI, String attName, String label, boolean readOnly,
			int columns, int minLength, int maxLength, boolean required, boolean allowInputUnmask, String mask,
			boolean autoUnmask, String inputPrompt) throws Exception {

		init(window, dtoBI, attName, label, readOnly, columns, minLength, maxLength, required, allowInputUnmask, mask,
				autoUnmask, inputPrompt);
	}

	@SuppressWarnings("rawtypes")
	private void init(WindowListado window, BeanItem dtoBI, String attName, String label, boolean readOnly, int columns,
			int minLength, int maxLength, boolean required, boolean allowInputUnmask, String mask, boolean autoUnmask,
			String inputPrompt) throws Exception {

		this.setSpacing(false);

		if (label == null && dtoBI.getBean() instanceof Entity) {
			String lbl = ((Entity) dtoBI.getBean()).label(attName);
			if (lbl != null) {
				label = lbl;
			}
		}

		valueTXT = UtilUI.buildTXT(dtoBI, attName, label, readOnly, columns, minLength, maxLength, required,
				allowInputUnmask, mask, autoUnmask);

		valueTXT.setInputPrompt(UtilUI.buildWinFilterTXTInputPromptList(inputPrompt));
		valueTXT.setDescription(valueTXT.getInputPrompt());

		this.addComponent(valueTXT);

		// ----------------------------------------------

		removeFilterBTN = new Button();
		removeFilterBTN.addStyleName("borderless tiny");
		removeFilterBTN.setIcon(FontAwesome.TIMES);
		removeFilterBTN.setDescription("Quitar filtro " + label + ".");

		this.addComponent(removeFilterBTN);
		this.setComponentAlignment(removeFilterBTN, Alignment.BOTTOM_LEFT);

		removeFilterBTN.addClickListener(e -> {
			try {
				valueTXT.setValue(null);
				window.loadDataResetPaged();
			} catch (Exception ex) {
				LogAndNotification.print(ex);
			}
		});

		// valueTXT.addTextChangeListener(e -> {
		// try {
		// valueTXT.setValue(e.getText());
		// window.loadDataResetPaged();
		// } catch (Exception ex) {
		// LogAndNotification.print(ex);
		// }
		// });

		valueTXT.addBlurListener(e -> {
			try {				
				 window.loadDataResetPaged();
			} catch (Exception ex) {
				LogAndNotification.print(ex);
			}
		});

	}

	public void validate() throws Validator.InvalidValueException {
		valueTXT.validate();
	}

	@Override
	public void addValidator(Validator validator) {
		valueTXT.addValidator(validator);

	}

	@Override
	public void removeValidator(Validator validator) {
		valueTXT.removeValidator(validator);

	}

	@Override
	public void removeAllValidators() {
		valueTXT.removeAllValidators();

	}

	@Override
	public Collection<Validator> getValidators() {

		return valueTXT.getValidators();
	}

	@Override
	public boolean isValid() {

		return valueTXT.isValid();
	}

	@Override
	public boolean isInvalidAllowed() {

		return valueTXT.isInvalidAllowed();
	}

	@Override
	public void setInvalidAllowed(boolean invalidValueAllowed) throws UnsupportedOperationException {
		valueTXT.setInvalidAllowed(invalidValueAllowed);

	}

}
