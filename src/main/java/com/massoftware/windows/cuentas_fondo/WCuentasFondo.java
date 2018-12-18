package com.massoftware.windows.cuentas_fondo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.vaadin.patrik.FastNavigation;

import com.massoftware.windows.EliminarDialog;
import com.massoftware.windows.LogAndNotification;
import com.massoftware.windows.SelectorBox;
import com.massoftware.windows.TextFieldBox;
import com.massoftware.windows.UtilUI;
import com.massoftware.windows.WindowListado;
import com.vaadin.data.sort.SortOrder;
import com.vaadin.data.util.BeanItem;
import com.vaadin.data.util.BeanItemContainer;
import com.vaadin.data.util.converter.StringToBooleanConverter;
import com.vaadin.event.Action;
import com.vaadin.event.Action.Handler;
import com.vaadin.server.FontAwesome;
import com.vaadin.shared.data.sort.SortDirection;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.Button;
import com.vaadin.ui.Grid;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.OptionGroup;
import com.vaadin.ui.Panel;
import com.vaadin.ui.Tree;
import com.vaadin.ui.VerticalLayout;
import com.vaadin.ui.renderers.HtmlRenderer;

public class WCuentasFondo extends WindowListado {

	private static final long serialVersionUID = -6410625501465383928L;

	// -------------------------------------------------------------

	private CuentasFondoBO cuentasFondoBO = new CuentasFondoBO();

	// -------------------------------------------------------------

	BeanItem<CuentasFondoFiltro> filterBI;
	protected BeanItemContainer<CuentasFondo> itemsBIC;

	// -------------------------------------------------------------

	private OptionGroup activoOG;
	private NumeroIB numeroIB;
	private TextFieldBox nombreTB;
	private SelectorBox bancoSB;

//	private Panel seccionIzquierda;
	private Tree tree;

	private String itemTodas = "Todas las cuentas";

	// -------------------------------------------------------------

	public WCuentasFondo() {
		super();
		init(null);
	}

	public WCuentasFondo(Integer numero) {
		super();
		init(numero);
	}

	protected BeanItemContainer<CuentasFondo> getItemsBIC() {
		return itemsBIC;
	}

	@SuppressWarnings({ "unchecked" })
	public void init(Integer numero) {

		try {

			buildContainersItems();

			filterBI.getItemProperty("numero").setValue(numero);

			UtilUI.confWinList(this, "Cuentas de fondo");

			// =======================================================
			// FILTROS

			HorizontalLayout filaFiltroHL = buildFiltros();

			// =======================================================
			// CUERPO

			HorizontalLayout cuerpo = new HorizontalLayout();
			cuerpo.setSpacing(true);

			cuerpo.addComponents(buildPanelTree(), buildItemsGRD());

			// =======================================================
			// BOTONERAS

			HorizontalLayout filaBotoneraHL = buildBotonera1();
			HorizontalLayout filaBotonera2HL = buildBotonera2();

			// =======================================================
			// CONTENT

			VerticalLayout content = UtilUI.buildWinContentVertical();

			content.addComponents(filaFiltroHL, cuerpo, filaBotoneraHL, filaBotonera2HL);

			content.setComponentAlignment(filaFiltroHL, Alignment.MIDDLE_CENTER);
			content.setComponentAlignment(filaBotoneraHL, Alignment.MIDDLE_LEFT);
			content.setComponentAlignment(filaBotonera2HL, Alignment.MIDDLE_RIGHT);

			this.setContent(content);

			// =======================================================
			// KEY EVENTs

			addKeyEvents();

			// =======================================================
			// CARGA DE DATOS

			loadData();

		} catch (Exception e) {
			LogAndNotification.print(e);
		}
	}

	private HorizontalLayout buildFiltros() throws Exception {

		bancoSB = new BancoSB(this);

		numeroIB = new NumeroIB(this);

		nombreTB = new NombreTB(this);

		activoOG = UtilUI.buildBooleanOG(filterBI, "bloqueado", null, false, false, "Todas", "Activas", "No activas",
				true, 0);

		activoOG.addValueChangeListener(e -> {
			loadDataResetPaged();
		});

		Button buscarBTN = UtilUI.buildButtonBuscar();
		buscarBTN.addClickListener(e -> {
			loadDataResetPaged();
		});

		HorizontalLayout filaFiltroHL = new HorizontalLayout();
		filaFiltroHL.setSpacing(true);

		filaFiltroHL.addComponents(bancoSB, numeroIB, nombreTB, activoOG, buscarBTN);

		filaFiltroHL.setComponentAlignment(buscarBTN, Alignment.MIDDLE_RIGHT);

		return filaFiltroHL;
	}

