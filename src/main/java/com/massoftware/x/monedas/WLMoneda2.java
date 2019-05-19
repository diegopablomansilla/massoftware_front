
package com.massoftware.x.monedas;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import com.vaadin.data.util.converter.StringToBooleanConverter;
import com.vaadin.server.FontAwesome;
import com.vaadin.ui.renderers.DateRenderer;
import com.vaadin.ui.renderers.HtmlRenderer;

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
import com.vaadin.ui.Component;

import org.vaadin.patrik.FastNavigation;

import com.massoftware.windows.*;

import com.massoftware.model.EntityId;

import com.massoftware.model.monedas.Moneda;
import com.massoftware.dao.monedas.MonedaFiltro;
import com.massoftware.dao.monedas.MonedaDAO;

@SuppressWarnings("serial")
public class WLMoneda2 extends WindowListado {

	// -------------------------------------------------------------

	BeanItem<MonedaFiltro> filterBI;
	protected BeanItemContainer<Moneda> itemsBIC;
	
	private MonedaDAO dao;

	// -------------------------------------------------------------

	
	private TextFieldBox numeroFromTXTB;
	private TextFieldBox numeroToTXTB;
	private TextFieldBox nombreTXTB;
	private TextFieldBox abreviaturaTXTB;


	// -------------------------------------------------------------

	public WLMoneda2() {
		super();
		dao = new MonedaDAO();
		filterBI = new BeanItem<MonedaFiltro>(new MonedaFiltro());
		init(false);
		setFocusGrid();
	}

	public WLMoneda2(MonedaFiltro filtro) {
		super();
		dao = new MonedaDAO();
		filterBI = new BeanItem<MonedaFiltro>(filtro);
		init(true);
		setFocusGrid();
	}

