
package com.massoftware.x.seguridad;

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
import com.massoftware.model.seguridad.SeguridadModulo;
import com.massoftware.service.seguridad.SeguridadModuloFiltro;
import com.massoftware.service.seguridad.SeguridadModuloService;

import com.massoftware.model.seguridad.SeguridadPuerta;
import com.massoftware.service.seguridad.SeguridadPuertaService;

@SuppressWarnings("serial")
public class WFSeguridadPuerta extends WindowForm {


	// -------------------------------------------------------------

	protected BeanItem<SeguridadPuerta> itemBI;
	
	private SeguridadPuertaService service;

	// -------------------------------------------------------------

	
	protected TextFieldEntity numeroTXT;
	protected TextFieldEntity nombreTXT;
	protected TextFieldEntity equateTXT;
	protected ComboBoxEntity seguridadModuloCBX;
	protected SelectorBox seguridadModuloSBX;


	// -------------------------------------------------------------

	public WFSeguridadPuerta(String mode, String id) {
		super(mode, id);					
	}

	protected SeguridadPuertaService getService() throws Exception {
		if(service == null){
			service = AppCX.services().buildSeguridadPuertaService();
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

		numeroTXT = new TextFieldEntity(itemBI, "numero", this.mode) {
			protected boolean ifExists(Object arg) throws Exception {
				return getService().isExistsNumero((Integer)arg);
			}
		};

		numeroTXT.focus();

		// ------------------------------------------------------------------

		nombreTXT = new TextFieldEntity(itemBI, "nombre", this.mode) {
			protected boolean ifExists(Object arg) throws Exception {
				return getService().isExistsNombre((String)arg);
			}
		};

		// ------------------------------------------------------------------

		equateTXT = new TextFieldEntity(itemBI, "equate", this.mode);

		SeguridadModuloService seguridadModuloService = AppCX.services().buildSeguridadModuloService();

		long seguridadModuloItems = seguridadModuloService.count();

		if (seguridadModuloItems < MAX_ROWS_FOR_CBX) {

			SeguridadModuloFiltro seguridadModuloFiltro = new SeguridadModuloFiltro();

			seguridadModuloFiltro.setUnlimited(true);

			seguridadModuloFiltro.setOrderBy(1);

			List<SeguridadModulo> seguridadModuloLista = seguridadModuloService.find(seguridadModuloFiltro);

			seguridadModuloCBX = new ComboBoxEntity(itemBI, "seguridadModulo", this.mode, seguridadModuloLista);

		} else {

			seguridadModuloSBX = new SelectorBox(itemBI, "seguridadModulo") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					SeguridadModuloService service = AppCX.services().buildSeguridadModuloService();

					return service.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					SeguridadModuloFiltro filtro = new SeguridadModuloFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return AppCX.widgets().buildWLSeguridadModulo(filtro);

				}

			};

		}

		
		// ---------------------------------------------------------------------------------------------------------

		return buildCuerpoLayout();

		// ---------------------------------------------------------------------------------------------------------
	}
	
	protected Component buildCuerpoLayout() throws Exception {		

		VerticalLayout generalVL = UtilUI.buildVL();

		// ------------------------------------------------------------------		
		
		
		generalVL.addComponent(numeroTXT);
		generalVL.addComponent(nombreTXT);
		generalVL.addComponent(equateTXT);
		if (seguridadModuloCBX != null) {
			generalVL.addComponent(seguridadModuloCBX);
		}
		if (seguridadModuloSBX != null) {
			generalVL.addComponent(seguridadModuloSBX);
		}

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
		
		
		((SeguridadPuerta) item).setNumero(getService().nextValueNumero());

	}

	protected void setBean(EntityId obj) throws Exception {

		// se utiliza para asignarle o cambiar el bean al contenedor del formulario

		itemBI.setBean((SeguridadPuerta) obj);
	}

	protected BeanItem<SeguridadPuerta> getItemBIC() throws Exception {

		// -----------------------------------------------------------------
		// Crea el Container del form, en base a al bean que queremos usar, y ademas
		// carga el form con un bean vacio
		// como este metodo se llama muchas veces, inicializar el contenedor una sola
		// vez

		if (itemBI == null) {
			itemBI = new BeanItem<SeguridadPuerta>(new SeguridadPuerta());
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
			SeguridadPuerta item = getService().findById(id);
			getItemBIC().setBean(item);

			return item;

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

		return (EntityId) getItemBIC().getBean();
	}

	// =================================================================================

}