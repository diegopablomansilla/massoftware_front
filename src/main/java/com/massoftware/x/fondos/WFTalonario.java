
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
import com.massoftware.model.fondos.TalonarioLetra;
import com.massoftware.service.fondos.TalonarioLetraFiltro;
import com.massoftware.service.fondos.TalonarioLetraService;
import com.massoftware.model.fondos.TalonarioControladorFizcal;
import com.massoftware.service.fondos.TalonarioControladorFizcalFiltro;
import com.massoftware.service.fondos.TalonarioControladorFizcalService;

import com.massoftware.model.fondos.Talonario;
import com.massoftware.service.fondos.TalonarioService;

@SuppressWarnings("serial")
public class WFTalonario extends WindowForm {


	// -------------------------------------------------------------

	protected BeanItem<Talonario> itemBI;
	
	private TalonarioService service;

	// -------------------------------------------------------------

	
	protected TextFieldEntity numeroTXT;
	protected TextFieldEntity nombreTXT;
	protected ComboBoxEntity talonarioLetraCBX;
	protected SelectorBox talonarioLetraSBX;
	protected TextFieldEntity puntoVentaTXT;
	protected CheckBoxEntity autonumeracionCHK;
	protected CheckBoxEntity numeracionPreImpresaCHK;
	protected CheckBoxEntity asociadoRG10098CHK;
	protected ComboBoxEntity talonarioControladorFizcalCBX;
	protected SelectorBox talonarioControladorFizcalSBX;
	protected TextFieldEntity primerNumeroTXT;
	protected TextFieldEntity proximoNumeroTXT;
	protected TextFieldEntity ultimoNumeroTXT;
	protected TextFieldEntity cantidadMinimaComprobantesTXT;
	protected DateFieldEntity fechaDAF;
	protected TextFieldEntity numeroCAITXT;
	protected DateFieldEntity vencimientoDAF;
	protected TextFieldEntity diasAvisoVencimientoTXT;


	// -------------------------------------------------------------

	public WFTalonario(String mode, String id) {
		super(mode, id);					
	}

	protected TalonarioService getService() throws Exception {
		if(service == null){
			service = AppCX.services().buildTalonarioService();
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

		TalonarioLetraService talonarioLetraService = AppCX.services().buildTalonarioLetraService();

		long talonarioLetraItems = talonarioLetraService.count();

		if (talonarioLetraItems < MAX_ROWS_FOR_CBX) {

			TalonarioLetraFiltro talonarioLetraFiltro = new TalonarioLetraFiltro();

			talonarioLetraFiltro.setUnlimited(true);

			talonarioLetraFiltro.setOrderBy(1);

			List<TalonarioLetra> talonarioLetraLista = talonarioLetraService.find(talonarioLetraFiltro);

			talonarioLetraCBX = new ComboBoxEntity(itemBI, "talonarioLetra", this.mode, talonarioLetraLista);

		} else {

			talonarioLetraSBX = new SelectorBox(itemBI, "talonarioLetra") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					TalonarioLetraService service = AppCX.services().buildTalonarioLetraService();

					return service.findByNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					TalonarioLetraFiltro filtro = new TalonarioLetraFiltro();

					if (filter) {

					}

					return AppCX.widgets().buildWLTalonarioLetra(filtro);

				}

			};

		}

		// ------------------------------------------------------------------

		puntoVentaTXT = new TextFieldEntity(itemBI, "puntoVenta", this.mode);

		// ------------------------------------------------------------------

		autonumeracionCHK = new CheckBoxEntity(itemBI, "autonumeracion");

		// ------------------------------------------------------------------

		numeracionPreImpresaCHK = new CheckBoxEntity(itemBI, "numeracionPreImpresa");

		// ------------------------------------------------------------------

		asociadoRG10098CHK = new CheckBoxEntity(itemBI, "asociadoRG10098");

		TalonarioControladorFizcalService talonarioControladorFizcalService = AppCX.services().buildTalonarioControladorFizcalService();

		long talonarioControladorFizcalItems = talonarioControladorFizcalService.count();

