package com.massoftware.windows.cuentas_fondo.grupo;

import com.massoftware.model.CuentaFondoGrupo;
import com.massoftware.model.CuentaFondoRubro;
import com.massoftware.model.EntityId;
import com.massoftware.windows.LogAndNotification;
import com.massoftware.windows.UniqueValidator;
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
	
	- enter en las cajas de filtrado
	- label class singular y plural de las clases entity
	- colocar los label en los entity y corregir en banco, rubro, tipoy grupo
	- en grupo hacer el maxnumber compuesto
	- el eliminar de entity id, buscar dependencias y hacer el check antes de eliminar
	- hacer los check null y unique antes de insertar y eliminar, esto en base a los tags del entity
	

	private static final long serialVersionUID = -6410625501465383928L;

	// -------------------------------------------------------------

	private BeanItem<CuentaFondoGrupo> itemBI;

	// -------------------------------------------------------------

	private ComboBox rubroCB;
	private TextField numeroTXT;
	private TextField nombreTXT;

	// -------------------------------------------------------------

	public WCuentaFondoGrupo(CuentaFondoRubro cuentaFondoRubro) {
		init(INSERT_MODE, null, cuentaFondoRubro);
	}

	public WCuentaFondoGrupo(String mode) {
		init(mode, null, null);
	}

	public WCuentaFondoGrupo(String mode, String id) {
		init(mode, id, null);
	}

	private void init(String mode, String id, CuentaFondoRubro cuentaFondoRubro) {

		try {

			this.id = id;
			this.mode = mode;

			// =======================================================
			// BEAN

			itemBI = new BeanItem<CuentaFondoGrupo>(new CuentaFondoGrupo());
			itemBI.getBean().setCuentaFondoRubro(cuentaFondoRubro);

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

		confWinForm("Grupo");
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

	@SuppressWarnings("serial")
	private VerticalLayout buildCouerpo() throws Exception {

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
		nombreTXT = UtilUI.buildTXT30100(itemBI, "nombre", false, true, false, null, false);
		nombreTXT.addValidator(new UniqueValidator(String.class, mode, "nombre", itemBI));

		// ---------------------------------------------------------------------------------------------------------

		VerticalLayout generalVL = UtilUI.buildVL();
		generalVL.addComponents(rubroCB, numeroTXT, nombreTXT);

		return generalVL;
	}

	// =================================================================================

	protected void setMaxValues() throws Exception {

		itemBI.getBean().setNumero((Integer) this.itemBI.getBean().maxValue("numero"));
	}

	protected void setBean(EntityId obj) throws Exception {

		itemBI.setBean((CuentaFondoGrupo) obj);
	}

	protected EntityId getBean() throws Exception {

		return itemBI.getBean();
	}

	// -----------------------------------------------------------------------------------

	protected void validateForm() {
		rubroCB.validate();
		numeroTXT.validate();
		nombreTXT.validate();
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
			this.getBean().insert();
			if (windowListado != null) {
				windowListado.loadDataResetPaged();
				((WCuentasFondo) windowListado).loadDataResetPagedTree(
						itemBI.getBean().getCuentaFondoRubro().getNumero(), itemBI.getBean().getNumero());
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
				((WCuentasFondo) windowListado).loadDataResetPagedTree(
						itemBI.getBean().getCuentaFondoRubro().getNumero(), itemBI.getBean().getNumero());
			}

			return this.getBean();

		} catch (Exception e) {
			LogAndNotification.print(e);
			return null;
		}
	}

}
