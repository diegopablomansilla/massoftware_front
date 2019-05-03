package com.massoftware.w.monedaafip;

import com.massoftware.dao.MonedaAFIPDAO;
import com.massoftware.model.EntityId;
import com.massoftware.model.MonedaAFIP;
import com.massoftware.windows.LogAndNotification;
import com.massoftware.windows.TextFieldEntity;
import com.massoftware.windows.UtilUI;
import com.massoftware.windows.WindowForm;
import com.vaadin.data.util.BeanItem;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.VerticalLayout;

@SuppressWarnings("serial")
public class WMonedaAFIP extends WindowForm {

	// -------------------------------------------------------------

	private BeanItem<MonedaAFIP> itemBI;

	// -------------------------------------------------------------

	private TextFieldEntity numeroTXT;
	private TextFieldEntity nombreTXT;	

	// -------------------------------------------------------------

	public WMonedaAFIP(String mode, String id) {
		super(mode, id);
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

		// ---------------------------------------------------------------------------------------------------------
		numeroTXT = new TextFieldEntity(this.itemBI, "codigo", this.mode);
		// ---------------------------------------------------------------------------------------------------------
		nombreTXT = new TextFieldEntity(this.itemBI, "nombre", this.mode);
		// ---------------------------------------------------------------------------------------------------------

		VerticalLayout generalVL = UtilUI.buildVL();
		generalVL.addComponents(numeroTXT, nombreTXT);

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

//		item.setNumero(this.itemBI.getBean().maxValueInteger("numero"));
	}

	protected void setBean(EntityId obj) throws Exception {

		// se utiliza para asignarle o cambiar el bean al contenedor del formulario

		itemBI.setBean((MonedaAFIP) obj);
	}

	protected BeanItem<MonedaAFIP> getItemBIC() {

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
			
			MonedaAFIPDAO dao = new MonedaAFIPDAO();			
			dao.insert(getItemBIC().getBean());			
//			((EntityId) getItemBIC().getBean()).insert();
			if (windowListado != null) {
				windowListado.loadDataResetPaged();
			}

			return getItemBIC().getBean();

		} catch (Exception e) {
			LogAndNotification.print(e);
			return null;
		}
	}

	// =================================================================================

}