	private Grid buildItemsGRD() {

		itemsGRD = UtilUI.buildGrid();
		FastNavigation nav = UtilUI.initNavigation(itemsGRD);

		// itemsGRD.setWidth(22f, Unit.EM);
		itemsGRD.setWidth("100%");

		itemsGRD.setColumns(
				new Object[] { "numeroRubro", "numeroGrupo", "numeroBanco", "numero", "nombre", "tipo", "bloqueado" });

		UtilUI.confColumn(itemsGRD.getColumn("numeroRubro"), "Rubro", true, true, false, true, 50);
		UtilUI.confColumn(itemsGRD.getColumn("numeroGrupo"), "Grupo", true, true, false, true, 50);
		UtilUI.confColumn(itemsGRD.getColumn("numeroBanco"), "Banco", true, true, false, true, 100);
		UtilUI.confColumn(itemsGRD.getColumn("numero"), "Cuenta", true, 50);
		UtilUI.confColumn(itemsGRD.getColumn("nombre"), "Nombre", true, 200);
		UtilUI.confColumn(itemsGRD.getColumn("tipo"), "Tipo", true, -1);
		UtilUI.confColumn(itemsGRD.getColumn("bloqueado"), "Bloqueado", true, true, false, true, 30);

		itemsGRD.setContainerDataSource(itemsBIC);

		// .......

		// SI UNA COLUMNA ES DE TIPO BOOLEAN HACER LO QUE SIGUE
		itemsGRD.getColumn("bloqueado").setRenderer(new HtmlRenderer(),
				new StringToBooleanConverter(FontAwesome.CHECK_SQUARE_O.getHtml(), FontAwesome.SQUARE_O.getHtml()));

		// SI UNA COLUMNA ES DE TIPO DATE HACER LO QUE SIGUE
		// itemsGRD.getColumn("attName").setRenderer(
		// new DateRenderer(new SimpleDateFormat("dd/MM/yyyy")));

		// SI UNA COLUMNA ES DE TIPO TIMESTAMP HACER LO QUE SIGUE
		// itemsGRD.getColumn("attName").setRenderer(
		// new DateRenderer(
		// new SimpleDateFormat("dd/MM/yyyy HH:mm:ss")));

		// .......

		List<SortOrder> order = new ArrayList<SortOrder>();

		order.add(new SortOrder("numeroRubro", SortDirection.ASCENDING));
		order.add(new SortOrder("numeroGrupo", SortDirection.ASCENDING));
		order.add(new SortOrder("numero", SortDirection.ASCENDING));

		itemsGRD.setSortOrder(order);

		nav.addRowFocusListener(e -> {
			try {
				int row = e.getRow();

				if (row == offset + limit - 1) {
					nextPageBTNClick();
				}
			} catch (Exception ex) {
				LogAndNotification.print(ex);
			}
		});

		return itemsGRD;
	}

	// =================================================================================

	private Panel buildPanelTree() {

		Panel seccionIzquierda = new Panel("Estructura");
		seccionIzquierda.setHeight("100%");
		seccionIzquierda.setWidth(20f, Unit.EM);
		seccionIzquierda.setHeight(25f, Unit.EM);
		seccionIzquierda.setContent(buildTree());

		return seccionIzquierda;
	}

	@SuppressWarnings("serial")
	private Tree buildTree() {
		try {

			Handler actionHandler = new Handler() {

				private final Action ACTION_ONE = new Action("Agregar");
				private final Action ACTION_TWO = new Action("Modificar");
				private final Action ACTION_THREE = new Action("Eliminar");
				private final Action[] ACTIONS = new Action[] { ACTION_ONE, ACTION_TWO, ACTION_THREE };

				@Override
				public void handleAction(Action action, Object sender, Object target) {

					if (action.getCaption().equals("Agregar")) {
						agregarBTNClick();
					} else if (action.getCaption().equals("Modificar")) {
						modificarBTNClick();
					} else if (action.getCaption().equals("Eliminar")) {
						eliminarItemTreeClick(target);
					}

				}

				@Override
				public Action[] getActions(Object target, Object sender) {
					return ACTIONS;
				}
			};

			tree = new Tree("Estructura");

			loadDataTree();

			tree.addValueChangeListener(event -> {
				if (event.getProperty() != null && event.getProperty().getValue() != null) {

					treeValueChangeListener(event.getProperty().getValue());

				}
			});

			tree.addActionHandler(actionHandler);

			return tree;

		} catch (Exception e) {
			LogAndNotification.print(e);
		}
		return null;
	}

	@SuppressWarnings("unchecked")
	private void treeValueChangeListener(Object item) {
		try {
			if (item instanceof RubrosFiltro) {
				filterBI.getItemProperty("numeroRubro").setValue(((RubrosFiltro) item).getNumero());
				this.loadDataResetPaged();
			} else if (item instanceof GruposFiltro) {
				filterBI.getItemProperty("numeroRubro").setValue(((GruposFiltro) item).getNumeroRubro());

				filterBI.getItemProperty("numeroGrupo").setValue(((GruposFiltro) item).getNumero());
				this.loadDataResetPaged();
			} else {
				filterBI.getItemProperty("numeroRubro").setValue(null);
				filterBI.getItemProperty("numeroGrupo").setValue(null);
				this.loadDataResetPaged();
			}

		} catch (Exception e) {
			LogAndNotification.print(e);
		}
	}

