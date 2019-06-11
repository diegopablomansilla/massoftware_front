
package com.massoftware.x.monedas;

import com.vaadin.data.util.BeanItem;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.Component;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.VerticalLayout;

import com.massoftware.windows.*;

import com.massoftware.AppCX;

import com.massoftware.model.EntityId;


import java.util.List;
import com.massoftware.model.afip.MonedaAFIP;
import com.massoftware.service.afip.MonedaAFIPFiltro;
import com.massoftware.service.afip.MonedaAFIPService;

import com.massoftware.model.monedas.Moneda;
import com.massoftware.service.monedas.MonedaService;

@SuppressWarnings("serial")
public class WFMoneda extends WindowForm {


	// -------------------------------------------------------------

	protected BeanItem<Moneda> itemBI;
	
	private MonedaService service;

	// -------------------------------------------------------------

	
	protected TextFieldEntity numeroTXT;
	protected TextFieldEntity nombreTXT;
	protected TextFieldEntity abreviaturaTXT;
	protected TextFieldEntity cotizacionTXT;
	protected DateFieldEntity cotizacionFechaDAF;
	protected CheckBoxEntity controlActualizacionCHK;
	protected ComboBoxEntity monedaAFIPCBX;
	protected SelectorBox monedaAFIPSBX;


	// -------------------------------------------------------------

	public WFMoneda(String mode, String id) {
		super(mode, id);					
	}

	protected MonedaService getService() throws Exception {
		if(service == null){
			service = AppCX.services().buildMonedaService();
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

		// ------------------------------------------------------------------

		abreviaturaTXT = new TextFieldEntity(itemBI, "abreviatura", this.mode) {
			protected boolean ifExists(Object arg) throws Exception {
				return getService().isExistsAbreviatura((String)arg);
			}
		};

		// ------------------------------------------------------------------

		cotizacionTXT = new TextFieldEntity(itemBI, "cotizacion", this.mode);

		// ------------------------------------------------------------------

		cotizacionFechaDAF = new DateFieldEntity(itemBI, "cotizacionFecha", this.mode, true);

		// ------------------------------------------------------------------

		controlActualizacionCHK = new CheckBoxEntity(itemBI, "controlActualizacion");

		MonedaAFIPService monedaAFIPService = AppCX.services().buildMonedaAFIPService();

		long monedaAFIPItems = monedaAFIPService.count();

		if (monedaAFIPItems < MAX_ROWS_FOR_CBX) {

			MonedaAFIPFiltro monedaAFIPFiltro = new MonedaAFIPFiltro();

			monedaAFIPFiltro.setUnlimited(true);

			monedaAFIPFiltro.setOrderBy(1);

			List<MonedaAFIP> monedaAFIPLista = monedaAFIPService.find(monedaAFIPFiltro);

			monedaAFIPCBX = new ComboBoxEntity(itemBI, "monedaAFIP", this.mode, monedaAFIPLista);

		} else {

			monedaAFIPSBX = new SelectorBox(itemBI, "monedaAFIP") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					MonedaAFIPService service = AppCX.services().buildMonedaAFIPService();

					return service.findByCodigoOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					MonedaAFIPFiltro filtro = new MonedaAFIPFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return AppCX.widgets().buildWLMonedaAFIP(filtro);

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
		generalVL.addComponent(abreviaturaTXT);
		generalVL.addComponent(cotizacionTXT);
		generalVL.addComponent(cotizacionFechaDAF);
		generalVL.addComponent(controlActualizacionCHK);
		if (monedaAFIPCBX != null) {
			generalVL.addComponent(monedaAFIPCBX);
		}
		if (monedaAFIPSBX != null) {
			generalVL.addComponent(monedaAFIPSBX);
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
		
		
		((Moneda) item).setNumero(getService().nextValueNumero());

	}

	protected void setBean(EntityId obj) throws Exception {

		// se utiliza para asignarle o cambiar el bean al contenedor del formulario

		itemBI.setBean((Moneda) obj);
	}

	protected BeanItem<Moneda> getItemBIC() throws Exception {

		// -----------------------------------------------------------------
		// Crea el Container del form, en base a al bean que queremos usar, y ademas
		// carga el form con un bean vacio
		// como este metodo se llama muchas veces, inicializar el contenedor una sola
		// vez

		if (itemBI == null) {
			itemBI = new BeanItem<Moneda>(new Moneda());
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
			Moneda item = getService().findById(id);
			getItemBIC().setBean(item);

			return item;

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

		return (EntityId) getItemBIC().getBean();
	}

	// =================================================================================

}