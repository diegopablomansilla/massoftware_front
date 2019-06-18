
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
import com.massoftware.model.contabilidad.AsientoContable;
import com.massoftware.service.contabilidad.AsientoContableFiltro;
import com.massoftware.service.contabilidad.AsientoContableService;
import com.massoftware.model.contabilidad.CuentaContable;
import com.massoftware.service.contabilidad.CuentaContableFiltro;
import com.massoftware.service.contabilidad.CuentaContableService;

import com.massoftware.model.contabilidad.AsientoContableItem;
import com.massoftware.service.contabilidad.AsientoContableItemService;

@SuppressWarnings("serial")
public class WFAsientoContableItem extends WindowForm {


	// -------------------------------------------------------------

	protected BeanItem<AsientoContableItem> itemBI;
	
	private AsientoContableItemService service;

	// -------------------------------------------------------------

	
	protected TextFieldEntity numeroTXT;
	protected DateFieldEntity fechaDAF;
	protected TextFieldEntity detalleTXT;
	protected ComboBoxEntity asientoContableCBX;
	protected SelectorBox asientoContableSBX;
	protected ComboBoxEntity cuentaContableCBX;
	protected SelectorBox cuentaContableSBX;
	protected TextFieldEntity debeTXT;
	protected TextFieldEntity haberTXT;


	// -------------------------------------------------------------

	public WFAsientoContableItem(String mode, String id) {
		super(mode, id);					
	}

	protected AsientoContableItemService getService() throws Exception {
		if(service == null){
			service = AppCX.services().buildAsientoContableItemService();
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

		AsientoContableService asientoContableService = AppCX.services().buildAsientoContableService();

		long asientoContableItems = asientoContableService.count();

		if (asientoContableItems < MAX_ROWS_FOR_CBX) {

			AsientoContableFiltro asientoContableFiltro = new AsientoContableFiltro();

			asientoContableFiltro.setUnlimited(true);

			asientoContableFiltro.setOrderBy(1);

			List<AsientoContable> asientoContableLista = asientoContableService.find(asientoContableFiltro);

			asientoContableCBX = new ComboBoxEntity(itemBI, "asientoContable", this.mode, asientoContableLista);

		} else {

			asientoContableSBX = new SelectorBox(itemBI, "asientoContable") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					AsientoContableService service = AppCX.services().buildAsientoContableService();

					return service.findByNumeroOrDetalle(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					AsientoContableFiltro filtro = new AsientoContableFiltro();

					if (filter) {

						filtro.setDetalle(getValue());

					}

					return AppCX.widgets().buildWLAsientoContable(filtro);

				}

			};

		}

		CuentaContableService cuentaContableService = AppCX.services().buildCuentaContableService();

		long cuentaContableItems = cuentaContableService.count();

		if (cuentaContableItems < MAX_ROWS_FOR_CBX) {

			CuentaContableFiltro cuentaContableFiltro = new CuentaContableFiltro();

			cuentaContableFiltro.setUnlimited(true);

			cuentaContableFiltro.setOrderBy(1);

			List<CuentaContable> cuentaContableLista = cuentaContableService.find(cuentaContableFiltro);

			cuentaContableCBX = new ComboBoxEntity(itemBI, "cuentaContable", this.mode, cuentaContableLista);

		} else {

			cuentaContableSBX = new SelectorBox(itemBI, "cuentaContable") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					CuentaContableService service = AppCX.services().buildCuentaContableService();

					return service.findByCodigoOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					CuentaContableFiltro filtro = new CuentaContableFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return AppCX.widgets().buildWLCuentaContable(filtro);

				}

			};

		}

		// ------------------------------------------------------------------

		debeTXT = new TextFieldEntity(itemBI, "debe", this.mode);

		// ------------------------------------------------------------------

		haberTXT = new TextFieldEntity(itemBI, "haber", this.mode);

		
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
		if (asientoContableCBX != null) {
			generalVL.addComponent(asientoContableCBX);
		}
		if (asientoContableSBX != null) {
			generalVL.addComponent(asientoContableSBX);
		}
		if (cuentaContableCBX != null) {
			generalVL.addComponent(cuentaContableCBX);
		}
		if (cuentaContableSBX != null) {
			generalVL.addComponent(cuentaContableSBX);
		}
		generalVL.addComponent(debeTXT);
		generalVL.addComponent(haberTXT);

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
		
		
		((AsientoContableItem) item).setNumero(getService().nextValueNumero());

	}

	protected void setBean(EntityId obj) throws Exception {

		// se utiliza para asignarle o cambiar el bean al contenedor del formulario

		itemBI.setBean((AsientoContableItem) obj);
	}

	protected BeanItem<AsientoContableItem> getItemBIC() throws Exception {

		// -----------------------------------------------------------------
		// Crea el Container del form, en base a al bean que queremos usar, y ademas
		// carga el form con un bean vacio
		// como este metodo se llama muchas veces, inicializar el contenedor una sola
		// vez

		if (itemBI == null) {
			itemBI = new BeanItem<AsientoContableItem>(new AsientoContableItem());
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
			AsientoContableItem item = getService().findById(id);
			getItemBIC().setBean(item);

			return item;

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

		return (EntityId) getItemBIC().getBean();
	}

	// =================================================================================

}