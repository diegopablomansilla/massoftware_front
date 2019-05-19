
package com.massoftware.x.monedas;

import com.vaadin.data.util.BeanItem;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.Component;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.VerticalLayout;

import com.massoftware.windows.*;

import com.massoftware.model.EntityId;


import java.util.List;
import com.massoftware.model.monedas.MonedaAFIP;
import com.massoftware.dao.monedas.MonedaAFIPFiltro;
import com.massoftware.dao.monedas.MonedaAFIPDAO;

import com.massoftware.model.monedas.Moneda;
import com.massoftware.dao.monedas.MonedaDAO;

@SuppressWarnings("serial")
public class WFMoneda2 extends WindowForm {

	// -------------------------------------------------------------

	private BeanItem<Moneda> itemBI;
	
	private MonedaDAO dao;

	// -------------------------------------------------------------

	
	private TextFieldEntity numeroTXT;
	private TextFieldEntity nombreTXT;
	private TextFieldEntity abreviaturaTXT;
	private TextFieldEntity cotizacionTXT;
	private DateFieldEntity cotizacionFechaDAF;
	private CheckBoxEntity controlActualizacionCHK;
	private ComboBoxEntity monedaAFIPCBX;
	private SelectorBox monedaAFIPSBX;


	// -------------------------------------------------------------

	public WFMoneda2(String mode, String id) {
		super(mode, id);				
		dao = new MonedaDAO();
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

	private Component buildCuerpo() throws Exception {

		

		// ------------------------------------------------------------------

		numeroTXT = new TextFieldEntity(itemBI, "numero", this.mode) {
			protected boolean ifExists(Object arg) throws Exception {
				//MonedaAFIPDAO dao = new MonedaAFIPDAO();
				return dao.isExistsNumero((Integer)arg);
			}
		};

		// ------------------------------------------------------------------

		nombreTXT = new TextFieldEntity(itemBI, "nombre", this.mode) {
			protected boolean ifExists(Object arg) throws Exception {
				//MonedaAFIPDAO dao = new MonedaAFIPDAO();
				return dao.isExistsNombre((String)arg);
			}
		};

		// ------------------------------------------------------------------

		abreviaturaTXT = new TextFieldEntity(itemBI, "abreviatura", this.mode) {
			protected boolean ifExists(Object arg) throws Exception {
				//MonedaAFIPDAO dao = new MonedaAFIPDAO();
				return dao.isExistsAbreviatura((String)arg);
			}
		};

		// ------------------------------------------------------------------

		cotizacionTXT = new TextFieldEntity(itemBI, "cotizacion", this.mode);

		// ------------------------------------------------------------------

		cotizacionFechaDAF = new DateFieldEntity(itemBI, "cotizacionFecha", this.mode, true);

		// ------------------------------------------------------------------

		controlActualizacionCHK = new CheckBoxEntity(itemBI, "controlActualizacion");

		MonedaAFIPDAO monedaAFIPDAO = new MonedaAFIPDAO();

		long items = monedaAFIPDAO.count();

		if (items < 300) {

			MonedaAFIPFiltro monedaAFIPFiltro = new MonedaAFIPFiltro();

			monedaAFIPFiltro.setUnlimited(true);

			List<MonedaAFIP> monedaAFIPLista = monedaAFIPDAO.find(monedaAFIPFiltro);

			monedaAFIPCBX = new ComboBoxEntity(itemBI, "monedaAFIP", this.mode, monedaAFIPLista);

		} else {

			monedaAFIPSBX = new SelectorBox(WLMonedaAFIP.class, itemBI, "monedaAFIP") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					MonedaAFIPDAO dao = new MonedaAFIPDAO();

					return dao.findByCodigoOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) {

					MonedaAFIPFiltro filtro = new MonedaAFIPFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return new WLMonedaAFIP(filtro);

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
		
		
		if (numeroTXT != null) {
			generalVL.addComponent(numeroTXT);
		}
		if (nombreTXT != null) {
			generalVL.addComponent(nombreTXT);
		}
		if (abreviaturaTXT != null) {
			generalVL.addComponent(abreviaturaTXT);
		}
		if (cotizacionTXT != null) {
			generalVL.addComponent(cotizacionTXT);
		}
		if (cotizacionFechaDAF != null) {
			generalVL.addComponent(cotizacionFechaDAF);
		}
		if (controlActualizacionCHK != null) {
			generalVL.addComponent(controlActualizacionCHK);
		}
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
		
		//MonedaDAO dao = new MonedaDAO();
		if(dao == null){
			dao = new MonedaDAO();
		}	
		
		
		((Moneda) item).setNumero(dao.nextValueNumero());

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

			//MonedaDAO dao = new MonedaDAO();
			dao.insert(getItemBIC().getBean());
			// ((EntityId) getItemBIC().getBean()).insert();
			if (windowListado != null) {
				windowListado.loadDataResetPaged();
			}

			return getItemBIC().getBean();

		} catch (Exception e) {
			LogAndNotification.print(e);
			return null;
		}
	}
	
	protected Object update() throws Exception {

		try {

			//MonedaDAO dao = new MonedaDAO();
			dao.update(getItemBIC().getBean());
//			((EntityId) getItemBIC().getBean()).update();
			if (windowListado != null) {
				windowListado.loadDataResetPaged();
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
			//MonedaDAO dao = new MonedaDAO();
			if(dao == null){
				dao = new MonedaDAO();
			}			
			Moneda item = dao.findById(id);
			getItemBIC().setBean(item);

			return item;

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

		return (EntityId) getItemBIC().getBean();
	}

	// =================================================================================

}