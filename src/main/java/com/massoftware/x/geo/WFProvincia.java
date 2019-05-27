
package com.massoftware.x.geo;

import com.vaadin.data.util.BeanItem;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.Component;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.VerticalLayout;

import com.massoftware.windows.*;

import com.massoftware.model.EntityId;


import java.util.List;
import com.massoftware.model.geo.Pais;
import com.massoftware.dao.geo.PaisFiltro;
import com.massoftware.dao.geo.PaisDAO;

import com.massoftware.model.geo.Provincia;
import com.massoftware.dao.geo.ProvinciaDAO;

@SuppressWarnings("serial")
public class WFProvincia extends WindowForm {


	// -------------------------------------------------------------

	protected BeanItem<Provincia> itemBI;
	
	private ProvinciaDAO dao;

	// -------------------------------------------------------------

	
	protected TextFieldEntity numeroTXT;
	protected TextFieldEntity nombreTXT;
	protected TextFieldEntity abreviaturaTXT;
	protected TextFieldEntity numeroAFIPTXT;
	protected TextFieldEntity numeroIngresosBrutosTXT;
	protected TextFieldEntity numeroRENATEATXT;
	protected ComboBoxEntity paisCBX;
	protected SelectorBox paisSBX;


	// -------------------------------------------------------------

	public WFProvincia(String mode, String id) {
		super(mode, id);					
	}

	protected ProvinciaDAO getDAO() {
		if(dao == null){
			dao = new ProvinciaDAO();
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

		abreviaturaTXT = new TextFieldEntity(itemBI, "abreviatura", this.mode) {
			protected boolean ifExists(Object arg) throws Exception {
				return getDAO().isExistsAbreviatura((String)arg);
			}
		};

		// ------------------------------------------------------------------

		numeroAFIPTXT = new TextFieldEntity(itemBI, "numeroAFIP", this.mode);

		// ------------------------------------------------------------------

		numeroIngresosBrutosTXT = new TextFieldEntity(itemBI, "numeroIngresosBrutos", this.mode);

		// ------------------------------------------------------------------

		numeroRENATEATXT = new TextFieldEntity(itemBI, "numeroRENATEA", this.mode);

		PaisDAO paisDAO = new PaisDAO();

		long items = paisDAO.count();

		if (items < 300) {

			PaisFiltro paisFiltro = new PaisFiltro();

			paisFiltro.setUnlimited(true);

			paisFiltro.setOrderBy("numero");

			List<Pais> paisLista = paisDAO.find(paisFiltro);

			paisCBX = new ComboBoxEntity(itemBI, "pais", this.mode, paisLista);

		} else {

			paisSBX = new SelectorBox(itemBI, "pais") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					PaisDAO dao = new PaisDAO();

					return dao.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					PaisFiltro filtro = new PaisFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return windowBuilder.buildWLPais(filtro);

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
		if (numeroAFIPTXT != null) {
			generalVL.addComponent(numeroAFIPTXT);
		}
		if (numeroIngresosBrutosTXT != null) {
			generalVL.addComponent(numeroIngresosBrutosTXT);
		}
		if (numeroRENATEATXT != null) {
			generalVL.addComponent(numeroRENATEATXT);
		}
		if (paisCBX != null) {
			generalVL.addComponent(paisCBX);
		}
		if (paisSBX != null) {
			generalVL.addComponent(paisSBX);
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
		
		
		((Provincia) item).setNumero(getDAO().nextValueNumero());

	}

	protected void setBean(EntityId obj) throws Exception {

		// se utiliza para asignarle o cambiar el bean al contenedor del formulario

		itemBI.setBean((Provincia) obj);
	}

	protected BeanItem<Provincia> getItemBIC() throws Exception {

		// -----------------------------------------------------------------
		// Crea el Container del form, en base a al bean que queremos usar, y ademas
		// carga el form con un bean vacio
		// como este metodo se llama muchas veces, inicializar el contenedor una sola
		// vez

		if (itemBI == null) {
			itemBI = new BeanItem<Provincia>(new Provincia());
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
			Provincia item = getDAO().findById(id);
			getItemBIC().setBean(item);

			return item;

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

		return (EntityId) getItemBIC().getBean();
	}

	// =================================================================================

}