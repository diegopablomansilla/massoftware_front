
package com.massoftware.x.contabilidad;


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
import com.massoftware.windows.*;

import com.massoftware.model.EntityId;

import com.massoftware.model.contabilidad.AsientoContableItem;
import com.massoftware.service.contabilidad.AsientoContableItemFiltro;
import com.massoftware.service.contabilidad.AsientoContableItemService;

import com.massoftware.model.contabilidad.AsientoContable;
import com.massoftware.service.contabilidad.AsientoContableFiltro;
import com.massoftware.service.contabilidad.AsientoContableService;
import com.massoftware.x.contabilidad.WLAsientoContable;

@SuppressWarnings("serial")
public class WLAsientoContableItem extends WindowListado {

	// -------------------------------------------------------------

	BeanItem<AsientoContableItemFiltro> filterBI;
	protected BeanItemContainer<AsientoContableItem> itemsBIC;
	
	private AsientoContableItemService service;

	// -------------------------------------------------------------

	
	protected TextFieldBox numeroFromTXTB;
	protected TextFieldBox numeroToTXTB;
	protected TextFieldBox detalleTXTB;
	protected ComboBoxBox asientoContableCBXB;
	protected SelectorBox asientoContableSBX;


	// -------------------------------------------------------------

	public WLAsientoContableItem() {
		super();		
		filterBI = new BeanItem<AsientoContableItemFiltro>(new AsientoContableItemFiltro());
		init(false);
		setFocusGrid();
	}

	public WLAsientoContableItem(AsientoContableItemFiltro filtro) {
		super();		
		filterBI = new BeanItem<AsientoContableItemFiltro>(filtro);
		init(true);
		setFocusGrid();
	}
	
	protected AsientoContableItemService getService() throws Exception {
		if(service == null){
			service = AppCX.services().buildAsientoContableItemService();
		}
		
		return service;
	}

