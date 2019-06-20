
package com.massoftware.x.monedas;


import java.util.ArrayList;
import java.util.List;

//import com.vaadin.data.util.converter.StringToBooleanConverter;
//import com.vaadin.server.FontAwesome;
//import com.vaadin.ui.renderers.DateRenderer;
//import com.vaadin.ui.renderers.HtmlRenderer;



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

import com.massoftware.model.monedas.MonedaCotizacion;
import com.massoftware.service.monedas.MonedaCotizacionFiltro;
import com.massoftware.service.monedas.MonedaCotizacionService;

import com.massoftware.model.monedas.Moneda;
import com.massoftware.service.monedas.MonedaFiltro;
import com.massoftware.service.monedas.MonedaService;
import com.massoftware.x.monedas.WLMoneda;

@SuppressWarnings("serial")
public class WLMonedaCotizacion extends WindowListado {

	// -------------------------------------------------------------

	BeanItem<MonedaCotizacionFiltro> filterBI;
	protected BeanItemContainer<MonedaCotizacion> itemsBIC;
	
	private MonedaCotizacionService service;

	// -------------------------------------------------------------

	
	protected ComboBoxBox monedaCBXB;
	protected SelectorBox monedaSBX;
	protected DateFieldBox cotizacionFechaFromTXTB;
	protected DateFieldBox cotizacionFechaToTXTB;


	// -------------------------------------------------------------

	public WLMonedaCotizacion() {
		super();		
		filterBI = new BeanItem<MonedaCotizacionFiltro>(new MonedaCotizacionFiltro());
		init(false);
		setFocusGrid();
	}

	public WLMonedaCotizacion(MonedaCotizacionFiltro filtro) {
		super();		
		filterBI = new BeanItem<MonedaCotizacionFiltro>(filtro);
		init(true);
		setFocusGrid();
	}
	
	protected MonedaCotizacionService getService() throws Exception {
		if(service == null){
			service = AppCX.services().buildMonedaCotizacionService();
		}
		
		return service;
	}

	protected void buildContent() throws Exception {

		confWinList(this, new MonedaCotizacion().labelPlural());

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

		MonedaService monedaService = AppCX.services().buildMonedaService();

		long monedaItems = monedaService.count();

		if (monedaItems < MAX_ROWS_FOR_CBX) {

			MonedaFiltro monedaFiltro = new MonedaFiltro();

			monedaFiltro.setUnlimited(true);

			monedaFiltro.setOrderBy(1);

			List<Moneda> monedaLista = monedaService.find(monedaFiltro);

			monedaCBXB = new ComboBoxBox(this, filterBI, "moneda", monedaLista, filterBI.getBean().getMoneda());

			monedaCBXB.focus();

		} else {

			monedaSBX = new SelectorBox(filterBI, "moneda") {

				protected void sourceLoadDataResetPaged() {

					loadDataResetPaged();

				}

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					MonedaService service = AppCX.services().buildMonedaService();

					return service.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					MonedaFiltro filtro = new MonedaFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					//WLMoneda windowPoPup = new WLMoneda(filtro) {

						//protected void setSelectedItem() throws Exception {

							//monedaSBX.setSelectedItem(itemsGRD.getSelectedRow());

						//}

					//};

					WLMoneda windowPoPup = AppCX.widgets().buildWLMoneda(filtro);

					windowPoPup.selectorSBX = monedaSBX;

					return windowPoPup;

				}

			};

			monedaSBX.focus();

		}

		// ------------------------------------------------------------------

		cotizacionFechaFromTXTB = new DateFieldBox(this, filterBI, "cotizacionFechaFrom", false);

		// ------------------------------------------------------------------

		cotizacionFechaToTXTB = new DateFieldBox(this, filterBI, "cotizacionFechaTo", false);
				
	
		// ------------------------------------------------------------------

