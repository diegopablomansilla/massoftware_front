
package com.massoftware.x.geo;


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

import com.massoftware.windows.*;

import com.massoftware.model.EntityId;

import com.massoftware.model.geo.CodigoPostal;
import com.massoftware.dao.geo.CodigoPostalFiltro;
import com.massoftware.dao.geo.CodigoPostalDAO;

import com.massoftware.model.geo.Pais;
import com.massoftware.dao.geo.PaisFiltro;
import com.massoftware.dao.geo.PaisDAO;
import com.massoftware.model.geo.Provincia;
import com.massoftware.dao.geo.ProvinciaFiltro;
import com.massoftware.dao.geo.ProvinciaDAO;
import com.massoftware.model.geo.Ciudad;
import com.massoftware.dao.geo.CiudadFiltro;
import com.massoftware.dao.geo.CiudadDAO;

@SuppressWarnings("serial")
public class WLCodigoPostal extends WindowListado {

	// -------------------------------------------------------------

	BeanItem<CodigoPostalFiltro> filterBI;
	protected BeanItemContainer<CodigoPostal> itemsBIC;
	
	private CodigoPostalDAO dao;

	// -------------------------------------------------------------

	
	protected TextFieldBox codigoTXTB;
	protected TextFieldBox numeroFromTXTB;
	protected TextFieldBox numeroToTXTB;
	protected ComboBoxBox paisCBXB;
	protected SelectorBox paisSBX;
	protected ComboBoxBox provinciaCBXB;
	protected SelectorBox provinciaSBX;
	protected ComboBoxBox ciudadCBXB;
	protected SelectorBox ciudadSBX;


	// -------------------------------------------------------------

	public WLCodigoPostal() {
		super();		
		filterBI = new BeanItem<CodigoPostalFiltro>(new CodigoPostalFiltro());
		init(false);
		setFocusGrid();
	}

	public WLCodigoPostal(CodigoPostalFiltro filtro) {
		super();		
		filterBI = new BeanItem<CodigoPostalFiltro>(filtro);
		init(true);
		setFocusGrid();
	}
	
	protected CodigoPostalDAO getDAO() {
		if(dao == null){
			dao = new CodigoPostalDAO();
		}
		
		return dao;
	}

	protected void buildContent() throws Exception {

		confWinList(this, new CodigoPostal().labelPlural());

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

		codigoTXTB = new TextFieldBox(this, filterBI, "codigo", "igual a ..");

		// ------------------------------------------------------------------

		numeroFromTXTB = new TextFieldBox(this, filterBI, "numeroFrom");

		// ------------------------------------------------------------------

		numeroToTXTB = new TextFieldBox(this, filterBI, "numeroTo");

		// ------------------------------------------------------------------

		PaisDAO paisDAO = new PaisDAO();

		long paisItems = paisDAO.count();

		if (paisItems < 300) {

			PaisFiltro paisFiltro = new PaisFiltro();

			paisFiltro.setUnlimited(true);

			paisFiltro.setOrderBy("numero");

			List<Pais> paisLista = paisDAO.find(paisFiltro);

			paisCBXB = new ComboBoxBox(this, filterBI, "pais", paisLista, filterBI.getBean().getPais());

		} else {

			paisSBX = new SelectorBox(filterBI, "pais") {

				protected void sourceLoadDataResetPaged() {

					loadDataResetPaged();

				}

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					PaisDAO dao = new PaisDAO();

					return dao.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					PaisFiltro filtro = new PaisFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					WLPais windowPoPup = new WLPais(filtro) {

						protected void setSelectedItem() throws Exception {

							paisSBX.setSelectedItem(itemsGRD.getSelectedRow());

						}

					};

					return windowPoPup;

				}

			};

		}

		// ------------------------------------------------------------------

		ProvinciaDAO provinciaDAO = new ProvinciaDAO();

		long provinciaItems = provinciaDAO.count();

