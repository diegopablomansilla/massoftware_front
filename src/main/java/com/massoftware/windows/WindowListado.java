package com.massoftware.windows;

import java.util.ArrayList;
import java.util.List;

import com.massoftware.windows.cuentas_fondo.CuentasFondo;
import com.vaadin.data.Validator.InvalidValueException;
import com.vaadin.data.sort.SortOrder;
import com.vaadin.data.util.BeanItemContainer;
import com.vaadin.event.ShortcutAction.KeyCode;
import com.vaadin.event.ShortcutAction.ModifierKey;
import com.vaadin.event.ShortcutListener;
import com.vaadin.server.FontAwesome;
import com.vaadin.ui.Button;
import com.vaadin.ui.DateField;
import com.vaadin.ui.Grid;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.TextField;
import com.vaadin.ui.Window;
import com.vaadin.ui.themes.ValoTheme;

public abstract class WindowListado extends Window {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3743382045012748994L;

	protected int limit = 10;
	protected int offset = 0;

	public Grid itemsGRD;
	protected Button agregarBTN;
	protected Button modificarBTN;
	protected Button copiarBTN;
	protected Button eliminarBTN;

	@SuppressWarnings("rawtypes")
	abstract protected BeanItemContainer getItemsBIC();

	protected void nextPageBTNClick() {
		offset = offset + limit;
		loadData(false);
	}

	public void loadDataResetPaged() {
		offset = 0;
		loadData();
	}

	protected void loadData() {
		loadData(true);
	}

	private void loadData(boolean removeAllItems) {
		try {

			validateFilterSection();

			if (removeAllItems) {
				getItemsBIC().removeAllItems();
			}

			// --------------------------------------

			addBeansToitemsBIC();

			// --------------------------------------

			List<SortOrder> order = new ArrayList<SortOrder>();

			for (SortOrder sortOrder : itemsGRD.getSortOrder()) {
				order.add(new SortOrder(sortOrder.getPropertyId().toString(), sortOrder.getDirection()));
			}

			itemsGRD.setSortOrder(order);

			itemsGRD.refreshAllRows();

			// --------------------------------------

			boolean enabled = getItemsBIC().size() > 0;

			itemsGRD.setEnabled(enabled);
			modificarBTN.setEnabled(enabled);
			eliminarBTN.setEnabled(enabled);
			copiarBTN.setEnabled(enabled);

		} catch (InvalidValueException e) {
			LogAndNotification.print(e);
		} catch (Exception e) {
			LogAndNotification.print(e);
		}
	}

	abstract protected void validateFilterSection();

	abstract protected void addBeansToitemsBIC();

	protected HorizontalLayout buildBotonera1() {

		HorizontalLayout filaBotoneraHL = new HorizontalLayout();
		filaBotoneraHL.setSpacing(true);

		agregarBTN = UtilUI.buildButtonAgregar();
		agregarBTN.addClickListener(e -> {
			agregarBTNClick();
		});
		modificarBTN = UtilUI.buildButtonModificar();
		modificarBTN.addClickListener(e -> {
			modificarBTNClick();
		});
		copiarBTN = UtilUI.buildButtonCopiar();
		copiarBTN.addClickListener(e -> {
			copiarBTNClick();
		});

		filaBotoneraHL.addComponents(agregarBTN, modificarBTN, copiarBTN);

		return filaBotoneraHL;
	}

	protected HorizontalLayout buildBotonera2() {

		HorizontalLayout filaBotonera2HL = new HorizontalLayout();
		filaBotonera2HL.setSpacing(true);

		eliminarBTN = UtilUI.buildButtonEliminar();
		eliminarBTN.addClickListener(e -> {
			eliminarBTNClick();
		});

		filaBotonera2HL.addComponents(eliminarBTN);

		return filaBotonera2HL;
	}

	protected void eliminarBTNClick() {
		try {

			if (itemsGRD.getSelectedRow() != null) {

				getUI().addWindow(
						new EliminarDialog(itemsGRD.getSelectedRow().toString(), new EliminarDialog.Callback() {
							public void onDialogResult(boolean yes) {

								try {
									if (yes) {
										if (itemsGRD.getSelectedRow() != null) {

											Object item = itemsGRD.getSelectedRow();

											deleteItem(item);

											LogAndNotification.printSuccessOk("Se eliminó con éxito el ítem " + item);

											loadData();
										}
									}
								} catch (Exception e) {
									LogAndNotification.print(e);
								}

							}
						}));
			}

		} catch (Exception e) {
			LogAndNotification.print(e);
		}
	}