	protected void buildContent() throws Exception {

		confWinList(this, new AsientoContableItem().labelPlural());

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

		detalleTXTB = new TextFieldBox(this, filterBI, "detalle", "contiene las palabras ..");

		// ------------------------------------------------------------------

		AsientoContableService asientoContableService = AppCX.services().buildAsientoContableService();

		long asientoContableItems = asientoContableService.count();

		if (asientoContableItems < MAX_ROWS_FOR_CBX) {

			AsientoContableFiltro asientoContableFiltro = new AsientoContableFiltro();

			asientoContableFiltro.setUnlimited(true);

			asientoContableFiltro.setOrderBy(1);

			List<AsientoContable> asientoContableLista = asientoContableService.find(asientoContableFiltro);

			asientoContableCBXB = new ComboBoxBox(this, filterBI, "asientoContable", asientoContableLista, filterBI.getBean().getAsientoContable());

		} else {

			asientoContableSBX = new SelectorBox(filterBI, "asientoContable") {

				protected void sourceLoadDataResetPaged() {

					loadDataResetPaged();

				}

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					AsientoContableService service = AppCX.services().buildAsientoContableService();

					return service.findByNumeroOrDetalle(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					AsientoContableFiltro filtro = new AsientoContableFiltro();

					if (filter) {

						filtro.setDetalle(getValue());

					}

					//WLAsientoContable windowPoPup = new WLAsientoContable(filtro) {

						//protected void setSelectedItem() throws Exception {

							//asientoContableSBX.setSelectedItem(itemsGRD.getSelectedRow());

						//}

					//};

					WLAsientoContable windowPoPup = AppCX.widgets().buildWLAsientoContable(filtro);

					windowPoPup.selectorSBX = asientoContableSBX;

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
		if (detalleTXTB != null) {
			filaFiltroHL.addComponent(detalleTXTB);
		}
		if (asientoContableCBXB != null) {
			filaFiltroHL.addComponent(asientoContableCBXB);
		}
		if (asientoContableSBX != null) {
			filaFiltroHL.addComponent(asientoContableSBX);
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

		itemsGRD.setColumns(new Object[] { "id", "numero", "fecha", "detalle", "asientoContable", "cuentaContable", "debe", "haber" });

		// ------------------------------------------------------------------
		
		UtilUI.confColumn(itemsGRD.getColumn("id"), true, true, true, -1);

		UtilUI.confColumn(itemsGRD.getColumn("numero"), true, 100);

		UtilUI.confColumn(itemsGRD.getColumn("fecha"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("detalle"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("asientoContable"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("cuentaContable"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("debe"), true, 120);

		UtilUI.confColumn(itemsGRD.getColumn("haber"), true, -1);
		
		// ------------------------------------------------------------------

		AsientoContableItem dto = new AsientoContableItem();
		for (Column column : itemsGRD.getColumns()) {
			column.setHeaderCaption(dto.label(column.getPropertyId().toString()));
		}

		itemsGRD.setContainerDataSource(getItemsBIC());

		// ------------------------------------------------------------------

		// SI UNA COLUMNA ES DE TIPO BOOLEAN HACER LO QUE SIGUE
		// itemsGRD.getColumn("bloqueado").setRenderer(new HtmlRenderer(), new StringToBooleanConverter(FontAwesome.CHECK_SQUARE_O.getHtml(), FontAwesome.SQUARE_O.getHtml()));
		

		// SI UNA COLUMNA ES DE TIPO DATE HACER LO QUE SIGUE
		// itemsGRD.getColumn("attName").setRenderer(new DateRenderer(new SimpleDateFormat("dd/MM/yyyy")));
		

		itemsGRD.getColumn("fecha").setRenderer(new DateRenderer(new SimpleDateFormat("dd/MM/yyyy")));

		// SI UNA COLUMNA ES DE TIPO TIMESTAMP HACER LO QUE SIGUE
		// itemsGRD.getColumn("attName").setRenderer(new DateRenderer(new SimpleDateFormat("dd/MM/yyyy HH:mm:ss")));
		

		// ------------------------------------------------------------------

		List<SortOrder> order = new ArrayList<SortOrder>();

		order.add(new SortOrder("numero", SortDirection.DESCENDING));

		itemsGRD.setSortOrder(order);			
		
		// ------------------------------------------------------------------		
	}

	// =================================================================================

	protected BeanItemContainer<AsientoContableItem> getItemsBIC() {

		// -----------------------------------------------------------------
		// Crea el Container de la grilla, en base a al bean que queremos usar, y ademas
		// carga la grilla con una lista vacia

		if (itemsBIC == null) {

			itemsBIC = new BeanItemContainer<AsientoContableItem>(AsientoContableItem.class, new ArrayList<AsientoContableItem>());
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
			// List<AsientoContableItem> items = new AsientoContableItem().find(limit, offset, buildOrderBy(),
			// filterBI.getBean());

			filterBI.getBean().setLimit((long)limit);
			filterBI.getBean().setOffset((long)offset);
			filterBI.getBean().setOrderBy(getNumbercolumn(itemsGRD.getSortOrder().get(0).getPropertyId().toString()));
			filterBI.getBean().setOrderByDesc(itemsGRD.getSortOrder().get(0).getDirection().toString().equals("ASCENDING") == false);
			
			if (filterBI.getBean().equals(lastFilter) == false) {						
			
				lastFilter = (AsientoContableItemFiltro) filterBI.getBean().clone();
				
				if (removeAllItems) {
					getItemsBIC().removeAllItems();
				}
				
				validateFilterSection();						 
			
				List<AsientoContableItem> items = getService().find(filterBI.getBean());
				
				// Agrega los resultados a la grilla
				for (AsientoContableItem item : items) {
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
		return AppCX.widgets().buildWFAsientoContableItem(mode, id);
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

// GENERATED BY ANTHILL 2019-06-19T11:23:56.648-03:00[America/Buenos_Aires]