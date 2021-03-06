
package com.massoftware.x.logistica;


import java.util.ArrayList;
import java.util.List;

//import com.vaadin.data.util.converter.StringToBooleanConverter;
//import com.vaadin.server.FontAwesome;
//import com.vaadin.ui.renderers.DateRenderer;
//import com.vaadin.ui.renderers.HtmlRenderer;




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

import com.massoftware.model.logistica.TransporteTarifa;
import com.massoftware.service.logistica.TransporteTarifaFiltro;
import com.massoftware.service.logistica.TransporteTarifaService;

import com.massoftware.model.logistica.Transporte;
import com.massoftware.service.logistica.TransporteFiltro;
import com.massoftware.service.logistica.TransporteService;
import com.massoftware.x.logistica.WLTransporte;

@SuppressWarnings("serial")
public class WLTransporteTarifa extends WindowListado {

	// -------------------------------------------------------------

	BeanItem<TransporteTarifaFiltro> filterBI;
	protected BeanItemContainer<TransporteTarifa> itemsBIC;
	
	private TransporteTarifaService service;

	// -------------------------------------------------------------

	
	protected ComboBoxBox transporteCBXB;
	protected SelectorBox transporteSBX;


	// -------------------------------------------------------------

	public WLTransporteTarifa() {
		super();		
		filterBI = new BeanItem<TransporteTarifaFiltro>(new TransporteTarifaFiltro());
		init(false);
		setFocusGrid();
	}

	public WLTransporteTarifa(TransporteTarifaFiltro filtro) {
		super();		
		filterBI = new BeanItem<TransporteTarifaFiltro>(filtro);
		init(true);
		setFocusGrid();
	}
	
	protected TransporteTarifaService getService() throws Exception {
		if(service == null){
			service = AppCX.services().buildTransporteTarifaService();
		}
		
		return service;
	}

	protected void buildContent() throws Exception {

		confWinList(this, new TransporteTarifa().labelPlural());

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

		TransporteService transporteService = AppCX.services().buildTransporteService();

		long transporteItems = transporteService.count();

		if (transporteItems < MAX_ROWS_FOR_CBX) {

			TransporteFiltro transporteFiltro = new TransporteFiltro();

			transporteFiltro.setUnlimited(true);

			transporteFiltro.setOrderBy(1);

			List<Transporte> transporteLista = transporteService.find(transporteFiltro);

			transporteCBXB = new ComboBoxBox(this, filterBI, "transporte", transporteLista, filterBI.getBean().getTransporte());

			transporteCBXB.focus();

		} else {

			transporteSBX = new SelectorBox(filterBI, "transporte") {

				protected void sourceLoadDataResetPaged() {

					loadDataResetPaged();

				}

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					TransporteService service = AppCX.services().buildTransporteService();

					return service.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					TransporteFiltro filtro = new TransporteFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					//WLTransporte windowPoPup = new WLTransporte(filtro) {

						//protected void setSelectedItem() throws Exception {

							//transporteSBX.setSelectedItem(itemsGRD.getSelectedRow());

						//}

					//};

					WLTransporte windowPoPup = AppCX.widgets().buildWLTransporte(filtro);

					windowPoPup.selectorSBX = transporteSBX;

					return windowPoPup;

				}

			};

			transporteSBX.focus();

		}
				
	
		// ------------------------------------------------------------------

		return buildFiltrosLayout();
	}
	
	protected Component buildFiltrosLayout() throws Exception {	
		
		HorizontalLayout filaFiltroHL = new HorizontalLayout();
		filaFiltroHL.setSpacing(true);
		
		// ------------------------------------------------------------------
		
		Button buscarBTN = buildButtonBuscar();		

		
		if (transporteCBXB != null) {
			filaFiltroHL.addComponent(transporteCBXB);
		}
		if (transporteSBX != null) {
			filaFiltroHL.addComponent(transporteSBX);
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

		itemsGRD.setColumns(new Object[] { "id", "numero", "carga", "ciudad", "precioFlete", "precioUnidadFacturacion", "precioUnidadStock", "precioBultos", "importeMinimoEntrega", "importeMinimoCarga" });

		// ------------------------------------------------------------------
		
		UtilUI.confColumn(itemsGRD.getColumn("id"), true, true, true, -1);

		UtilUI.confColumn(itemsGRD.getColumn("numero"), true, 100);

		UtilUI.confColumn(itemsGRD.getColumn("carga"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("ciudad"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("precioFlete"), true, 120);

		UtilUI.confColumn(itemsGRD.getColumn("precioUnidadFacturacion"), true, 120);

		UtilUI.confColumn(itemsGRD.getColumn("precioUnidadStock"), true, 120);

		UtilUI.confColumn(itemsGRD.getColumn("precioBultos"), true, 120);

		UtilUI.confColumn(itemsGRD.getColumn("importeMinimoEntrega"), true, 120);

		UtilUI.confColumn(itemsGRD.getColumn("importeMinimoCarga"), true, -1);
		
		// ------------------------------------------------------------------

		TransporteTarifa dto = new TransporteTarifa();
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
		

		// ------------------------------------------------------------------

		List<SortOrder> order = new ArrayList<SortOrder>();

		order.add(new SortOrder("numero", SortDirection.DESCENDING));

		itemsGRD.setSortOrder(order);			
		
		// ------------------------------------------------------------------		
	}

	// =================================================================================

	protected BeanItemContainer<TransporteTarifa> getItemsBIC() {

		// -----------------------------------------------------------------
		// Crea el Container de la grilla, en base a al bean que queremos usar, y ademas
		// carga la grilla con una lista vacia

		if (itemsBIC == null) {

			itemsBIC = new BeanItemContainer<TransporteTarifa>(TransporteTarifa.class, new ArrayList<TransporteTarifa>());
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
			// List<TransporteTarifa> items = new TransporteTarifa().find(limit, offset, buildOrderBy(),
			// filterBI.getBean());

			filterBI.getBean().setLimit((long)limit);
			filterBI.getBean().setOffset((long)offset);
			filterBI.getBean().setOrderBy(getNumbercolumn(itemsGRD.getSortOrder().get(0).getPropertyId().toString()));
			filterBI.getBean().setOrderByDesc(itemsGRD.getSortOrder().get(0).getDirection().toString().equals("ASCENDING") == false);
			
			if (filterBI.getBean().equals(lastFilter) == false) {						
			
				lastFilter = (TransporteTarifaFiltro) filterBI.getBean().clone();
				
				if (removeAllItems) {
					getItemsBIC().removeAllItems();
				}
				
				validateFilterSection();						 
			
				List<TransporteTarifa> items = getService().find(filterBI.getBean());
				
				// Agrega los resultados a la grilla
				for (TransporteTarifa item : items) {
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
		return AppCX.widgets().buildWFTransporteTarifa(mode, id);
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

// GENERATED BY ANTHILL 2019-07-08T12:47:40.023-03:00[America/Buenos_Aires]