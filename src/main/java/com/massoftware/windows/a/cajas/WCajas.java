package com.massoftware.windows.a.cajas;

import java.util.ArrayList;
import java.util.List;

import org.vaadin.patrik.FastNavigation;

import com.massoftware.model.Caja;
import com.massoftware.model.CajasFiltro;
import com.massoftware.x.util.UtilUI;
import com.massoftware.x.util.controls.TextFieldBox;
import com.massoftware.x.util.windows.LogAndNotification;
import com.massoftware.x.util.windows.WindowForm;
import com.massoftware.x.util.windows.WindowListado;
import com.vaadin.data.sort.SortOrder;
import com.vaadin.data.util.BeanItem;
import com.vaadin.data.util.BeanItemContainer;
import com.vaadin.shared.data.sort.SortDirection;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.Button;
import com.vaadin.ui.Grid;
import com.vaadin.ui.Grid.Column;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.VerticalLayout;

@SuppressWarnings("serial")
public class WCajas extends WindowListado {

	// -------------------------------------------------------------

	BeanItem<CajasFiltro> filterBI;
	protected BeanItemContainer<Caja> itemsBIC;

	// -------------------------------------------------------------

	private TextFieldBox numeroIB;
	private TextFieldBox nombreTB;

	// -------------------------------------------------------------

	public WCajas() {
		super();
		filterBI = new BeanItem<CajasFiltro>(new CajasFiltro());
		init(false);
	}

	public WCajas(CajasFiltro filtro) {
		super();
		filterBI = new BeanItem<CajasFiltro>(filtro);
		init(true);
	}

	protected void buildContent() throws Exception {

		confWinList(this, new Caja().labelPlural());

		// =======================================================
		// FILTROS

		HorizontalLayout filtrosLayout = buildFiltros();

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

	private HorizontalLayout buildFiltros() throws Exception {

		numeroIB = new TextFieldBox(this, filterBI, "numero");

		// --------------------------------------------------------

		nombreTB = new TextFieldBox(this, filterBI, "nombre");

		// --------------------------------------------------------

		Button buscarBTN = buildButtonBuscar();

		HorizontalLayout filaFiltroHL = new HorizontalLayout();
		filaFiltroHL.setSpacing(true);

		filaFiltroHL.addComponents(numeroIB, nombreTB, buscarBTN);
		filaFiltroHL.setComponentAlignment(buscarBTN, Alignment.MIDDLE_RIGHT);		

		return filaFiltroHL;
	}

	private Grid buildItemsGRD() throws Exception {

		itemsGRD = UtilUI.buildGrid();
		FastNavigation nav = UtilUI.initNavigation(itemsGRD);

		// ------------------------------------------------------------------

		// itemsGRD.setWidth("100%");
		itemsGRD.setWidth(25f, Unit.EM);
		itemsGRD.setHeight(20.5f, Unit.EM);

		itemsGRD.setColumns(new Object[] { "numero", "nombre" });

		UtilUI.confColumn(itemsGRD.getColumn("numero"), true, 70);
		UtilUI.confColumn(itemsGRD.getColumn("nombre"), true, -1);		

		Caja dto = new Caja();
		for (Column column : itemsGRD.getColumns()) {
			column.setHeaderCaption(dto.label(column.getPropertyId().toString()));
		}

		itemsGRD.setContainerDataSource(getItemsBIC());

		// .......

		// SI UNA COLUMNA ES DE TIPO BOOLEAN HACER LO QUE SIGUE
//		itemsGRD.getColumn("bloqueado").setRenderer(new HtmlRenderer(),
//				new StringToBooleanConverter(FontAwesome.CHECK_SQUARE_O.getHtml(), FontAwesome.SQUARE_O.getHtml()));

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

	// =================================================================================

	protected BeanItemContainer<Caja> getItemsBIC() {

		// -----------------------------------------------------------------
		// Crea el Container de la grilla, en base a al bean que queremos usar, y ademas
		// carga la grilla con una lista vacia

		if (itemsBIC == null) {
			itemsBIC = new BeanItemContainer<Caja>(Caja.class, new ArrayList<Caja>());
		}
		return itemsBIC;
	}

	protected void addBeansToItemsBIC() {

		// -----------------------------------------------------------------
		// Consulta a la base de datos y agrega los beans conseguidos al contenedor de
		// la grilla

		try {

			// -----------------------------------------------------------------
			// realiza la consulta a la base de datos
			List<Caja> items = new Caja().find(limit, offset, buildOrderBy(), filterBI.getBean());						

			// -----------------------------------------------------------------
			// Agrega los resultados a la grilla
			for (Caja item : items) {
				getItemsBIC().addBean(item);
			}

			// -----------------------------------------------------------------

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

	}

	protected WindowForm buildWinddowForm(String mode, String id) {
		return new WCaja(mode, id);		
	}

	// =================================================================================

} // END CLASS
