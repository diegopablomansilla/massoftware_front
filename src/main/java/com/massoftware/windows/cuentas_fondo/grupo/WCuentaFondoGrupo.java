package com.massoftware.windows.cuentas_fondo.grupo;

import com.massoftware.model.CuentaFondoGrupo;
import com.massoftware.model.CuentaFondoRubro;
import com.massoftware.model.EntityId;
import com.massoftware.windows.LogAndNotification;
import com.massoftware.windows.UtilUI;
import com.massoftware.windows.WindowForm;
import com.massoftware.windows.cuentas_fondo.WCuentasFondo;
import com.vaadin.data.Property;
import com.vaadin.data.Property.ValueChangeEvent;
import com.vaadin.data.util.BeanItem;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.ComboBox;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.TextField;
import com.vaadin.ui.VerticalLayout;

public class WCuentaFondoGrupo extends WindowForm {

	private static final long serialVersionUID = -6410625501465383928L;

	// -------------------------------------------------------------

	private BeanItem<CuentaFondoGrupo> itemBI;

	// -------------------------------------------------------------

	private ComboBox rubroCB;
	private TextField numeroTXT;
	private TextField nombreTXT;

	// -------------------------------------------------------------

	public WCuentaFondoGrupo(String mode, String id) {

		super(mode, id);
	}

	public WCuentaFondoGrupo(String mode, String id, String cuentaFondoRubroId) {

		if (cuentaFondoRubroId != null) {
			CuentaFondoRubro cuentaFondoRubro = new CuentaFondoRubro();
			cuentaFondoRubro.setId(cuentaFondoRubroId);

			getItemsBIC().getBean().setCuentaFondoRubro(cuentaFondoRubro);

		}

		init(mode, id);
	}

	protected void buildContent() throws Exception {

		confWinForm(itemBI.getBean().labelSingular());
		this.setWidth(31f, Unit.EM);

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

	@SuppressWarnings("serial")
	private VerticalLayout buildCuerpo() throws Exception {

		// ---------------------------------------------------------------------------------------------------------
		rubroCB = UtilUI.buildFieldCB(itemBI, "cuentaFondoRubro", false, false, CuentaFondoRubro.class,
				new CuentaFondoRubro().find());
		rubroCB.addValueChangeListener(e -> {
			validateRubroAndNumero();
		});
		// ---------------------------------------------------------------------------------------------------------
		numeroTXT = UtilUI.buildTXTIntegerPlus(itemBI, "numero", false, true);
		numeroTXT.addValueChangeListener(new Property.ValueChangeListener() {
			public void valueChange(ValueChangeEvent event) {
				// String value = (String) event.getProperty().getValue();
				validateRubroAndNumero();
			}
		});
		// ---------------------------------------------------------------------------------------------------------
		nombreTXT = UtilUI.buildTXT30100(itemBI, "nombre", false, true);
		nombreTXT.addValueChangeListener(new Property.ValueChangeListener() {
			public void valueChange(ValueChangeEvent event) {
				validateRubroAndNombre();
			}
		});

		// ---------------------------------------------------------------------------------------------------------

		VerticalLayout generalVL = UtilUI.buildVL();
		generalVL.addComponents(rubroCB, numeroTXT, nombreTXT);

		return generalVL;
	}

	// =================================================================================

	protected void setMaxValues() throws Exception {

		itemBI.getBean()
				.setNumero((Integer) this.itemBI.getBean().maxValue(new String[] { "cuentaFondoRubro" }, "numero"));
	}

	protected void setBean(EntityId obj) throws Exception {

		itemBI.setBean((CuentaFondoGrupo) obj);
	}

	protected BeanItem<CuentaFondoGrupo> getItemsBIC() {

		// -----------------------------------------------------------------
		// Crea el Container del form, en base a al bean que queremos usar, y ademas
		// carga el form con un bean vacio

		if (itemBI == null) {
			itemBI = new BeanItem<CuentaFondoGrupo>(new CuentaFondoGrupo());
		}
		return itemBI;
	}

	// -----------------------------------------------------------------------------------

	private void validateRubroAndNumero() {
		try {

			if (COPY_MODE.equals(mode)) {
				((CuentaFondoGrupo) this.itemBI.getBean()._originalDTO).setNumero(null);
				((CuentaFondoGrupo) this.itemBI.getBean()._originalDTO).getCuentaFondoRubro().setNumero(null);
			}

			this.itemBI.getBean().checkUniqueRubroAndNumero();

		} catch (Exception ex) {
			LogAndNotification.print(ex);
		}
	}

	private void validateRubroAndNombre() {
		try {

			if (COPY_MODE.equals(mode)) {
				((CuentaFondoGrupo) this.itemBI.getBean()._originalDTO).setNombre(null);
				((CuentaFondoGrupo) this.itemBI.getBean()._originalDTO).getCuentaFondoRubro().setNumero(null);
			}

			this.itemBI.getBean().checkUniqueRubroAndNombre();

		} catch (Exception ex) {
			LogAndNotification.print(ex);
		}
	}

	// =================================================================================
	// SECCION PARA CONSULTAS A LA BASE DE DATOS

	// metodo que realiza la consulta a la base de datos
	protected CuentaFondoGrupo queryData() {
		try {

			CuentaFondoGrupo item = new CuentaFondoGrupo();
			item.loadById(id);
			if (COPY_MODE.equals(mode)) {
				item.setId(null);
			}

			return item;

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

		return new CuentaFondoGrupo();
	}

	// =================================================================================

	protected Object insert() throws Exception {

		try {
			itemBI.getBean().insert();
			if (windowListado != null) {
				windowListado.loadDataResetPaged();
				((WCuentasFondo) windowListado).loadDataResetPagedTree(
						itemBI.getBean().getCuentaFondoRubro().getNumero(), itemBI.getBean().getNumero());
			}

			return itemBI.getBean();

		} catch (Exception e) {
			LogAndNotification.print(e);
			return null;
		}
	}

	protected Object update() throws Exception {

		try {
			itemBI.getBean().update();
			if (windowListado != null) {
				windowListado.loadDataResetPaged();
				((WCuentasFondo) windowListado).loadDataResetPagedTree(
						itemBI.getBean().getCuentaFondoRubro().getNumero(), itemBI.getBean().getNumero());
			}

			return itemBI.getBean();

		} catch (Exception e) {
			LogAndNotification.print(e);
			return null;
		}
	}
	
	protected void validateForm() throws Exception {
		validateRubroAndNumero();
		validateRubroAndNombre();
		super.validateForm();
	}

}
