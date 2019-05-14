
package com.massoftware.x.monedas;

import com.vaadin.data.util.BeanItem;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.VerticalLayout;

import com.massoftware.windows.*;

import com.massoftware.model.EntityId;



import com.massoftware.model.monedas.MonedaAFIP;
import com.massoftware.dao.monedas.MonedaAFIPDAO;

@SuppressWarnings("serial")
public class WFMonedaAFIP extends WindowForm {

	// -------------------------------------------------------------

	private BeanItem<MonedaAFIP> itemBI;
	
	private MonedaAFIPDAO dao;

	// -------------------------------------------------------------

	
	private TextFieldEntity codigoTXT;
	private TextFieldEntity nombreTXT;


	// -------------------------------------------------------------

	public WFMonedaAFIP(String mode, String id) {
		super(mode, id);
		dao = new MonedaAFIPDAO();
	}

	protected void buildContent() throws Exception {

		confWinForm(this.itemBI.getBean().labelSingular());
		this.setWidth(28f, Unit.EM);

		// =======================================================
		// CUERPO

		VerticalLayout cuerpo = buildCuerpo();

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

	private VerticalLayout buildCuerpo() throws Exception {

		

		// ------------------------------------------------------------------

		codigoTXT = new TextFieldEntity(itemBI, "codigo", this.mode) {
			protected boolean checkUnique(Object arg) throws Exception {
				//MonedaAFIPDAO dao = new MonedaAFIPDAO();
				return dao.isUniqueCodigo((String)arg);
			}
		};

		// ------------------------------------------------------------------

		nombreTXT = new TextFieldEntity(itemBI, "nombre", this.mode) {
			protected boolean checkUnique(Object arg) throws Exception {
				//MonedaAFIPDAO dao = new MonedaAFIPDAO();
				return dao.isUniqueNombre((String)arg);
			}
		};


		// ------------------------------------------------------------------

		VerticalLayout generalVL = UtilUI.buildVL();
		generalVL.addComponents(codigoTXT, nombreTXT);

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

		itemBI.setBean((MonedaAFIP) obj);
	}

	protected BeanItem<MonedaAFIP> getItemBIC() throws Exception {

		// -----------------------------------------------------------------
		// Crea el Container del form, en base a al bean que queremos usar, y ademas
		// carga el form con un bean vacio
		// como este metodo se llama muchas veces, inicializar el contenedor una sola
		// vez

		if (itemBI == null) {
			itemBI = new BeanItem<MonedaAFIP>(new MonedaAFIP());
		}
		return itemBI;
	}

	protected Object insert() throws Exception {

		try {

			//MonedaAFIPDAO dao = new MonedaAFIPDAO();
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

			//MonedaAFIPDAO dao = new MonedaAFIPDAO();
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
			MonedaAFIPDAO dao = new MonedaAFIPDAO();
			MonedaAFIP item = dao.findById(id, 0);
			getItemBIC().setBean(item);

			return item;

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

		return (EntityId) getItemBIC().getBean();
	}

	// =================================================================================

}