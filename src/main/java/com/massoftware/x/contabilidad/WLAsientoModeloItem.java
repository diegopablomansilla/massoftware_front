
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
import com.massoftware.x.util.*;
import com.massoftware.x.util.controls.*;
import com.massoftware.x.util.windows.*;


import com.massoftware.model.EntityId;

import com.massoftware.model.contabilidad.AsientoModeloItem;
import com.massoftware.service.contabilidad.AsientoModeloItemFiltro;
import com.massoftware.service.contabilidad.AsientoModeloItemService;

import com.massoftware.model.contabilidad.AsientoModelo;
import com.massoftware.service.contabilidad.AsientoModeloFiltro;
import com.massoftware.service.contabilidad.AsientoModeloService;
import com.massoftware.x.contabilidad.WLAsientoModelo;

@SuppressWarnings("serial")
public class WLAsientoModeloItem extends WindowListado {

	// -------------------------------------------------------------

	BeanItem<AsientoModeloItemFiltro> filterBI;
	protected BeanItemContainer<AsientoModeloItem> itemsBIC;
	
	private AsientoModeloItemService service;

	// -------------------------------------------------------------

	
	protected ComboBoxBox asientoModeloCBXB;
	protected SelectorBox asientoModeloSBX;


	// -------------------------------------------------------------

	public WLAsientoModeloItem() {
		super();		
		filterBI = new BeanItem<AsientoModeloItemFiltro>(new AsientoModeloItemFiltro());
		init(false);
		setFocusGrid();
	}

	public WLAsientoModeloItem(AsientoModeloItemFiltro filtro) {
		super();		
		filterBI = new BeanItem<AsientoModeloItemFiltro>(filtro);
		init(true);
		setFocusGrid();
	}
	
	protected AsientoModeloItemService getService() throws Exception {
		if(service == null){
			service = AppCX.services().buildAsientoModeloItemService();
		}
		
		return service;
	}

	protected void buildContent() throws Exception {

		confWinList(this, new AsientoModeloItem().labelPlural());

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

		AsientoModeloService asientoModeloService = AppCX.services().buildAsientoModeloService();

		long asientoModeloItems = asientoModeloService.count();

		if (asientoModeloItems < MAX_ROWS_FOR_CBX) {

			AsientoModeloFiltro asientoModeloFiltro = new AsientoModeloFiltro();

			asientoModeloFiltro.setUnlimited(true);

			asientoModeloFiltro.setOrderBy(1);

			List<AsientoModelo> asientoModeloLista = asientoModeloService.find(asientoModeloFiltro);

			asientoModeloCBXB = new ComboBoxBox(this, filterBI, "asientoModelo", asientoModeloLista, filterBI.getBean().getAsientoModelo());

			asientoModeloCBXB.focus();

		} else {

			asientoModeloSBX = new SelectorBox(filterBI, "asientoModelo") {

				protected void sourceLoadDataResetPaged() {

					loadDataResetPaged();

				}

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					AsientoModeloService service = AppCX.services().buildAsientoModeloService();

					return service.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					AsientoModeloFiltro filtro = new AsientoModeloFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					//WLAsientoModelo windowPoPup = new WLAsientoModelo(filtro) {

						//protected void setSelectedItem() throws Exception {

							//asientoModeloSBX.setSelectedItem(itemsGRD.getSelectedRow());

						//}

					//};

					WLAsientoModelo windowPoPup = AppCX.widgets().buildWLAsientoModelo(filtro);

					windowPoPup.selectorSBX = asientoModeloSBX;

					return windowPoPup;

				}

			};

			asientoModeloSBX.focus();

		}
				
	
		// ------------------------------------------------------------------

		return buildFiltrosLayout();
	}
	
	protected Component buildFiltrosLayout() throws Exception {	
		
		HorizontalLayout filaFiltroHL = new HorizontalLayout();
		filaFiltroHL.setSpacing(true);
		
		// ------------------------------------------------------------------
		
		Button buscarBTN = buildButtonBuscar();		

		
		if (asientoModeloCBXB != null) {
			filaFiltroHL.addComponent(asientoModeloCBXB);
		}
		if (asientoModeloSBX != null) {
			filaFiltroHL.addComponent(asientoModeloSBX);
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

		itemsGRD.setColumns(new Object[] { "id", "numero", "asientoModelo", "cuentaContable" });

		// ------------------------------------------------------------------
		
		UtilUI.confColumn(itemsGRD.getColumn("id"), true, true, true, -1);

		UtilUI.confColumn(itemsGRD.getColumn("numero"), true, 100);

		UtilUI.confColumn(itemsGRD.getColumn("asientoModelo"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("cuentaContable"), true, -1);
		
		// ------------------------------------------------------------------

		AsientoModeloItem dto = new AsientoModeloItem();
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

	protected BeanItemContainer<AsientoModeloItem> getItemsBIC() {

		// -----------------------------------------------------------------
		// Crea el Container de la grilla, en base a al bean que queremos usar, y ademas
		// carga la grilla con una lista vacia

		if (itemsBIC == null) {

			itemsBIC = new BeanItemContainer<AsientoModeloItem>(AsientoModeloItem.class, new ArrayList<AsientoModeloItem>());
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
			// List<AsientoModeloItem> items = new AsientoModeloItem().find(limit, offset, buildOrderBy(),
			// filterBI.getBean());

			filterBI.getBean().setLimit((long)limit);
			filterBI.getBean().setOffset((long)offset);
			filterBI.getBean().setOrderBy(getNumbercolumn(itemsGRD.getSortOrder().get(0).getPropertyId().toString()));
			filterBI.getBean().setOrderByDesc(itemsGRD.getSortOrder().get(0).getDirection().toString().equals("ASCENDING") == false);
			
			if (filterBI.getBean().equals(lastFilter) == false) {						
			
				lastFilter = (AsientoModeloItemFiltro) filterBI.getBean().clone();
				
				if (removeAllItems) {
					getItemsBIC().removeAllItems();
				}
				
				validateFilterSection();						 
			
				List<AsientoModeloItem> items = getService().find(filterBI.getBean());
				
				// Agrega los resultados a la grilla
				for (AsientoModeloItem item : items) {
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
		return AppCX.widgets().buildWFAsientoModeloItem(mode, id);
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

// GENERATED BY ANTHILL 2019-06-29T09:32:08.991-03:00[America/Buenos_Aires]