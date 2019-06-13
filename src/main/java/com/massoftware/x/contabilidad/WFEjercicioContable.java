
package com.massoftware.x.contabilidad;

import com.vaadin.data.util.BeanItem;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.Component;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.VerticalLayout;

import com.massoftware.windows.*;

import com.massoftware.AppCX;

import com.massoftware.model.EntityId;



import com.massoftware.model.contabilidad.EjercicioContable;
import com.massoftware.service.contabilidad.EjercicioContableService;

@SuppressWarnings("serial")
public class WFEjercicioContable extends WindowForm {


	// -------------------------------------------------------------

	protected BeanItem<EjercicioContable> itemBI;
	
	private EjercicioContableService service;

	// -------------------------------------------------------------

	
	protected TextFieldEntity numeroTXT;
	protected DateFieldEntity aperturaDAF;
	protected DateFieldEntity cierreDAF;
	protected CheckBoxEntity cerradoCHK;
	protected CheckBoxEntity cerradoModulosCHK;
	protected TextAreaEntity comentarioTXA;


	// -------------------------------------------------------------

	public WFEjercicioContable(String mode, String id) {
		super(mode, id);					
	}

	protected EjercicioContableService getService() throws Exception {
		if(service == null){
			service = AppCX.services().buildEjercicioContableService();
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

		aperturaDAF = new DateFieldEntity(itemBI, "apertura", this.mode, false);

		// ------------------------------------------------------------------

		cierreDAF = new DateFieldEntity(itemBI, "cierre", this.mode, false);

		// ------------------------------------------------------------------

		cerradoCHK = new CheckBoxEntity(itemBI, "cerrado");

		// ------------------------------------------------------------------

		cerradoModulosCHK = new CheckBoxEntity(itemBI, "cerradoModulos");

		// ------------------------------------------------------------------

		comentarioTXA = new TextAreaEntity(itemBI, "comentario", this.mode);

		
		// ---------------------------------------------------------------------------------------------------------

		return buildCuerpoLayout();

		// ---------------------------------------------------------------------------------------------------------
	}
	
	protected Component buildCuerpoLayout() throws Exception {		

		VerticalLayout generalVL = UtilUI.buildVL();

		// ------------------------------------------------------------------		
		
		
		generalVL.addComponent(numeroTXT);
		generalVL.addComponent(aperturaDAF);
		generalVL.addComponent(cierreDAF);
		generalVL.addComponent(cerradoCHK);
		generalVL.addComponent(cerradoModulosCHK);
		generalVL.addComponent(comentarioTXA);

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
		
		
		((EjercicioContable) item).setNumero(getService().nextValueNumero());

	}

	protected void setBean(EntityId obj) throws Exception {

		// se utiliza para asignarle o cambiar el bean al contenedor del formulario

		itemBI.setBean((EjercicioContable) obj);
	}

	protected BeanItem<EjercicioContable> getItemBIC() throws Exception {

		// -----------------------------------------------------------------
		// Crea el Container del form, en base a al bean que queremos usar, y ademas
		// carga el form con un bean vacio
		// como este metodo se llama muchas veces, inicializar el contenedor una sola
		// vez

		if (itemBI == null) {
			itemBI = new BeanItem<EjercicioContable>(new EjercicioContable());
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
			EjercicioContable item = getService().findById(id);
			getItemBIC().setBean(item);

			return item;

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

		return (EntityId) getItemBIC().getBean();
	}

	// =================================================================================

}