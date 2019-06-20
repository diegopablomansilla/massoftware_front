
package com.massoftware.x.clientes;

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
import com.massoftware.model.clientes.ClasificacionCliente;
import com.massoftware.service.clientes.ClasificacionClienteFiltro;
import com.massoftware.service.clientes.ClasificacionClienteService;

import com.massoftware.model.clientes.MotivoBloqueoCliente;
import com.massoftware.service.clientes.MotivoBloqueoClienteService;

@SuppressWarnings("serial")
public class WFMotivoBloqueoCliente extends WindowForm {


	// -------------------------------------------------------------

	protected BeanItem<MotivoBloqueoCliente> itemBI;
	
	private MotivoBloqueoClienteService service;

	// -------------------------------------------------------------

	
	protected TextFieldEntity numeroTXT;
	protected TextFieldEntity nombreTXT;
	protected ComboBoxEntity clasificacionClienteCBX;
	protected SelectorBox clasificacionClienteSBX;


	// -------------------------------------------------------------

	public WFMotivoBloqueoCliente(String mode, String id) {
		super(mode, id);					
	}

	protected MotivoBloqueoClienteService getService() throws Exception {
		if(service == null){
			service = AppCX.services().buildMotivoBloqueoClienteService();
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

		ClasificacionClienteService clasificacionClienteService = AppCX.services().buildClasificacionClienteService();

		long clasificacionClienteItems = clasificacionClienteService.count();

		if (clasificacionClienteItems < MAX_ROWS_FOR_CBX) {

			ClasificacionClienteFiltro clasificacionClienteFiltro = new ClasificacionClienteFiltro();

			clasificacionClienteFiltro.setUnlimited(true);

			clasificacionClienteFiltro.setOrderBy(1);

			List<ClasificacionCliente> clasificacionClienteLista = clasificacionClienteService.find(clasificacionClienteFiltro);

			clasificacionClienteCBX = new ComboBoxEntity(itemBI, "clasificacionCliente", this.mode, clasificacionClienteLista);

		} else {

			clasificacionClienteSBX = new SelectorBox(itemBI, "clasificacionCliente") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					ClasificacionClienteService service = AppCX.services().buildClasificacionClienteService();

					return service.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					ClasificacionClienteFiltro filtro = new ClasificacionClienteFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return AppCX.widgets().buildWLClasificacionCliente(filtro);

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
		if (clasificacionClienteCBX != null) {
			generalVL.addComponent(clasificacionClienteCBX);
		}
		if (clasificacionClienteSBX != null) {
			generalVL.addComponent(clasificacionClienteSBX);
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
		
		
		((MotivoBloqueoCliente) item).setNumero(getService().nextValueNumero());

	}

	protected void setBean(EntityId obj) throws Exception {

		// se utiliza para asignarle o cambiar el bean al contenedor del formulario

		itemBI.setBean((MotivoBloqueoCliente) obj);
	}

	protected BeanItem<MotivoBloqueoCliente> getItemBIC() throws Exception {

		// -----------------------------------------------------------------
		// Crea el Container del form, en base a al bean que queremos usar, y ademas
		// carga el form con un bean vacio
		// como este metodo se llama muchas veces, inicializar el contenedor una sola
		// vez

		if (itemBI == null) {
			itemBI = new BeanItem<MotivoBloqueoCliente>(new MotivoBloqueoCliente());
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
			MotivoBloqueoCliente item = getService().findById(id);
			getItemBIC().setBean(item);

			return item;

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

		return (EntityId) getItemBIC().getBean();
	}

	// =================================================================================

}