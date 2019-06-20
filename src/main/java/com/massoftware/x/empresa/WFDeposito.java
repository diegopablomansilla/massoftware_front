
package com.massoftware.x.empresa;

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
import com.massoftware.model.empresa.Sucursal;
import com.massoftware.service.empresa.SucursalFiltro;
import com.massoftware.service.empresa.SucursalService;
import com.massoftware.model.empresa.DepositoModulo;
import com.massoftware.service.empresa.DepositoModuloFiltro;
import com.massoftware.service.empresa.DepositoModuloService;
import com.massoftware.model.seguridad.SeguridadPuerta;
import com.massoftware.service.seguridad.SeguridadPuertaFiltro;
import com.massoftware.service.seguridad.SeguridadPuertaService;
import com.massoftware.model.seguridad.SeguridadPuerta;
import com.massoftware.service.seguridad.SeguridadPuertaFiltro;
import com.massoftware.service.seguridad.SeguridadPuertaService;

import com.massoftware.model.empresa.Deposito;
import com.massoftware.service.empresa.DepositoService;

@SuppressWarnings("serial")
public class WFDeposito extends WindowForm {


	// -------------------------------------------------------------

	protected BeanItem<Deposito> itemBI;
	
	private DepositoService service;

	// -------------------------------------------------------------

	
	protected TextFieldEntity numeroTXT;
	protected TextFieldEntity nombreTXT;
	protected TextFieldEntity abreviaturaTXT;
	protected ComboBoxEntity sucursalCBX;
	protected SelectorBox sucursalSBX;
	protected ComboBoxEntity depositoModuloCBX;
	protected SelectorBox depositoModuloSBX;
	protected ComboBoxEntity puertaOperativoCBX;
	protected SelectorBox puertaOperativoSBX;
	protected ComboBoxEntity puertaConsultaCBX;
	protected SelectorBox puertaConsultaSBX;


	// -------------------------------------------------------------

	public WFDeposito(String mode, String id) {
		super(mode, id);					
	}

