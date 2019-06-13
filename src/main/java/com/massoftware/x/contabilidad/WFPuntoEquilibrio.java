
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
import com.massoftware.model.contabilidad.TipoPuntoEquilibrio;
import com.massoftware.service.contabilidad.TipoPuntoEquilibrioFiltro;
import com.massoftware.service.contabilidad.TipoPuntoEquilibrioService;
import com.massoftware.model.contabilidad.EjercicioContable;
import com.massoftware.service.contabilidad.EjercicioContableFiltro;
import com.massoftware.service.contabilidad.EjercicioContableService;

import com.massoftware.model.contabilidad.PuntoEquilibrio;
import com.massoftware.service.contabilidad.PuntoEquilibrioService;

@SuppressWarnings("serial")
public class WFPuntoEquilibrio extends WindowForm {


	// -------------------------------------------------------------

	protected BeanItem<PuntoEquilibrio> itemBI;
	
	private PuntoEquilibrioService service;

	// -------------------------------------------------------------

	
	protected TextFieldEntity numeroTXT;
	protected TextFieldEntity nombreTXT;
	protected ComboBoxEntity tipoPuntoEquilibrioCBX;
	protected SelectorBox tipoPuntoEquilibrioSBX;
	protected ComboBoxEntity ejercicioContableCBX;
	protected SelectorBox ejercicioContableSBX;


	// -------------------------------------------------------------

	public WFPuntoEquilibrio(String mode, String id) {
		super(mode, id);					
	}

	protected PuntoEquilibrioService getService() throws Exception {
		if(service == null){
			service = AppCX.services().buildPuntoEquilibrioService();
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

		TipoPuntoEquilibrioService tipoPuntoEquilibrioService = AppCX.services().buildTipoPuntoEquilibrioService();

		long tipoPuntoEquilibrioItems = tipoPuntoEquilibrioService.count();

		if (tipoPuntoEquilibrioItems < MAX_ROWS_FOR_CBX) {

			TipoPuntoEquilibrioFiltro tipoPuntoEquilibrioFiltro = new TipoPuntoEquilibrioFiltro();

			tipoPuntoEquilibrioFiltro.setUnlimited(true);

			tipoPuntoEquilibrioFiltro.setOrderBy(1);

			List<TipoPuntoEquilibrio> tipoPuntoEquilibrioLista = tipoPuntoEquilibrioService.find(tipoPuntoEquilibrioFiltro);

			tipoPuntoEquilibrioCBX = new ComboBoxEntity(itemBI, "tipoPuntoEquilibrio", this.mode, tipoPuntoEquilibrioLista);

		} else {

			tipoPuntoEquilibrioSBX = new SelectorBox(itemBI, "tipoPuntoEquilibrio") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					TipoPuntoEquilibrioService service = AppCX.services().buildTipoPuntoEquilibrioService();

					return service.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					TipoPuntoEquilibrioFiltro filtro = new TipoPuntoEquilibrioFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return AppCX.widgets().buildWLTipoPuntoEquilibrio(filtro);

				}

			};

		}

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

		
		// ---------------------------------------------------------------------------------------------------------

		return buildCuerpoLayout();

		// ---------------------------------------------------------------------------------------------------------
	}
	
	protected Component buildCuerpoLayout() throws Exception {		

		VerticalLayout generalVL = UtilUI.buildVL();

		// ------------------------------------------------------------------		
		
		
		generalVL.addComponent(numeroTXT);
		generalVL.addComponent(nombreTXT);
		if (tipoPuntoEquilibrioCBX != null) {
			generalVL.addComponent(tipoPuntoEquilibrioCBX);
		}
		if (tipoPuntoEquilibrioSBX != null) {
			generalVL.addComponent(tipoPuntoEquilibrioSBX);
		}
		if (ejercicioContableCBX != null) {
			generalVL.addComponent(ejercicioContableCBX);
		}
		if (ejercicioContableSBX != null) {
			generalVL.addComponent(ejercicioContableSBX);
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
		
		
		((PuntoEquilibrio) item).setNumero(getService().nextValueNumero());

	}

	protected void setBean(EntityId obj) throws Exception {

		// se utiliza para asignarle o cambiar el bean al contenedor del formulario

		itemBI.setBean((PuntoEquilibrio) obj);
	}

	protected BeanItem<PuntoEquilibrio> getItemBIC() throws Exception {

		// -----------------------------------------------------------------
		// Crea el Container del form, en base a al bean que queremos usar, y ademas
		// carga el form con un bean vacio
		// como este metodo se llama muchas veces, inicializar el contenedor una sola
		// vez

		if (itemBI == null) {
			itemBI = new BeanItem<PuntoEquilibrio>(new PuntoEquilibrio());
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
			PuntoEquilibrio item = getService().findById(id);
			getItemBIC().setBean(item);

			return item;

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

		return (EntityId) getItemBIC().getBean();
	}

	// =================================================================================

}