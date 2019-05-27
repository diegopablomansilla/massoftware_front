
package com.massoftware.x.geo;

import com.vaadin.data.util.BeanItem;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.Component;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.VerticalLayout;

import com.massoftware.windows.*;

import com.massoftware.model.EntityId;


import java.util.List;
import com.massoftware.model.geo.Ciudad;
import com.massoftware.dao.geo.CiudadFiltro;
import com.massoftware.dao.geo.CiudadDAO;

import com.massoftware.model.geo.CodigoPostal;
import com.massoftware.dao.geo.CodigoPostalDAO;

@SuppressWarnings("serial")
public class WFCodigoPostal extends WindowForm {


	// -------------------------------------------------------------

	protected BeanItem<CodigoPostal> itemBI;
	
	private CodigoPostalDAO dao;

	// -------------------------------------------------------------

	
	protected TextFieldEntity codigoTXT;
	protected TextFieldEntity numeroTXT;
	protected TextFieldEntity nombreCalleTXT;
	protected TextFieldEntity numeroCalleTXT;
	protected ComboBoxEntity ciudadCBX;
	protected SelectorBox ciudadSBX;


	// -------------------------------------------------------------

	public WFCodigoPostal(String mode, String id) {
		super(mode, id);					
	}

	protected CodigoPostalDAO getDAO() {
		if(dao == null){
			dao = new CodigoPostalDAO();
		}
		
		return dao;
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

		codigoTXT = new TextFieldEntity(itemBI, "codigo", this.mode) {
			protected boolean ifExists(Object arg) throws Exception {
				return getDAO().isExistsCodigo((String)arg);
			}
		};

		codigoTXT.focus();

		// ------------------------------------------------------------------

		numeroTXT = new TextFieldEntity(itemBI, "numero", this.mode) {
			protected boolean ifExists(Object arg) throws Exception {
				return getDAO().isExistsNumero((Integer)arg);
			}
		};

		// ------------------------------------------------------------------

		nombreCalleTXT = new TextFieldEntity(itemBI, "nombreCalle", this.mode);

		// ------------------------------------------------------------------

		numeroCalleTXT = new TextFieldEntity(itemBI, "numeroCalle", this.mode);

		CiudadDAO ciudadDAO = new CiudadDAO();

		long items = ciudadDAO.count();

		if (items < 300) {

			CiudadFiltro ciudadFiltro = new CiudadFiltro();

			ciudadFiltro.setUnlimited(true);

			ciudadFiltro.setOrderBy("codigo");

			List<Ciudad> ciudadLista = ciudadDAO.find(ciudadFiltro);

			ciudadCBX = new ComboBoxEntity(itemBI, "ciudad", this.mode, ciudadLista);

		} else {

			ciudadSBX = new SelectorBox(itemBI, "ciudad") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					CiudadDAO dao = new CiudadDAO();

					return dao.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					CiudadFiltro filtro = new CiudadFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return windowBuilder.buildWLCiudad(filtro);

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
		
		
		if (codigoTXT != null) {
			generalVL.addComponent(codigoTXT);
		}
		if (numeroTXT != null) {
			generalVL.addComponent(numeroTXT);
		}
		if (nombreCalleTXT != null) {
			generalVL.addComponent(nombreCalleTXT);
		}
		if (numeroCalleTXT != null) {
			generalVL.addComponent(numeroCalleTXT);
		}
		if (ciudadCBX != null) {
			generalVL.addComponent(ciudadCBX);
		}
		if (ciudadSBX != null) {
			generalVL.addComponent(ciudadSBX);
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
		
		
		((CodigoPostal) item).setNumero(getDAO().nextValueNumero());

	}

	protected void setBean(EntityId obj) throws Exception {

		// se utiliza para asignarle o cambiar el bean al contenedor del formulario

		itemBI.setBean((CodigoPostal) obj);
	}

	protected BeanItem<CodigoPostal> getItemBIC() throws Exception {

		// -----------------------------------------------------------------
		// Crea el Container del form, en base a al bean que queremos usar, y ademas
		// carga el form con un bean vacio
		// como este metodo se llama muchas veces, inicializar el contenedor una sola
		// vez

		if (itemBI == null) {
			itemBI = new BeanItem<CodigoPostal>(new CodigoPostal());
		}
		return itemBI;
	}

	protected Object insert() throws Exception {

		try {
			
			getDAO().insert(getItemBIC().getBean());
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


			getDAO().update(getItemBIC().getBean());
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
			CodigoPostal item = getDAO().findById(id);
			getItemBIC().setBean(item);

			return item;

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

		return (EntityId) getItemBIC().getBean();
	}

	// =================================================================================

}