	protected DepositoService getService() throws Exception {
		if(service == null){
			service = AppCX.services().buildDepositoService();
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

		abreviaturaTXT = new TextFieldEntity(itemBI, "abreviatura", this.mode) {
			protected boolean ifExists(Object arg) throws Exception {
				return getService().isExistsAbreviatura((String)arg);
			}
		};

		SucursalService sucursalService = AppCX.services().buildSucursalService();

		long sucursalItems = sucursalService.count();

		if (sucursalItems < MAX_ROWS_FOR_CBX) {

			SucursalFiltro sucursalFiltro = new SucursalFiltro();

			sucursalFiltro.setUnlimited(true);

			sucursalFiltro.setOrderBy(1);

			List<Sucursal> sucursalLista = sucursalService.find(sucursalFiltro);

			sucursalCBX = new ComboBoxEntity(itemBI, "sucursal", this.mode, sucursalLista);

		} else {

			sucursalSBX = new SelectorBox(itemBI, "sucursal") {

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

					return AppCX.widgets().buildWLSucursal(filtro);

				}

			};

		}

		DepositoModuloService depositoModuloService = AppCX.services().buildDepositoModuloService();

		long depositoModuloItems = depositoModuloService.count();

		if (depositoModuloItems < MAX_ROWS_FOR_CBX) {

			DepositoModuloFiltro depositoModuloFiltro = new DepositoModuloFiltro();

			depositoModuloFiltro.setUnlimited(true);

			depositoModuloFiltro.setOrderBy(1);

			List<DepositoModulo> depositoModuloLista = depositoModuloService.find(depositoModuloFiltro);

			depositoModuloCBX = new ComboBoxEntity(itemBI, "depositoModulo", this.mode, depositoModuloLista);

		} else {

			depositoModuloSBX = new SelectorBox(itemBI, "depositoModulo") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					DepositoModuloService service = AppCX.services().buildDepositoModuloService();

					return service.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					DepositoModuloFiltro filtro = new DepositoModuloFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return AppCX.widgets().buildWLDepositoModulo(filtro);

				}

			};

		}

		SeguridadPuertaService puertaOperativoService = AppCX.services().buildSeguridadPuertaService();

		long puertaOperativoItems = puertaOperativoService.count();

		if (puertaOperativoItems < MAX_ROWS_FOR_CBX) {

			SeguridadPuertaFiltro puertaOperativoFiltro = new SeguridadPuertaFiltro();

			puertaOperativoFiltro.setUnlimited(true);

			puertaOperativoFiltro.setOrderBy(1);

			List<SeguridadPuerta> puertaOperativoLista = puertaOperativoService.find(puertaOperativoFiltro);

			puertaOperativoCBX = new ComboBoxEntity(itemBI, "puertaOperativo", this.mode, puertaOperativoLista);

		} else {

			puertaOperativoSBX = new SelectorBox(itemBI, "puertaOperativo") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					SeguridadPuertaService service = AppCX.services().buildSeguridadPuertaService();

					return service.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					SeguridadPuertaFiltro filtro = new SeguridadPuertaFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return AppCX.widgets().buildWLSeguridadPuerta(filtro);

				}

			};

		}

		SeguridadPuertaService puertaConsultaService = AppCX.services().buildSeguridadPuertaService();

		long puertaConsultaItems = puertaConsultaService.count();

		if (puertaConsultaItems < MAX_ROWS_FOR_CBX) {

			SeguridadPuertaFiltro puertaConsultaFiltro = new SeguridadPuertaFiltro();

			puertaConsultaFiltro.setUnlimited(true);

			puertaConsultaFiltro.setOrderBy(1);

			List<SeguridadPuerta> puertaConsultaLista = puertaConsultaService.find(puertaConsultaFiltro);

			puertaConsultaCBX = new ComboBoxEntity(itemBI, "puertaConsulta", this.mode, puertaConsultaLista);

		} else {

			puertaConsultaSBX = new SelectorBox(itemBI, "puertaConsulta") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					SeguridadPuertaService service = AppCX.services().buildSeguridadPuertaService();

					return service.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					SeguridadPuertaFiltro filtro = new SeguridadPuertaFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return AppCX.widgets().buildWLSeguridadPuerta(filtro);

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
		generalVL.addComponent(abreviaturaTXT);
		if (sucursalCBX != null) {
			generalVL.addComponent(sucursalCBX);
		}
		if (sucursalSBX != null) {
			generalVL.addComponent(sucursalSBX);
		}
		if (depositoModuloCBX != null) {
			generalVL.addComponent(depositoModuloCBX);
		}
		if (depositoModuloSBX != null) {
			generalVL.addComponent(depositoModuloSBX);
		}
		if (puertaOperativoCBX != null) {
			generalVL.addComponent(puertaOperativoCBX);
		}
		if (puertaOperativoSBX != null) {
			generalVL.addComponent(puertaOperativoSBX);
		}
		if (puertaConsultaCBX != null) {
			generalVL.addComponent(puertaConsultaCBX);
		}
		if (puertaConsultaSBX != null) {
			generalVL.addComponent(puertaConsultaSBX);
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
		
		
		((Deposito) item).setNumero(getService().nextValueNumero());

	}

	protected void setBean(EntityId obj) throws Exception {

		// se utiliza para asignarle o cambiar el bean al contenedor del formulario

		itemBI.setBean((Deposito) obj);
	}

	protected BeanItem<Deposito> getItemBIC() throws Exception {

		// -----------------------------------------------------------------
		// Crea el Container del form, en base a al bean que queremos usar, y ademas
		// carga el form con un bean vacio
		// como este metodo se llama muchas veces, inicializar el contenedor una sola
		// vez

		if (itemBI == null) {
			itemBI = new BeanItem<Deposito>(new Deposito());
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
			Deposito item = getService().findById(id);
			getItemBIC().setBean(item);

			return item;

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

		return (EntityId) getItemBIC().getBean();
	}

	// =================================================================================

}