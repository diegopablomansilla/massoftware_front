
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
import com.massoftware.model.contabilidad.AsientoModelo;
import com.massoftware.service.contabilidad.AsientoModeloFiltro;
import com.massoftware.service.contabilidad.AsientoModeloService;
import com.massoftware.model.contabilidad.CuentaContable;
import com.massoftware.service.contabilidad.CuentaContableFiltro;
import com.massoftware.service.contabilidad.CuentaContableService;

import com.massoftware.model.contabilidad.AsientoModeloItem;
import com.massoftware.service.contabilidad.AsientoModeloItemService;

@SuppressWarnings("serial")
public class WFAsientoModeloItem extends WindowForm {


	// -------------------------------------------------------------

	protected BeanItem<AsientoModeloItem> itemBI;
	
	private AsientoModeloItemService service;

	// -------------------------------------------------------------

	
	protected TextFieldEntity numeroTXT;
	protected ComboBoxEntity asientoModeloCBX;
	protected SelectorBox asientoModeloSBX;
	protected ComboBoxEntity cuentaContableCBX;
	protected SelectorBox cuentaContableSBX;


	// -------------------------------------------------------------

	public WFAsientoModeloItem(String mode, String id) {
		super(mode, id);					
	}

	protected AsientoModeloItemService getService() throws Exception {
		if(service == null){
			service = AppCX.services().buildAsientoModeloItemService();
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

		AsientoModeloService asientoModeloService = AppCX.services().buildAsientoModeloService();

		long asientoModeloItems = asientoModeloService.count();

		if (asientoModeloItems < MAX_ROWS_FOR_CBX) {

			AsientoModeloFiltro asientoModeloFiltro = new AsientoModeloFiltro();

			asientoModeloFiltro.setUnlimited(true);

			asientoModeloFiltro.setOrderBy(1);

			List<AsientoModelo> asientoModeloLista = asientoModeloService.find(asientoModeloFiltro);

			asientoModeloCBX = new ComboBoxEntity(itemBI, "asientoModelo", this.mode, asientoModeloLista);

		} else {

			asientoModeloSBX = new SelectorBox(itemBI, "asientoModelo") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					AsientoModeloService service = AppCX.services().buildAsientoModeloService();

					return service.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					AsientoModeloFiltro filtro = new AsientoModeloFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return AppCX.widgets().buildWLAsientoModelo(filtro);

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

		
		// ---------------------------------------------------------------------------------------------------------

		return buildCuerpoLayout();

		// ---------------------------------------------------------------------------------------------------------
	}
	
	protected Component buildCuerpoLayout() throws Exception {		

		VerticalLayout generalVL = UtilUI.buildVL();

		// ------------------------------------------------------------------		
		
		
		generalVL.addComponent(numeroTXT);
		if (asientoModeloCBX != null) {
			generalVL.addComponent(asientoModeloCBX);
		}
		if (asientoModeloSBX != null) {
			generalVL.addComponent(asientoModeloSBX);
		}
		if (cuentaContableCBX != null) {
			generalVL.addComponent(cuentaContableCBX);
		}
		if (cuentaContableSBX != null) {
			generalVL.addComponent(cuentaContableSBX);
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
		
		
		((AsientoModeloItem) item).setNumero(getService().nextValueNumero());

	}

	protected void setBean(EntityId obj) throws Exception {

		// se utiliza para asignarle o cambiar el bean al contenedor del formulario

		itemBI.setBean((AsientoModeloItem) obj);
	}

	protected BeanItem<AsientoModeloItem> getItemBIC() throws Exception {

		// -----------------------------------------------------------------
		// Crea el Container del form, en base a al bean que queremos usar, y ademas
		// carga el form con un bean vacio
		// como este metodo se llama muchas veces, inicializar el contenedor una sola
		// vez

		if (itemBI == null) {
			itemBI = new BeanItem<AsientoModeloItem>(new AsientoModeloItem());
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
			AsientoModeloItem item = getService().findById(id);
			getItemBIC().setBean(item);

			return item;

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

		return (EntityId) getItemBIC().getBean();
	}

	// =================================================================================

}