package com.massoftware.windows.banco2;

import com.massoftware.model.Banco;
import com.massoftware.windows.LogAndNotification;
import com.massoftware.windows.UtilUI;
import com.massoftware.windows.WindowForm;
import com.vaadin.data.util.BeanItem;
import com.vaadin.data.validator.AbstractValidator;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.CheckBox;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.TabSheet;
import com.vaadin.ui.TextField;
import com.vaadin.ui.VerticalLayout;

public class WBanco extends WindowForm {

	private static final long serialVersionUID = -6410625501465383928L;

	// -------------------------------------------------------------

	private BeanItem<Banco> itemBI;

	// -------------------------------------------------------------

	private TextField numeroTXT;
	private TextField nombreTXT;
	private TextField cuitTXT;
	private CheckBox bloqueadoCHX;
	private TextField hojaTXT;
	private TextField primeraFilaTXT;
	private TextField ultimaFilaTXT;
	private TextField fechaTXT;
	private TextField descripcionTXT;
	private TextField referencia1TXT;
	private TextField importeTXT;
	private TextField referencia2TXT;
	private TextField saldoTXT;

	// -------------------------------------------------------------

	public WBanco() {
		init(INSERT_MODE, null);
	}

	public WBanco(String mode) {
		init(mode, null);
	}

	public WBanco(String mode, String id) {
		init(mode, id);
	}

	private void init(String mode, String id) {

		try {

			this.id = id;
			this.mode = mode;

			// =======================================================
			// BEAN

			itemBI = new BeanItem<Banco>(new Banco());

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

			if (INSERT_MODE.equalsIgnoreCase(mode)) {
				this.setCaption("Agregar " + getCaption().toLowerCase());
			} else if (UPDATE_MODE.equalsIgnoreCase(mode)) {
				this.setCaption("Modificar " + getCaption().toLowerCase() + " : " + itemBI.getBean());
			} else if (COPY_MODE.equalsIgnoreCase(mode)) {
				this.setCaption("Copiar " + getCaption() + " : " + itemBI.getBean());
			}

			// =======================================================

		} catch (Exception e) {
			LogAndNotification.print(e);
		}
	}

