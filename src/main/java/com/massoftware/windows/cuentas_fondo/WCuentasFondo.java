package com.massoftware.windows.cuentas_fondo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.vaadin.patrik.FastNavigation;

import com.massoftware.Context;
import com.massoftware.windows.EliminarDialog;
import com.massoftware.windows.LogAndNotification;
import com.massoftware.windows.SelectorBox;
import com.massoftware.windows.TextFieldBox;
import com.massoftware.windows.TextFieldIntegerBox;
import com.massoftware.windows.UtilUI;
import com.massoftware.windows.WindowListado;
import com.massoftware.windows.cuentas_fondo.rubros.Rubros;
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

	protected Button agregarTreeBTN;
	protected Button modificarTreeBTN;
	// protected Button copiarTreeBTN;
	protected Button eliminarTreeBTN;

	private OptionGroup activoOG;
	private TextFieldIntegerBox numeroIB;
	private TextFieldBox nombreTB;
	private SelectorBox bancoSB;
	private Tree tree;

	private String itemTodas = "Todas las cuentas";

	// -------------------------------------------------------------

	public WCuentasFondo() {
		super();
		init(null);
	}

	public WCuentasFondo(CuentasFondoFiltro filtro) {
		super();
		init(filtro);
	}

	public void init(CuentasFondoFiltro filtro) {

		try {

			// =======================================================
			// FILTRO

			if (filtro != null) {
				filterBI = new BeanItem<CuentasFondoFiltro>(filtro);
			} else {
				filterBI = new BeanItem<CuentasFondoFiltro>(new CuentasFondoFiltro());
			}

			// =======================================================
			// LAYOUT CONTROLs

			buildContent();

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

	private void buildContent() throws Exception {

		confWinList(this, "Cuentas de fondo");

		// =======================================================
		// FILTROS

		HorizontalLayout filtrosLayout = buildFiltros();

		// =======================================================
		// CUERPO

		VerticalLayout izquierda = UtilUI.buildVL();
		izquierda.addComponent(buildPanelTree());
		HorizontalLayout filaBotoneraTreeHL = buildBotonera1Tree();
		HorizontalLayout filaBotoneraTree2HL = buildBotonera2Tree();
		izquierda.addComponents(filaBotoneraTreeHL, filaBotoneraTree2HL);
		izquierda.setComponentAlignment(filaBotoneraTreeHL, Alignment.MIDDLE_LEFT);
		izquierda.setComponentAlignment(filaBotoneraTree2HL, Alignment.MIDDLE_RIGHT);

		// ------------------------------------------------------

		VerticalLayout derecha = UtilUI.buildVL();
		derecha.setWidth("100%");
		derecha.addComponent(buildItemsGRD());
		HorizontalLayout filaBotoneraHL = buildBotonera1();
		HorizontalLayout filaBotonera2HL = buildBotonera2();
		derecha.addComponents(filaBotoneraHL, filaBotonera2HL);
		derecha.setComponentAlignment(filaBotoneraHL, Alignment.MIDDLE_LEFT);
		derecha.setComponentAlignment(filaBotonera2HL, Alignment.MIDDLE_RIGHT);

		// ------------------------------------------------------

		HorizontalLayout cuerpo = new HorizontalLayout();
		cuerpo.setSpacing(false);
		cuerpo.setMargin(false);

		cuerpo.addComponents(izquierda, derecha);

		// =======================================================
		// CONTENT

		VerticalLayout content = UtilUI.buildWinContentVertical();

		content.addComponents(filtrosLayout, cuerpo);

		content.setComponentAlignment(filtrosLayout, Alignment.MIDDLE_CENTER);

		this.setContent(content);
	}

	private HorizontalLayout buildFiltros() throws Exception {

		bancoSB = new WCBancoSB(this);

		numeroIB = new TextFieldIntegerBox(this, filterBI, "numero", "Cuenta", false, 5, -1, 3, false, false, null,
				false, UtilUI.EQUALS, 0, 255);

		nombreTB = new TextFieldBox(this, filterBI, "nombre", "Nombre", false, 20, -1, 25, false, false, null, false,
				UtilUI.CONTAINS_WORDS_AND);

		activoOG = UtilUI.buildBooleanOG(filterBI, "bloqueado", null, false, false, "Todas", "Activas", "No activas",
				true, 0);

		activoOG.addValueChangeListener(e -> {
			loadDataResetPaged();
		});

		Button buscarBTN = buildButtonBuscar();

		HorizontalLayout filaFiltroHL = new HorizontalLayout();
		filaFiltroHL.setSpacing(true);

		filaFiltroHL.addComponents(bancoSB, numeroIB, nombreTB, activoOG, buscarBTN);

		filaFiltroHL.setComponentAlignment(buscarBTN, Alignment.MIDDLE_RIGHT);

		return filaFiltroHL;
	}

	private Grid buildItemsGRD() {

		itemsGRD = UtilUI.buildGrid();
		FastNavigation nav = UtilUI.initNavigation(itemsGRD);

		// ------------------------------------------------------------------

		// itemsGRD.setWidth(22f, Unit.EM);
		itemsGRD.setWidth("100%");
		itemsGRD.setHeight(20.5f, Unit.EM);

		itemsGRD.setColumns(
				new Object[] { "numeroRubro", "numeroGrupo", "numeroBanco", "numero", "nombre", "tipo", "bloqueado" });

		UtilUI.confColumn(itemsGRD.getColumn("numeroRubro"), "Rubro", true, true, false, true, 50);
		UtilUI.confColumn(itemsGRD.getColumn("numeroGrupo"), "Grupo", true, true, false, true, 50);
		UtilUI.confColumn(itemsGRD.getColumn("numeroBanco"), "Banco", true, true, false, true, 100);
		UtilUI.confColumn(itemsGRD.getColumn("numero"), "Cuenta", true, 50);
		UtilUI.confColumn(itemsGRD.getColumn("nombre"), "Nombre", true, 200);
		UtilUI.confColumn(itemsGRD.getColumn("tipo"), "Tipo", true, -1);
		UtilUI.confColumn(itemsGRD.getColumn("bloqueado"), "Bloqueado", true, true, false, true, 30);

		itemsGRD.setContainerDataSource(getItemsBIC());

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

		// ------------------------------------------------------------------

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

		// ------------------------------------------------------------------

		return itemsGRD;
	}

	// =================================================================================

	protected HorizontalLayout buildBotonera1Tree() {

		HorizontalLayout filaBotoneraHL = new HorizontalLayout();
		filaBotoneraHL.setSpacing(true);

		agregarTreeBTN = UtilUI.buildButtonAgregar();
		agregarTreeBTN.addClickListener(e -> {
			agregarTreeBTNClick();
		});
		modificarTreeBTN = UtilUI.buildButtonModificar();
		modificarTreeBTN.addClickListener(e -> {
			modificarTreeBTNClick();
		});
		// copiarTreeBTN = UtilUI.buildButtonCopiar();
		// copiarTreeBTN.addClickListener(e -> {
		// // copiarBTNClick();
		// });

		filaBotoneraHL.addComponents(agregarTreeBTN, modificarTreeBTN/* , copiarTreeBTN */);

		return filaBotoneraHL;
	}

	protected HorizontalLayout buildBotonera2Tree() {

		HorizontalLayout filaBotonera2HL = new HorizontalLayout();
		filaBotonera2HL.setSpacing(true);

		eliminarTreeBTN = UtilUI.buildButtonEliminar();
		eliminarTreeBTN.addClickListener(e -> {
			eliminarTreeBTNClick();
		});

		filaBotonera2HL.addComponents(eliminarTreeBTN);

		return filaBotonera2HL;
	}

	private Panel buildPanelTree() {

		Panel seccionIzquierda = new Panel("Estructura");
		seccionIzquierda.setWidth(20f, Unit.EM);
		seccionIzquierda.setHeight(20.5f, Unit.EM);
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
						agregarTreeBTNClick();
					} else if (action.getCaption().equals("Modificar")) {
						modificarTreeBTNClick();
					} else if (action.getCaption().equals("Eliminar")) {
						eliminarTreeBTNClick();
					}

				}

				@Override
				public Action[] getActions(Object target, Object sender) {
					return ACTIONS;
				}
			};

			tree = new Tree("Estructura");

			loadDataResetPagedTree();

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
			if (item instanceof Rubros) {
				filterBI.getItemProperty("numeroRubro").setValue(((Rubros) item).getNumero());
				this.loadDataResetPaged();
			} else if (item instanceof Grupos) {
				filterBI.getItemProperty("numeroRubro").setValue(((Grupos) item).getNumeroRubro());

				filterBI.getItemProperty("numeroGrupo").setValue(((Grupos) item).getNumero());
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

	public void loadDataResetPagedTree() throws Exception {
		loadDataResetPagedTree(null, null);
	}

	public void loadDataResetPagedTree(Integer numeroRubro, Integer numeroGrupo) throws Exception {

		tree.removeAllItems();
		tree.addItem(itemTodas);
		tree.select(itemTodas);
		addCuentasContablesTree(numeroRubro, numeroGrupo);
		tree.expandItem(itemTodas);
	}

	private void addCuentasContablesTree(Integer numeroRubro, Integer numeroGrupo) throws Exception {

		List<Rubros> rubros = queryDataRubrosFiltro();

		for (Rubros rubro : rubros) {

			tree.addItem(rubro);
			tree.setParent(rubro, itemTodas);
			// tree.setChildrenAllowed(cuentaContable, false);

			GruposFiltro filtro = new GruposFiltro();
			filtro.setNumeroRubro(rubro.getNumero());

			List<Grupos> grupos = queryDataGruposFiltro(filtro);

			if (numeroRubro != null && rubro.getNumero() != null && rubro.getNumero().equals(numeroRubro)) {
				tree.select(rubro);
				tree.expandItem(rubro);
			}

			for (Grupos grupo : grupos) {

				grupo.setNumeroRubro(rubro.getNumero());

				tree.addItem(grupo);
				tree.setParent(grupo, rubro);
				tree.setChildrenAllowed(grupo, false);
				// tree.expandItem(grupo);

				if (numeroRubro != null && rubro.getNumero() != null && rubro.getNumero().equals(numeroRubro)
						&& numeroGrupo != null && grupo.getNumero() != null && grupo.getNumero().equals(numeroGrupo)) {
					tree.select(grupo);
					tree.expandItem(grupo);
				}

			}

			// tree.expandItem(rubro);

		}
	}

	protected void eliminarTreeBTNClick() {
		try {

			if (tree.getValue() != null && tree.getValue() instanceof Rubros || tree.getValue() instanceof Grupos) {

				getUI().addWindow(new EliminarDialog(tree.getValue().toString(), new EliminarDialog.Callback() {
					public void onDialogResult(boolean yes) {

						try {
							if (yes) {
								if (tree.getValue() != null) {

									Object item = tree.getValue();

									deleteItemTree(item);

									LogAndNotification.printSuccessOk("Se eliminó con éxito el ítem " + item);

									if (item instanceof Grupos) {
										loadDataResetPagedTree(((Grupos) item).getNumeroRubro(), null);
									} else {
										loadDataResetPagedTree();
									}

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

	protected void agregarTreeBTNClick() {
		try {

			if (tree.getValue() != null && tree.getValue() instanceof String || tree.getValue().equals(itemTodas)) {

				WRubro window = new WRubro();
				window.setModal(true);
				window.center();
				window.setWindowListado(this);
				getUI().addWindow(window);

			} else if (tree.getValue() != null && tree.getValue() instanceof Rubros) {

				WGrupo window = new WGrupo(((Rubros) tree.getValue()).getNumero());
				window.setModal(true);
				window.center();
				window.setWindowListado(this);
				getUI().addWindow(window);

			}

		} catch (Exception e) {
			LogAndNotification.print(e);
		}
	}

	protected void modificarTreeBTNClick() {
		try {

			if (tree.getValue() != null && tree.getValue() instanceof Rubros) {

				Rubros item = (Rubros) tree.getValue();
				RubroFiltro filtro = new RubroFiltro();
				filtro.setNumero(item.getNumero());

				WRubro window = new WRubro(WRubro.UPDATE_MODE, filtro);
				window.setModal(true);
				window.center();
				window.setWindowListado(this);
				getUI().addWindow(window);

			} else if (tree.getValue() != null && tree.getValue() instanceof Grupos) {

				Grupos item = (Grupos) tree.getValue();
				GrupoFiltro filtro = new GrupoFiltro();
				filtro.setNumero(item.getNumero());
				filtro.setNumeroRubro(item.getNumeroRubro());

				WGrupo window = new WGrupo(WGrupo.UPDATE_MODE, filtro);
				window.setModal(true);
				window.center();
				window.setWindowListado(this);
				getUI().addWindow(window);
			}

		} catch (Exception e) {
			LogAndNotification.print(e);
		}
	}

	// =================================================================================

	protected BeanItemContainer<CuentasFondo> getItemsBIC() {
		if (itemsBIC == null) {
			itemsBIC = new BeanItemContainer<CuentasFondo>(CuentasFondo.class, new ArrayList<CuentasFondo>());
		}
		return itemsBIC;
	}

	protected void validateFilterSection() {
		bancoSB.validate();
		numeroIB.validate();
		nombreTB.validate();
	}

	protected void addBeansToitemsBIC() {

		List<CuentasFondo> items = queryData();

		for (CuentasFondo item : items) {
			getItemsBIC().addBean(item);
		}
	}

	// =================================================================================
	// SECCION PARA CONSULTAS A LA BASE DE DATOS

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

	// ------------------------------------------------------------------------------

	private List<Rubros> queryDataRubrosFiltro() {
		try {

			return Context.getRubrosBO().find();

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

		return new ArrayList<Rubros>();
	}

	private List<Grupos> queryDataGruposFiltro(GruposFiltro filtro) {
		try {

			return Context.getGruposBO().find(filtro);

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

		return new ArrayList<Grupos>();
	}

	// metodo que realiza el delete en la base de datos
	private void deleteItemTree(Object item) {
		try {

			if (item instanceof Rubros) {
				Context.getRubrosBO().deleteItem((Rubros) item);
			} else if (item instanceof Grupos) {
				Context.getGruposBO().deleteItem((Grupos) item);
			}

		} catch (Exception e) {
			LogAndNotification.print(e);
		}
	}

	// =================================================================================

} // END CLASS
