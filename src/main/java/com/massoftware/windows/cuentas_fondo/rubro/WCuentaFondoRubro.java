package com.massoftware.windows.cuentas_fondo.rubro;

import com.massoftware.model.CuentaFondoRubro;
import com.massoftware.model.EntityId;
import com.massoftware.windows.LogAndNotification;
import com.massoftware.windows.UniqueValidator;
import com.massoftware.windows.UtilUI;
import com.massoftware.windows.WindowForm;
import com.massoftware.windows.cuentas_fondo.WCuentasFondo;
import com.vaadin.data.util.BeanItem;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.TextField;
import com.vaadin.ui.VerticalLayout;

public class WCuentaFondoRubro extends WindowForm {

	private static final long serialVersionUID = -6410625501465383928L;

	// -------------------------------------------------------------

	private BeanItem<CuentaFondoRubro> itemBI;

	// -------------------------------------------------------------

	private TextField numeroTXT;
	private TextField nombreTXT;

	// -------------------------------------------------------------

	public WCuentaFondoRubro() {
		init(INSERT_MODE, null);
	}

	public WCuentaFondoRubro(String mode) {
		init(mode, null);
	}

	public WCuentaFondoRubro(String mode, String id) {
		init(mode, id);
	}

	private void init(String mode, String id) {

		try {

			this.id = id;
			this.mode = mode;

			// =======================================================
			// BEAN

			itemBI = new BeanItem<CuentaFondoRubro>(new CuentaFondoRubro());

			// =======================================================
			// LAYOUT CONTROLs

			buildContent();

			// =======================================================
			// KEY EVENTs

			addKeyEvents();

			// =======================================================
			// CARGA DE DATOS

			loadData(this.id);

			// =======================================================
			// ACTUALIZAR TITULO
			 
			actualizarTitulo();

			// =======================================================

		} catch (Exception e) {
			LogAndNotification.print(e);
		}
	}

	private void buildContent() throws Exception {

		confWinForm(this.itemBI.getBean().labelSingular());
		this.setWidth(31f, Unit.EM);

		// =======================================================
		// CUERPO

		VerticalLayout cuerpo = buildCouerpo();

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

	private VerticalLayout buildCouerpo() throws Exception {

		// ---------------------------------------------------------------------------------------------------------
		numeroTXT = UtilUI.buildTXTIntegerPlus(itemBI, "numero", false, true);		
		numeroTXT.addValidator(new UniqueValidator(Integer.class, mode, "numero", "Número", itemBI));
		// ---------------------------------------------------------------------------------------------------------
		nombreTXT = UtilUI.buildTXT30100(itemBI, "nombre", false, true);		
		nombreTXT.addValidator(new UniqueValidator(String.class, mode, "nombre", itemBI));

		// ---------------------------------------------------------------------------------------------------------

		VerticalLayout generalVL = UtilUI.buildVL();
		generalVL.addComponents(numeroTXT, nombreTXT);

		return generalVL;
	}

	// =================================================================================

	protected void setMaxValues() throws Exception {
		itemBI.getBean().setNumero((Integer) this.itemBI.getBean().maxValue("numero"));
	}

	protected void setBean(EntityId obj) throws Exception {

		itemBI.setBean((CuentaFondoRubro) obj);
	}

	protected EntityId getBean() throws Exception {

		return itemBI.getBean();
	}

	// -----------------------------------------------------------------------------------

	protected void validateForm() {
		numeroTXT.validate();
		nombreTXT.validate();
	}

	// =================================================================================
	// SECCION PARA CONSULTAS A LA BASE DE DATOS

	// metodo que realiza la consulta a la base de datos
	protected CuentaFondoRubro queryData() {
		try {

			CuentaFondoRubro item = new CuentaFondoRubro();
			item.loadById(id);
			if (COPY_MODE.equals(mode)) {
				item.setId(null);
			}

			return item;

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

		return new CuentaFondoRubro();
	}

	// =================================================================================

	protected Object insert() throws Exception {

		try {
			this.getBean().insert();
			if (windowListado != null) {
				windowListado.loadDataResetPaged();
				((WCuentasFondo) windowListado).loadDataResetPagedTree(itemBI.getBean().getNumero(), null);
			}

			return this.getBean();

		} catch (Exception e) {
			LogAndNotification.print(e);
			return null;
		}
	}

	protected Object update() throws Exception {

		try {
			this.getBean().update();
			if (windowListado != null) {
				windowListado.loadDataResetPaged();
				((WCuentasFondo) windowListado).loadDataResetPagedTree(itemBI.getBean().getNumero(), null);
			}

			return this.getBean();

		} catch (Exception e) {
			LogAndNotification.print(e);
			return null;
		}
	}

}
