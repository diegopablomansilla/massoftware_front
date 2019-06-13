
package com.massoftware.x.contabilidad;

import com.vaadin.data.util.BeanItem;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.Component;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.VerticalLayout;

import com.massoftware.windows.*;

import com.massoftware.AppCX;

import com.massoftware.model.EntityId;


import java.util.List;
import com.massoftware.model.contabilidad.EjercicioContable;
import com.massoftware.service.contabilidad.EjercicioContableFiltro;
import com.massoftware.service.contabilidad.EjercicioContableService;
import com.massoftware.model.contabilidad.CuentaContableEstado;
import com.massoftware.service.contabilidad.CuentaContableEstadoFiltro;
import com.massoftware.service.contabilidad.CuentaContableEstadoService;
import com.massoftware.model.contabilidad.CentroCostoContable;
import com.massoftware.service.contabilidad.CentroCostoContableFiltro;
import com.massoftware.service.contabilidad.CentroCostoContableService;
import com.massoftware.model.contabilidad.PuntoEquilibrio;
import com.massoftware.service.contabilidad.PuntoEquilibrioFiltro;
import com.massoftware.service.contabilidad.PuntoEquilibrioService;
import com.massoftware.model.contabilidad.CostoVenta;
import com.massoftware.service.contabilidad.CostoVentaFiltro;
import com.massoftware.service.contabilidad.CostoVentaService;
import com.massoftware.model.seguridad.SeguridadPuerta;
import com.massoftware.service.seguridad.SeguridadPuertaFiltro;
import com.massoftware.service.seguridad.SeguridadPuertaService;

import com.massoftware.model.contabilidad.CuentaContable;
import com.massoftware.service.contabilidad.CuentaContableService;

@SuppressWarnings("serial")
public class WFCuentaContable extends WindowForm {


	// -------------------------------------------------------------

	protected BeanItem<CuentaContable> itemBI;
	
	private CuentaContableService service;

	// -------------------------------------------------------------

	
	protected TextFieldEntity codigoTXT;
	protected TextFieldEntity nombreTXT;
	protected ComboBoxEntity ejercicioContableCBX;
	protected SelectorBox ejercicioContableSBX;
	protected TextFieldEntity integraTXT;
	protected TextFieldEntity cuentaJerarquiaTXT;
	protected CheckBoxEntity imputableCHK;
	protected CheckBoxEntity ajustaPorInflacionCHK;
	protected ComboBoxEntity cuentaContableEstadoCBX;
	protected SelectorBox cuentaContableEstadoSBX;
	protected CheckBoxEntity cuentaConApropiacionCHK;
	protected ComboBoxEntity centroCostoContableCBX;
	protected SelectorBox centroCostoContableSBX;
	protected TextFieldEntity cuentaAgrupadoraTXT;
	protected TextFieldEntity porcentajeTXT;
	protected ComboBoxEntity puntoEquilibrioCBX;
	protected SelectorBox puntoEquilibrioSBX;
	protected ComboBoxEntity costoVentaCBX;
	protected SelectorBox costoVentaSBX;
	protected ComboBoxEntity seguridadPuertaCBX;
	protected SelectorBox seguridadPuertaSBX;


	// -------------------------------------------------------------

	public WFCuentaContable(String mode, String id) {
		super(mode, id);					
	}

