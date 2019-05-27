
package com.massoftware.x.geo;

import com.vaadin.data.util.BeanItem;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.Component;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.VerticalLayout;

import com.massoftware.windows.*;

import com.massoftware.model.EntityId;


import java.util.List;
import com.massoftware.model.geo.Provincia;
import com.massoftware.dao.geo.ProvinciaFiltro;
import com.massoftware.dao.geo.ProvinciaDAO;

import com.massoftware.model.geo.Ciudad;
import com.massoftware.dao.geo.CiudadDAO;

@SuppressWarnings("serial")
public class WFCiudad extends WindowForm {


	// -------------------------------------------------------------

	protected BeanItem<Ciudad> itemBI;
	
	private CiudadDAO dao;

	// -------------------------------------------------------------

	
	protected TextFieldEntity numeroTXT;
	protected TextFieldEntity nombreTXT;
	protected TextFieldEntity departamentoTXT;
	protected TextFieldEntity numeroAFIPTXT;
	protected ComboBoxEntity provinciaCBX;
	protected SelectorBox provinciaSBX;


	// -------------------------------------------------------------

	public WFCiudad(String mode, String id) {
		super(mode, id);					
	}

	protected CiudadDAO getDAO() {
		if(dao == null){
			dao = new CiudadDAO();
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

		numeroTXT = new TextFieldEntity(itemBI, "numero", this.mode) {
			protected boolean ifExists(Object arg) throws Exception {
				return getDAO().isExistsNumero((Integer)arg);
			}
		};

		numeroTXT.focus();

		// ------------------------------------------------------------------

		nombreTXT = new TextFieldEntity(itemBI, "nombre", this.mode) {
			protected boolean ifExists(Object arg) throws Exception {
				return getDAO().isExistsNombre((String)arg);
			}
		};

		// ------------------------------------------------------------------

		departamentoTXT = new TextFieldEntity(itemBI, "departamento", this.mode);

		// ------------------------------------------------------------------

		numeroAFIPTXT = new TextFieldEntity(itemBI, "numeroAFIP", this.mode);

		ProvinciaDAO provinciaDAO = new ProvinciaDAO();

		long items = provinciaDAO.count();

		if (items < 300) {

			ProvinciaFiltro provinciaFiltro = new ProvinciaFiltro();

			provinciaFiltro.setUnlimited(true);

			provinciaFiltro.setOrderBy("numero");

			List<Provincia> provinciaLista = provinciaDAO.find(provinciaFiltro);

			provinciaCBX = new ComboBoxEntity(itemBI, "provincia", this.mode, provinciaLista);

		} else {

			provinciaSBX = new SelectorBox(itemBI, "provincia") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					ProvinciaDAO dao = new ProvinciaDAO();

					return dao.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					ProvinciaFiltro filtro = new ProvinciaFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return windowBuilder.buildWLProvincia(filtro);

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
		if (departamentoTXT != null) {
			generalVL.addComponent(departamentoTXT);
		}
		if (numeroAFIPTXT != null) {
			generalVL.addComponent(numeroAFIPTXT);
		}
		if (provinciaCBX != null) {
			generalVL.addComponent(provinciaCBX);
		}
		if (provinciaSBX != null) {
			generalVL.addComponent(provinciaSBX);
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
		
		
		((Ciudad) item).setNumero(getDAO().nextValueNumero());

	}

	protected void setBean(EntityId obj) throws Exception {

		// se utiliza para asignarle o cambiar el bean al contenedor del formulario

		itemBI.setBean((Ciudad) obj);
	}

	protected BeanItem<Ciudad> getItemBIC() throws Exception {

		// -----------------------------------------------------------------
		// Crea el Container del form, en base a al bean que queremos usar, y ademas
		// carga el form con un bean vacio
		// como este metodo se llama muchas veces, inicializar el contenedor una sola
		// vez

		if (itemBI == null) {
			itemBI = new BeanItem<Ciudad>(new Ciudad());
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
			Ciudad item = getDAO().findById(id);
			getItemBIC().setBean(item);

			return item;

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

		return (EntityId) getItemBIC().getBean();
	}

	// =================================================================================

}