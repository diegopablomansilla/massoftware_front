
package com.massoftware.x.empresa;

import com.vaadin.data.util.BeanItem;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.Component;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.VerticalLayout;

import com.massoftware.windows.*;

import com.massoftware.AppCX;

import com.massoftware.model.EntityId;


import java.util.List;
import com.massoftware.model.empresa.TipoSucursal;
import com.massoftware.service.empresa.TipoSucursalFiltro;
import com.massoftware.service.empresa.TipoSucursalService;

import com.massoftware.model.empresa.Sucursal;
import com.massoftware.service.empresa.SucursalService;

@SuppressWarnings("serial")
public class WFSucursal extends WindowForm {


	// -------------------------------------------------------------

	protected BeanItem<Sucursal> itemBI;
	
	private SucursalService service;

	// -------------------------------------------------------------

	
	protected TextFieldEntity numeroTXT;
	protected TextFieldEntity nombreTXT;
	protected TextFieldEntity abreviaturaTXT;
	protected ComboBoxEntity tipoSucursalCBX;
	protected SelectorBox tipoSucursalSBX;
	protected TextFieldEntity cuentaClientesDesdeTXT;
	protected TextFieldEntity cuentaClientesHastaTXT;
	protected TextFieldEntity cantidadCaracteresClientesTXT;
	protected CheckBoxEntity identificacionNumericaClientesCHK;
	protected CheckBoxEntity permiteCambiarClientesCHK;
	protected TextFieldEntity cuentaProveedoresDesdeTXT;
	protected TextFieldEntity cuentaProveedoresHastaTXT;
	protected TextFieldEntity cantidadCaracteresProveedoresTXT;
	protected CheckBoxEntity identificacionNumericaProveedoresCHK;
	protected CheckBoxEntity permiteCambiarProveedoresCHK;
	protected TextFieldEntity clientesOcacionalesDesdeTXT;
	protected TextFieldEntity clientesOcacionalesHastaTXT;
	protected TextFieldEntity numeroCobranzaDesdeTXT;
	protected TextFieldEntity numeroCobranzaHastaTXT;


	// -------------------------------------------------------------

	public WFSucursal(String mode, String id) {
		super(mode, id);					
	}

	protected SucursalService getService() throws Exception {
		if(service == null){
			service = AppCX.services().buildSucursalService();
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

		TipoSucursalService tipoSucursalService = AppCX.services().buildTipoSucursalService();

		long tipoSucursalItems = tipoSucursalService.count();

		if (tipoSucursalItems < MAX_ROWS_FOR_CBX) {

			TipoSucursalFiltro tipoSucursalFiltro = new TipoSucursalFiltro();

			tipoSucursalFiltro.setUnlimited(true);

			tipoSucursalFiltro.setOrderBy(1);

			List<TipoSucursal> tipoSucursalLista = tipoSucursalService.find(tipoSucursalFiltro);

			tipoSucursalCBX = new ComboBoxEntity(itemBI, "tipoSucursal", this.mode, tipoSucursalLista);

		} else {

			tipoSucursalSBX = new SelectorBox(itemBI, "tipoSucursal") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					TipoSucursalService service = AppCX.services().buildTipoSucursalService();

					return service.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					TipoSucursalFiltro filtro = new TipoSucursalFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return AppCX.widgets().buildWLTipoSucursal(filtro);

				}

			};

		}

		// ------------------------------------------------------------------

		cuentaClientesDesdeTXT = new TextFieldEntity(itemBI, "cuentaClientesDesde", this.mode);

		// ------------------------------------------------------------------

		cuentaClientesHastaTXT = new TextFieldEntity(itemBI, "cuentaClientesHasta", this.mode);

		// ------------------------------------------------------------------

		cantidadCaracteresClientesTXT = new TextFieldEntity(itemBI, "cantidadCaracteresClientes", this.mode);

		// ------------------------------------------------------------------

