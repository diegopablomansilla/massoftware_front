
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

import com.massoftware.model.fondos.CuentaFondo;
import com.massoftware.service.fondos.CuentaFondoFiltro;
import com.massoftware.service.fondos.CuentaFondoService;

import com.massoftware.model.fondos.banco.Banco;
import com.massoftware.service.fondos.banco.BancoFiltro;
import com.massoftware.service.fondos.banco.BancoService;
import com.massoftware.x.fondos.banco.WLBanco;

@SuppressWarnings("serial")
public class WLCuentaFondo extends WindowListado {

	// -------------------------------------------------------------

	BeanItem<CuentaFondoFiltro> filterBI;
	protected BeanItemContainer<CuentaFondo> itemsBIC;
	
	private CuentaFondoService service;

	// -------------------------------------------------------------

	
	protected TextFieldBox numeroFromTXTB;
	protected TextFieldBox numeroToTXTB;
	protected TextFieldBox nombreTXTB;
	protected ComboBoxBox bancoCBXB;
	protected SelectorBox bancoSBX;


	// -------------------------------------------------------------

	public WLCuentaFondo() {
		super();		
		filterBI = new BeanItem<CuentaFondoFiltro>(new CuentaFondoFiltro());
		init(false);
		setFocusGrid();
	}

	public WLCuentaFondo(CuentaFondoFiltro filtro) {
		super();		
		filterBI = new BeanItem<CuentaFondoFiltro>(filtro);
		init(true);
		setFocusGrid();
	}
	
	protected CuentaFondoService getService() throws Exception {
		if(service == null){
			service = AppCX.services().buildCuentaFondoService();
		}
		
		return service;
	}

