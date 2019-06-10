
package com.massoftware.x.logistica;

import com.vaadin.data.util.BeanItem;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.Component;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.VerticalLayout;

import com.massoftware.windows.*;

import com.massoftware.model.EntityId;


import java.util.List;
import com.massoftware.model.geo.CodigoPostal;
import com.massoftware.dao.geo.CodigoPostalFiltro;
import com.massoftware.dao.geo.CodigoPostalDAO;

import com.massoftware.model.logistica.Transporte;
import com.massoftware.dao.logistica.TransporteDAO;

@SuppressWarnings("serial")
public class WFTransporte extends WindowForm {


	// -------------------------------------------------------------

	protected BeanItem<Transporte> itemBI;
	
	private TransporteDAO dao;

	// -------------------------------------------------------------

	
	protected TextFieldEntity numeroTXT;
	protected TextFieldEntity nombreTXT;
	protected TextFieldEntity cuitTXT;
	protected TextFieldEntity ingresosBrutosTXT;
	protected TextFieldEntity telefonoTXT;
	protected TextFieldEntity faxTXT;
	protected ComboBoxEntity codigoPostalCBX;
	protected SelectorBox codigoPostalSBX;
	protected TextFieldEntity domicilioTXT;
	protected TextAreaEntity comentarioTXA;


	// -------------------------------------------------------------

	public WFTransporte(String mode, String id) {
		super(mode, id);					
	}

	protected TransporteDAO getDAO() {
		if(dao == null){
			dao = new TransporteDAO();
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

		cuitTXT = new TextFieldEntity(itemBI, "cuit", this.mode) {
			protected boolean ifExists(Object arg) throws Exception {
				return getDAO().isExistsCuit((Long)arg);
			}
		};

		// ------------------------------------------------------------------

		ingresosBrutosTXT = new TextFieldEntity(itemBI, "ingresosBrutos", this.mode);

		// ------------------------------------------------------------------

		telefonoTXT = new TextFieldEntity(itemBI, "telefono", this.mode);

		// ------------------------------------------------------------------

		faxTXT = new TextFieldEntity(itemBI, "fax", this.mode);

		CodigoPostalDAO codigoPostalDAO = new CodigoPostalDAO();

		long codigoPostalItems = codigoPostalDAO.count();

		if (codigoPostalItems < MAX_ROWS_FOR_CBX) {

			CodigoPostalFiltro codigoPostalFiltro = new CodigoPostalFiltro();

			codigoPostalFiltro.setUnlimited(true);

			codigoPostalFiltro.setOrderBy(1);

			List<CodigoPostal> codigoPostalLista = codigoPostalDAO.find(codigoPostalFiltro);

			codigoPostalCBX = new ComboBoxEntity(itemBI, "codigoPostal", this.mode, codigoPostalLista);

		} else {

			codigoPostalSBX = new SelectorBox(itemBI, "codigoPostal") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					CodigoPostalDAO dao = new CodigoPostalDAO();

					return dao.findByCodigoOrNumero(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					CodigoPostalFiltro filtro = new CodigoPostalFiltro();

					if (filter) {

						filtro.setCodigo(getValue());

					}

					return windowBuilder.buildWLCodigoPostal(filtro);

				}

			};

		}

		// ------------------------------------------------------------------

		domicilioTXT = new TextFieldEntity(itemBI, "domicilio", this.mode);

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
		generalVL.addComponent(nombreTXT);
		generalVL.addComponent(cuitTXT);
		generalVL.addComponent(ingresosBrutosTXT);
		generalVL.addComponent(telefonoTXT);
		generalVL.addComponent(faxTXT);
		if (codigoPostalCBX != null) {
			generalVL.addComponent(codigoPostalCBX);
		}
		if (codigoPostalSBX != null) {
			generalVL.addComponent(codigoPostalSBX);
		}
		generalVL.addComponent(domicilioTXT);
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
		
		
		((Transporte) item).setNumero(getDAO().nextValueNumero());

	}

	protected void setBean(EntityId obj) throws Exception {

		// se utiliza para asignarle o cambiar el bean al contenedor del formulario

		itemBI.setBean((Transporte) obj);
	}

	protected BeanItem<Transporte> getItemBIC() throws Exception {

		// -----------------------------------------------------------------
		// Crea el Container del form, en base a al bean que queremos usar, y ademas
		// carga el form con un bean vacio
		// como este metodo se llama muchas veces, inicializar el contenedor una sola
		// vez

		if (itemBI == null) {
			itemBI = new BeanItem<Transporte>(new Transporte());
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
			Transporte item = getDAO().findById(id);
			getItemBIC().setBean(item);

			return item;

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

		return (EntityId) getItemBIC().getBean();
	}

	// =================================================================================

}