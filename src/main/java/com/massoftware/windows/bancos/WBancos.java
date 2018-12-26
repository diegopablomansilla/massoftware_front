package com.massoftware.windows.bancos;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.vaadin.patrik.FastNavigation;

import com.massoftware.windows.LogAndNotification;
import com.massoftware.windows.TextFieldBox;
import com.massoftware.windows.TextFieldIntegerBox;
import com.massoftware.windows.UtilUI;
import com.massoftware.windows.WindowListado;
import com.massoftware.windows.banco.BancoFiltro;
import com.massoftware.windows.banco.WBanco;
import com.vaadin.data.sort.SortOrder;
import com.vaadin.data.util.BeanItem;
import com.vaadin.data.util.BeanItemContainer;
import com.vaadin.data.util.converter.StringToBooleanConverter;
import com.vaadin.server.FontAwesome;
import com.vaadin.shared.data.sort.SortDirection;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.Button;
import com.vaadin.ui.Grid;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.OptionGroup;
import com.vaadin.ui.VerticalLayout;
import com.vaadin.ui.renderers.HtmlRenderer;

public class WBancos extends WindowListado {

	private static final long serialVersionUID = -6410625501465383928L;

	// -------------------------------------------------------------

	private BancosBO bo;

	// -------------------------------------------------------------

	BeanItem<BancosFiltro> filterBI;
	protected BeanItemContainer<Bancos> itemsBIC;

	// -------------------------------------------------------------

	private TextFieldIntegerBox numeroIB;
	private TextFieldBox nombreTB;
	private TextFieldBox nombreOficialTB;
	private OptionGroup bloqueadoOG;

	public Button seleccionarBTN;

	// -------------------------------------------------------------

	public WBancos() {
		super();
		init(null);
	}

	public WBancos(BancosFiltro filtro) {
		super();
		init(filtro);
		buildSelectorSection();
		this.setModal(true);
	}