		if (provinciaItems < 300) {

			ProvinciaFiltro provinciaFiltro = new ProvinciaFiltro();

			provinciaFiltro.setUnlimited(true);

			provinciaFiltro.setOrderBy("numero");

			List<Provincia> provinciaLista = provinciaDAO.find(provinciaFiltro);

			provinciaCBXB = new ComboBoxBox(this, filterBI, "provincia", provinciaLista, filterBI.getBean().getProvincia());

		} else {

			provinciaSBX = new SelectorBox(filterBI, "provincia") {

				protected void sourceLoadDataResetPaged() {

					loadDataResetPaged();

				}

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					ProvinciaDAO dao = new ProvinciaDAO();

					return dao.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					ProvinciaFiltro filtro = new ProvinciaFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					WLProvincia windowPoPup = new WLProvincia(filtro) {

						protected void setSelectedItem() throws Exception {

							provinciaSBX.setSelectedItem(itemsGRD.getSelectedRow());

						}

					};

					return windowPoPup;

				}

			};

		}

		// ------------------------------------------------------------------

		CiudadDAO ciudadDAO = new CiudadDAO();

		long ciudadItems = ciudadDAO.count();

		if (ciudadItems < 300) {

			CiudadFiltro ciudadFiltro = new CiudadFiltro();

			ciudadFiltro.setUnlimited(true);

			ciudadFiltro.setOrderBy("numero");

			List<Ciudad> ciudadLista = ciudadDAO.find(ciudadFiltro);

			ciudadCBXB = new ComboBoxBox(this, filterBI, "ciudad", ciudadLista, filterBI.getBean().getCiudad());

		} else {

			ciudadSBX = new SelectorBox(filterBI, "ciudad") {

				protected void sourceLoadDataResetPaged() {

					loadDataResetPaged();

				}

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					CiudadDAO dao = new CiudadDAO();

					return dao.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					CiudadFiltro filtro = new CiudadFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					WLCiudad windowPoPup = new WLCiudad(filtro) {

						protected void setSelectedItem() throws Exception {

							ciudadSBX.setSelectedItem(itemsGRD.getSelectedRow());

						}

					};

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

		
		if (codigoTXTB != null) {
			filaFiltroHL.addComponent(codigoTXTB);
		}
		if (numeroFromTXTB != null) {
			filaFiltroHL.addComponent(numeroFromTXTB);
		}
		if (numeroToTXTB != null) {
			filaFiltroHL.addComponent(numeroToTXTB);
		}
		if (paisCBXB != null) {
			filaFiltroHL.addComponent(paisCBXB);
		}
		if (paisSBX != null) {
			filaFiltroHL.addComponent(paisSBX);
		}
		if (provinciaCBXB != null) {
			filaFiltroHL.addComponent(provinciaCBXB);
		}
		if (provinciaSBX != null) {
			filaFiltroHL.addComponent(provinciaSBX);
		}
		if (ciudadCBXB != null) {
			filaFiltroHL.addComponent(ciudadCBXB);
		}
		if (ciudadSBX != null) {
			filaFiltroHL.addComponent(ciudadSBX);
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

		itemsGRD.setColumns(new Object[] { "id", "codigo", "numero", "nombreCalle", "numeroCalle", "ciudad" });

		// ------------------------------------------------------------------
		
		UtilUI.confColumn(itemsGRD.getColumn("id"), true, true, true, -1);

		UtilUI.confColumn(itemsGRD.getColumn("codigo"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("numero"), true, 100);

		UtilUI.confColumn(itemsGRD.getColumn("nombreCalle"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("numeroCalle"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("ciudad"), true, -1);
		
		// ------------------------------------------------------------------

		CodigoPostal dto = new CodigoPostal();
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

		order.add(new SortOrder("codigo", SortDirection.ASCENDING));

		itemsGRD.setSortOrder(order);			
		
		// ------------------------------------------------------------------		
	}

	// =================================================================================

	protected BeanItemContainer<CodigoPostal> getItemsBIC() {

		// -----------------------------------------------------------------
		// Crea el Container de la grilla, en base a al bean que queremos usar, y ademas
		// carga la grilla con una lista vacia

		if (itemsBIC == null) {

			itemsBIC = new BeanItemContainer<CodigoPostal>(CodigoPostal.class, new ArrayList<CodigoPostal>());
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
			// List<CodigoPostal> items = new CodigoPostal().find(limit, offset, buildOrderBy(),
			// filterBI.getBean());

			filterBI.getBean().setLimit((long)limit);
			filterBI.getBean().setOffset((long)offset);
			filterBI.getBean().setOrderBy(itemsGRD.getSortOrder().get(0).getPropertyId().toString());
			filterBI.getBean().setOrderByDesc(itemsGRD.getSortOrder().get(0).getDirection().toString().equals("ASCENDING") == false);
			
			if (filterBI.getBean().equals(lastFilter) == false) {						
			
				lastFilter = (CodigoPostalFiltro) filterBI.getBean().clone();
				
				if (removeAllItems) {
					getItemsBIC().removeAllItems();
				}
				
				validateFilterSection();						 
			
				List<CodigoPostal> items = getDAO().find(filterBI.getBean());
				
				// Agrega los resultados a la grilla
				for (CodigoPostal item : items) {
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

		getDAO().deleteById(((EntityId) item).getId());

	}

	protected WindowForm buildWinddowForm(String mode, String id) throws Exception {
		return windowBuilder.buildWFCodigoPostal(mode, id);
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

// GENERATED BY ANTHILL 2019-05-27T19:20:27.333-03:00[America/Buenos_Aires]