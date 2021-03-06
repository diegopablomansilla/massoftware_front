
package com.massoftware.x.fondos;


import java.util.ArrayList;
import java.util.List;

//import com.vaadin.data.util.converter.StringToBooleanConverter;
//import com.vaadin.server.FontAwesome;
//import com.vaadin.ui.renderers.DateRenderer;
//import com.vaadin.ui.renderers.HtmlRenderer;


import com.vaadin.data.util.converter.StringToBooleanConverter;
import com.vaadin.server.FontAwesome;
import com.vaadin.ui.renderers.HtmlRenderer;

import com.vaadin.ui.renderers.DateRenderer;
import java.text.SimpleDateFormat;

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

import com.massoftware.AppCX;
import com.massoftware.x.util.*;
import com.massoftware.x.util.controls.*;
import com.massoftware.x.util.windows.*;


import com.massoftware.model.EntityId;

import com.massoftware.model.fondos.Talonario;
import com.massoftware.service.fondos.TalonarioFiltro;
import com.massoftware.service.fondos.TalonarioService;


@SuppressWarnings("serial")
public class WLTalonario extends WindowListado {

	// -------------------------------------------------------------

	BeanItem<TalonarioFiltro> filterBI;
	protected BeanItemContainer<Talonario> itemsBIC;
	
	private TalonarioService service;

	// -------------------------------------------------------------

	
	protected TextFieldBox numeroFromTXTB;
	protected TextFieldBox numeroToTXTB;
	protected TextFieldBox nombreTXTB;


	// -------------------------------------------------------------

	public WLTalonario() {
		super();		
		filterBI = new BeanItem<TalonarioFiltro>(new TalonarioFiltro());
		init(false);
		setFocusGrid();
	}

	public WLTalonario(TalonarioFiltro filtro) {
		super();		
		filterBI = new BeanItem<TalonarioFiltro>(filtro);
		init(true);
		setFocusGrid();
	}
	
	protected TalonarioService getService() throws Exception {
		if(service == null){
			service = AppCX.services().buildTalonarioService();
		}
		
		return service;
	}