	public void init(BancosFiltro filtro) {

		try {

			bo = new BancosBO();

			// =======================================================
			// LAYOUT CONTROLs

			if (filtro != null) {
				filterBI = new BeanItem<BancosFiltro>(filtro);
			} else {
				filterBI = new BeanItem<BancosFiltro>(new BancosFiltro());
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

		confWinList(this, "Bancos");

		// =======================================================
		// FILTROS

		VerticalLayout filtrosLayout = buildFiltros();

		// =======================================================
		// CUERPO
		// solo cuando por ejemplo tenemos un arbol y una grilla, o cosas asi mas
		// complejas q solo la grilla

		// =======================================================
		// BOTONERAS

		HorizontalLayout filaBotoneraHL = buildBotonera1();
		HorizontalLayout filaBotonera2HL = buildBotonera2();

		// =======================================================
		// CONTENT

		VerticalLayout content = UtilUI.buildWinContentVertical();

		content.addComponents(filtrosLayout, buildItemsGRD(), filaBotoneraHL, filaBotonera2HL);

		content.setComponentAlignment(filtrosLayout, Alignment.MIDDLE_CENTER);
		content.setComponentAlignment(filaBotoneraHL, Alignment.MIDDLE_LEFT);
		content.setComponentAlignment(filaBotonera2HL, Alignment.MIDDLE_RIGHT);

		this.setContent(content);
	}

	private VerticalLayout buildFiltros() throws Exception {

		numeroIB = new TextFieldIntegerBox(this, filterBI, "numero", "Numero", false, 10, 0, -1, false, false, null,
				false, UtilUI.EQUALS, 0, Short.MAX_VALUE);

		nombreTB = new TextFieldBox(this, filterBI, "nombre", "Nombre", false, 20, -1, 40, false, false, null, false,
				UtilUI.CONTAINS_WORDS_AND);

		// this.addShortcutListener(new ShortcutListener("ENTER", KeyCode.ENTER, new
		// int[] {}) {
		//
		// private static final long serialVersionUID = 1L;
		//
		// @Override
		// public void handleAction(Object sender, Object target) {
		//
		// if (target instanceof TextField && ((TextField)
		// target).getCaption().equals(nombreTB.getCaption())) {
		// loadDataResetPaged();
		// }
		// }
		// });

		nombreOficialTB = new TextFieldBox(this, filterBI, "nombreOficial", "Nombre oficial", false, 20, -1, 40, false,
				false, null, false, UtilUI.CONTAINS_WORDS_AND);

		bloqueadoOG = UtilUI.buildBooleanOG(filterBI, "bloqueado", "Situación", false, false, "Todos", "Bloquado",
				"No bloqueado", true, 0);

		bloqueadoOG.addValueChangeListener(e -> {
			loadDataResetPaged();
		});

		// --------------------------------------------------------

		Button buscarBTN = buildButtonBuscar();

		HorizontalLayout filaFiltroHL = new HorizontalLayout();
		filaFiltroHL.setSpacing(true);

		HorizontalLayout filaFiltro2HL = new HorizontalLayout();
		filaFiltroHL.setSpacing(true);

		filaFiltroHL.addComponents(numeroIB, nombreTB, buscarBTN);
		filaFiltroHL.setComponentAlignment(buscarBTN, Alignment.MIDDLE_RIGHT);

		filaFiltro2HL.addComponents(nombreOficialTB, bloqueadoOG);

		VerticalLayout filasFiltroVL = new VerticalLayout();
		filasFiltroVL.setWidth("100%");
		filasFiltroVL.addComponents(filaFiltroHL, filaFiltro2HL);

		return filasFiltroVL;
	}

	private Grid buildItemsGRD() {

		itemsGRD = UtilUI.buildGrid();
		FastNavigation nav = UtilUI.initNavigation(itemsGRD);

		// ------------------------------------------------------------------

		// itemsGRD.setWidth("100%");
		itemsGRD.setWidth(35f, Unit.EM);
		itemsGRD.setHeight(20.5f, Unit.EM);

		itemsGRD.setColumns(new Object[] { "numero", "nombre", "nombreOficial", "bloqueado" });

		UtilUI.confColumn(itemsGRD.getColumn("numero"), "Nro.", true, 70);
		UtilUI.confColumn(itemsGRD.getColumn("nombre"), "Nombre", true, 200);
		UtilUI.confColumn(itemsGRD.getColumn("nombreOficial"), "Nombre oficial", true, 200);
		UtilUI.confColumn(itemsGRD.getColumn("bloqueado"), "Bloqueado", true, -1);

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

	private void buildSelectorSection() {

		HorizontalLayout filaBotoneraHL = new HorizontalLayout();
		filaBotoneraHL.setSpacing(true);

		seleccionarBTN = UtilUI.buildButtonSeleccionar();

		filaBotoneraHL.addComponents(seleccionarBTN);

		((VerticalLayout) this.getContent()).addComponent(filaBotoneraHL);

		((VerticalLayout) this.getContent()).setComponentAlignment(filaBotoneraHL, Alignment.MIDDLE_CENTER);

	}

	// =================================================================================

	protected BeanItemContainer<Bancos> getItemsBIC() {
		if (itemsBIC == null) {
			itemsBIC = new BeanItemContainer<Bancos>(Bancos.class, new ArrayList<Bancos>());
		}
		return itemsBIC;
	}

	protected void validateFilterSection() {
		numeroIB.validate();
		nombreTB.validate();
		nombreOficialTB.validate();
		bloqueadoOG.validate();
	}

	protected void addBeansToitemsBIC() {

		List<Bancos> items = queryData();

		for (Bancos item : items) {
			getItemsBIC().addBean(item);
		}
	}

	protected void agregarBTNClick() {
		try {

			itemsGRD.select(null);
			WBanco window = new WBanco();
			window.setModal(true);
			window.center();
			window.setWindowListado(this);
			getUI().addWindow(window);

		} catch (Exception e) {
			LogAndNotification.print(e);
		}
	}

	protected void modificarBTNClick() {
		try {

			if (itemsGRD.getSelectedRow() != null) {

				Bancos item = (Bancos) itemsGRD.getSelectedRow();
				BancoFiltro filtro = new BancoFiltro();
				filtro.setNumero(item.getNumero());

				WBanco window = new WBanco(WBanco.UPDATE_MODE, filtro);
				window.setModal(true);
				window.center();
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

				Bancos item = (Bancos) itemsGRD.getSelectedRow();
				BancoFiltro filtro = new BancoFiltro();
				filtro.setNumero(item.getNumero());

				WBanco window = new WBanco(WBanco.COPY_MODE, filtro);
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
	// SECCION PARA CONSULTAS A LA BASE DE DATOS

	// metodo que realiza la consulta a la base de datos
	private List<Bancos> queryData() {

		try {

			Map<String, Boolean> orderBy = new HashMap<String, Boolean>();

			for (SortOrder sortOrder : itemsGRD.getSortOrder()) {
				orderBy.put(sortOrder.getPropertyId().toString(),
						sortOrder.getDirection().toString().equals("ASCENDING"));
			}

			// return Context.getBancosBO().find(limit, offset, orderBy,
			// this.filterBI.getBean());
			return bo.find(limit, offset, orderBy, this.filterBI.getBean());

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

		return new ArrayList<Bancos>();
	}

	// metodo que realiza el delete en la base de datos
	protected void deleteItem(Object item) throws Exception {

		bo.deleteItem((Bancos) item);

	}

	// =================================================================================

} // END CLASS