	protected void buildContent() throws Exception {

		confWinList(this, new CuentaFondo().labelPlural());

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

		BancoService bancoService = AppCX.services().buildBancoService();

		long bancoItems = bancoService.count();

		if (bancoItems < MAX_ROWS_FOR_CBX) {

			BancoFiltro bancoFiltro = new BancoFiltro();

			bancoFiltro.setUnlimited(true);

			bancoFiltro.setOrderBy(1);

			List<Banco> bancoLista = bancoService.find(bancoFiltro);

			bancoCBXB = new ComboBoxBox(this, filterBI, "banco", bancoLista, filterBI.getBean().getBanco());

		} else {

			bancoSBX = new SelectorBox(filterBI, "banco") {

				protected void sourceLoadDataResetPaged() {

					loadDataResetPaged();

				}

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					BancoService service = AppCX.services().buildBancoService();

					return service.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					BancoFiltro filtro = new BancoFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					//WLBanco windowPoPup = new WLBanco(filtro) {

						//protected void setSelectedItem() throws Exception {

							//bancoSBX.setSelectedItem(itemsGRD.getSelectedRow());

						//}

					//};

					WLBanco windowPoPup = AppCX.widgets().buildWLBanco(filtro);

					windowPoPup.selectorSBX = bancoSBX;

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
		if (bancoCBXB != null) {
			filaFiltroHL.addComponent(bancoCBXB);
		}
		if (bancoSBX != null) {
			filaFiltroHL.addComponent(bancoSBX);
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

		itemsGRD.setColumns(new Object[] { "id", "numero", "nombre", "cuentaContable", "cuentaFondoGrupo", "cuentaFondoTipo", "obsoleto", "noImprimeCaja", "ventas", "fondos", "compras", "moneda", "caja", "rechazados", "conciliacion", "cuentaFondoTipoBanco", "banco", "cuentaBancaria", "cbu", "limiteDescubierto", "cuentaFondoCaucion", "cuentaFondoDiferidos", "formato", "cuentaFondoBancoCopia", "limiteOperacionIndividual", "seguridadPuertaUso", "seguridadPuertaConsulta", "seguridadPuertaLimite" });

		// ------------------------------------------------------------------
		
		UtilUI.confColumn(itemsGRD.getColumn("id"), true, true, true, -1);

		UtilUI.confColumn(itemsGRD.getColumn("numero"), true, 100);

		UtilUI.confColumn(itemsGRD.getColumn("nombre"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("cuentaContable"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("cuentaFondoGrupo"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("cuentaFondoTipo"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("obsoleto"), true, 70);

		UtilUI.confColumn(itemsGRD.getColumn("noImprimeCaja"), true, 70);

		UtilUI.confColumn(itemsGRD.getColumn("ventas"), true, 70);

		UtilUI.confColumn(itemsGRD.getColumn("fondos"), true, 70);

		UtilUI.confColumn(itemsGRD.getColumn("compras"), true, 70);

		UtilUI.confColumn(itemsGRD.getColumn("moneda"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("caja"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("rechazados"), true, 70);

		UtilUI.confColumn(itemsGRD.getColumn("conciliacion"), true, 70);

		UtilUI.confColumn(itemsGRD.getColumn("cuentaFondoTipoBanco"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("banco"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("cuentaBancaria"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("cbu"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("limiteDescubierto"), true, 120);

		UtilUI.confColumn(itemsGRD.getColumn("cuentaFondoCaucion"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("cuentaFondoDiferidos"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("formato"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("cuentaFondoBancoCopia"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("limiteOperacionIndividual"), true, 120);

		UtilUI.confColumn(itemsGRD.getColumn("seguridadPuertaUso"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("seguridadPuertaConsulta"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("seguridadPuertaLimite"), true, -1);
		
		// ------------------------------------------------------------------

		CuentaFondo dto = new CuentaFondo();
		for (Column column : itemsGRD.getColumns()) {
			column.setHeaderCaption(dto.label(column.getPropertyId().toString()));
		}

		itemsGRD.setContainerDataSource(getItemsBIC());

		// ------------------------------------------------------------------

		// SI UNA COLUMNA ES DE TIPO BOOLEAN HACER LO QUE SIGUE
		// itemsGRD.getColumn("bloqueado").setRenderer(new HtmlRenderer(), new StringToBooleanConverter(FontAwesome.CHECK_SQUARE_O.getHtml(), FontAwesome.SQUARE_O.getHtml()));
		

		itemsGRD.getColumn("obsoleto").setRenderer(new HtmlRenderer(), new StringToBooleanConverter(FontAwesome.CHECK_SQUARE_O.getHtml(),FontAwesome.SQUARE_O.getHtml()));

		itemsGRD.getColumn("noImprimeCaja").setRenderer(new HtmlRenderer(), new StringToBooleanConverter(FontAwesome.CHECK_SQUARE_O.getHtml(),FontAwesome.SQUARE_O.getHtml()));

		itemsGRD.getColumn("ventas").setRenderer(new HtmlRenderer(), new StringToBooleanConverter(FontAwesome.CHECK_SQUARE_O.getHtml(),FontAwesome.SQUARE_O.getHtml()));

		itemsGRD.getColumn("fondos").setRenderer(new HtmlRenderer(), new StringToBooleanConverter(FontAwesome.CHECK_SQUARE_O.getHtml(),FontAwesome.SQUARE_O.getHtml()));

		itemsGRD.getColumn("compras").setRenderer(new HtmlRenderer(), new StringToBooleanConverter(FontAwesome.CHECK_SQUARE_O.getHtml(),FontAwesome.SQUARE_O.getHtml()));

		itemsGRD.getColumn("rechazados").setRenderer(new HtmlRenderer(), new StringToBooleanConverter(FontAwesome.CHECK_SQUARE_O.getHtml(),FontAwesome.SQUARE_O.getHtml()));

		itemsGRD.getColumn("conciliacion").setRenderer(new HtmlRenderer(), new StringToBooleanConverter(FontAwesome.CHECK_SQUARE_O.getHtml(),FontAwesome.SQUARE_O.getHtml()));

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

	protected BeanItemContainer<CuentaFondo> getItemsBIC() {

		// -----------------------------------------------------------------
		// Crea el Container de la grilla, en base a al bean que queremos usar, y ademas
		// carga la grilla con una lista vacia

		if (itemsBIC == null) {

			itemsBIC = new BeanItemContainer<CuentaFondo>(CuentaFondo.class, new ArrayList<CuentaFondo>());
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
			// List<CuentaFondo> items = new CuentaFondo().find(limit, offset, buildOrderBy(),
			// filterBI.getBean());

			filterBI.getBean().setLimit((long)limit);
			filterBI.getBean().setOffset((long)offset);
			filterBI.getBean().setOrderBy(getNumbercolumn(itemsGRD.getSortOrder().get(0).getPropertyId().toString()));
			filterBI.getBean().setOrderByDesc(itemsGRD.getSortOrder().get(0).getDirection().toString().equals("ASCENDING") == false);
			
			if (filterBI.getBean().equals(lastFilter) == false) {						
			
				lastFilter = (CuentaFondoFiltro) filterBI.getBean().clone();
				
				if (removeAllItems) {
					getItemsBIC().removeAllItems();
				}
				
				validateFilterSection();						 
			
				List<CuentaFondo> items = getService().find(filterBI.getBean());
				
				// Agrega los resultados a la grilla
				for (CuentaFondo item : items) {
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
		return AppCX.widgets().buildWFCuentaFondo(mode, id);
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

// GENERATED BY ANTHILL 2019-06-20T16:41:27.420-03:00[America/Buenos_Aires]