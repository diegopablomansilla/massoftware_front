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
import com.vaadin.ui.themes.ValoTheme;

public class SelectorBox extends HorizontalLayout implements Validatable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2869082571369904793L;

	public Button openSelectorBTN;
	public TextField valueTXT;
	public Button removeFilterBTN;

	@SuppressWarnings("rawtypes")
	public SelectorBox(BeanItem dtoBI, String attName, String label, boolean required) throws Exception {
		init(dtoBI, attName, label, required, null);
	}

	@SuppressWarnings("rawtypes")
	public SelectorBox(BeanItem dtoBI, String attName, String label, boolean required, String label2)
			throws Exception {
		init(dtoBI, attName, label, required, label2);
	}

	@SuppressWarnings("rawtypes")
	private void init(BeanItem dtoBI, String attName, String label, boolean required, String label2) throws Exception {

		// HorizontalLayout hl = buildHL();
		this.setWidthUndefined();
		this.setMargin(false);
		this.setSpacing(false);
		// hl.setCaption(label);

		openSelectorBTN = new Button();
		openSelectorBTN.addStyleName("borderless tiny");
		openSelectorBTN.setIcon(FontAwesome.FOLDER_OPEN);
		openSelectorBTN.setDescription("Buscar " + label);

		valueTXT = new TextField();
		valueTXT.setValidationVisible(true);
		valueTXT.setRequiredError("El campo es requerido. Es decir no debe estar vacio.");
		valueTXT.setNullRepresentation("");
		valueTXT.addStyleName(ValoTheme.TEXTFIELD_TINY);
		valueTXT.setCaption(label);
		// txtValue.setEnabled(false);
		valueTXT.setRequired(required);
		valueTXT.setInputPrompt(label2);
		valueTXT.setDescription(label2);

		String searchFor = label;
		if (searchFor != null) {
			searchFor = searchFor.toLowerCase();
			valueTXT.setDescription("Buscar por " + searchFor);
		} else {
			searchFor = "";
			valueTXT.setDescription("Buscar por " + label.toLowerCase());
		}
		valueTXT.setInputPrompt(searchFor);

		this.addComponent(openSelectorBTN);
		this.setComponentAlignment(openSelectorBTN, Alignment.BOTTOM_LEFT);
		valueTXT.setCaption(label);

		this.addComponent(valueTXT);
		this.setComponentAlignment(valueTXT, Alignment.MIDDLE_LEFT);

		// ----------------------------------------------

		removeFilterBTN = new Button();
		removeFilterBTN.addStyleName(ValoTheme.BUTTON_BORDERLESS);
		removeFilterBTN.addStyleName(ValoTheme.BUTTON_TINY);
		removeFilterBTN.setIcon(FontAwesome.TIMES);
		removeFilterBTN.setDescription("Borrar valor");

		removeFilterBTN.addClickListener(e -> {
			valueTXT.setValue(null);
		});

		this.addComponent(removeFilterBTN);
		this.setComponentAlignment(removeFilterBTN, Alignment.BOTTOM_LEFT);

		valueTXT.setPropertyDataSource(dtoBI.getItemProperty(attName));

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