
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

import com.massoftware.model.contabilidad.AsientoContable;
import com.massoftware.service.contabilidad.AsientoContableFiltro;
import com.massoftware.service.contabilidad.AsientoContableService;

import com.massoftware.model.contabilidad.EjercicioContable;
import com.massoftware.service.contabilidad.EjercicioContableFiltro;
import com.massoftware.service.contabilidad.EjercicioContableService;
import com.massoftware.x.contabilidad.WLEjercicioContable;
import com.massoftware.model.contabilidad.MinutaContable;
import com.massoftware.service.contabilidad.MinutaContableFiltro;
import com.massoftware.service.contabilidad.MinutaContableService;
import com.massoftware.x.contabilidad.WLMinutaContable;
import com.massoftware.model.contabilidad.AsientoContableModulo;
import com.massoftware.service.contabilidad.AsientoContableModuloFiltro;
import com.massoftware.service.contabilidad.AsientoContableModuloService;
import com.massoftware.x.contabilidad.WLAsientoContableModulo;
import com.massoftware.model.empresa.Sucursal;
import com.massoftware.service.empresa.SucursalFiltro;
import com.massoftware.service.empresa.SucursalService;
import com.massoftware.x.empresa.WLSucursal;

@SuppressWarnings("serial")
public class WLAsientoContable extends WindowListado {

	// -------------------------------------------------------------

	BeanItem<AsientoContableFiltro> filterBI;
	protected BeanItemContainer<AsientoContable> itemsBIC;
	
	private AsientoContableService service;

	// -------------------------------------------------------------

	
	protected TextFieldBox numeroFromTXTB;
	protected TextFieldBox numeroToTXTB;
	protected TextFieldBox detalleTXTB;
	protected TextFieldBox fechaFromTXTB;
	protected TextFieldBox fechaToTXTB;
	protected ComboBoxBox ejercicioContableCBXB;
	protected SelectorBox ejercicioContableSBX;
	protected ComboBoxBox minutaContableCBXB;
	protected SelectorBox minutaContableSBX;
	protected ComboBoxBox asientoContableModuloCBXB;
	protected SelectorBox asientoContableModuloSBX;
	protected ComboBoxBox sucursalCBXB;
	protected SelectorBox sucursalSBX;


	// -------------------------------------------------------------

	public WLAsientoContable() {
		super();		
		filterBI = new BeanItem<AsientoContableFiltro>(new AsientoContableFiltro());
		init(false);
		setFocusGrid();
	}

	public WLAsientoContable(AsientoContableFiltro filtro) {
		super();		
		filterBI = new BeanItem<AsientoContableFiltro>(filtro);
		init(true);
		setFocusGrid();
	}
	
	protected AsientoContableService getService() throws Exception {
		if(service == null){
			service = AppCX.services().buildAsientoContableService();
		}
		
		return service;
	}

	protected void buildContent() throws Exception {

		confWinList(this, new AsientoContable().labelPlural());

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

		fechaFromTXTB = new TextFieldBox(this, filterBI, "fechaFrom");

		// ------------------------------------------------------------------

		fechaToTXTB = new TextFieldBox(this, filterBI, "fechaTo");

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

		MinutaContableService minutaContableService = AppCX.services().buildMinutaContableService();

		long minutaContableItems = minutaContableService.count();

		if (minutaContableItems < MAX_ROWS_FOR_CBX) {

			MinutaContableFiltro minutaContableFiltro = new MinutaContableFiltro();

			minutaContableFiltro.setUnlimited(true);

			minutaContableFiltro.setOrderBy(1);

			List<MinutaContable> minutaContableLista = minutaContableService.find(minutaContableFiltro);

			minutaContableCBXB = new ComboBoxBox(this, filterBI, "minutaContable", minutaContableLista, filterBI.getBean().getMinutaContable());

		} else {

			minutaContableSBX = new SelectorBox(filterBI, "minutaContable") {

				protected void sourceLoadDataResetPaged() {

					loadDataResetPaged();

				}

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					MinutaContableService service = AppCX.services().buildMinutaContableService();

					return service.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					MinutaContableFiltro filtro = new MinutaContableFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					//WLMinutaContable windowPoPup = new WLMinutaContable(filtro) {

						//protected void setSelectedItem() throws Exception {

							//minutaContableSBX.setSelectedItem(itemsGRD.getSelectedRow());

						//}

					//};

					WLMinutaContable windowPoPup = AppCX.widgets().buildWLMinutaContable(filtro);

					windowPoPup.selectorSBX = minutaContableSBX;

					return windowPoPup;

				}

			};

		}

		// ------------------------------------------------------------------

		AsientoContableModuloService asientoContableModuloService = AppCX.services().buildAsientoContableModuloService();

		long asientoContableModuloItems = asientoContableModuloService.count();

