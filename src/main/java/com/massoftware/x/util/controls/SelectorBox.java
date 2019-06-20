package com.massoftware.x.util.controls;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import com.massoftware.model.Entity;
import com.massoftware.x.util.windows.LogAndNotification;
import com.massoftware.x.util.windows.WindowListado;
import com.vaadin.data.Validatable;
import com.vaadin.data.Validator;
import com.vaadin.data.util.BeanItem;
import com.vaadin.server.FontAwesome;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.Button;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.TextField;
import com.vaadin.ui.Window;
import com.vaadin.ui.themes.ValoTheme;

public class SelectorBox extends HorizontalLayout implements Validatable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2869082571369904793L;

	private Button openSelectorBTN;
	public TextField valueTXT;
	private Button removeFilterBTN;

	protected String uuid;

	@SuppressWarnings({ "rawtypes" })
	private BeanItem itemBI;

	// @SuppressWarnings({ "rawtypes" })
	// private Class classWindow;

	private String attName;

	@SuppressWarnings("rawtypes")
	public SelectorBox(BeanItem itemBI, String attName) throws Exception {
		init(itemBI, attName, null);
	}

	@SuppressWarnings("rawtypes")
	public SelectorBox(BeanItem itemBI, String attName, String label2) throws Exception {
		init(itemBI, attName, label2);
	}

	@SuppressWarnings("rawtypes")
	private void init(BeanItem itemBI, String attName, String label2) throws Exception {

		uuid = UUID.randomUUID().toString();

		// this.classWindow = classWindow;
		this.itemBI = itemBI;
		this.attName = attName;

		// HorizontalLayout hl = buildHL();
		this.setWidthUndefined();
		this.setMargin(false);
		this.setSpacing(false);
		// hl.setCaption(label);

		String label = ((Entity) itemBI.getBean()).label(attName);
		boolean required = ((Entity) itemBI.getBean()).required(attName);
		label2 = (label2 == null || label2.trim().length() == 0) ? label : label2;
		int columns = (int) ((Entity) itemBI.getBean()).columns(attName);

		openSelectorBTN = new Button();
		openSelectorBTN.addStyleName("borderless tiny");
		openSelectorBTN.setIcon(FontAwesome.FOLDER_OPEN);
		openSelectorBTN.setDescription("Buscar " + label);

		valueTXT = new TextField();
		valueTXT.setValidationVisible(true);
		valueTXT.setRequiredError("El campo '" + label + "' es requerido. Es decir no debe estar vacio.");
		valueTXT.setNullRepresentation("");
		valueTXT.addStyleName(ValoTheme.TEXTFIELD_TINY);
		valueTXT.setColumns(columns);

		// txtValue.setEnabled(false);
		valueTXT.setRequired(required);
		valueTXT.setDescription("Buscar por " + label2);
		valueTXT.setInputPrompt("Buscar por " + label2.toLowerCase());
		// valueTXT.setCaption(label);
		setCaption(label);

		this.addComponent(openSelectorBTN);
		this.setComponentAlignment(openSelectorBTN, Alignment.BOTTOM_LEFT);
		this.addComponent(valueTXT);
		this.setComponentAlignment(valueTXT, Alignment.MIDDLE_LEFT);

		// ----------------------------------------------

		removeFilterBTN = new Button();
		removeFilterBTN.addStyleName(ValoTheme.BUTTON_BORDERLESS);
		removeFilterBTN.addStyleName(ValoTheme.BUTTON_TINY);
		removeFilterBTN.setIcon(FontAwesome.TIMES);
		removeFilterBTN.setDescription("Borrar valor");

		// removeFilterBTN.addClickListener(e -> {
		// valueTXT.setValue(null);
		// });

		this.addComponent(removeFilterBTN);
		this.setComponentAlignment(removeFilterBTN, Alignment.BOTTOM_LEFT);

		this.setComponentAlignment(valueTXT, Alignment.BOTTOM_LEFT);
		this.setComponentAlignment(openSelectorBTN, Alignment.BOTTOM_LEFT);

		// valueTXT.setPropertyDataSource(itemBI.getItemProperty(attName));

		// this.addShortcutListener(new ShortcutListener("DELETE", KeyCode.DELETE, new
		// int[] {}) {
		//
		// private static final long serialVersionUID = 1L;
		//
		// @Override
		// public void handleAction(Object sender, Object target) {
		// if (target.equals(valueTXT)) {
		// valueTXT.setValue(null);
		// }
		// }
		// });

		valueTXT.addBlurListener(e -> {
			blur();
		});

		openSelectorBTN.addClickListener(e -> {
			open(false);
		});
		removeFilterBTN.addClickListener(e -> {
			try {

				valueTXT.setValue(null);
				setSelectedItem(null);
				valueTXT.focus();

			} catch (Exception ex) {
				LogAndNotification.print(ex);
			}
		});

		// this.setWidth("100%");
		valueTXT.setWidth(25f, Unit.EM);

		setInitValue(itemBI.getItemProperty(attName).getValue());

	}

	///////////////////////////////////////////////////////////////////////

	@SuppressWarnings({ "rawtypes" })
	public void blur() {
		try {

			sourceLoadDataResetPaged();

			String value = getValue();

			if (value != null) {

				List items = find(value);

				if (items.size() == 1) {

					setSelectedItem(items.get(0));

				} else {

					open(items.size() > 0);

				}
			} else {

				setSelectedItem(null);

			}

		} catch (Exception e) {
			LogAndNotification.print(e);
		}
	}

	// --------------------------------------------------------

	@SuppressWarnings("rawtypes")
	private void open(boolean filter) {
		try {

			sourceLoadDataResetPaged();

			Iterator it = getUI().getWindows().iterator();

			while (it.hasNext()) {
				Window w = (Window) it.next();

				// if (w.getClass() == classWindow && w.getId().equals(uuid)) {
				// return;
				// }

				if (w.getId() != null && w.getId().equals(uuid)) {
					return;
				}
			}

			WindowListado windowPopup = getPopup(filter);
			windowPopup.setId(uuid);

			windowPopup.addCloseListener(e -> {
				try {

					if (windowPopup.itemsGRD.getSelectedRow() != null) {

						setSelectedItem(windowPopup.itemsGRD.getSelectedRow());

					} else {

						setSelectedItem(null);

					}

					this.valueTXT.focus();

				} catch (Exception ex) {
					LogAndNotification.print(ex);
				}
			});

			windowPopup.seleccionarBTN.addClickListener(e -> {
				try {

					if (windowPopup.itemsGRD.getSelectedRow() != null) {

						setSelectedItem(windowPopup.itemsGRD.getSelectedRow());
						this.valueTXT.focus();
						windowPopup.close();

					}

				} catch (Exception ex) {
					LogAndNotification.print(ex);
				}
			});

			// windowPopup.addShortcutListener(new ShortcutListener("ENTER", KeyCode.ENTER,
			// new int[] {}) {
			//
			// private static final long serialVersionUID = 1L;
			//
			// @Override
			// public void handleAction(Object sender, Object target) {
			//
			// try {
			//
			// if (windowPopup.itemsGRD.getSelectedRow() != null) {
			//
			// setSelectedItem(windowPopup.itemsGRD.getSelectedRow());
			//
			// windowPopup.close();
			//
			// }
			//
			// } catch (Exception ex) {
			// LogAndNotification.print(ex);
			// }
			//
			// }
			// });

			getUI().addWindow(windowPopup);

		} catch (Exception e) {
			LogAndNotification.print(e);
		}
	}

	///////////////////////////////////////////////////////////////////////

	protected void setInitValue(Object item) {

		if (item != null) {
			valueTXT.setValue(item.toString());
		} else {
			valueTXT.setValue(null);
		}
	}

	public void setSelectedItem(Object item) throws Exception {

		if (item != null) {
			valueTXT.setValue(item.toString());
		} else {
			valueTXT.setValue(null);
		}

		setSelectedItemBean(item);

		sourceLoadDataResetPaged();
	}

	@SuppressWarnings("unchecked")
	protected void setSelectedItemBean(Object item) {

		itemBI.getItemProperty(attName).setValue(item);

		// if (item != null) {
		// ((Moneda) itemBI.getBean()).setMonedaAFIP((MonedaAFIP) item);
		// } else {
		// ((Moneda) itemBI.getBean()).setMonedaAFIP(null);
		// }

	}

	@SuppressWarnings("rawtypes")
	protected List find(String value) throws Exception {

		if (value.contains("-")) {
			value = value.split("-")[0].trim();
		}

		return findBean(value);
	}

	// --------------------------------------------------------

	protected void sourceLoadDataResetPaged() {

	}

	protected WindowListado getPopup(boolean filter) throws Exception {

		// MonedaAFIPFiltro filtro = new MonedaAFIPFiltro();
		//
		// if (filter) {
		// filtro.setNombre(this.getValue());
		// }
		//
		// return new WLMonedaAFIP(filtro);

		return null;
	}

	@SuppressWarnings("rawtypes")
	protected List findBean(String value) throws Exception {

		// MonedaAFIPDAO dao = new MonedaAFIPDAO();
		//
		// return dao.findByCodigoOrNombre(value);

		return new ArrayList();
	}

	///////////////////////////////////////////////////////////////////////

	protected String getValue() {

		String value = this.valueTXT.getValue();

		if (value != null) {
			value = value.trim();
			if (value.length() == 0) {
				value = null;
			}
		}

		return value;
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

	public void focus() {
		valueTXT.focus();
	}

}
