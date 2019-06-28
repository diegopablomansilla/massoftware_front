
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
import com.massoftware.model.fondos.CuentaFondo;
import com.massoftware.service.fondos.CuentaFondoFiltro;
import com.massoftware.service.fondos.CuentaFondoService;

import com.massoftware.model.fondos.JuridiccionConvnioMultilateral;
import com.massoftware.service.fondos.JuridiccionConvnioMultilateralService;

@SuppressWarnings("serial")
public class WFJuridiccionConvnioMultilateral extends WindowForm {


	// -------------------------------------------------------------

	protected BeanItem<JuridiccionConvnioMultilateral> itemBI;
	
	private JuridiccionConvnioMultilateralService service;

	// -------------------------------------------------------------

	
	protected TextFieldEntity numeroTXT;
	protected TextFieldEntity nombreTXT;
	protected ComboBoxEntity cuentaFondoCBX;
	protected SelectorBox cuentaFondoSBX;


	// -------------------------------------------------------------

	public WFJuridiccionConvnioMultilateral(String mode, String id) {
		super(mode, id);					
	}

	protected JuridiccionConvnioMultilateralService getService() throws Exception {
		if(service == null){
			service = AppCX.services().buildJuridiccionConvnioMultilateralService();
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

		CuentaFondoService cuentaFondoService = AppCX.services().buildCuentaFondoService();

		long cuentaFondoItems = cuentaFondoService.count();

		if (cuentaFondoItems < MAX_ROWS_FOR_CBX) {

			CuentaFondoFiltro cuentaFondoFiltro = new CuentaFondoFiltro();

			cuentaFondoFiltro.setUnlimited(true);

			cuentaFondoFiltro.setOrderBy(1);

			List<CuentaFondo> cuentaFondoLista = cuentaFondoService.find(cuentaFondoFiltro);

			cuentaFondoCBX = new ComboBoxEntity(itemBI, "cuentaFondo", this.mode, cuentaFondoLista);

		} else {

			cuentaFondoSBX = new SelectorBox(itemBI, "cuentaFondo") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					CuentaFondoService service = AppCX.services().buildCuentaFondoService();

					return service.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					CuentaFondoFiltro filtro = new CuentaFondoFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return AppCX.widgets().buildWLCuentaFondo(filtro);

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
		if (cuentaFondoCBX != null) {
			generalVL.addComponent(cuentaFondoCBX);
		}
		if (cuentaFondoSBX != null) {
			generalVL.addComponent(cuentaFondoSBX);
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
		
		
		((JuridiccionConvnioMultilateral) item).setNumero(getService().nextValueNumero());

	}

	protected void setBean(EntityId obj) throws Exception {

		// se utiliza para asignarle o cambiar el bean al contenedor del formulario

		itemBI.setBean((JuridiccionConvnioMultilateral) obj);
	}

	protected BeanItem<JuridiccionConvnioMultilateral> getItemBIC() throws Exception {

		// -----------------------------------------------------------------
		// Crea el Container del form, en base a al bean que queremos usar, y ademas
		// carga el form con un bean vacio
		// como este metodo se llama muchas veces, inicializar el contenedor una sola
		// vez

		if (itemBI == null) {
			itemBI = new BeanItem<JuridiccionConvnioMultilateral>(new JuridiccionConvnioMultilateral());
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
			JuridiccionConvnioMultilateral item = getService().findById(id);
			getItemBIC().setBean(item);

			return item;

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

		return (EntityId) getItemBIC().getBean();
	}

	// =================================================================================

}