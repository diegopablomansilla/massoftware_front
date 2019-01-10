package com.massoftware.windows.banco;

import com.massoftware.model.Banco;
import com.massoftware.model.EntityId;
import com.massoftware.windows.UniqueValidator;
import com.massoftware.windows.UtilUI;
import com.massoftware.windows.WindowForm;
import com.vaadin.data.util.BeanItem;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.CheckBox;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.TabSheet;
import com.vaadin.ui.TextField;
import com.vaadin.ui.VerticalLayout;

@SuppressWarnings("serial")
public class WBanco extends WindowForm {

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

	public WBanco(String mode, String id) {
		super(mode, id);
	}

	protected void buildContent() throws Exception {

		confWinForm(this.itemBI.getBean().labelSingular());
		this.setWidth(28f, Unit.EM);

		// =======================================================
		// CUERPO

		TabSheet cuerpo = buildCuerpo();

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

	private TabSheet buildCuerpo() throws Exception {

		// ---------------------------------------------------------------------------------------------------------
		numeroTXT = UtilUI.buildTXTIntegerPlus(itemBI, "numero", false, true);
		numeroTXT.addValidator(new UniqueValidator(Integer.class, mode, "numero", itemBI));
		// ---------------------------------------------------------------------------------------------------------
		nombreTXT = UtilUI.buildTXT30100(itemBI, "nombre", false, true);
		nombreTXT.addValidator(new UniqueValidator(String.class, mode, "nombre", itemBI));
		// ---------------------------------------------------------------------------------------------------------
		cuitTXT = UtilUI.buildTXT(itemBI, "cuit", "CUIT", false, 11, 1, 11, true, true, "99-99999999-9", true);
		cuitTXT.addValidator(new UniqueValidator(Long.class, mode, "cuit", itemBI));
		// ---------------------------------------------------------------------------------------------------------
		bloqueadoCHX = UtilUI.buildFieldCHK(itemBI, "bloqueado", false);
		// ---------------------------------------------------------------------------------------------------------
		hojaTXT = UtilUI.buildTXTIntegerPlus(itemBI, "hoja", false, false);
		// ---------------------------------------------------------------------------------------------------------
		primeraFilaTXT = UtilUI.buildTXTIntegerPlus(itemBI, "primeraFila", false, false);
		// ---------------------------------------------------------------------------------------------------------
		ultimaFilaTXT = UtilUI.buildTXTIntegerPlus(itemBI, "ultimaFila", false, false);
		// ---------------------------------------------------------------------------------------------------------
		fechaTXT = UtilUI.buildTXT(itemBI, "fecha", null, false, 6, 1, 3, false, false, null, false);
		// ---------------------------------------------------------------------------------------------------------
		descripcionTXT = UtilUI.buildTXT(itemBI, "descripcion", null, false, 6, 1, 3, false, false, null, false);
		// ---------------------------------------------------------------------------------------------------------
		referencia1TXT = UtilUI.buildTXT(itemBI, "referencia1", null, false, 6, 1, 3, false, false, null, false);
		// ---------------------------------------------------------------------------------------------------------
		importeTXT = UtilUI.buildTXT(itemBI, "importe", null, false, 6, 1, 3, false, false, null, false);
		// ---------------------------------------------------------------------------------------------------------
		referencia2TXT = UtilUI.buildTXT(itemBI, "referencia2", null, false, 6, 1, 3, false, false, null, false);
		// ---------------------------------------------------------------------------------------------------------
		saldoTXT = UtilUI.buildTXT(itemBI, "saldo", null, false, 6, 1, 3, false, false, null, false);
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

		// ---------------------------------------------------------------------------------------------------------

		return tabSheet;

		// ---------------------------------------------------------------------------------------------------------
	}

	// =================================================================================

	protected void setMaxValues() throws Exception {
		// Al momento de insertar o copiar a veces se necesita el maximo valor de ese
		// atributo, + 1, esto es asi para hacer una especie de numero incremental de
		// ese atributo
		// Este metodo se ejecuta despues de consultar a la base de datos el bean en
		// base a su id

		itemBI.getBean().setNumero(this.itemBI.getBean().maxValueInteger("numero"));
	}

	protected void setBean(EntityId obj) throws Exception {

		// se utiliza para asignarle o cambiar el bean al contenedor del formulario

		itemBI.setBean((Banco) obj);
	}

	protected BeanItem<Banco> getItemsBIC() {

		// -----------------------------------------------------------------
		// Crea el Container del form, en base a al bean que queremos usar, y ademas
		// carga el form con un bean vacio
		// como este metodo se llama muchas veces, inicializar el contenedor una sola
		// vez

		if (itemBI == null) {
			itemBI = new BeanItem<Banco>(new Banco());
		}
		return itemBI;
	}

	// =================================================================================

}
