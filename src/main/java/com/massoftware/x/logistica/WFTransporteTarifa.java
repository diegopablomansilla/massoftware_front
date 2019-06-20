
package com.massoftware.x.logistica;

import com.vaadin.data.util.BeanItem;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.Component;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.VerticalLayout;

import com.massoftware.x.util.*;
import com.massoftware.x.util.controls.*;
import com.massoftware.x.util.windows.*;

import com.massoftware.AppCX;

import com.massoftware.model.EntityId;


import java.util.List;
import com.massoftware.model.logistica.Carga;
import com.massoftware.service.logistica.CargaFiltro;
import com.massoftware.service.logistica.CargaService;
import com.massoftware.model.geo.Ciudad;
import com.massoftware.service.geo.CiudadFiltro;
import com.massoftware.service.geo.CiudadService;

import com.massoftware.model.logistica.TransporteTarifa;
import com.massoftware.service.logistica.TransporteTarifaService;

@SuppressWarnings("serial")
public class WFTransporteTarifa extends WindowForm {


	// -------------------------------------------------------------

	protected BeanItem<TransporteTarifa> itemBI;
	
	private TransporteTarifaService service;

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

	protected TransporteTarifaService getService() throws Exception {
		if(service == null){
			service = AppCX.services().buildTransporteTarifaService();
		}
		
		return service;
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

		CargaService cargaService = AppCX.services().buildCargaService();

		long cargaItems = cargaService.count();

		if (cargaItems < MAX_ROWS_FOR_CBX) {

			CargaFiltro cargaFiltro = new CargaFiltro();

			cargaFiltro.setUnlimited(true);

			cargaFiltro.setOrderBy(1);

			List<Carga> cargaLista = cargaService.find(cargaFiltro);

			cargaCBX = new ComboBoxEntity(itemBI, "carga", this.mode, cargaLista);

		} else {

			cargaSBX = new SelectorBox(itemBI, "carga") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					CargaService service = AppCX.services().buildCargaService();

					return service.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					CargaFiltro filtro = new CargaFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return AppCX.widgets().buildWLCarga(filtro);

				}

			};

		}

		CiudadService ciudadService = AppCX.services().buildCiudadService();

		long ciudadItems = ciudadService.count();

		if (ciudadItems < MAX_ROWS_FOR_CBX) {

			CiudadFiltro ciudadFiltro = new CiudadFiltro();

			ciudadFiltro.setUnlimited(true);

			ciudadFiltro.setOrderBy(1);

			List<Ciudad> ciudadLista = ciudadService.find(ciudadFiltro);

			ciudadCBX = new ComboBoxEntity(itemBI, "ciudad", this.mode, ciudadLista);

		} else {

			ciudadSBX = new SelectorBox(itemBI, "ciudad") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					CiudadService service = AppCX.services().buildCiudadService();

					return service.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					CiudadFiltro filtro = new CiudadFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return AppCX.widgets().buildWLCiudad(filtro);

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
		
		
		((TransporteTarifa) item).setNumero(getService().nextValueNumero());

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
			
			getService().insert(getItemBIC().getBean());
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


			getService().update(getItemBIC().getBean());
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
			TransporteTarifa item = getService().findById(id);
			getItemBIC().setBean(item);

			return item;

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

		return (EntityId) getItemBIC().getBean();
	}

	// =================================================================================

}