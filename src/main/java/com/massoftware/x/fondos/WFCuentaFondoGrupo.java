
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
import com.massoftware.model.fondos.CuentaFondoRubro;
import com.massoftware.service.fondos.CuentaFondoRubroFiltro;
import com.massoftware.service.fondos.CuentaFondoRubroService;

import com.massoftware.model.fondos.CuentaFondoGrupo;
import com.massoftware.service.fondos.CuentaFondoGrupoService;

@SuppressWarnings("serial")
public class WFCuentaFondoGrupo extends WindowForm {


	// -------------------------------------------------------------

	protected BeanItem<CuentaFondoGrupo> itemBI;
	
	private CuentaFondoGrupoService service;

	// -------------------------------------------------------------

	
	protected TextFieldEntity numeroTXT;
	protected TextFieldEntity nombreTXT;
	protected ComboBoxEntity cuentaFondoRubroCBX;
	protected SelectorBox cuentaFondoRubroSBX;


	// -------------------------------------------------------------

	public WFCuentaFondoGrupo(String mode, String id) {
		super(mode, id);					
	}

	protected CuentaFondoGrupoService getService() throws Exception {
		if(service == null){
			service = AppCX.services().buildCuentaFondoGrupoService();
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

		CuentaFondoRubroService cuentaFondoRubroService = AppCX.services().buildCuentaFondoRubroService();

		long cuentaFondoRubroItems = cuentaFondoRubroService.count();

		if (cuentaFondoRubroItems < MAX_ROWS_FOR_CBX) {

			CuentaFondoRubroFiltro cuentaFondoRubroFiltro = new CuentaFondoRubroFiltro();

			cuentaFondoRubroFiltro.setUnlimited(true);

			cuentaFondoRubroFiltro.setOrderBy(1);

			List<CuentaFondoRubro> cuentaFondoRubroLista = cuentaFondoRubroService.find(cuentaFondoRubroFiltro);

			cuentaFondoRubroCBX = new ComboBoxEntity(itemBI, "cuentaFondoRubro", this.mode, cuentaFondoRubroLista);

		} else {

			cuentaFondoRubroSBX = new SelectorBox(itemBI, "cuentaFondoRubro") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					CuentaFondoRubroService service = AppCX.services().buildCuentaFondoRubroService();

					return service.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					CuentaFondoRubroFiltro filtro = new CuentaFondoRubroFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return AppCX.widgets().buildWLCuentaFondoRubro(filtro);

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
		if (cuentaFondoRubroCBX != null) {
			generalVL.addComponent(cuentaFondoRubroCBX);
		}
		if (cuentaFondoRubroSBX != null) {
			generalVL.addComponent(cuentaFondoRubroSBX);
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
		
		
		((CuentaFondoGrupo) item).setNumero(getService().nextValueNumero());

	}

	protected void setBean(EntityId obj) throws Exception {

		// se utiliza para asignarle o cambiar el bean al contenedor del formulario

		itemBI.setBean((CuentaFondoGrupo) obj);
	}

	protected BeanItem<CuentaFondoGrupo> getItemBIC() throws Exception {

		// -----------------------------------------------------------------
		// Crea el Container del form, en base a al bean que queremos usar, y ademas
		// carga el form con un bean vacio
		// como este metodo se llama muchas veces, inicializar el contenedor una sola
		// vez

		if (itemBI == null) {
			itemBI = new BeanItem<CuentaFondoGrupo>(new CuentaFondoGrupo());
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
			CuentaFondoGrupo item = getService().findById(id);
			getItemBIC().setBean(item);

			return item;

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

		return (EntityId) getItemBIC().getBean();
	}

	// =================================================================================

}