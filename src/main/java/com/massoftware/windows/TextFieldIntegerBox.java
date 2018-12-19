package com.massoftware.windows;

import java.util.Collection;

import com.vaadin.data.Validatable;
import com.vaadin.data.Validator;
import com.vaadin.data.util.BeanItem;
import com.vaadin.server.FontAwesome;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.Button;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.TextField;

public class TextFieldIntegerBox extends HorizontalLayout implements Validatable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2869082571269904793L;

	public TextField valueTXT;
	public Button removeFilterBTN;

	@SuppressWarnings("rawtypes")
	public TextFieldIntegerBox(WindowListado window, BeanItem dtoBI, String attName, String label, boolean readOnly, int columns,
			int minLength, int maxLength, boolean required, boolean allowInputUnmask, String mask, boolean autoUnmask,
			String inputPrompt, int minValue, int maxValue) {

		this.setSpacing(false);

		valueTXT = UtilUI.buildTXTInteger(dtoBI, attName, label, readOnly, columns, minLength, maxLength, required,
				allowInputUnmask, mask, autoUnmask, minValue, maxValue);

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

//		valueTXT.addTextChangeListener(e -> {
//			try {
//				valueTXT.setValue(e.getText());
//				window.loadDataResetPaged();
//			} catch (Exception ex) {
//				LogAndNotification.print(ex);
//			}
//		});
		
		valueTXT.addBlurListener(e -> {
			try {				
				window.loadDataResetPaged();
			} catch (Exception ex) {
				LogAndNotification.print(ex);
			}
		});
		
//		this.addShortcutListener(new ShortcutListener("DELETE", KeyCode.DELETE, new int[] {}) {
//
//			private static final long serialVersionUID = 1L;
//
//			@Override
//			public void handleAction(Object sender, Object target) {
//				if (target.equals(valueTXT)) {
//					valueTXT.setValue(null);
//				}
//			}
//		});

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