	protected void buildContent() throws Exception {

		confWinList(this, new Moneda().labelPlural());

		// =======================================================
		// FILTROS

		Component filtrosLayout = buildFiltros();

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

	private Component buildFiltros() throws Exception {		
		

		// ------------------------------------------------------------------

		numeroFromTXTB = new TextFieldBox(this, filterBI, "numeroFrom");

		// ------------------------------------------------------------------

		numeroToTXTB = new TextFieldBox(this, filterBI, "numeroTo");

		// ------------------------------------------------------------------

		nombreTXTB = new TextFieldBox(this, filterBI, "nombre", "contiene las palabras ..");

		// ------------------------------------------------------------------

		abreviaturaTXTB = new TextFieldBox(this, filterBI, "abreviatura", "contiene las palabras ..");
				

		return buildFiltrosLayout();
	}
	
	protected Component buildFiltrosLayout() throws Exception {	
		
		HorizontalLayout filaFiltroHL = new HorizontalLayout();
		filaFiltroHL.setSpacing(true);
		
		// ------------------------------------------------------------------
		
		Button buscarBTN = buildButtonBuscar();		

		filaFiltroHL.addComponents(numeroFromTXTB, numeroToTXTB, nombreTXTB, abreviaturaTXTB, buscarBTN);
		filaFiltroHL.setComponentAlignment(buscarBTN, Alignment.MIDDLE_RIGHT);

		// ------------------------------------------------------------------

		return filaFiltroHL;
		
		// ------------------------------------------------------------------
	}

	private Grid buildItemsGRD() throws Exception {

		itemsGRD = UtilUI.buildGrid();
		FastNavigation nav = UtilUI.initNavigation(itemsGRD);

		// ------------------------------------------------------------------

		buildItemsGRDLayout();

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
	
	protected void buildItemsGRDLayout() throws Exception {		

		// ------------------------------------------------------------------

		itemsGRD.setWidth("100%");
		// itemsGRD.setWidth(25f, Unit.EM);
		itemsGRD.setHeight(20.5f, Unit.EM);

		itemsGRD.setColumns(new Object[] { "id", "numero", "nombre", "abreviatura", "cotizacion", "cotizacionFecha", "controlActualizacion", "monedaAFIP" });

		// ------------------------------------------------------------------
		
		UtilUI.confColumn(itemsGRD.getColumn("id"), true, true, true, -1);

		UtilUI.confColumn(itemsGRD.getColumn("numero"), true, 100);

		UtilUI.confColumn(itemsGRD.getColumn("nombre"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("abreviatura"), true, 60);

		UtilUI.confColumn(itemsGRD.getColumn("cotizacion"), true, 120);

		UtilUI.confColumn(itemsGRD.getColumn("cotizacionFecha"), true, 120);

		UtilUI.confColumn(itemsGRD.getColumn("controlActualizacion"), true, 70);

		UtilUI.confColumn(itemsGRD.getColumn("monedaAFIP"), true, 240);
		
		// ------------------------------------------------------------------

		Moneda dto = new Moneda();
		for (Column column : itemsGRD.getColumns()) {
			column.setHeaderCaption(dto.label(column.getPropertyId().toString()));
		}

		itemsGRD.setContainerDataSource(getItemsBIC());

		// ------------------------------------------------------------------

		// SI UNA COLUMNA ES DE TIPO BOOLEAN HACER LO QUE SIGUE
		// itemsGRD.getColumn("bloqueado").setRenderer(new HtmlRenderer(), new StringToBooleanConverter(FontAwesome.CHECK_SQUARE_O.getHtml(), FontAwesome.SQUARE_O.getHtml()));
		

		itemsGRD.getColumn("controlActualizacion").setRenderer(new HtmlRenderer(), new StringToBooleanConverter(FontAwesome.CHECK_SQUARE_O.getHtml(),FontAwesome.SQUARE_O.getHtml()));

		// SI UNA COLUMNA ES DE TIPO DATE HACER LO QUE SIGUE
		// itemsGRD.getColumn("attName").setRenderer(new DateRenderer(new SimpleDateFormat("dd/MM/yyyy")));
		

		// SI UNA COLUMNA ES DE TIPO TIMESTAMP HACER LO QUE SIGUE
		// itemsGRD.getColumn("attName").setRenderer(new DateRenderer(new SimpleDateFormat("dd/MM/yyyy HH:mm:ss")));
		

		itemsGRD.getColumn("cotizacionFecha").setRenderer(new DateRenderer(new SimpleDateFormat("dd/MM/yyyy HH:mm:ss")));

		// ------------------------------------------------------------------

		List<SortOrder> order = new ArrayList<SortOrder>();

		order.add(new SortOrder("id", SortDirection.ASCENDING));

		itemsGRD.setSortOrder(order);			
		
		// ------------------------------------------------------------------		
	}

	// =================================================================================

	protected BeanItemContainer<Moneda> getItemsBIC() {

		// -----------------------------------------------------------------
		// Crea el Container de la grilla, en base a al bean que queremos usar, y ademas
		// carga la grilla con una lista vacia

		if (itemsBIC == null) {

			itemsBIC = new BeanItemContainer<Moneda>(Moneda.class, new ArrayList<Moneda>());
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
			// List<Moneda> items = new Moneda().find(limit, offset, buildOrderBy(),
			// filterBI.getBean());

			//MonedaDAO dao = new MonedaDAO();
			dao = new MonedaDAO();

			filterBI.getBean().setLimit((long)limit);
			filterBI.getBean().setOffset((long)offset);
			filterBI.getBean().setOrderBy(itemsGRD.getSortOrder().get(0).getPropertyId().toString());
			filterBI.getBean().setOrderByDesc(itemsGRD.getSortOrder().get(0).getDirection().toString().equals("ASCENDING") == false);
			
			System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
			for (SortOrder sortOrder : itemsGRD.getSortOrder()) {								
				System.out.println(sortOrder.getPropertyId().toString() + " " + sortOrder.getDirection().toString());				
//				orderBy.put(sortOrder.getPropertyId().toString(), sortOrder.getDirection().toString().equals("ASCENDING"));
			}
			System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");

			List<Moneda> items = dao.find(filterBI.getBean());

			// -----------------------------------------------------------------
			// Agrega los resultados a la grilla
			for (Moneda item : items) {
				getItemsBIC().addBean(item);
			}

			// -----------------------------------------------------------------

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

	}

	protected void deleteItem(Object item) throws Exception {

		// ((EntityId) item).delete();

		//MonedaDAO dao = new MonedaDAO();
		dao = new MonedaDAO();
		dao.deleteById(((EntityId) item).getId());

	}

	protected WindowForm buildWinddowForm(String mode, String id) {
		return new WFMoneda(mode, id);
	}
	
	public void setFocusGrid() {
		if( itemsBIC.size() > 0) {
			itemsGRD.select(itemsBIC.getIdByIndex(0));	
		}					
		itemsGRD.focus();
	}
	
	

	// =================================================================================

} // END CLASS

// GENERATED BY ANTHILL 2019-05-19T20:05:30.712-03:00[America/Buenos_Aires]