		identificacionNumericaClientesCHK = new CheckBoxEntity(itemBI, "identificacionNumericaClientes");

		// ------------------------------------------------------------------

		permiteCambiarClientesCHK = new CheckBoxEntity(itemBI, "permiteCambiarClientes");

		// ------------------------------------------------------------------

		cuentaProveedoresDesdeTXT = new TextFieldEntity(itemBI, "cuentaProveedoresDesde", this.mode);

		// ------------------------------------------------------------------

		cuentaProveedoresHastaTXT = new TextFieldEntity(itemBI, "cuentaProveedoresHasta", this.mode);

		// ------------------------------------------------------------------

		cantidadCaracteresProveedoresTXT = new TextFieldEntity(itemBI, "cantidadCaracteresProveedores", this.mode);

		// ------------------------------------------------------------------

		identificacionNumericaProveedoresCHK = new CheckBoxEntity(itemBI, "identificacionNumericaProveedores");

		// ------------------------------------------------------------------

		permiteCambiarProveedoresCHK = new CheckBoxEntity(itemBI, "permiteCambiarProveedores");

		// ------------------------------------------------------------------

		clientesOcacionalesDesdeTXT = new TextFieldEntity(itemBI, "clientesOcacionalesDesde", this.mode);

		// ------------------------------------------------------------------

		clientesOcacionalesHastaTXT = new TextFieldEntity(itemBI, "clientesOcacionalesHasta", this.mode);

		// ------------------------------------------------------------------

		numeroCobranzaDesdeTXT = new TextFieldEntity(itemBI, "numeroCobranzaDesde", this.mode);

		// ------------------------------------------------------------------

		numeroCobranzaHastaTXT = new TextFieldEntity(itemBI, "numeroCobranzaHasta", this.mode);

		
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
		if (tipoSucursalCBX != null) {
			generalVL.addComponent(tipoSucursalCBX);
		}
		if (tipoSucursalSBX != null) {
			generalVL.addComponent(tipoSucursalSBX);
		}
		generalVL.addComponent(cuentaClientesDesdeTXT);
		generalVL.addComponent(cuentaClientesHastaTXT);
		generalVL.addComponent(cantidadCaracteresClientesTXT);
		generalVL.addComponent(identificacionNumericaClientesCHK);
		generalVL.addComponent(permiteCambiarClientesCHK);
		generalVL.addComponent(cuentaProveedoresDesdeTXT);
		generalVL.addComponent(cuentaProveedoresHastaTXT);
		generalVL.addComponent(cantidadCaracteresProveedoresTXT);
		generalVL.addComponent(identificacionNumericaProveedoresCHK);
		generalVL.addComponent(permiteCambiarProveedoresCHK);
		generalVL.addComponent(clientesOcacionalesDesdeTXT);
		generalVL.addComponent(clientesOcacionalesHastaTXT);
		generalVL.addComponent(numeroCobranzaDesdeTXT);
		generalVL.addComponent(numeroCobranzaHastaTXT);

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
		
		
		((Sucursal) item).setNumero(getService().nextValueNumero());

	}

	protected void setBean(EntityId obj) throws Exception {

		// se utiliza para asignarle o cambiar el bean al contenedor del formulario

		itemBI.setBean((Sucursal) obj);
	}

	protected BeanItem<Sucursal> getItemBIC() throws Exception {

		// -----------------------------------------------------------------
		// Crea el Container del form, en base a al bean que queremos usar, y ademas
		// carga el form con un bean vacio
		// como este metodo se llama muchas veces, inicializar el contenedor una sola
		// vez

		if (itemBI == null) {
			itemBI = new BeanItem<Sucursal>(new Sucursal());
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
			Sucursal item = getService().findById(id);
			getItemBIC().setBean(item);

			return item;

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

		return (EntityId) getItemBIC().getBean();
	}

	// =================================================================================

}