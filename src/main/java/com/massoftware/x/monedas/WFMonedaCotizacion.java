
package com.massoftware.x.monedas;

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
import com.massoftware.model.monedas.Moneda;
import com.massoftware.service.monedas.MonedaFiltro;
import com.massoftware.service.monedas.MonedaService;
import com.massoftware.model.seguridad.Usuario;
import com.massoftware.service.seguridad.UsuarioFiltro;
import com.massoftware.service.seguridad.UsuarioService;

import com.massoftware.model.monedas.MonedaCotizacion;
import com.massoftware.service.monedas.MonedaCotizacionService;

@SuppressWarnings("serial")
public class WFMonedaCotizacion extends WindowForm {


	// -------------------------------------------------------------

	protected BeanItem<MonedaCotizacion> itemBI;
	
	private MonedaCotizacionService service;

	// -------------------------------------------------------------

	
	protected DateFieldEntity cotizacionFechaDAF;
	protected TextFieldEntity compraTXT;
	protected TextFieldEntity ventaTXT;
	protected DateFieldEntity cotizacionFechaAuditoriaDAF;
	protected ComboBoxEntity monedaCBX;
	protected SelectorBox monedaSBX;
	protected ComboBoxEntity usuarioCBX;
	protected SelectorBox usuarioSBX;


	// -------------------------------------------------------------

	public WFMonedaCotizacion(String mode, String id) {
		super(mode, id);					
	}

	protected MonedaCotizacionService getService() throws Exception {
		if(service == null){
			service = AppCX.services().buildMonedaCotizacionService();
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

		cotizacionFechaDAF = new DateFieldEntity(itemBI, "cotizacionFecha", this.mode, true);

		cotizacionFechaDAF.focus();

		// ------------------------------------------------------------------

		compraTXT = new TextFieldEntity(itemBI, "compra", this.mode);

		// ------------------------------------------------------------------

		ventaTXT = new TextFieldEntity(itemBI, "venta", this.mode);

		// ------------------------------------------------------------------

		cotizacionFechaAuditoriaDAF = new DateFieldEntity(itemBI, "cotizacionFechaAuditoria", this.mode, true);

		MonedaService monedaService = AppCX.services().buildMonedaService();

		long monedaItems = monedaService.count();

		if (monedaItems < MAX_ROWS_FOR_CBX) {

			MonedaFiltro monedaFiltro = new MonedaFiltro();

			monedaFiltro.setUnlimited(true);

			monedaFiltro.setOrderBy(1);

			List<Moneda> monedaLista = monedaService.find(monedaFiltro);

			monedaCBX = new ComboBoxEntity(itemBI, "moneda", this.mode, monedaLista);

		} else {

			monedaSBX = new SelectorBox(itemBI, "moneda") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					MonedaService service = AppCX.services().buildMonedaService();

					return service.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					MonedaFiltro filtro = new MonedaFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return AppCX.widgets().buildWLMoneda(filtro);

				}

			};

		}

		UsuarioService usuarioService = AppCX.services().buildUsuarioService();

		long usuarioItems = usuarioService.count();

		if (usuarioItems < MAX_ROWS_FOR_CBX) {

			UsuarioFiltro usuarioFiltro = new UsuarioFiltro();

			usuarioFiltro.setUnlimited(true);

			usuarioFiltro.setOrderBy(1);

			List<Usuario> usuarioLista = usuarioService.find(usuarioFiltro);

			usuarioCBX = new ComboBoxEntity(itemBI, "usuario", this.mode, usuarioLista);

		} else {

			usuarioSBX = new SelectorBox(itemBI, "usuario") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					UsuarioService service = AppCX.services().buildUsuarioService();

					return service.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					UsuarioFiltro filtro = new UsuarioFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return AppCX.widgets().buildWLUsuario(filtro);

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
		
		
		generalVL.addComponent(cotizacionFechaDAF);
		generalVL.addComponent(compraTXT);
		generalVL.addComponent(ventaTXT);
		generalVL.addComponent(cotizacionFechaAuditoriaDAF);
		if (monedaCBX != null) {
			generalVL.addComponent(monedaCBX);
		}
		if (monedaSBX != null) {
			generalVL.addComponent(monedaSBX);
		}
		if (usuarioCBX != null) {
			generalVL.addComponent(usuarioCBX);
		}
		if (usuarioSBX != null) {
			generalVL.addComponent(usuarioSBX);
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
		
		

	}

	protected void setBean(EntityId obj) throws Exception {

		// se utiliza para asignarle o cambiar el bean al contenedor del formulario

		itemBI.setBean((MonedaCotizacion) obj);
	}

	protected BeanItem<MonedaCotizacion> getItemBIC() throws Exception {

		// -----------------------------------------------------------------
		// Crea el Container del form, en base a al bean que queremos usar, y ademas
		// carga el form con un bean vacio
		// como este metodo se llama muchas veces, inicializar el contenedor una sola
		// vez

		if (itemBI == null) {
			itemBI = new BeanItem<MonedaCotizacion>(new MonedaCotizacion());
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
			MonedaCotizacion item = getService().findById(id);
			getItemBIC().setBean(item);

			return item;

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

		return (EntityId) getItemBIC().getBean();
	}

	// =================================================================================

}