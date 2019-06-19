
package com.massoftware.x.empresa;


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

import com.massoftware.model.empresa.Empresa;
import com.massoftware.service.empresa.EmpresaFiltro;
import com.massoftware.service.empresa.EmpresaService;


@SuppressWarnings("serial")
public class WLEmpresa extends WindowListado {

	// -------------------------------------------------------------

	BeanItem<EmpresaFiltro> filterBI;
	protected BeanItemContainer<Empresa> itemsBIC;
	
	private EmpresaService service;

	// -------------------------------------------------------------

	


	// -------------------------------------------------------------

	public WLEmpresa() {
		super();		
		filterBI = new BeanItem<EmpresaFiltro>(new EmpresaFiltro());
		init(false);
		setFocusGrid();
	}

	public WLEmpresa(EmpresaFiltro filtro) {
		super();		
		filterBI = new BeanItem<EmpresaFiltro>(filtro);
		init(true);
		setFocusGrid();
	}
	
	protected EmpresaService getService() throws Exception {
		if(service == null){
			service = AppCX.services().buildEmpresaService();
		}
		
		return service;
	}

	protected void buildContent() throws Exception {

		confWinList(this, new Empresa().labelPlural());

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

		return buildFiltrosLayout();
	}
	
	protected Component buildFiltrosLayout() throws Exception {	
		
		HorizontalLayout filaFiltroHL = new HorizontalLayout();
		filaFiltroHL.setSpacing(true);
		
		// ------------------------------------------------------------------
		
		Button buscarBTN = buildButtonBuscar();		

		
		
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

		itemsGRD.setColumns(new Object[] { "id", "ejercicioContable", "fechaCierreVentas", "fechaCierreStock", "fechaCierreFondo", "fechaCierreCompras", "fechaCierreContabilidad", "fechaCierreGarantiaDevoluciones", "fechaCierreTambos", "fechaCierreRRHH" });

		// ------------------------------------------------------------------
		
		UtilUI.confColumn(itemsGRD.getColumn("id"), true, true, true, -1);

		UtilUI.confColumn(itemsGRD.getColumn("ejercicioContable"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("fechaCierreVentas"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("fechaCierreStock"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("fechaCierreFondo"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("fechaCierreCompras"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("fechaCierreContabilidad"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("fechaCierreGarantiaDevoluciones"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("fechaCierreTambos"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("fechaCierreRRHH"), true, -1);
		
		// ------------------------------------------------------------------

		Empresa dto = new Empresa();
		for (Column column : itemsGRD.getColumns()) {
			column.setHeaderCaption(dto.label(column.getPropertyId().toString()));
		}

		itemsGRD.setContainerDataSource(getItemsBIC());

		// ------------------------------------------------------------------

		// SI UNA COLUMNA ES DE TIPO BOOLEAN HACER LO QUE SIGUE
		// itemsGRD.getColumn("bloqueado").setRenderer(new HtmlRenderer(), new StringToBooleanConverter(FontAwesome.CHECK_SQUARE_O.getHtml(), FontAwesome.SQUARE_O.getHtml()));
		

		// SI UNA COLUMNA ES DE TIPO DATE HACER LO QUE SIGUE
		// itemsGRD.getColumn("attName").setRenderer(new DateRenderer(new SimpleDateFormat("dd/MM/yyyy")));
		

		itemsGRD.getColumn("fechaCierreVentas").setRenderer(new DateRenderer(new SimpleDateFormat("dd/MM/yyyy")));

		itemsGRD.getColumn("fechaCierreStock").setRenderer(new DateRenderer(new SimpleDateFormat("dd/MM/yyyy")));

		itemsGRD.getColumn("fechaCierreFondo").setRenderer(new DateRenderer(new SimpleDateFormat("dd/MM/yyyy")));

		itemsGRD.getColumn("fechaCierreCompras").setRenderer(new DateRenderer(new SimpleDateFormat("dd/MM/yyyy")));

		itemsGRD.getColumn("fechaCierreContabilidad").setRenderer(new DateRenderer(new SimpleDateFormat("dd/MM/yyyy")));

		itemsGRD.getColumn("fechaCierreGarantiaDevoluciones").setRenderer(new DateRenderer(new SimpleDateFormat("dd/MM/yyyy")));

		itemsGRD.getColumn("fechaCierreTambos").setRenderer(new DateRenderer(new SimpleDateFormat("dd/MM/yyyy")));

		itemsGRD.getColumn("fechaCierreRRHH").setRenderer(new DateRenderer(new SimpleDateFormat("dd/MM/yyyy")));

		// SI UNA COLUMNA ES DE TIPO TIMESTAMP HACER LO QUE SIGUE
		// itemsGRD.getColumn("attName").setRenderer(new DateRenderer(new SimpleDateFormat("dd/MM/yyyy HH:mm:ss")));
		

		// ------------------------------------------------------------------

		List<SortOrder> order = new ArrayList<SortOrder>();

		order.add(new SortOrder("ejercicioContable", SortDirection.DESCENDING));

		itemsGRD.setSortOrder(order);			
		
		// ------------------------------------------------------------------		
	}

	// =================================================================================

	protected BeanItemContainer<Empresa> getItemsBIC() {

		// -----------------------------------------------------------------
		// Crea el Container de la grilla, en base a al bean que queremos usar, y ademas
		// carga la grilla con una lista vacia

		if (itemsBIC == null) {

			itemsBIC = new BeanItemContainer<Empresa>(Empresa.class, new ArrayList<Empresa>());
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
			// List<Empresa> items = new Empresa().find(limit, offset, buildOrderBy(),
			// filterBI.getBean());

			filterBI.getBean().setLimit((long)limit);
			filterBI.getBean().setOffset((long)offset);
			filterBI.getBean().setOrderBy(getNumbercolumn(itemsGRD.getSortOrder().get(0).getPropertyId().toString()));
			filterBI.getBean().setOrderByDesc(itemsGRD.getSortOrder().get(0).getDirection().toString().equals("ASCENDING") == false);
			
			if (filterBI.getBean().equals(lastFilter) == false) {						
			
				lastFilter = (EmpresaFiltro) filterBI.getBean().clone();
				
				if (removeAllItems) {
					getItemsBIC().removeAllItems();
				}
				
				validateFilterSection();						 
			
				List<Empresa> items = getService().find(filterBI.getBean());
				
				// Agrega los resultados a la grilla
				for (Empresa item : items) {
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
		return AppCX.widgets().buildWFEmpresa(mode, id);
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

// GENERATED BY ANTHILL 2019-06-19T11:51:57.852-03:00[America/Buenos_Aires]