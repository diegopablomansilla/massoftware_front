
package com.massoftware.x.logistica;

import com.vaadin.data.util.BeanItem;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.Component;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.VerticalLayout;

import com.massoftware.windows.*;

import com.massoftware.model.EntityId;


import java.util.List;
import com.massoftware.model.logistica.Carga;
import com.massoftware.dao.logistica.CargaFiltro;
import com.massoftware.dao.logistica.CargaDAO;
import com.massoftware.model.geo.Ciudad;
import com.massoftware.dao.geo.CiudadFiltro;
import com.massoftware.dao.geo.CiudadDAO;

import com.massoftware.model.logistica.TransporteTarifa;
import com.massoftware.dao.logistica.TransporteTarifaDAO;

@SuppressWarnings("serial")
public class WFTransporteTarifa extends WindowForm {


	// -------------------------------------------------------------

	protected BeanItem<TransporteTarifa> itemBI;
	
	private TransporteTarifaDAO dao;

	// -------------------------------------------------------------

	
	protected TextFieldEntity numeroTXT;
	protected ComboBoxEntity cargaCBX;
	protected SelectorBox cargaSBX;
	protected ComboBoxEntity ciudadCBX;
	protected SelectorBox ciudadSBX;
	protected TextFieldEntity precioFleteTXT;
	protected TextFieldEntity precioUnidadFacturacionTXT;
	protected TextFieldEntity precioUnidadStockTXT;
	protected TextFieldEntity precioBultosTXT;
	protected TextFieldEntity importeMinimoEntregaTXT;
	protected TextFieldEntity importeMinimoCargaTXT;


	// -------------------------------------------------------------

	public WFTransporteTarifa(String mode, String id) {
		super(mode, id);					
	}

	protected TransporteTarifaDAO getDAO() {
		if(dao == null){
			dao = new TransporteTarifaDAO();
		}
		
		return dao;
	}

	protected void buildContent() throws Exception {

		confWinForm(this.itemBI.getBean().labelSingular());
		this.setWidth(28f, Unit.EM);

		// =======================================================
		// CUERPO

		Component cuerpo = buildCuerpo();

		// =======================================================
		// BOTONERAS

		HorizontalLayout filaBotoneraHL = buildBotonera1();

		// =======================================================
		// CONTENT

		VerticalLayout content = UtilUI.buildWinContentVertical();

		content.addComponents(cuerpo, filaBotoneraHL);

		content.setComponentAlignment(filaBotoneraHL, Alignment.MIDDLE_LEFT);

		this.setContent(content);
	}

