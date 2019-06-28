
package com.massoftware.x.fondos;

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
import com.massoftware.model.fondos.Ticket;
import com.massoftware.service.fondos.TicketFiltro;
import com.massoftware.service.fondos.TicketService;

import com.massoftware.model.fondos.TicketModelo;
import com.massoftware.service.fondos.TicketModeloService;

@SuppressWarnings("serial")
public class WFTicketModelo extends WindowForm {


	// -------------------------------------------------------------

	protected BeanItem<TicketModelo> itemBI;
	
	private TicketModeloService service;

	// -------------------------------------------------------------

	
	protected TextFieldEntity numeroTXT;
	protected TextFieldEntity nombreTXT;
	protected ComboBoxEntity ticketCBX;
	protected SelectorBox ticketSBX;
	protected TextFieldEntity pruebaLecturaTXT;
	protected CheckBoxEntity activoCHK;
	protected TextFieldEntity longitudLecturaTXT;
	protected TextFieldEntity identificacionPosicionTXT;
	protected TextFieldEntity identificacionTXT;
	protected TextFieldEntity importePosicionTXT;
	protected TextFieldEntity longitudTXT;
	protected TextFieldEntity cantidadDecimalesTXT;
	protected TextFieldEntity numeroPosicionTXT;
	protected TextFieldEntity numeroLongitudTXT;
	protected TextFieldEntity prefijoIdentificacionTXT;
	protected TextFieldEntity posicionPrefijoTXT;


	// -------------------------------------------------------------

	public WFTicketModelo(String mode, String id) {
		super(mode, id);					
	}

	protected TicketModeloService getService() throws Exception {
		if(service == null){
			service = AppCX.services().buildTicketModeloService();
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

		TicketService ticketService = AppCX.services().buildTicketService();

		long ticketItems = ticketService.count();

		if (ticketItems < MAX_ROWS_FOR_CBX) {

			TicketFiltro ticketFiltro = new TicketFiltro();

			ticketFiltro.setUnlimited(true);

			ticketFiltro.setOrderBy(1);

			List<Ticket> ticketLista = ticketService.find(ticketFiltro);

			ticketCBX = new ComboBoxEntity(itemBI, "ticket", this.mode, ticketLista);

		} else {

			ticketSBX = new SelectorBox(itemBI, "ticket") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					TicketService service = AppCX.services().buildTicketService();

					return service.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					TicketFiltro filtro = new TicketFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return AppCX.widgets().buildWLTicket(filtro);

				}

			};

		}

		// ------------------------------------------------------------------

		pruebaLecturaTXT = new TextFieldEntity(itemBI, "pruebaLectura", this.mode);

		// ------------------------------------------------------------------

		activoCHK = new CheckBoxEntity(itemBI, "activo");

		// ------------------------------------------------------------------

		longitudLecturaTXT = new TextFieldEntity(itemBI, "longitudLectura", this.mode);

		// ------------------------------------------------------------------

		identificacionPosicionTXT = new TextFieldEntity(itemBI, "identificacionPosicion", this.mode);

		// ------------------------------------------------------------------

		identificacionTXT = new TextFieldEntity(itemBI, "identificacion", this.mode);

		// ------------------------------------------------------------------

		importePosicionTXT = new TextFieldEntity(itemBI, "importePosicion", this.mode);

		// ------------------------------------------------------------------

		longitudTXT = new TextFieldEntity(itemBI, "longitud", this.mode);

		// ------------------------------------------------------------------

		cantidadDecimalesTXT = new TextFieldEntity(itemBI, "cantidadDecimales", this.mode);

		// ------------------------------------------------------------------

		numeroPosicionTXT = new TextFieldEntity(itemBI, "numeroPosicion", this.mode);

		// ------------------------------------------------------------------

		numeroLongitudTXT = new TextFieldEntity(itemBI, "numeroLongitud", this.mode);

		// ------------------------------------------------------------------

		prefijoIdentificacionTXT = new TextFieldEntity(itemBI, "prefijoIdentificacion", this.mode);

		// ------------------------------------------------------------------

		posicionPrefijoTXT = new TextFieldEntity(itemBI, "posicionPrefijo", this.mode);

		
		// ---------------------------------------------------------------------------------------------------------

		return buildCuerpoLayout();

		// ---------------------------------------------------------------------------------------------------------
	}
	
	protected Component buildCuerpoLayout() throws Exception {		

		VerticalLayout generalVL = UtilUI.buildVL();

		// ------------------------------------------------------------------		
		
		
		generalVL.addComponent(numeroTXT);
		generalVL.addComponent(nombreTXT);
		if (ticketCBX != null) {
			generalVL.addComponent(ticketCBX);
		}
		if (ticketSBX != null) {
			generalVL.addComponent(ticketSBX);
		}
		generalVL.addComponent(pruebaLecturaTXT);
		generalVL.addComponent(activoCHK);
		generalVL.addComponent(longitudLecturaTXT);
		generalVL.addComponent(identificacionPosicionTXT);
		generalVL.addComponent(identificacionTXT);
		generalVL.addComponent(importePosicionTXT);
		generalVL.addComponent(longitudTXT);
		generalVL.addComponent(cantidadDecimalesTXT);
		generalVL.addComponent(numeroPosicionTXT);
		generalVL.addComponent(numeroLongitudTXT);
		generalVL.addComponent(prefijoIdentificacionTXT);
		generalVL.addComponent(posicionPrefijoTXT);

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
		
		
		((TicketModelo) item).setNumero(getService().nextValueNumero());

	}

	protected void setBean(EntityId obj) throws Exception {

		// se utiliza para asignarle o cambiar el bean al contenedor del formulario

		itemBI.setBean((TicketModelo) obj);
	}

	protected BeanItem<TicketModelo> getItemBIC() throws Exception {

		// -----------------------------------------------------------------
		// Crea el Container del form, en base a al bean que queremos usar, y ademas
		// carga el form con un bean vacio
		// como este metodo se llama muchas veces, inicializar el contenedor una sola
		// vez

		if (itemBI == null) {
			itemBI = new BeanItem<TicketModelo>(new TicketModelo());
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
			TicketModelo item = getService().findById(id);
			getItemBIC().setBean(item);

			return item;

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

		return (EntityId) getItemBIC().getBean();
	}

	// =================================================================================

}