		return buildFiltrosLayout();
	}
	
	protected Component buildFiltrosLayout() throws Exception {	
		
		HorizontalLayout filaFiltroHL = new HorizontalLayout();
		filaFiltroHL.setSpacing(true);
		
		// ------------------------------------------------------------------
		
		Button buscarBTN = buildButtonBuscar();		

		
		if (monedaCBXB != null) {
			filaFiltroHL.addComponent(monedaCBXB);
		}
		if (monedaSBX != null) {
			filaFiltroHL.addComponent(monedaSBX);
		}
		if (cotizacionFechaFromTXTB != null) {
			filaFiltroHL.addComponent(cotizacionFechaFromTXTB);
		}
		if (cotizacionFechaToTXTB != null) {
			filaFiltroHL.addComponent(cotizacionFechaToTXTB);
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

		itemsGRD.setColumns(new Object[] { "id", "cotizacionFecha", "compra", "venta", "cotizacionFechaAuditoria", "moneda", "usuario" });

		// ------------------------------------------------------------------
		
		UtilUI.confColumn(itemsGRD.getColumn("id"), true, true, true, -1);

		UtilUI.confColumn(itemsGRD.getColumn("cotizacionFecha"), true, 120);

		UtilUI.confColumn(itemsGRD.getColumn("compra"), true, 120);

		UtilUI.confColumn(itemsGRD.getColumn("venta"), true, 120);

		UtilUI.confColumn(itemsGRD.getColumn("cotizacionFechaAuditoria"), true, 120);

		UtilUI.confColumn(itemsGRD.getColumn("moneda"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("usuario"), true, -1);
		
		// ------------------------------------------------------------------

		MonedaCotizacion dto = new MonedaCotizacion();
		for (Column column : itemsGRD.getColumns()) {
			column.setHeaderCaption(dto.label(column.getPropertyId().toString()));
		}

		itemsGRD.setContainerDataSource(getItemsBIC());

		// ------------------------------------------------------------------

		// SI UNA COLUMNA ES DE TIPO BOOLEAN HACER LO QUE SIGUE
		// itemsGRD.getColumn("bloqueado").setRenderer(new HtmlRenderer(), new StringToBooleanConverter(FontAwesome.CHECK_SQUARE_O.getHtml(), FontAwesome.SQUARE_O.getHtml()));
		

		// SI UNA COLUMNA ES DE TIPO DATE HACER LO QUE SIGUE
		// itemsGRD.getColumn("attName").setRenderer(new DateRenderer(new SimpleDateFormat("dd/MM/yyyy")));
		

		// SI UNA COLUMNA ES DE TIPO TIMESTAMP HACER LO QUE SIGUE
		// itemsGRD.getColumn("attName").setRenderer(new DateRenderer(new SimpleDateFormat("dd/MM/yyyy HH:mm:ss")));
		

		itemsGRD.getColumn("cotizacionFecha").setRenderer(new DateRenderer(new SimpleDateFormat("dd/MM/yyyy HH:mm:ss")));

		itemsGRD.getColumn("cotizacionFechaAuditoria").setRenderer(new DateRenderer(new SimpleDateFormat("dd/MM/yyyy HH:mm:ss")));

		// ------------------------------------------------------------------

		List<SortOrder> order = new ArrayList<SortOrder>();

		order.add(new SortOrder("cotizacionFecha", SortDirection.DESCENDING));

		itemsGRD.setSortOrder(order);			
		
		// ------------------------------------------------------------------		
	}

	// =================================================================================

	protected BeanItemContainer<MonedaCotizacion> getItemsBIC() {

		// -----------------------------------------------------------------
		// Crea el Container de la grilla, en base a al bean que queremos usar, y ademas
		// carga la grilla con una lista vacia

		if (itemsBIC == null) {

			itemsBIC = new BeanItemContainer<MonedaCotizacion>(MonedaCotizacion.class, new ArrayList<MonedaCotizacion>());
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
			// List<MonedaCotizacion> items = new MonedaCotizacion().find(limit, offset, buildOrderBy(),
			// filterBI.getBean());

			filterBI.getBean().setLimit((long)limit);
			filterBI.getBean().setOffset((long)offset);
			filterBI.getBean().setOrderBy(getNumbercolumn(itemsGRD.getSortOrder().get(0).getPropertyId().toString()));
			filterBI.getBean().setOrderByDesc(itemsGRD.getSortOrder().get(0).getDirection().toString().equals("ASCENDING") == false);
			
			if (filterBI.getBean().equals(lastFilter) == false) {						
			
				lastFilter = (MonedaCotizacionFiltro) filterBI.getBean().clone();
				
				if (removeAllItems) {
					getItemsBIC().removeAllItems();
				}
				
				validateFilterSection();						 
			
				List<MonedaCotizacion> items = getService().find(filterBI.getBean());
				
				// Agrega los resultados a la grilla
				for (MonedaCotizacion item : items) {
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
		return AppCX.widgets().buildWFMonedaCotizacion(mode, id);
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

// GENERATED BY ANTHILL 2019-06-20T16:20:15.510-03:00[America/Buenos_Aires]