	private void buildContent() throws Exception {

		confWinForm("BancoX");
		this.setWidth(31f, Unit.EM);

		// =======================================================
		// CUERPO

		TabSheet cuerpo = buildCouerpo();

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

	@SuppressWarnings({ "serial", "rawtypes" })
	private TabSheet buildCouerpo() throws Exception {

		// ---------------------------------------------------------------------------------------------------------
		numeroTXT = UtilUI.buildTXTShortPlus(itemBI, "numero", "Número", false, 1, true);

		numeroTXT.addValidator(new AbstractValidator("") {

			@Override
			protected boolean isValidValue(Object value) {

				try {

					if (COPY_MODE.equals(mode)) {
						itemBI.getBean().checkUnique("numero", numeroTXT.getCaption(), true);
					} else {
						itemBI.getBean().checkUnique("numero", numeroTXT.getCaption(), false);
					}

					return true;

				} catch (Exception e) {
					LogAndNotification.print(e);
					this.setErrorMessage(e.getMessage());
					return false;
				}

			}

			@Override
			public Class getType() {

				return Integer.class;
			}

		});
		// ---------------------------------------------------------------------------------------------------------
		nombreTXT = UtilUI.buildTXT(itemBI, "nombre", "Nombre", false, 40, 1, 40, true, false, null, false);
		nombreTXT.addValidator(new AbstractValidator("") {

			@Override
			protected boolean isValidValue(Object value) {

				try {

					if (COPY_MODE.equals(mode)) {
						itemBI.getBean().checkUnique("nombre", nombreTXT.getCaption(), true);
					} else {
						itemBI.getBean().checkUnique("nombre", nombreTXT.getCaption(), false);
					}

					return true;

				} catch (Exception e) {
					LogAndNotification.print(e);
					this.setErrorMessage(e.getMessage());
					return false;
				}

			}

			@Override
			public Class getType() {

				return String.class;
			}

		});
		// ---------------------------------------------------------------------------------------------------------
		cuitTXT = UtilUI.buildTXT(itemBI, "cuit", "CUIT", false, 11, 1, 11, true, true, "99-999999999-9", true);
		cuitTXT.addValidator(new AbstractValidator("") {

			@Override
			protected boolean isValidValue(Object value) {

				try {

					if (COPY_MODE.equals(mode)) {
						itemBI.getBean().checkUnique("cuit", cuitTXT.getCaption(), true);
					} else {
						itemBI.getBean().checkUnique("cuit", cuitTXT.getCaption(), false);
					}

					return true;

				} catch (Exception e) {
					LogAndNotification.print(e);
					this.setErrorMessage(e.getMessage());
					return false;
				}

			}

			@Override
			public Class getType() {

				return Long.class;
			}

		});
		// ---------------------------------------------------------------------------------------------------------
		bloqueadoCHX = UtilUI.buildFieldCHK(itemBI, "bloqueado", "Bloqueado", false);
		// ---------------------------------------------------------------------------------------------------------
		hojaTXT = UtilUI.buildTXTTinyintPlus(itemBI, "hoja", "Hoja", false, 1, false);
		// ---------------------------------------------------------------------------------------------------------
		primeraFilaTXT = UtilUI.buildTXTIntegerPlus(itemBI, "primeraFila", "Primera fila", false, 1, false);
		// ---------------------------------------------------------------------------------------------------------
		ultimaFilaTXT = UtilUI.buildTXTIntegerPlus(itemBI, "ultimaFila", "Última fila", false, 1, false);
		// ---------------------------------------------------------------------------------------------------------
		fechaTXT = UtilUI.buildTXT(itemBI, "fecha", "Fecha", false, 5, 1, 3, false, false, null, false);
		// ---------------------------------------------------------------------------------------------------------
		descripcionTXT = UtilUI.buildTXT(itemBI, "descripcion", "Descripcion", false, 6, 1, 3, false, false, null,
				false);
		// ---------------------------------------------------------------------------------------------------------
		referencia1TXT = UtilUI.buildTXT(itemBI, "referencia1", "Referencia1", false, 6, 1, 3, false, false, null,
				false);
		// ---------------------------------------------------------------------------------------------------------
		importeTXT = UtilUI.buildTXT(itemBI, "importe", "Importe", false, 6, 1, 3, false, false, null, false);
		// ---------------------------------------------------------------------------------------------------------
		referencia2TXT = UtilUI.buildTXT(itemBI, "referencia2", "Referencia2", false, 6, 1, 3, false, false, null,
				false);
		// ---------------------------------------------------------------------------------------------------------
		saldoTXT = UtilUI.buildTXT(itemBI, "saldo", "Saldo", false, 6, 1, 3, false, false, null, false);
		// ---------------------------------------------------------------------------------------------------------

		HorizontalLayout formatoExtractoRow0HL = UtilUI.buildHL();
		formatoExtractoRow0HL.setMargin(false);
		formatoExtractoRow0HL.addComponents(hojaTXT, primeraFilaTXT, ultimaFilaTXT);

		HorizontalLayout formatoExtractoRow3HL = UtilUI.buildHL();
		formatoExtractoRow3HL.setMargin(false);
		formatoExtractoRow3HL.addComponents(referencia1TXT, referencia2TXT);

		HorizontalLayout formatoExtractoRow4HL = UtilUI.buildHL();
		formatoExtractoRow4HL.setMargin(false);
		formatoExtractoRow4HL.addComponents(importeTXT, saldoTXT);

		VerticalLayout formatoExtractoVL = UtilUI.buildVL();
		formatoExtractoVL.addComponents(formatoExtractoRow0HL, fechaTXT, descripcionTXT, formatoExtractoRow3HL,
				formatoExtractoRow4HL);

		VerticalLayout generalVL = UtilUI.buildVL();
		generalVL.addComponents(numeroTXT, nombreTXT, cuitTXT, bloqueadoCHX);

		TabSheet tabSheet = UtilUI.buildTS();

		tabSheet.addTab(generalVL, "General");
		tabSheet.addTab(formatoExtractoVL, "Formato extracto");

		return tabSheet;
	}

	// =================================================================================

	protected void setMaxValues() throws Exception {
		itemBI.getBean().setNumero(maxNumero());
	}

	protected void setBean(Object obj) throws Exception {
		Banco item = (Banco) obj;

		itemBI.setBean(item);
	}

	// -----------------------------------------------------------------------------------

	protected void validateForm() {
		numeroTXT.validate();
		nombreTXT.validate();
		cuitTXT.validate();
		bloqueadoCHX.validate();
		hojaTXT.validate();
		primeraFilaTXT.validate();
		ultimaFilaTXT.validate();
		fechaTXT.validate();
		descripcionTXT.validate();
		referencia1TXT.validate();
		importeTXT.validate();
		referencia2TXT.validate();
		saldoTXT.validate();
	}

	// =================================================================================
	// SECCION PARA CONSULTAS A LA BASE DE DATOS

	public Integer maxNumero() throws Exception {
		return 893;// bo.maxNumero();
		666
	}

	// metodo que realiza la consulta a la base de datos
	protected Banco queryData() {
		try {

			Banco item = new Banco();
			item.loadById(id);

			return item;

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

		return new Banco();
	}

	protected Object insert() throws Exception {

		try {
			this.itemBI.getBean().insert();
			if (windowListado != null) {
				windowListado.loadDataResetPaged();
			}

			return itemBI.getBean();

		} catch (Exception e) {
			LogAndNotification.print(e);
			return null;
		}
	}

	protected Object update() throws Exception {

		try {
			this.itemBI.getBean().update();
			if (windowListado != null) {
				windowListado.loadDataResetPaged();
			}

			return itemBI.getBean();

		} catch (Exception e) {
			LogAndNotification.print(e);
			return null;
		}
	}

	// =================================================================================

}
