package com.massoftware.windows;

import java.util.Iterator;

import com.massoftware.model.EntityId;
import com.vaadin.data.Validatable;
import com.vaadin.data.util.BeanItem;
import com.vaadin.event.ShortcutAction.KeyCode;
import com.vaadin.event.ShortcutAction.ModifierKey;
import com.vaadin.event.ShortcutListener;
import com.vaadin.ui.AbstractComponentContainer;
import com.vaadin.ui.AbstractField;
import com.vaadin.ui.Button;
import com.vaadin.ui.Component;
import com.vaadin.ui.ComponentContainer;
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

	protected String id;

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

	public WindowForm() {
	}

	public WindowForm(String mode, String id) {
		init(mode, id);
	}

	protected void init(String mode, String id) {
		try {

			this.id = id;
			this.mode = mode;

			// =======================================================
			// BEAN

			getItemsBIC();

			// =======================================================
			// LAYOUT CONTROLs

			buildContent();

			// =======================================================
			// KEY EVENTs

			addKeyEvents();

			// =======================================================
			// CARGA DE DATOS

			loadData(this.id);

			// =======================================================
			// ACTUALIZAR TITULO

			actualizarTitulo();

			// =======================================================

		} catch (Exception e) {
			LogAndNotification.print(e);
		}
	}

	abstract protected void buildContent() throws Exception;

	// -------------------------------------------------------------

	public void setWindowListado(WindowListado windowListado) {
		this.windowListado = windowListado;
	}

	// -------------------------------------------------------------

	protected void actualizarTitulo() throws Exception {
		if (INSERT_MODE.equalsIgnoreCase(mode)) {
			this.setCaption("Agregar " + getCaption().toLowerCase());
		} else if (UPDATE_MODE.equalsIgnoreCase(mode)) {
			this.setCaption("Modificar " + getCaption().toLowerCase() + " : " + getItemsBIC().getBean());
		} else if (COPY_MODE.equalsIgnoreCase(mode)) {
			this.setCaption("Copiar " + getCaption() + " : " + getItemsBIC().getBean());
		}
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
		copiarBTN = UtilUI.buildButtonCopiar();
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

	protected void loadData(String id) {

		try {

			// validateForm();

			if (INSERT_MODE.equals(mode)) {
				setMaxValues();
			} else {
				EntityId item = queryData();
				if (item != null) {
					setBean(item);
					if (COPY_MODE.equals(mode)) {
						setMaxValues();
					}
				} else {
					LogAndNotification.printError("No se encontro el item",
							"Se intento buscar un item en base a los siguientes parámetros de búsqueda, " + id);
				}

			}

		} catch (Exception e) {
			LogAndNotification.print(e);
		}
	}

	abstract protected void setMaxValues() throws Exception;

	abstract protected void setBean(EntityId obj) throws Exception;

	// abstract protected EntityId getBean() throws Exception;

	@SuppressWarnings("rawtypes")
	abstract protected BeanItem getItemsBIC();

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

	protected Object insert() throws Exception {

		try {
			((EntityId) getItemsBIC().getBean()).insert();
			if (windowListado != null) {
				windowListado.loadDataResetPaged();
			}

			return getItemsBIC().getBean();

		} catch (Exception e) {
			LogAndNotification.print(e);
			return null;
		}
	}

	protected Object update() throws Exception {

		try {
			((EntityId) getItemsBIC().getBean()).update();
			if (windowListado != null) {
				windowListado.loadDataResetPaged();
			}

			return getItemsBIC().getBean();

		} catch (Exception e) {
			LogAndNotification.print(e);
			return null;
		}
	}

	protected Window confWinForm(String label) {

		this.setCaption(label);
		this.setImmediate(true);
		// window.setWidth("-1px");
		// window.setHeight("-1px");
		this.setWidthUndefined();
		this.setHeightUndefined();
		this.setClosable(true);
		this.setResizable(false);
		this.setModal(true);
		this.center();
		// window.setContent((Component) this);
		// getUI().addWindow(window);

		this.setModal(true);
		this.center();

		return this;
	}

	protected void validateForm() throws Exception {
		// -----------------------------------------------------------------
		// realiza la validacion de todos los campos del fomulario, antes de realizar la
		// actualizacion o insercion en la base de datos

		validateAllFields((AbstractComponentContainer) this.getContent());
	}

	@SuppressWarnings({ "rawtypes" })
	private void validateAllFields(AbstractComponentContainer componentContainer) throws Exception {

		Iterator<Component> itr = componentContainer.iterator();

		while (itr.hasNext()) {
			Component component = itr.next();
			if (component instanceof Validatable) {
				((Validatable) component).validate();
			} else if (component instanceof AbstractField) {
				((AbstractField) component).validate();
			} else if (component instanceof ComponentContainer) {
				validateAllFields((AbstractComponentContainer) component);
			}
		}

	}

	// =================================================================================

	// metodo que realiza la consulta a la base de datos
	protected EntityId queryData() throws Exception {
		try {

			EntityId item = (EntityId) getItemsBIC().getBean();
			item.loadById(id); // consulta a DB
			if (COPY_MODE.equals(mode)) {
				item.setId(null);
			}

			return item;

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

		return (EntityId) getItemsBIC().getBean();
	}

	// =================================================================================

}
