
package com.massoftware.x.contabilidad;


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
import com.massoftware.windows.*;

import com.massoftware.model.EntityId;

import com.massoftware.model.contabilidad.PuntoEquilibrio;
import com.massoftware.service.contabilidad.PuntoEquilibrioFiltro;
import com.massoftware.service.contabilidad.PuntoEquilibrioService;

import com.massoftware.model.contabilidad.EjercicioContable;
import com.massoftware.service.contabilidad.EjercicioContableFiltro;
import com.massoftware.service.contabilidad.EjercicioContableService;
import com.massoftware.x.contabilidad.WLEjercicioContable;

@SuppressWarnings("serial")
public class WLPuntoEquilibrio extends WindowListado {

	// -------------------------------------------------------------

	BeanItem<PuntoEquilibrioFiltro> filterBI;
	protected BeanItemContainer<PuntoEquilibrio> itemsBIC;
	
	private PuntoEquilibrioService service;

	// -------------------------------------------------------------

	
	protected TextFieldBox numeroFromTXTB;
	protected TextFieldBox numeroToTXTB;
	protected TextFieldBox nombreTXTB;
	protected ComboBoxBox ejercicioContableCBXB;
	protected SelectorBox ejercicioContableSBX;


	// -------------------------------------------------------------

	public WLPuntoEquilibrio() {
		super();		
		filterBI = new BeanItem<PuntoEquilibrioFiltro>(new PuntoEquilibrioFiltro());
		init(false);
		setFocusGrid();
	}

	public WLPuntoEquilibrio(PuntoEquilibrioFiltro filtro) {
		super();		
		filterBI = new BeanItem<PuntoEquilibrioFiltro>(filtro);
		init(true);
		setFocusGrid();
	}
	
	protected PuntoEquilibrioService getService() throws Exception {
		if(service == null){
			service = AppCX.services().buildPuntoEquilibrioService();
		}
		
		return service;
	}

	protected void buildContent() throws Exception {

		confWinList(this, new PuntoEquilibrio().labelPlural());

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

		EjercicioContableService ejercicioContableService = AppCX.services().buildEjercicioContableService();

		long ejercicioContableItems = ejercicioContableService.count();

		if (ejercicioContableItems < MAX_ROWS_FOR_CBX) {

			EjercicioContableFiltro ejercicioContableFiltro = new EjercicioContableFiltro();

			ejercicioContableFiltro.setUnlimited(true);

			ejercicioContableFiltro.setOrderBy(1);

			List<EjercicioContable> ejercicioContableLista = ejercicioContableService.find(ejercicioContableFiltro);

			ejercicioContableCBXB = new ComboBoxBox(this, filterBI, "ejercicioContable", ejercicioContableLista, filterBI.getBean().getEjercicioContable());

		} else {

			ejercicioContableSBX = new SelectorBox(filterBI, "ejercicioContable") {

				protected void sourceLoadDataResetPaged() {

					loadDataResetPaged();

				}

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					EjercicioContableService service = AppCX.services().buildEjercicioContableService();

					return service.findByNumero(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					EjercicioContableFiltro filtro = new EjercicioContableFiltro();

					if (filter) {

					}

					//WLEjercicioContable windowPoPup = new WLEjercicioContable(filtro) {

						//protected void setSelectedItem() throws Exception {

							//ejercicioContableSBX.setSelectedItem(itemsGRD.getSelectedRow());

						//}

					//};

					WLEjercicioContable windowPoPup = AppCX.widgets().buildWLEjercicioContable(filtro);

					windowPoPup.selectorSBX = ejercicioContableSBX;

					return windowPoPup;

				}

			};

		}
				
	
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
		if (ejercicioContableCBXB != null) {
			filaFiltroHL.addComponent(ejercicioContableCBXB);
		}
		if (ejercicioContableSBX != null) {
			filaFiltroHL.addComponent(ejercicioContableSBX);
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

		itemsGRD.setColumns(new Object[] { "id", "numero", "nombre", "tipoPuntoEquilibrio", "ejercicioContable" });

		// ------------------------------------------------------------------
		
		UtilUI.confColumn(itemsGRD.getColumn("id"), true, true, true, -1);

		UtilUI.confColumn(itemsGRD.getColumn("numero"), true, 100);

		UtilUI.confColumn(itemsGRD.getColumn("nombre"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("tipoPuntoEquilibrio"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("ejercicioContable"), true, -1);
		
		// ------------------------------------------------------------------

		PuntoEquilibrio dto = new PuntoEquilibrio();
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

	protected BeanItemContainer<PuntoEquilibrio> getItemsBIC() {

		// -----------------------------------------------------------------
		// Crea el Container de la grilla, en base a al bean que queremos usar, y ademas
		// carga la grilla con una lista vacia

		if (itemsBIC == null) {

			itemsBIC = new BeanItemContainer<PuntoEquilibrio>(PuntoEquilibrio.class, new ArrayList<PuntoEquilibrio>());
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
			// List<PuntoEquilibrio> items = new PuntoEquilibrio().find(limit, offset, buildOrderBy(),
			// filterBI.getBean());

			filterBI.getBean().setLimit((long)limit);
			filterBI.getBean().setOffset((long)offset);
			filterBI.getBean().setOrderBy(getNumbercolumn(itemsGRD.getSortOrder().get(0).getPropertyId().toString()));
			filterBI.getBean().setOrderByDesc(itemsGRD.getSortOrder().get(0).getDirection().toString().equals("ASCENDING") == false);
			
			if (filterBI.getBean().equals(lastFilter) == false) {						
			
				lastFilter = (PuntoEquilibrioFiltro) filterBI.getBean().clone();
				
				if (removeAllItems) {
					getItemsBIC().removeAllItems();
				}
				
				validateFilterSection();						 
			
				List<PuntoEquilibrio> items = getService().find(filterBI.getBean());
				
				// Agrega los resultados a la grilla
				for (PuntoEquilibrio item : items) {
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
		return AppCX.widgets().buildWFPuntoEquilibrio(mode, id);
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

// GENERATED BY ANTHILL 2019-06-19T12:29:54.446-03:00[America/Buenos_Aires]