		if (talonarioControladorFizcalItems < MAX_ROWS_FOR_CBX) {

			TalonarioControladorFizcalFiltro talonarioControladorFizcalFiltro = new TalonarioControladorFizcalFiltro();

			talonarioControladorFizcalFiltro.setUnlimited(true);

			talonarioControladorFizcalFiltro.setOrderBy(1);

			List<TalonarioControladorFizcal> talonarioControladorFizcalLista = talonarioControladorFizcalService.find(talonarioControladorFizcalFiltro);

			talonarioControladorFizcalCBX = new ComboBoxEntity(itemBI, "talonarioControladorFizcal", this.mode, talonarioControladorFizcalLista);

		} else {

			talonarioControladorFizcalSBX = new SelectorBox(itemBI, "talonarioControladorFizcal") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					TalonarioControladorFizcalService service = AppCX.services().buildTalonarioControladorFizcalService();

					return service.findByCodigoOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					TalonarioControladorFizcalFiltro filtro = new TalonarioControladorFizcalFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return AppCX.widgets().buildWLTalonarioControladorFizcal(filtro);

				}

			};

		}

		// ------------------------------------------------------------------

		primerNumeroTXT = new TextFieldEntity(itemBI, "primerNumero", this.mode);

		// ------------------------------------------------------------------

		proximoNumeroTXT = new TextFieldEntity(itemBI, "proximoNumero", this.mode);

		// ------------------------------------------------------------------

		ultimoNumeroTXT = new TextFieldEntity(itemBI, "ultimoNumero", this.mode);

		// ------------------------------------------------------------------

		cantidadMinimaComprobantesTXT = new TextFieldEntity(itemBI, "cantidadMinimaComprobantes", this.mode);

		// ------------------------------------------------------------------

		fechaDAF = new DateFieldEntity(itemBI, "fecha", this.mode, false);

		// ------------------------------------------------------------------

		numeroCAITXT = new TextFieldEntity(itemBI, "numeroCAI", this.mode);

		// ------------------------------------------------------------------

		vencimientoDAF = new DateFieldEntity(itemBI, "vencimiento", this.mode, false);

		// ------------------------------------------------------------------

		diasAvisoVencimientoTXT = new TextFieldEntity(itemBI, "diasAvisoVencimiento", this.mode);

		
		// ---------------------------------------------------------------------------------------------------------

		return buildCuerpoLayout();

		// ---------------------------------------------------------------------------------------------------------
	}
	
	protected Component buildCuerpoLayout() throws Exception {		

		VerticalLayout generalVL = UtilUI.buildVL();

		// ------------------------------------------------------------------		
		
		
		generalVL.addComponent(numeroTXT);
		generalVL.addComponent(nombreTXT);
		if (talonarioLetraCBX != null) {
			generalVL.addComponent(talonarioLetraCBX);
		}
		if (talonarioLetraSBX != null) {
			generalVL.addComponent(talonarioLetraSBX);
		}
		generalVL.addComponent(puntoVentaTXT);
		generalVL.addComponent(autonumeracionCHK);
		generalVL.addComponent(numeracionPreImpresaCHK);
		generalVL.addComponent(asociadoRG10098CHK);
		if (talonarioControladorFizcalCBX != null) {
			generalVL.addComponent(talonarioControladorFizcalCBX);
		}
		if (talonarioControladorFizcalSBX != null) {
			generalVL.addComponent(talonarioControladorFizcalSBX);
		}
		generalVL.addComponent(primerNumeroTXT);
		generalVL.addComponent(proximoNumeroTXT);
		generalVL.addComponent(ultimoNumeroTXT);
		generalVL.addComponent(cantidadMinimaComprobantesTXT);
		generalVL.addComponent(fechaDAF);
		generalVL.addComponent(numeroCAITXT);
		generalVL.addComponent(vencimientoDAF);
		generalVL.addComponent(diasAvisoVencimientoTXT);

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
		
		
		((Talonario) item).setNumero(getService().nextValueNumero());

	}

	protected void setBean(EntityId obj) throws Exception {

		// se utiliza para asignarle o cambiar el bean al contenedor del formulario

		itemBI.setBean((Talonario) obj);
	}

	protected BeanItem<Talonario> getItemBIC() throws Exception {

		// -----------------------------------------------------------------
		// Crea el Container del form, en base a al bean que queremos usar, y ademas
		// carga el form con un bean vacio
		// como este metodo se llama muchas veces, inicializar el contenedor una sola
		// vez

		if (itemBI == null) {
			itemBI = new BeanItem<Talonario>(new Talonario());
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
			Talonario item = getService().findById(id);
			getItemBIC().setBean(item);

			return item;

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

		return (EntityId) getItemBIC().getBean();
	}

	// =================================================================================

}