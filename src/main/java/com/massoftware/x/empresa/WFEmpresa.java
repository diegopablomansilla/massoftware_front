
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
import com.massoftware.model.contabilidad.EjercicioContable;
import com.massoftware.service.contabilidad.EjercicioContableFiltro;
import com.massoftware.service.contabilidad.EjercicioContableService;

import com.massoftware.model.empresa.Empresa;
import com.massoftware.service.empresa.EmpresaService;

@SuppressWarnings("serial")
public class WFEmpresa extends WindowForm {


	// -------------------------------------------------------------

	protected BeanItem<Empresa> itemBI;
	
	private EmpresaService service;

	// -------------------------------------------------------------

	
	protected ComboBoxEntity ejercicioContableCBX;
	protected SelectorBox ejercicioContableSBX;
	protected DateFieldEntity fechaCierreVentasDAF;
	protected DateFieldEntity fechaCierreStockDAF;
	protected DateFieldEntity fechaCierreFondoDAF;
	protected DateFieldEntity fechaCierreComprasDAF;
	protected DateFieldEntity fechaCierreContabilidadDAF;
	protected DateFieldEntity fechaCierreGarantiaDevolucionesDAF;
	protected DateFieldEntity fechaCierreTambosDAF;
	protected DateFieldEntity fechaCierreRRHHDAF;


	// -------------------------------------------------------------

	public WFEmpresa(String mode, String id) {
		super(mode, id);					
	}

	protected EmpresaService getService() throws Exception {
		if(service == null){
			service = AppCX.services().buildEmpresaService();
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

		

		EjercicioContableService ejercicioContableService = AppCX.services().buildEjercicioContableService();

		long ejercicioContableItems = ejercicioContableService.count();

		if (ejercicioContableItems < MAX_ROWS_FOR_CBX) {

			EjercicioContableFiltro ejercicioContableFiltro = new EjercicioContableFiltro();

			ejercicioContableFiltro.setUnlimited(true);

			ejercicioContableFiltro.setOrderBy(1);

			List<EjercicioContable> ejercicioContableLista = ejercicioContableService.find(ejercicioContableFiltro);

			ejercicioContableCBX = new ComboBoxEntity(itemBI, "ejercicioContable", this.mode, ejercicioContableLista);

			ejercicioContableCBX.focus();

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

			ejercicioContableSBX.focus();

		}

		// ------------------------------------------------------------------

		fechaCierreVentasDAF = new DateFieldEntity(itemBI, "fechaCierreVentas", this.mode, false);

		// ------------------------------------------------------------------

		fechaCierreStockDAF = new DateFieldEntity(itemBI, "fechaCierreStock", this.mode, false);

		// ------------------------------------------------------------------

		fechaCierreFondoDAF = new DateFieldEntity(itemBI, "fechaCierreFondo", this.mode, false);

		// ------------------------------------------------------------------

		fechaCierreComprasDAF = new DateFieldEntity(itemBI, "fechaCierreCompras", this.mode, false);

		// ------------------------------------------------------------------

		fechaCierreContabilidadDAF = new DateFieldEntity(itemBI, "fechaCierreContabilidad", this.mode, false);

		// ------------------------------------------------------------------

		fechaCierreGarantiaDevolucionesDAF = new DateFieldEntity(itemBI, "fechaCierreGarantiaDevoluciones", this.mode, false);

		// ------------------------------------------------------------------

		fechaCierreTambosDAF = new DateFieldEntity(itemBI, "fechaCierreTambos", this.mode, false);

		// ------------------------------------------------------------------

		fechaCierreRRHHDAF = new DateFieldEntity(itemBI, "fechaCierreRRHH", this.mode, false);

		
		// ---------------------------------------------------------------------------------------------------------

		return buildCuerpoLayout();

		// ---------------------------------------------------------------------------------------------------------
	}
	
	protected Component buildCuerpoLayout() throws Exception {		

		VerticalLayout generalVL = UtilUI.buildVL();

		// ------------------------------------------------------------------		
		
		
		if (ejercicioContableCBX != null) {
			generalVL.addComponent(ejercicioContableCBX);
		}
		if (ejercicioContableSBX != null) {
			generalVL.addComponent(ejercicioContableSBX);
		}
		generalVL.addComponent(fechaCierreVentasDAF);
		generalVL.addComponent(fechaCierreStockDAF);
		generalVL.addComponent(fechaCierreFondoDAF);
		generalVL.addComponent(fechaCierreComprasDAF);
		generalVL.addComponent(fechaCierreContabilidadDAF);
		generalVL.addComponent(fechaCierreGarantiaDevolucionesDAF);
		generalVL.addComponent(fechaCierreTambosDAF);
		generalVL.addComponent(fechaCierreRRHHDAF);

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

		itemBI.setBean((Empresa) obj);
	}

	protected BeanItem<Empresa> getItemBIC() throws Exception {

		// -----------------------------------------------------------------
		// Crea el Container del form, en base a al bean que queremos usar, y ademas
		// carga el form con un bean vacio
		// como este metodo se llama muchas veces, inicializar el contenedor una sola
		// vez

		if (itemBI == null) {
			itemBI = new BeanItem<Empresa>(new Empresa());
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
			Empresa item = getService().findById(id);
			getItemBIC().setBean(item);

			return item;

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

		return (EntityId) getItemBIC().getBean();
	}

	// =================================================================================

}