	protected CuentaContableService getService() throws Exception {
		if(service == null){
			service = AppCX.services().buildCuentaContableService();
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

		codigoTXT = new TextFieldEntity(itemBI, "codigo", this.mode) {
			protected boolean ifExists(Object arg) throws Exception {
				return getService().isExistsCodigo((String)arg);
			}
		};

		codigoTXT.focus();

		// ------------------------------------------------------------------

		nombreTXT = new TextFieldEntity(itemBI, "nombre", this.mode) {
			protected boolean ifExists(Object arg) throws Exception {
				return getService().isExistsNombre((String)arg);
			}
		};

		EjercicioContableService ejercicioContableService = AppCX.services().buildEjercicioContableService();

		long ejercicioContableItems = ejercicioContableService.count();

		if (ejercicioContableItems < MAX_ROWS_FOR_CBX) {

			EjercicioContableFiltro ejercicioContableFiltro = new EjercicioContableFiltro();

			ejercicioContableFiltro.setUnlimited(true);

			ejercicioContableFiltro.setOrderBy(1);

			List<EjercicioContable> ejercicioContableLista = ejercicioContableService.find(ejercicioContableFiltro);

			ejercicioContableCBX = new ComboBoxEntity(itemBI, "ejercicioContable", this.mode, ejercicioContableLista);

		} else {

			ejercicioContableSBX = new SelectorBox(itemBI, "ejercicioContable") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					EjercicioContableService service = AppCX.services().buildEjercicioContableService();

					return service.findByNumero(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					EjercicioContableFiltro filtro = new EjercicioContableFiltro();

					if (filter) {

					}

					return AppCX.widgets().buildWLEjercicioContable(filtro);

				}

			};

		}

		// ------------------------------------------------------------------

		integraTXT = new TextFieldEntity(itemBI, "integra", this.mode);

		// ------------------------------------------------------------------

		cuentaJerarquiaTXT = new TextFieldEntity(itemBI, "cuentaJerarquia", this.mode);

		// ------------------------------------------------------------------

		imputableCHK = new CheckBoxEntity(itemBI, "imputable");

		// ------------------------------------------------------------------

		ajustaPorInflacionCHK = new CheckBoxEntity(itemBI, "ajustaPorInflacion");

		CuentaContableEstadoService cuentaContableEstadoService = AppCX.services().buildCuentaContableEstadoService();

		long cuentaContableEstadoItems = cuentaContableEstadoService.count();

		if (cuentaContableEstadoItems < MAX_ROWS_FOR_CBX) {

			CuentaContableEstadoFiltro cuentaContableEstadoFiltro = new CuentaContableEstadoFiltro();

			cuentaContableEstadoFiltro.setUnlimited(true);

			cuentaContableEstadoFiltro.setOrderBy(1);

			List<CuentaContableEstado> cuentaContableEstadoLista = cuentaContableEstadoService.find(cuentaContableEstadoFiltro);

			cuentaContableEstadoCBX = new ComboBoxEntity(itemBI, "cuentaContableEstado", this.mode, cuentaContableEstadoLista);

		} else {

			cuentaContableEstadoSBX = new SelectorBox(itemBI, "cuentaContableEstado") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					CuentaContableEstadoService service = AppCX.services().buildCuentaContableEstadoService();

					return service.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					CuentaContableEstadoFiltro filtro = new CuentaContableEstadoFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return AppCX.widgets().buildWLCuentaContableEstado(filtro);

				}

			};

		}

		// ------------------------------------------------------------------

		cuentaConApropiacionCHK = new CheckBoxEntity(itemBI, "cuentaConApropiacion");

		CentroCostoContableService centroCostoContableService = AppCX.services().buildCentroCostoContableService();

		long centroCostoContableItems = centroCostoContableService.count();

		if (centroCostoContableItems < MAX_ROWS_FOR_CBX) {

			CentroCostoContableFiltro centroCostoContableFiltro = new CentroCostoContableFiltro();

			centroCostoContableFiltro.setUnlimited(true);

			centroCostoContableFiltro.setOrderBy(1);

			List<CentroCostoContable> centroCostoContableLista = centroCostoContableService.find(centroCostoContableFiltro);

			centroCostoContableCBX = new ComboBoxEntity(itemBI, "centroCostoContable", this.mode, centroCostoContableLista);

		} else {

			centroCostoContableSBX = new SelectorBox(itemBI, "centroCostoContable") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					CentroCostoContableService service = AppCX.services().buildCentroCostoContableService();

					return service.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					CentroCostoContableFiltro filtro = new CentroCostoContableFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return AppCX.widgets().buildWLCentroCostoContable(filtro);

				}

			};

		}

		// ------------------------------------------------------------------

		cuentaAgrupadoraTXT = new TextFieldEntity(itemBI, "cuentaAgrupadora", this.mode);

		// ------------------------------------------------------------------

		porcentajeTXT = new TextFieldEntity(itemBI, "porcentaje", this.mode);

		PuntoEquilibrioService puntoEquilibrioService = AppCX.services().buildPuntoEquilibrioService();

		long puntoEquilibrioItems = puntoEquilibrioService.count();

		if (puntoEquilibrioItems < MAX_ROWS_FOR_CBX) {

			PuntoEquilibrioFiltro puntoEquilibrioFiltro = new PuntoEquilibrioFiltro();

			puntoEquilibrioFiltro.setUnlimited(true);

			puntoEquilibrioFiltro.setOrderBy(1);

			List<PuntoEquilibrio> puntoEquilibrioLista = puntoEquilibrioService.find(puntoEquilibrioFiltro);

			puntoEquilibrioCBX = new ComboBoxEntity(itemBI, "puntoEquilibrio", this.mode, puntoEquilibrioLista);

		} else {

			puntoEquilibrioSBX = new SelectorBox(itemBI, "puntoEquilibrio") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					PuntoEquilibrioService service = AppCX.services().buildPuntoEquilibrioService();

					return service.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					PuntoEquilibrioFiltro filtro = new PuntoEquilibrioFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return AppCX.widgets().buildWLPuntoEquilibrio(filtro);

				}

			};

		}

		CostoVentaService costoVentaService = AppCX.services().buildCostoVentaService();

		long costoVentaItems = costoVentaService.count();

		if (costoVentaItems < MAX_ROWS_FOR_CBX) {

			CostoVentaFiltro costoVentaFiltro = new CostoVentaFiltro();

			costoVentaFiltro.setUnlimited(true);

			costoVentaFiltro.setOrderBy(1);

			List<CostoVenta> costoVentaLista = costoVentaService.find(costoVentaFiltro);

			costoVentaCBX = new ComboBoxEntity(itemBI, "costoVenta", this.mode, costoVentaLista);

		} else {

			costoVentaSBX = new SelectorBox(itemBI, "costoVenta") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					CostoVentaService service = AppCX.services().buildCostoVentaService();

					return service.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					CostoVentaFiltro filtro = new CostoVentaFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return AppCX.widgets().buildWLCostoVenta(filtro);

				}

			};

		}

		SeguridadPuertaService seguridadPuertaService = AppCX.services().buildSeguridadPuertaService();

		long seguridadPuertaItems = seguridadPuertaService.count();

		if (seguridadPuertaItems < MAX_ROWS_FOR_CBX) {

			SeguridadPuertaFiltro seguridadPuertaFiltro = new SeguridadPuertaFiltro();

			seguridadPuertaFiltro.setUnlimited(true);

			seguridadPuertaFiltro.setOrderBy(1);

			List<SeguridadPuerta> seguridadPuertaLista = seguridadPuertaService.find(seguridadPuertaFiltro);

			seguridadPuertaCBX = new ComboBoxEntity(itemBI, "seguridadPuerta", this.mode, seguridadPuertaLista);

		} else {

			seguridadPuertaSBX = new SelectorBox(itemBI, "seguridadPuerta") {

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
		
		
		generalVL.addComponent(codigoTXT);
		generalVL.addComponent(nombreTXT);
		if (ejercicioContableCBX != null) {
			generalVL.addComponent(ejercicioContableCBX);
		}
		if (ejercicioContableSBX != null) {
			generalVL.addComponent(ejercicioContableSBX);
		}
		generalVL.addComponent(integraTXT);
		generalVL.addComponent(cuentaJerarquiaTXT);
		generalVL.addComponent(imputableCHK);
		generalVL.addComponent(ajustaPorInflacionCHK);
		if (cuentaContableEstadoCBX != null) {
			generalVL.addComponent(cuentaContableEstadoCBX);
		}
		if (cuentaContableEstadoSBX != null) {
			generalVL.addComponent(cuentaContableEstadoSBX);
		}
		generalVL.addComponent(cuentaConApropiacionCHK);
		if (centroCostoContableCBX != null) {
			generalVL.addComponent(centroCostoContableCBX);
		}
		if (centroCostoContableSBX != null) {
			generalVL.addComponent(centroCostoContableSBX);
		}
		generalVL.addComponent(cuentaAgrupadoraTXT);
		generalVL.addComponent(porcentajeTXT);
		if (puntoEquilibrioCBX != null) {
			generalVL.addComponent(puntoEquilibrioCBX);
		}
		if (puntoEquilibrioSBX != null) {
			generalVL.addComponent(puntoEquilibrioSBX);
		}
		if (costoVentaCBX != null) {
			generalVL.addComponent(costoVentaCBX);
		}
		if (costoVentaSBX != null) {
			generalVL.addComponent(costoVentaSBX);
		}
		if (seguridadPuertaCBX != null) {
			generalVL.addComponent(seguridadPuertaCBX);
		}
		if (seguridadPuertaSBX != null) {
			generalVL.addComponent(seguridadPuertaSBX);
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

		itemBI.setBean((CuentaContable) obj);
	}

	protected BeanItem<CuentaContable> getItemBIC() throws Exception {

		// -----------------------------------------------------------------
		// Crea el Container del form, en base a al bean que queremos usar, y ademas
		// carga el form con un bean vacio
		// como este metodo se llama muchas veces, inicializar el contenedor una sola
		// vez

		if (itemBI == null) {
			itemBI = new BeanItem<CuentaContable>(new CuentaContable());
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
			CuentaContable item = getService().findById(id);
			getItemBIC().setBean(item);

			return item;

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

		return (EntityId) getItemBIC().getBean();
	}

	// =================================================================================

}