		if (asientoContableModuloItems < MAX_ROWS_FOR_CBX) {

			AsientoContableModuloFiltro asientoContableModuloFiltro = new AsientoContableModuloFiltro();

			asientoContableModuloFiltro.setUnlimited(true);

			asientoContableModuloFiltro.setOrderBy(1);

			List<AsientoContableModulo> asientoContableModuloLista = asientoContableModuloService.find(asientoContableModuloFiltro);

			asientoContableModuloCBXB = new ComboBoxBox(this, filterBI, "asientoContableModulo", asientoContableModuloLista, filterBI.getBean().getAsientoContableModulo());

		} else {

			asientoContableModuloSBX = new SelectorBox(filterBI, "asientoContableModulo") {

				protected void sourceLoadDataResetPaged() {

					loadDataResetPaged();

				}

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					AsientoContableModuloService service = AppCX.services().buildAsientoContableModuloService();

					return service.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					AsientoContableModuloFiltro filtro = new AsientoContableModuloFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					//WLAsientoContableModulo windowPoPup = new WLAsientoContableModulo(filtro) {

						//protected void setSelectedItem() throws Exception {

							//asientoContableModuloSBX.setSelectedItem(itemsGRD.getSelectedRow());

						//}

					//};

					WLAsientoContableModulo windowPoPup = AppCX.widgets().buildWLAsientoContableModulo(filtro);

					windowPoPup.selectorSBX = asientoContableModuloSBX;

					return windowPoPup;

				}

			};

		}

		// ------------------------------------------------------------------

		SucursalService sucursalService = AppCX.services().buildSucursalService();

		long sucursalItems = sucursalService.count();

		if (sucursalItems < MAX_ROWS_FOR_CBX) {

			SucursalFiltro sucursalFiltro = new SucursalFiltro();

			sucursalFiltro.setUnlimited(true);

			sucursalFiltro.setOrderBy(1);

			List<Sucursal> sucursalLista = sucursalService.find(sucursalFiltro);

			sucursalCBXB = new ComboBoxBox(this, filterBI, "sucursal", sucursalLista, filterBI.getBean().getSucursal());

		} else {

			sucursalSBX = new SelectorBox(filterBI, "sucursal") {

				protected void sourceLoadDataResetPaged() {

					loadDataResetPaged();

				}

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					SucursalService service = AppCX.services().buildSucursalService();

					return service.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					SucursalFiltro filtro = new SucursalFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					//WLSucursal windowPoPup = new WLSucursal(filtro) {

						//protected void setSelectedItem() throws Exception {

							//sucursalSBX.setSelectedItem(itemsGRD.getSelectedRow());

						//}

					//};

					WLSucursal windowPoPup = AppCX.widgets().buildWLSucursal(filtro);

					windowPoPup.selectorSBX = sucursalSBX;

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
		if (fechaFromTXTB != null) {
			filaFiltroHL.addComponent(fechaFromTXTB);
		}
		if (fechaToTXTB != null) {
			filaFiltroHL.addComponent(fechaToTXTB);
		}
		if (ejercicioContableCBXB != null) {
			filaFiltroHL.addComponent(ejercicioContableCBXB);
		}
		if (ejercicioContableSBX != null) {
			filaFiltroHL.addComponent(ejercicioContableSBX);
		}
		if (minutaContableCBXB != null) {
			filaFiltroHL.addComponent(minutaContableCBXB);
		}
		if (minutaContableSBX != null) {
			filaFiltroHL.addComponent(minutaContableSBX);
		}
		if (asientoContableModuloCBXB != null) {
			filaFiltroHL.addComponent(asientoContableModuloCBXB);
		}
		if (asientoContableModuloSBX != null) {
			filaFiltroHL.addComponent(asientoContableModuloSBX);
		}
		if (sucursalCBXB != null) {
			filaFiltroHL.addComponent(sucursalCBXB);
		}
		if (sucursalSBX != null) {
			filaFiltroHL.addComponent(sucursalSBX);
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

		itemsGRD.setColumns(new Object[] { "id", "numero", "fecha", "detalle", "ejercicioContable", "minutaContable", "sucursal", "asientoContableModulo" });

		// ------------------------------------------------------------------
		
		UtilUI.confColumn(itemsGRD.getColumn("id"), true, true, true, -1);

		UtilUI.confColumn(itemsGRD.getColumn("numero"), true, 100);

		UtilUI.confColumn(itemsGRD.getColumn("fecha"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("detalle"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("ejercicioContable"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("minutaContable"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("sucursal"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("asientoContableModulo"), true, -1);
		
		// ------------------------------------------------------------------

		AsientoContable dto = new AsientoContable();
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

	protected BeanItemContainer<AsientoContable> getItemsBIC() {

		// -----------------------------------------------------------------
		// Crea el Container de la grilla, en base a al bean que queremos usar, y ademas
		// carga la grilla con una lista vacia

		if (itemsBIC == null) {

			itemsBIC = new BeanItemContainer<AsientoContable>(AsientoContable.class, new ArrayList<AsientoContable>());
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
			// List<AsientoContable> items = new AsientoContable().find(limit, offset, buildOrderBy(),
			// filterBI.getBean());

			filterBI.getBean().setLimit((long)limit);
			filterBI.getBean().setOffset((long)offset);
			filterBI.getBean().setOrderBy(getNumbercolumn(itemsGRD.getSortOrder().get(0).getPropertyId().toString()));
			filterBI.getBean().setOrderByDesc(itemsGRD.getSortOrder().get(0).getDirection().toString().equals("ASCENDING") == false);
			
			if (filterBI.getBean().equals(lastFilter) == false) {						
			
				lastFilter = (AsientoContableFiltro) filterBI.getBean().clone();
				
				if (removeAllItems) {
					getItemsBIC().removeAllItems();
				}
				
				validateFilterSection();						 
			
				List<AsientoContable> items = getService().find(filterBI.getBean());
				
				// Agrega los resultados a la grilla
				for (AsientoContable item : items) {
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
		return AppCX.widgets().buildWFAsientoContable(mode, id);
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

// GENERATED BY ANTHILL 2019-06-19T11:51:57.769-03:00[America/Buenos_Aires]