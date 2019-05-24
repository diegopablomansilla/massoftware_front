package com.massoftware.windows;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import com.massoftware.dao.AbstractFilter;
import com.massoftware.model.EntityId;
import com.vaadin.data.Validatable;
import com.vaadin.data.sort.SortOrder;
import com.vaadin.data.util.BeanItemContainer;
import com.vaadin.event.ShortcutAction.KeyCode;
import com.vaadin.event.ShortcutAction.ModifierKey;
import com.vaadin.event.ShortcutListener;
import com.vaadin.event.SortEvent;
import com.vaadin.server.FontAwesome;
import com.vaadin.ui.AbstractComponentContainer;
import com.vaadin.ui.AbstractField;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.Button;
import com.vaadin.ui.Component;
import com.vaadin.ui.ComponentContainer;
import com.vaadin.ui.DateField;
import com.vaadin.ui.Grid;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.TextField;
import com.vaadin.ui.VerticalLayout;
import com.vaadin.ui.Window;
import com.vaadin.ui.themes.ValoTheme;

public abstract class WindowListado extends Window {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3743382045012748994L;

	protected int limit = 10;
	protected int offset = 0;
	protected AbstractFilter lastFilter;

	public Grid itemsGRD;
	protected Button agregarBTN;
	protected Button modificarBTN;
	protected Button copiarBTN;
	protected Button eliminarBTN;

	public Button seleccionarBTN;

	protected boolean selectionMode = false;

	public WindowListado() {
		super();
	}

	public void init(boolean selectionMode) {

		try {

			this.selectionMode = selectionMode;

			// =======================================================
			// LAYOUT CONTROLs

			buildContent();

			if (selectionMode) {
				buildSelectorSection();
				this.setModal(true);
			}

			// =======================================================
			// KEY EVENTs

			addKeyEvents();

			// =======================================================
			// CARGA DE DATOS

			loadData();

			// =======================================================

		} catch (Exception e) {
			LogAndNotification.print(e);
		}
	}

	private void buildSelectorSection() {

		HorizontalLayout filaBotoneraHL = new HorizontalLayout();
		filaBotoneraHL.setSpacing(true);

		seleccionarBTN = UtilUI.buildButtonSeleccionar();

		filaBotoneraHL.addComponents(seleccionarBTN);

		((VerticalLayout) this.getContent()).addComponent(filaBotoneraHL);

		((VerticalLayout) this.getContent()).setComponentAlignment(filaBotoneraHL, Alignment.MIDDLE_CENTER);

	}

	@SuppressWarnings("rawtypes")
	abstract protected BeanItemContainer getItemsBIC();

	abstract protected void buildContent() throws Exception;

	protected void nextPageBTNClick() {
		offset = offset + limit;
		loadData(false);
	}

	public void loadDataResetPaged() {
		offset = 0;
		loadData();
	}
	
	public void loadDataResetPagedFull() {
		loadDataResetPagedFull(true);
	}

	public void loadDataResetPagedFull(boolean focus) {
		offset = 0;
		lastFilter = null;
		loadData();
		if(focus) {
			this.itemsGRD.focus();	
		}		
	}

	protected void loadData() {
		loadData(true);
	}

	private void loadData(boolean removeAllItems) {
		try {

			validateFilterSection();

			// if (removeAllItems) {
			// getItemsBIC().removeAllItems();
			// }

			// --------------------------------------

			addBeansToItemsBIC(removeAllItems);

			// --------------------------------------

			// List<SortOrder> order = new ArrayList<SortOrder>();

			// for (SortOrder sortOrder : itemsGRD.getSortOrder()) {
			// order.add(new SortOrder(sortOrder.getPropertyId().toString(),
			// sortOrder.getDirection()));
			// }

			// itemsGRD.setSortOrder(order);

			itemsGRD.refreshAllRows();

			// --------------------------------------

			boolean enabled = getItemsBIC().size() > 0;

			itemsGRD.setEnabled(enabled);
			modificarBTN.setEnabled(enabled);
			eliminarBTN.setEnabled(enabled);
			copiarBTN.setEnabled(enabled);

		} catch (Exception e) {
			LogAndNotification.print(e);
		}
	}