	private void loadDataTree() throws Exception {

		tree.removeAllItems();
		tree.addItem(itemTodas);
		tree.select(itemTodas);
		addCuentasContablesTree();
		tree.expandItem(itemTodas);
	}

	private void addCuentasContablesTree() throws Exception {

		List<RubrosFiltro> rubros = queryDataRubrosFiltro();

		for (RubrosFiltro rubro : rubros) {

			tree.addItem(rubro);
			tree.setParent(rubro, itemTodas);
			// tree.setChildrenAllowed(cuentaContable, false);

			List<GruposFiltro> grupos = queryDataGruposFiltro();

			for (GruposFiltro grupo : grupos) {

				grupo.setNumeroRubro(rubro.getNumero());

				tree.addItem(grupo);
				tree.setParent(grupo, rubro);
				tree.setChildrenAllowed(grupo, false);
				// tree.expandItem(grupo);

			}

			// tree.expandItem(rubro);

		}
	}

	private void eliminarItemTreeClick(Object item) {
		try {

			getUI().addWindow(new EliminarDialog(item.toString(), new EliminarDialog.Callback() {
				public void onDialogResult(boolean yes) {

					try {
						if (yes) {

							if (item instanceof RubrosFiltro) {
								deleteItem((RubrosFiltro) item);
							} else if (item instanceof GruposFiltro) {
								deleteItem((GruposFiltro) item);
							} else {
							}

							LogAndNotification.printSuccessOk("Se eliminó con éxito el ítem " + item);

							loadDataTree();
							loadDataResetPaged();

						}
					} catch (Exception e) {
						LogAndNotification.print(e);
					}

				}
			}));

		} catch (Exception e) {
			LogAndNotification.print(e);
		}
	}

	// =================================================================================

	private void buildContainersItems() throws Exception {

		filterBI = new BeanItem<CuentasFondoFiltro>(new CuentasFondoFiltro());
		itemsBIC = new BeanItemContainer<CuentasFondo>(CuentasFondo.class, new ArrayList<CuentasFondo>());
	}

	// =================================================================================

	protected void validateFilterSection() {
		bancoSB.validate();
		numeroIB.validate();
		nombreTB.validate();
	}

	protected void addBeansToitemsBIC() {

		List<CuentasFondo> items = queryData();

		for (CuentasFondo item : items) {
			itemsBIC.addBean(item);
		}
	}

	// =================================================================================
	// SECCION PARA CONSULTAS A LA BASE DE DATOS

	private List<RubrosFiltro> queryDataRubrosFiltro() {
		try {

			return mockDataRubrosFiltro();

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

		return new ArrayList<RubrosFiltro>();
	}

	private List<GruposFiltro> queryDataGruposFiltro() {
		try {

			return mockDataGruposFiltro();

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

		return new ArrayList<GruposFiltro>();
	}

	// metodo que realiza la consulta a la base de datos
	private List<CuentasFondo> queryData() {

		try {

			Map<String, Boolean> orderBy = new HashMap<String, Boolean>();

			for (SortOrder sortOrder : itemsGRD.getSortOrder()) {
				orderBy.put(sortOrder.getPropertyId().toString(),
						sortOrder.getDirection().toString().equals("ASCENDING"));
			}

			return cuentasFondoBO.find(limit, offset, orderBy, this.filterBI.getBean());

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

		return new ArrayList<CuentasFondo>();
	}

	// metodo que realiza el delete en la base de datos
	protected void deleteItem(Object item) {
		try {

			cuentasFondoBO.deleteItem((CuentasFondo) item);

		} catch (Exception e) {
			LogAndNotification.print(e);
		}
	}

	// metodo que realiza el delete en la base de datos
	private void deleteItem(RubrosFiltro item) {
		try {

			tree.removeItem(item);

		} catch (Exception e) {
			LogAndNotification.print(e);
		}
	}

	// metodo que realiza el delete en la base de datos
	private void deleteItem(GruposFiltro item) {
		try {

			tree.removeItem(item);

		} catch (Exception e) {
			LogAndNotification.print(e);
		}
	}

	// =================================================================================
	// SECCION SOLO PARA FINES DE MOCKUP

	private List<RubrosFiltro> mockDataRubrosFiltro() {

		List<RubrosFiltro> itemsMock = new ArrayList<RubrosFiltro>();

		if (itemsMock.size() == 0) {

			for (int i = 0; i < 20; i++) {

				RubrosFiltro item = new RubrosFiltro();

				item.setNumero(i);
				item.setNombre("Rubro " + i);

				itemsMock.add(item);
			}
		}

		return itemsMock;
	}

	private List<GruposFiltro> mockDataGruposFiltro() {

		List<GruposFiltro> itemsMock = new ArrayList<GruposFiltro>();

		if (itemsMock.size() == 0) {

			for (int i = 0; i < 20; i++) {

				GruposFiltro item = new GruposFiltro();

				item.setNumero(i);
				item.setNombre("Grupo " + i);

				itemsMock.add(item);
			}
		}

		return itemsMock;
	}

	// =================================================================================

} // END CLASS
