
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
import com.massoftware.model.contabilidad.MinutaContable;
import com.massoftware.service.contabilidad.MinutaContableFiltro;
import com.massoftware.service.contabilidad.MinutaContableService;
import com.massoftware.model.empresa.Sucursal;
import com.massoftware.service.empresa.SucursalFiltro;
import com.massoftware.service.empresa.SucursalService;
import com.massoftware.model.contabilidad.AsientoContableModulo;
import com.massoftware.service.contabilidad.AsientoContableModuloFiltro;
import com.massoftware.service.contabilidad.AsientoContableModuloService;

import com.massoftware.model.contabilidad.AsientoContable;
import com.massoftware.service.contabilidad.AsientoContableService;

@SuppressWarnings("serial")
public class WFAsientoContable extends WindowForm {


	// -------------------------------------------------------------

	protected BeanItem<AsientoContable> itemBI;
	
	private AsientoContableService service;

	// -------------------------------------------------------------

	
	protected TextFieldEntity numeroTXT;
	protected DateFieldEntity fechaDAF;
	protected TextFieldEntity detalleTXT;
	protected ComboBoxEntity ejercicioContableCBX;
	protected SelectorBox ejercicioContableSBX;
	protected ComboBoxEntity minutaContableCBX;
	protected SelectorBox minutaContableSBX;
	protected ComboBoxEntity sucursalCBX;
	protected SelectorBox sucursalSBX;
	protected ComboBoxEntity asientoContableModuloCBX;
	protected SelectorBox asientoContableModuloSBX;


	// -------------------------------------------------------------

	public WFAsientoContable(String mode, String id) {
		super(mode, id);					
	}

	protected AsientoContableService getService() throws Exception {
		if(service == null){
			service = AppCX.services().buildAsientoContableService();
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

		fechaDAF = new DateFieldEntity(itemBI, "fecha", this.mode, false);

		// ------------------------------------------------------------------

		detalleTXT = new TextFieldEntity(itemBI, "detalle", this.mode);

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

		MinutaContableService minutaContableService = AppCX.services().buildMinutaContableService();

		long minutaContableItems = minutaContableService.count();

		if (minutaContableItems < MAX_ROWS_FOR_CBX) {

			MinutaContableFiltro minutaContableFiltro = new MinutaContableFiltro();

			minutaContableFiltro.setUnlimited(true);

			minutaContableFiltro.setOrderBy(1);

			List<MinutaContable> minutaContableLista = minutaContableService.find(minutaContableFiltro);

			minutaContableCBX = new ComboBoxEntity(itemBI, "minutaContable", this.mode, minutaContableLista);

		} else {

			minutaContableSBX = new SelectorBox(itemBI, "minutaContable") {

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

					return AppCX.widgets().buildWLMinutaContable(filtro);

				}

			};

		}

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

		AsientoContableModuloService asientoContableModuloService = AppCX.services().buildAsientoContableModuloService();

		long asientoContableModuloItems = asientoContableModuloService.count();

		if (asientoContableModuloItems < MAX_ROWS_FOR_CBX) {

			AsientoContableModuloFiltro asientoContableModuloFiltro = new AsientoContableModuloFiltro();

			asientoContableModuloFiltro.setUnlimited(true);

			asientoContableModuloFiltro.setOrderBy(1);

			List<AsientoContableModulo> asientoContableModuloLista = asientoContableModuloService.find(asientoContableModuloFiltro);

			asientoContableModuloCBX = new ComboBoxEntity(itemBI, "asientoContableModulo", this.mode, asientoContableModuloLista);

		} else {

			asientoContableModuloSBX = new SelectorBox(itemBI, "asientoContableModulo") {

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

					return AppCX.widgets().buildWLAsientoContableModulo(filtro);

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
		generalVL.addComponent(fechaDAF);
		generalVL.addComponent(detalleTXT);
		if (ejercicioContableCBX != null) {
			generalVL.addComponent(ejercicioContableCBX);
		}
		if (ejercicioContableSBX != null) {
			generalVL.addComponent(ejercicioContableSBX);
		}
		if (minutaContableCBX != null) {
			generalVL.addComponent(minutaContableCBX);
		}
		if (minutaContableSBX != null) {
			generalVL.addComponent(minutaContableSBX);
		}
		if (sucursalCBX != null) {
			generalVL.addComponent(sucursalCBX);
		}
		if (sucursalSBX != null) {
			generalVL.addComponent(sucursalSBX);
		}
		if (asientoContableModuloCBX != null) {
			generalVL.addComponent(asientoContableModuloCBX);
		}
		if (asientoContableModuloSBX != null) {
			generalVL.addComponent(asientoContableModuloSBX);
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
		
		
		((AsientoContable) item).setNumero(getService().nextValueNumero());

	}

	protected void setBean(EntityId obj) throws Exception {

		// se utiliza para asignarle o cambiar el bean al contenedor del formulario

		itemBI.setBean((AsientoContable) obj);
	}

	protected BeanItem<AsientoContable> getItemBIC() throws Exception {

		// -----------------------------------------------------------------
		// Crea el Container del form, en base a al bean que queremos usar, y ademas
		// carga el form con un bean vacio
		// como este metodo se llama muchas veces, inicializar el contenedor una sola
		// vez

		if (itemBI == null) {
			itemBI = new BeanItem<AsientoContable>(new AsientoContable());
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
			AsientoContable item = getService().findById(id);
			getItemBIC().setBean(item);

			return item;

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

		return (EntityId) getItemBIC().getBean();
	}

	// =================================================================================

}