	abstract protected void deleteItem(Object item) throws Exception;

	protected void agregarBTNClick() {
		try {

			itemsGRD.select(null);
			Window window = new Window("Agregar ítem ");
			window.setModal(true);
			window.center();
			window.setWidth("400px");
			window.setHeight("300px");
			getUI().addWindow(window);

		} catch (Exception e) {
			LogAndNotification.print(e);
		}
	}

	protected void modificarBTNClick() {
		try {

			if (itemsGRD.getSelectedRow() != null) {

				CuentasFondo item = (CuentasFondo) itemsGRD.getSelectedRow();
				item.getNumero();

				Window window = new Window("Modificar ítem " + item);
				window.setModal(true);
				window.center();
				window.setWidth("400px");
				window.setHeight("300px");
				getUI().addWindow(window);
			}

		} catch (Exception e) {
			LogAndNotification.print(e);
		}
	}

	protected void copiarBTNClick() {
		try {

			if (itemsGRD.getSelectedRow() != null) {
				itemsGRD.select(null);
				Window window = new Window("Agregar ítem ");
				window.setModal(true);
				window.center();
				window.setWidth("400px");
				window.setHeight("300px");
				getUI().addWindow(window);
			}

		} catch (Exception e) {
			LogAndNotification.print(e);
		}
	}

	protected void addKeyEvents() {

		this.addShortcutListener(new ShortcutListener("ENTER", KeyCode.ENTER, new int[] {}) {

			private static final long serialVersionUID = 1L;

			@Override
			public void handleAction(Object sender, Object target) {
				if (target.equals(itemsGRD)) {
					modificarBTNClick();
				}
			}
		});

		// --------------------------------------------------

		this.addShortcutListener(new ShortcutListener("CTRL+A", KeyCode.A, new int[] { ModifierKey.CTRL }) {

			private static final long serialVersionUID = 1L;

			@Override
			public void handleAction(Object sender, Object target) {
				agregarBTNClick();
			}
		});
		// --------------------------------------------------

		this.addShortcutListener(new ShortcutListener("CTRL+M", KeyCode.M, new int[] { ModifierKey.CTRL }) {

			private static final long serialVersionUID = 1L;

			@Override
			public void handleAction(Object sender, Object target) {
				modificarBTNClick();
			}
		});

		// --------------------------------------------------

		this.addShortcutListener(new ShortcutListener("CTRL+C", KeyCode.C, new int[] { ModifierKey.CTRL }) {

			private static final long serialVersionUID = 1L;

			@Override
			public void handleAction(Object sender, Object target) {
				copiarBTNClick();
			}
		});

		// --------------------------------------------------

		this.addShortcutListener(new ShortcutListener("CTRL+B", KeyCode.B, new int[] { ModifierKey.CTRL }) {

			private static final long serialVersionUID = 1L;

			@Override
			public void handleAction(Object sender, Object target) {
				eliminarBTNClick();
			}
		});

		// --------------------------------------------------

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

	protected Button buildButtonBuscar() {

		Button buscarBTN = new Button();
		// buscarBTN.addStyleName(ValoTheme.BUTTON_PRIMARY);
		buscarBTN.addStyleName(ValoTheme.BUTTON_TINY);
		buscarBTN.setIcon(FontAwesome.SEARCH);
		// buscarBTN.setWidth("5px");
		// agregarBTN.setCaption("Agregar");
		buscarBTN.setDescription("Buscar" + " (Ctrl+B)");
		// agregarBTN.addClickListener(e -> {
		// // agregarBTNClick();
		// });

		buscarBTN.addClickListener(e -> {
			loadDataResetPaged();
		});

		return buscarBTN;
	}

	protected Window confWinList(Window window, String label) {

		window.setCaption(label);
		window.setImmediate(true);
		// window.setWidth("-1px");
		// window.setHeight("-1px");
		window.setWidthUndefined();
		window.setHeightUndefined();
		window.setClosable(true);
		window.setResizable(false);
		window.setModal(false);
		window.center();

		return window;
	}

}