	protected void buildContent() throws Exception {

		confWinList(this, new Talonario().labelPlural());

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

	protected Component buildFiltros() throws Exception {		
		

		// ------------------------------------------------------------------

		numeroFromTXTB = new TextFieldBox(this, filterBI, "numeroFrom");

		// ------------------------------------------------------------------

		numeroToTXTB = new TextFieldBox(this, filterBI, "numeroTo");

		// ------------------------------------------------------------------

		nombreTXTB = new TextFieldBox(this, filterBI, "nombre", "contiene las palabras ..");
				
	
		// ------------------------------------------------------------------

		return buildFiltrosLayout();
	}
	
	protected Component buildFiltrosLayout() throws Exception {	
		
		HorizontalLayout filaFiltroHL = new HorizontalLayout();
		filaFiltroHL.setSpacing(true);
		
		// ------------------------------------------------------------------
		
		Button buscarBTN = buildButtonBuscar();		

		
		if (numeroFromTXTB != null) {
			filaFiltroHL.addComponent(numeroFromTXTB);
		}
		if (numeroToTXTB != null) {
			filaFiltroHL.addComponent(numeroToTXTB);
		}
		if (nombreTXTB != null) {
			filaFiltroHL.addComponent(nombreTXTB);
		}
		
		filaFiltroHL.addComponent(buscarBTN);
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
		
		itemsGRD.addSortListener(e -> {
			sort(e);
		});

		// ------------------------------------------------------------------

		return itemsGRD;
	}
	
	protected void buildItemsGRDLayout() throws Exception {		

		// ------------------------------------------------------------------

		itemsGRD.setWidth("100%");
		// itemsGRD.setWidth(25f, Unit.EM);
		itemsGRD.setHeight(20.5f, Unit.EM);

		itemsGRD.setColumns(new Object[] { "id", "numero", "nombre", "talonarioLetra", "puntoVenta", "autonumeracion", "numeracionPreImpresa", "asociadoRG10098", "talonarioControladorFizcal", "primerNumero", "proximoNumero", "ultimoNumero", "cantidadMinimaComprobantes", "fecha", "numeroCAI", "vencimiento", "diasAvisoVencimiento" });

		// ------------------------------------------------------------------
		
		UtilUI.confColumn(itemsGRD.getColumn("id"), true, true, true, -1);

		UtilUI.confColumn(itemsGRD.getColumn("numero"), true, 100);

		UtilUI.confColumn(itemsGRD.getColumn("nombre"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("talonarioLetra"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("puntoVenta"), true, 100);

		UtilUI.confColumn(itemsGRD.getColumn("autonumeracion"), true, 70);

		UtilUI.confColumn(itemsGRD.getColumn("numeracionPreImpresa"), true, 70);

		UtilUI.confColumn(itemsGRD.getColumn("asociadoRG10098"), true, 70);

		UtilUI.confColumn(itemsGRD.getColumn("talonarioControladorFizcal"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("primerNumero"), true, 100);

		UtilUI.confColumn(itemsGRD.getColumn("proximoNumero"), true, 100);

		UtilUI.confColumn(itemsGRD.getColumn("ultimoNumero"), true, 100);

		UtilUI.confColumn(itemsGRD.getColumn("cantidadMinimaComprobantes"), true, 100);

		UtilUI.confColumn(itemsGRD.getColumn("fecha"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("numeroCAI"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("vencimiento"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("diasAvisoVencimiento"), true, -1);
		
		// ------------------------------------------------------------------

		Talonario dto = new Talonario();
		for (Column column : itemsGRD.getColumns()) {
			column.setHeaderCaption(dto.label(column.getPropertyId().toString()));
		}

		itemsGRD.setContainerDataSource(getItemsBIC());

		// ------------------------------------------------------------------

		// SI UNA COLUMNA ES DE TIPO BOOLEAN HACER LO QUE SIGUE
		// itemsGRD.getColumn("bloqueado").setRenderer(new HtmlRenderer(), new StringToBooleanConverter(FontAwesome.CHECK_SQUARE_O.getHtml(), FontAwesome.SQUARE_O.getHtml()));
		

		itemsGRD.getColumn("autonumeracion").setRenderer(new HtmlRenderer(), new StringToBooleanConverter(FontAwesome.CHECK_SQUARE_O.getHtml(),FontAwesome.SQUARE_O.getHtml()));

		itemsGRD.getColumn("numeracionPreImpresa").setRenderer(new HtmlRenderer(), new StringToBooleanConverter(FontAwesome.CHECK_SQUARE_O.getHtml(),FontAwesome.SQUARE_O.getHtml()));

		itemsGRD.getColumn("asociadoRG10098").setRenderer(new HtmlRenderer(), new StringToBooleanConverter(FontAwesome.CHECK_SQUARE_O.getHtml(),FontAwesome.SQUARE_O.getHtml()));

		// SI UNA COLUMNA ES DE TIPO DATE HACER LO QUE SIGUE
		// itemsGRD.getColumn("attName").setRenderer(new DateRenderer(new SimpleDateFormat("dd/MM/yyyy")));
		

		itemsGRD.getColumn("fecha").setRenderer(new DateRenderer(new SimpleDateFormat("dd/MM/yyyy")));

		itemsGRD.getColumn("vencimiento").setRenderer(new DateRenderer(new SimpleDateFormat("dd/MM/yyyy")));

		// SI UNA COLUMNA ES DE TIPO TIMESTAMP HACER LO QUE SIGUE
		// itemsGRD.getColumn("attName").setRenderer(new DateRenderer(new SimpleDateFormat("dd/MM/yyyy HH:mm:ss")));
		

		// ------------------------------------------------------------------

		List<SortOrder> order = new ArrayList<SortOrder>();

		order.add(new SortOrder("numero", SortDirection.DESCENDING));

		itemsGRD.setSortOrder(order);			
		
		// ------------------------------------------------------------------		
	}

	// =================================================================================

	protected BeanItemContainer<Talonario> getItemsBIC() {

		// -----------------------------------------------------------------
		// Crea el Container de la grilla, en base a al bean que queremos usar, y ademas
		// carga la grilla con una lista vacia

		if (itemsBIC == null) {

			itemsBIC = new BeanItemContainer<Talonario>(Talonario.class, new ArrayList<Talonario>());
		}

		return itemsBIC;
	}

	protected void addBeansToItemsBIC(boolean removeAllItems) {

		// -----------------------------------------------------------------
		// Consulta a la base de datos y agrega los beans conseguidos al contenedor de
		// la grilla

		try {

			// -----------------------------------------------------------------
			// realiza la consulta a la base de datos
			// List<Talonario> items = new Talonario().find(limit, offset, buildOrderBy(),
			// filterBI.getBean());

			filterBI.getBean().setLimit((long)limit);
			filterBI.getBean().setOffset((long)offset);
			filterBI.getBean().setOrderBy(getNumbercolumn(itemsGRD.getSortOrder().get(0).getPropertyId().toString()));
			filterBI.getBean().setOrderByDesc(itemsGRD.getSortOrder().get(0).getDirection().toString().equals("ASCENDING") == false);
			
			if (filterBI.getBean().equals(lastFilter) == false) {						
			
				lastFilter = (TalonarioFiltro) filterBI.getBean().clone();
				
				if (removeAllItems) {
					getItemsBIC().removeAllItems();
				}
				
				validateFilterSection();						 
			
				List<Talonario> items = getService().find(filterBI.getBean());
				
				// Agrega los resultados a la grilla
				for (Talonario item : items) {
					getItemsBIC().addBean(item);
				}
				
				if(items.size() == 0) {
					LogAndNotification.printSuccessOk(this.getCaption() + ": No se encontraron registros en base a los parámetros de consulta !." );
				} else if(items.size() == 1) {
					LogAndNotification.printSuccessOk(this.getCaption() + ": " +  items.size() + " registro encontrado en base a los parámetros de consulta !." );
				} else if(items.size() > 1) {
					LogAndNotification.printSuccessOk(this.getCaption() + ": " +  items.size() + " registros encontrados en base a los parámetros de consulta !." );
				}
				
			
			}							

			// -----------------------------------------------------------------

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

	}

	protected void deleteItem(Object item) throws Exception {

		// ((EntityId) item).delete();

		getService().deleteById(((EntityId) item).getId());

	}

	protected WindowForm buildWinddowForm(String mode, String id) throws Exception {
		return AppCX.widgets().buildWFTalonario(mode, id);
	}
	
	public void setFocusGrid() {			
		if( itemsBIC != null && itemsBIC.size() > 0) {
			itemsGRD.select(itemsBIC.getIdByIndex(0));	
		}	
		if(itemsGRD != null) {
			itemsGRD.focus();	
		}
	}
	
	

	// =================================================================================

} // END CLASS

// GENERATED BY ANTHILL 2019-07-08T12:47:41.198-03:00[America/Buenos_Aires]