	protected Component buildCuerpo() throws Exception {

		

		// ------------------------------------------------------------------

		numeroTXT = new TextFieldEntity(itemBI, "numero", this.mode);

		numeroTXT.focus();

		CargaDAO cargaDAO = new CargaDAO();

		long cargaItems = cargaDAO.count();

		if (cargaItems < MAX_ROWS_FOR_CBX) {

			CargaFiltro cargaFiltro = new CargaFiltro();

			cargaFiltro.setUnlimited(true);

			cargaFiltro.setOrderBy("numero");

			List<Carga> cargaLista = cargaDAO.find(cargaFiltro);

			cargaCBX = new ComboBoxEntity(itemBI, "carga", this.mode, cargaLista);

		} else {

			cargaSBX = new SelectorBox(itemBI, "carga") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					CargaDAO dao = new CargaDAO();

					return dao.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					CargaFiltro filtro = new CargaFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return windowBuilder.buildWLCarga(filtro);

				}

			};

		}

		CiudadDAO ciudadDAO = new CiudadDAO();

		long ciudadItems = ciudadDAO.count();

		if (ciudadItems < MAX_ROWS_FOR_CBX) {

			CiudadFiltro ciudadFiltro = new CiudadFiltro();

			ciudadFiltro.setUnlimited(true);

			ciudadFiltro.setOrderBy("numero");

			List<Ciudad> ciudadLista = ciudadDAO.find(ciudadFiltro);

			ciudadCBX = new ComboBoxEntity(itemBI, "ciudad", this.mode, ciudadLista);

		} else {

			ciudadSBX = new SelectorBox(itemBI, "ciudad") {

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

					return windowBuilder.buildWLCiudad(filtro);

				}

			};

		}

		// ------------------------------------------------------------------

		precioFleteTXT = new TextFieldEntity(itemBI, "precioFlete", this.mode);

		// ------------------------------------------------------------------

		precioUnidadFacturacionTXT = new TextFieldEntity(itemBI, "precioUnidadFacturacion", this.mode);

		// ------------------------------------------------------------------

		precioUnidadStockTXT = new TextFieldEntity(itemBI, "precioUnidadStock", this.mode);

		// ------------------------------------------------------------------

		precioBultosTXT = new TextFieldEntity(itemBI, "precioBultos", this.mode);

		// ------------------------------------------------------------------

		importeMinimoEntregaTXT = new TextFieldEntity(itemBI, "importeMinimoEntrega", this.mode);

		// ------------------------------------------------------------------

		importeMinimoCargaTXT = new TextFieldEntity(itemBI, "importeMinimoCarga", this.mode);

		
		// ---------------------------------------------------------------------------------------------------------

		return buildCuerpoLayout();

		// ---------------------------------------------------------------------------------------------------------
	}
	
	protected Component buildCuerpoLayout() throws Exception {		

		VerticalLayout generalVL = UtilUI.buildVL();

		// ------------------------------------------------------------------		
		
		
		generalVL.addComponent(numeroTXT);
		if (cargaCBX != null) {
			generalVL.addComponent(cargaCBX);
		}
		if (cargaSBX != null) {
			generalVL.addComponent(cargaSBX);
		}
		if (ciudadCBX != null) {
			generalVL.addComponent(ciudadCBX);
		}
		if (ciudadSBX != null) {
			generalVL.addComponent(ciudadSBX);
		}
		generalVL.addComponent(precioFleteTXT);
		generalVL.addComponent(precioUnidadFacturacionTXT);
		generalVL.addComponent(precioUnidadStockTXT);
		generalVL.addComponent(precioBultosTXT);
		generalVL.addComponent(importeMinimoEntregaTXT);
		generalVL.addComponent(importeMinimoCargaTXT);

		// ---------------------------------------------------------------------------------------------------------

		return generalVL;

		// ---------------------------------------------------------------------------------------------------------
	}

	// =================================================================================

	protected void setMaxValues(EntityId item) throws Exception {
		// Al momento de insertar o copiar a veces se necesita el maximo valor de ese
		// atributo, + 1, esto es asi para hacer una especie de numero incremental de
		// ese atributo
		// Este metodo se ejecuta despues de consultar a la base de datos el bean en
		// base a su id

		// item.setNumero(this.itemBI.getBean().maxValueInteger("numero"));		
		
		
		((TransporteTarifa) item).setNumero(getDAO().nextValueNumero());

	}

	protected void setBean(EntityId obj) throws Exception {

		// se utiliza para asignarle o cambiar el bean al contenedor del formulario

		itemBI.setBean((TransporteTarifa) obj);
	}

	protected BeanItem<TransporteTarifa> getItemBIC() throws Exception {

		// -----------------------------------------------------------------
		// Crea el Container del form, en base a al bean que queremos usar, y ademas
		// carga el form con un bean vacio
		// como este metodo se llama muchas veces, inicializar el contenedor una sola
		// vez

		if (itemBI == null) {
			itemBI = new BeanItem<TransporteTarifa>(new TransporteTarifa());
		}
		return itemBI;
	}

	protected Object insert() throws Exception {

		try {
			
			getDAO().insert(getItemBIC().getBean());
			// ((EntityId) getItemBIC().getBean()).insert();
			if (windowListado != null) {
				windowListado.loadDataResetPagedFull();
			}

			return getItemBIC().getBean();

		} catch (Exception e) {
			LogAndNotification.print(e);
			return null;
		}
	}
	
	protected Object update() throws Exception {

		try {


			getDAO().update(getItemBIC().getBean());
//			((EntityId) getItemBIC().getBean()).update();
			if (windowListado != null) {
				windowListado.loadDataResetPagedFull();
			}

			return getItemBIC().getBean();

		} catch (Exception e) {
			LogAndNotification.print(e);
			return null;
		}
	}
	
	// metodo que realiza la consulta a la base de datos
	protected EntityId queryData() throws Exception {
		try {

			//EntityId item = (EntityId) getItemBIC().getBean();
			//item.loadById(id); // consulta a DB						
			TransporteTarifa item = getDAO().findById(id);
			getItemBIC().setBean(item);

			return item;

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

		return (EntityId) getItemBIC().getBean();
	}

	// =================================================================================

}