	protected void validateFilterSection() throws Exception {
		// -----------------------------------------------------------------
		// realiza la validacion de todos los filtros de la grilla, antes de realizar la
		// consulta en la base de datos

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

	protected void addBeansToItemsBIC() {

	}

	protected void addBeansToItemsBIC(boolean removeAllItems) {

	}

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
										// if (itemsGRD.getSelectedRow() != null) {

										Object item = itemsGRD.getSelectedRow();

										deleteItem(item);

										LogAndNotification.printSuccessOk("Se eliminó con éxito el ítem " + item);

										loadDataResetPagedFull();
										// }
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

	protected void deleteItem(Object item) throws Exception {

		((EntityId) item).delete();

	}

	protected void enterListener(Object target) {

		if (selectionMode == false && target.equals(itemsGRD)) {

			modificarBTNClick();

		} else if (selectionMode == true && target.equals(itemsGRD)) {

			if (itemsGRD.getSelectedRow() != null) {
				setSelectedItem();
				close();
			}

		} else if (target instanceof TextField) {
			
			TextField txt = (TextField) target;
			
			if (txt.getValue() != null && txt.getValue().trim().length() > 0 && txt.getParent() instanceof SelectorBox) {
				SelectorBox sbc = (SelectorBox) txt.getParent();
				sbc.blur();	
			} else {
				loadDataResetPaged();	
			}			

		} 
		
		
	}
	
	protected void setSelectedItem() {
		// setSelectedItem(windowPopup.itemsGRD.getSelectedRow());
	}

	protected void addKeyEvents() {

		this.addShortcutListener(new ShortcutListener("ENTER", KeyCode.ENTER, new int[] {}) {

			private static final long serialVersionUID = 1L;

			@Override
			public void handleAction(Object sender, Object target) {

				enterListener(target);

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

		this.addShortcutListener(new ShortcutListener("CTRL+E", KeyCode.E, new int[] { ModifierKey.CTRL }) {

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
					
					
					TextField txt = (TextField) target;
					
					if (txt.getValue() != null && txt.getValue().trim().length() > 0 && txt.getParent() instanceof SelectorBox) {
						
						SelectorBox sbc = (SelectorBox) txt.getParent();
						sbc.setSelectedItem(null);
						
					} else {
						
						txt.setValue(null);						
						loadDataResetPagedFull(false);	
					}	
					
					

				} else if (target instanceof DateField && ((DateField) target).isEnabled()
						&& ((DateField) target).isReadOnly() == false) {

					((DateField) target).setValue(null);

					loadDataResetPagedFull(false);
					
				} else if (target instanceof ComboBoxEntity && ((ComboBoxEntity) target).isEnabled()
						&& ((ComboBoxEntity) target).isReadOnly() == false) {

//					((ComboBoxEntity) target).setValue(null);
//
//					loadDataResetPagedFull(false);
				}
			}
		});

		// --------------------------------------------------

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

	protected Map<String, Boolean> buildOrderBy() {

		Map<String, Boolean> orderBy = new HashMap<String, Boolean>();

		for (SortOrder sortOrder : itemsGRD.getSortOrder()) {
			orderBy.put(sortOrder.getPropertyId().toString(), sortOrder.getDirection().toString().equals("ASCENDING"));
		}

		return orderBy;

	}

	abstract protected WindowForm buildWinddowForm(String mode, String id) throws Exception;

	protected void agregarBTNClick() {
		try {

			itemsGRD.select(null);
			WindowForm window = buildWinddowForm(WindowForm.INSERT_MODE, null);
			window.setWindowListado(this);
			getUI().addWindow(window);

		} catch (Exception e) {
			LogAndNotification.print(e);
		}
	}

	protected void modificarBTNClick() {
		try {

			if (itemsGRD.getSelectedRow() != null) {
				EntityId item = (EntityId) itemsGRD.getSelectedRow();
				WindowForm window = buildWinddowForm(WindowForm.UPDATE_MODE, item.getId());
				window.setWindowListado(this);
				getUI().addWindow(window);
			}

		} catch (Exception e) {
			LogAndNotification.print(e);
		}
	}

	protected void copiarBTNClick() {
		try {

			if (itemsGRD.getSelectedRow() != null) {
				EntityId item = (EntityId) itemsGRD.getSelectedRow();
				WindowForm window = buildWinddowForm(WindowForm.COPY_MODE, item.getId());
				window.setWindowListado(this);
				getUI().addWindow(window);
			}

		} catch (Exception e) {
			LogAndNotification.print(e);
		}
	}

	protected void sort(SortEvent sortEvent) {
		try {
			// loadData();
			loadDataResetPaged();
		} catch (Exception e) {
			LogAndNotification.print(e);
		}

	}

}
