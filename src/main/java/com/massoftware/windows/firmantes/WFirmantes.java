package com.massoftware.windows.firmantes;

import java.util.ArrayList;
import java.util.List;

import org.vaadin.patrik.FastNavigation;

import com.massoftware.model.Firmante;
import com.massoftware.model.FirmantesFiltro;
import com.massoftware.x.util.UtilUI;
import com.massoftware.x.util.controls.OptionGroupEntityBoolean;
import com.massoftware.x.util.controls.TextFieldBox;
import com.massoftware.x.util.windows.LogAndNotification;
import com.massoftware.x.util.windows.WindowForm;
import com.massoftware.x.util.windows.WindowListado;
import com.vaadin.data.sort.SortOrder;
import com.vaadin.data.util.BeanItem;
import com.vaadin.data.util.BeanItemContainer;
import com.vaadin.data.util.converter.StringToBooleanConverter;
import com.vaadin.server.FontAwesome;
import com.vaadin.shared.data.sort.SortDirection;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.Button;
import com.vaadin.ui.Grid;
import com.vaadin.ui.Grid.Column;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.VerticalLayout;
import com.vaadin.ui.renderers.HtmlRenderer;

@SuppressWarnings("serial")
public class WFirmantes extends WindowListado {

	// -------------------------------------------------------------

	BeanItem<FirmantesFiltro> filterBI;
	protected BeanItemContainer<Firmante> itemsBIC;

	// -------------------------------------------------------------

	private TextFieldBox numeroIB;
	private TextFieldBox nombreTB;
	private OptionGroupEntityBoolean bloqueadoOG;

	// -------------------------------------------------------------

	public WFirmantes() {
		super();
		filterBI = new BeanItem<FirmantesFiltro>(new FirmantesFiltro());
		init(false);
	}

	public WFirmantes(FirmantesFiltro filtro) {
		super();
		filterBI = new BeanItem<FirmantesFiltro>(filtro);
		init(true);
	}

	protected void buildContent() throws Exception {

		confWinList(this, new Firmante().labelPlural());

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

		numeroIB = new TextFieldBox(this, filterBI, "numero");

		// --------------------------------------------------------

		nombreTB = new TextFieldBox(this, filterBI, "nombre");

		// this.addShortcutListener(new ShortcutListener("ENTER", KeyCode.ENTER, new
		// int[] {}) {
		//
		// private static final long serialVersionUID = 1L;
		//
		// @Override
		// public void handleAction(Object sender, Object target) {
		//
		// try {
		//
		// if (target instanceof TextField
		// && ((TextField) target).getCaption().equals(nombreTB.valueTXT.getCaption()))
		// {
		// loadDataResetPaged();
		// }
		// } catch (Exception e) {
		// LogAndNotification.print(e);
		// }
		//
		// }
		// });

		// --------------------------------------------------------

		bloqueadoOG = new OptionGroupEntityBoolean(this, filterBI, "bloqueado", "Todos", "Obsoletos", "Activos", true, 2);

		// --------------------------------------------------------

		Button buscarBTN = buildButtonBuscar();

		HorizontalLayout filaFiltroHL = new HorizontalLayout();
		filaFiltroHL.setSpacing(true);

		HorizontalLayout filaFiltro2HL = new HorizontalLayout();
		filaFiltroHL.setSpacing(true);

		filaFiltroHL.addComponents(numeroIB, nombreTB, buscarBTN);
		filaFiltroHL.setComponentAlignment(buscarBTN, Alignment.MIDDLE_RIGHT);

		filaFiltro2HL.addComponents(bloqueadoOG);

		VerticalLayout filasFiltroVL = new VerticalLayout();
		filasFiltroVL.setWidth("100%");
		filasFiltroVL.addComponents(filaFiltroHL, filaFiltro2HL);

		return filasFiltroVL;
	}

	private Grid buildItemsGRD() throws Exception {

		itemsGRD = UtilUI.buildGrid();
		FastNavigation nav = UtilUI.initNavigation(itemsGRD);

		// ------------------------------------------------------------------

		// itemsGRD.setWidth("100%");
		itemsGRD.setWidth(35f, Unit.EM);
		itemsGRD.setHeight(20.5f, Unit.EM);

		itemsGRD.setColumns(new Object[] { "numero", "nombre", "cargo", "bloqueado" });

		UtilUI.confColumn(itemsGRD.getColumn("numero"), true, 70);
		UtilUI.confColumn(itemsGRD.getColumn("nombre"), true, 230);
		UtilUI.confColumn(itemsGRD.getColumn("cargo"), true, 150);
		UtilUI.confColumn(itemsGRD.getColumn("bloqueado"), true, -1);

		Firmante dto = new Firmante();
		for (Column column : itemsGRD.getColumns()) {
			column.setHeaderCaption(dto.label(column.getPropertyId().toString()));
		}

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

	// =================================================================================

	protected BeanItemContainer<Firmante> getItemsBIC() {

		// -----------------------------------------------------------------
		// Crea el Container de la grilla, en base a al bean que queremos usar, y ademas
		// carga la grilla con una lista vacia

		if (itemsBIC == null) {
			itemsBIC = new BeanItemContainer<Firmante>(Firmante.class, new ArrayList<Firmante>());
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
			List<Firmante> items = new Firmante().find(limit, offset, buildOrderBy(), filterBI.getBean());

			// -----------------------------------------------------------------
			// Agrega los resultados a la grilla
			for (Firmante item : items) {
				getItemsBIC().addBean(item);
			}

			// -----------------------------------------------------------------

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

	}

	protected WindowForm buildWinddowForm(String mode, String id) {
		return new WFirmante(mode, id);
	}

	// =================================================================================

} // END CLASS
