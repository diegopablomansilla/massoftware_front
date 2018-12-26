package com.massoftware.windows;

import com.vaadin.event.ShortcutAction.KeyCode;
import com.vaadin.event.ShortcutAction.ModifierKey;
import com.vaadin.event.ShortcutListener;
import com.vaadin.ui.Button;
import com.vaadin.ui.DateField;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.TextField;
import com.vaadin.ui.Window;

public abstract class WindowForm extends Window {

	/**
	 * 
	 */
	private static final long serialVersionUID = -9181246374126971713L;

	// -------------------------------------------------------------

	public final static String INSERT_MODE = "INSERT_MODE";
	public final static String UPDATE_MODE = "UPDATE_MODE";
	public final static String COPY_MODE = "COPY_MODE";

	protected String mode;

	// -------------------------------------------------------------

	protected Button agregarBTN;
	protected Button modificarBTN;
	protected Button copiarBTN;

	protected WindowListado windowListado;

	// -------------------------------------------------------------

	public void setWindowListado(WindowListado windowListado) {
		this.windowListado = windowListado;
	}

	// -------------------------------------------------------------

	protected HorizontalLayout buildBotonera1() {

		HorizontalLayout filaBotoneraHL = new HorizontalLayout();
		filaBotoneraHL.setSpacing(true);

		agregarBTN = UtilUI.buildButtonAgregar();
		agregarBTN.addClickListener(e -> {
			save();
		});
		modificarBTN = UtilUI.buildButtonModificar();
		modificarBTN.addClickListener(e -> {
			save();
		});
		copiarBTN = UtilUI.buildButtonModificar();
		copiarBTN.addClickListener(e -> {
			save();
		});

		agregarBTN.setVisible(INSERT_MODE.equals(mode));
		modificarBTN.setVisible(UPDATE_MODE.equals(mode));
		copiarBTN.setVisible(COPY_MODE.equals(mode));

		filaBotoneraHL.addComponents(agregarBTN, modificarBTN, copiarBTN);

		return filaBotoneraHL;
	}

	protected void addKeyEvents() {

		this.addShortcutListener(new ShortcutListener("CTRL+S", KeyCode.S, new int[] { ModifierKey.CTRL }) {

			private static final long serialVersionUID = 1L;

			@Override
			public void handleAction(Object sender, Object target) {
				save();
			}
		});

		this.addShortcutListener(new ShortcutListener("DELETE", KeyCode.DELETE, new int[] {}) {

			private static final long serialVersionUID = 1L;

			@Override
			public void handleAction(Object sender, Object target) {
				if (target instanceof TextField && ((TextField) target).isEnabled()
						&& ((TextField) target).isReadOnly() == false) {
					((TextField) target).setValue(null);
				} else if (target instanceof DateField && ((DateField) target).isEnabled()
						&& ((DateField) target).isReadOnly() == false) {
					((DateField) target).setValue(null);
				}
			}
		});
	}

	// -------------------------------------------------------------

	protected void loadData(Object filtro) {
		
		
		
		try {
			
//			validateForm();

			if (INSERT_MODE.equals(mode)) {
				setMaxValues();
			} else {
				Object item = queryData();
				if (item != null) {
					setBean(item);
					if (COPY_MODE.equals(mode)) {
						setMaxValues();
					}
				} else {
					LogAndNotification.printError("No se encontro el item",
							"Se intento buscar un item en base a los siguientes parámetros de búsqueda, " + filtro);
				}
				

				
			}

		} catch (Exception e) {
			LogAndNotification.print(e);
		}
	}

	abstract protected Object queryData();

	abstract protected void setMaxValues() throws Exception;

	abstract protected void setBean(Object obj) throws Exception;

	protected void save() {

		try {

			validateForm();

			String m = null;
			Object savedItem = null;

			if (INSERT_MODE.equalsIgnoreCase(mode)) {
				savedItem = insert();
				m = "El item se agregó con éxito, " + savedItem + ".";
			} else if (COPY_MODE.equalsIgnoreCase(mode)) {
				savedItem = insert();
				m = "El item se copió con éxito, " + savedItem + ".";
			} else if (UPDATE_MODE.equalsIgnoreCase(mode)) {
				savedItem = update();
				m = "El item se modificó con éxito, " + savedItem + ".";
			}

			if (savedItem != null) {

				LogAndNotification.printSuccessOk(m);

				close();
			}

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

	}

	abstract protected void validateForm();

	abstract protected Object insert() throws Exception;

	abstract protected Object update() throws Exception;

}
