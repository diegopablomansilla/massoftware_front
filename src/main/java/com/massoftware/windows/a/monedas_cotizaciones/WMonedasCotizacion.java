package com.massoftware.windows.a.monedas_cotizaciones;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.vaadin.patrik.FastNavigation;

import com.massoftware.model.MonedaCotizacion;
import com.massoftware.model.MonedasCotizacionFiltro;
import com.massoftware.model.seguridad.Usuario;
import com.massoftware.service.monedas.MonedaFiltro;
import com.massoftware.service.monedas.MonedaService;
import com.massoftware.x.util.UtilUI;
import com.massoftware.x.util.controls.ComboBoxBox;
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
import com.vaadin.ui.renderers.DateRenderer;

@SuppressWarnings("serial")
public class WMonedasCotizacion extends WindowListado {

	// -------------------------------------------------------------

	BeanItem<MonedasCotizacionFiltro> filterBI;
	protected BeanItemContainer<MonedaCotizacion> itemsBIC;

	// -------------------------------------------------------------

	private ComboBoxBox monedaCB;

	private Usuario usuario;

	// -------------------------------------------------------------

	public WMonedasCotizacion(Usuario usuario) {
		super();
		filterBI = new BeanItem<MonedasCotizacionFiltro>(new MonedasCotizacionFiltro());
		this.usuario = usuario;
		init(false);
	}

	public WMonedasCotizacion(MonedasCotizacionFiltro filtro, Usuario usuario) {
		super();
		filterBI = new BeanItem<MonedasCotizacionFiltro>(filtro);
		this.usuario = usuario;
		init(true);
	}

	protected void buildContent() throws Exception {

		confWinList(this, new MonedaCotizacion().labelPlural());

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

		// --------------------------------------------------------

		MonedaFiltro filtro = new MonedaFiltro();
		filtro.setUnlimited(true);
		monedaCB = new ComboBoxBox(this, filterBI, "moneda", new MonedaService().find(filtro));

		// --------------------------------------------------------

		Button buscarBTN = buildButtonBuscar();

		HorizontalLayout filaFiltroHL = new HorizontalLayout();
		filaFiltroHL.setSpacing(true);

		filaFiltroHL.addComponents(monedaCB, buscarBTN);
		filaFiltroHL.setComponentAlignment(buscarBTN, Alignment.MIDDLE_RIGHT);

		return filaFiltroHL;
	}

	private Grid buildItemsGRD() throws Exception {

		itemsGRD = UtilUI.buildGrid();
		FastNavigation nav = UtilUI.initNavigation(itemsGRD);

		// ------------------------------------------------------------------

		// itemsGRD.setWidth("100%");
		itemsGRD.setWidth(43f, Unit.EM);
		itemsGRD.setHeight(20.5f, Unit.EM);

		itemsGRD.setColumns(new Object[] { "moneda", "fecha", "compra", "venta", "usuario", "auditoriaFecha" });

		UtilUI.confColumn(itemsGRD.getColumn("moneda"), true, 100);
		UtilUI.confColumn(itemsGRD.getColumn("fecha"), true, 120);
		UtilUI.confColumn(itemsGRD.getColumn("compra"), true, 70);
		UtilUI.confColumn(itemsGRD.getColumn("venta"), true, 70);
		UtilUI.confColumn(itemsGRD.getColumn("usuario"), true, 120);
		UtilUI.confColumn(itemsGRD.getColumn("auditoriaFecha"), true, -1);

		MonedaCotizacion dto = new MonedaCotizacion();
		for (Column column : itemsGRD.getColumns()) {
			column.setHeaderCaption(dto.label(column.getPropertyId().toString()));
		}

		itemsGRD.setContainerDataSource(getItemsBIC());

		// .......

		// SI UNA COLUMNA ES DE TIPO BOOLEAN HACER LO QUE SIGUE
		// itemsGRD.getColumn("bloqueado").setRenderer(new HtmlRenderer(),
		// new StringToBooleanConverter(FontAwesome.CHECK_SQUARE_O.getHtml(),
		// FontAwesome.SQUARE_O.getHtml()));

		// SI UNA COLUMNA ES DE TIPO DATE HACER LO QUE SIGUE
		// itemsGRD.getColumn("attName").setRenderer(
		// new DateRenderer(new SimpleDateFormat("dd/MM/yyyy")));

		// SI UNA COLUMNA ES DE TIPO TIMESTAMP HACER LO QUE SIGUE
		itemsGRD.getColumn("fecha").setRenderer(new DateRenderer(new SimpleDateFormat("dd/MM/yyyy HH:mm:ss")));

		itemsGRD.getColumn("auditoriaFecha").setRenderer(new DateRenderer(new SimpleDateFormat("dd/MM/yyyy HH:mm:ss")));

		// .......

		List<SortOrder> order = new ArrayList<SortOrder>();

		order.add(new SortOrder("moneda", SortDirection.ASCENDING));
		order.add(new SortOrder("fecha", SortDirection.DESCENDING));

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

	protected BeanItemContainer<MonedaCotizacion> getItemsBIC() {

		// -----------------------------------------------------------------
		// Crea el Container de la grilla, en base a al bean que queremos usar, y ademas
		// carga la grilla con una lista vacia

		if (itemsBIC == null) {
			itemsBIC = new BeanItemContainer<MonedaCotizacion>(MonedaCotizacion.class,
					new ArrayList<MonedaCotizacion>());
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
			List<MonedaCotizacion> items = new MonedaCotizacion().find(limit, offset, buildOrderBy(),
					filterBI.getBean());

			// -----------------------------------------------------------------
			// Agrega los resultados a la grilla
			for (MonedaCotizacion item : items) {
				getItemsBIC().addBean(item);
			}

			// -----------------------------------------------------------------

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

	}

	protected WindowForm buildWinddowForm(String mode, String id) {
		return new WMonedaCotizacion(mode, id, usuario);
	}

	// =================================================================================

} // END CLASS
