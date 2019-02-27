package com.massoftware.windows.a.monedas;

import java.util.List;

import com.massoftware.model.EntityId;
import com.massoftware.model.Moneda;
import com.massoftware.model.MonedaAFIP;
import com.massoftware.windows.CheckBoxEntity;
import com.massoftware.windows.ComboBoxEntity;
import com.massoftware.windows.DateFieldEntity;
import com.massoftware.windows.TextFieldEntity;
import com.massoftware.windows.UtilUI;
import com.massoftware.windows.WindowForm;
import com.vaadin.data.util.BeanItem;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.VerticalLayout;

@SuppressWarnings("serial")
public class WMoneda extends WindowForm {

	// -------------------------------------------------------------

	private BeanItem<Moneda> itemBI;

	// -------------------------------------------------------------

	private TextFieldEntity numeroTXT;
	private TextFieldEntity nombreTXT;
	private TextFieldEntity abreviaturaTXT;
	private TextFieldEntity cotizacionTXT;
	private DateFieldEntity cotizacionFechaDFT;
	private CheckBoxEntity controlActualizacionCHX;
	private ComboBoxEntity monedaAFIPCBX;

	private HorizontalLayout cotizacionHL;

	// -------------------------------------------------------------

	public WMoneda(String mode, String id) {
		super(mode, id);

		cotizacionHL.setVisible(UPDATE_MODE.equals(mode));

	}

	protected void buildContent() throws Exception {

		confWinForm(this.itemBI.getBean().labelSingular());
		// this.setWidth(28f, Unit.EM);

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
		numeroTXT = new TextFieldEntity(this.itemBI, "numero", this.mode);
		// ---------------------------------------------------------------------------------------------------------
		nombreTXT = new TextFieldEntity(this.itemBI, "nombre", this.mode);
		// ---------------------------------------------------------------------------------------------------------
		abreviaturaTXT = new TextFieldEntity(this.itemBI, "abreviatura", this.mode);
		// ---------------------------------------------------------------------------------------------------------
		cotizacionTXT = new TextFieldEntity(this.itemBI, "cotizacion", this.mode);
		// ---------------------------------------------------------------------------------------------------------
		cotizacionFechaDFT = new DateFieldEntity(this.itemBI, "cotizacionFecha", this.mode, true);
		// ---------------------------------------------------------------------------------------------------------
		controlActualizacionCHX = new CheckBoxEntity(this.itemBI, "controlActualizacion");
		// ---------------------------------------------------------------------------------------------------------
		List<MonedaAFIP> monedasAFIP = new MonedaAFIP().find();
		monedaAFIPCBX = new ComboBoxEntity(this.itemBI, "monedaAFIP", this.mode, monedasAFIP);
		// ---------------------------------------------------------------------------------------------------------

		HorizontalLayout nombresHL = UtilUI.buildHL();
		nombresHL.setMargin(false);
		nombresHL.addComponents(abreviaturaTXT, nombreTXT);

		cotizacionHL = UtilUI.buildHL();
		cotizacionHL.setMargin(false);
		cotizacionHL.addComponents(cotizacionTXT, cotizacionFechaDFT);

		VerticalLayout generalVL = UtilUI.buildVL();
		generalVL.addComponents(numeroTXT, nombresHL, cotizacionHL, controlActualizacionCHX, monedaAFIPCBX);

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

		((Moneda) item).setNumero(this.itemBI.getBean().maxValueInteger("numero"));
	}

	protected void setBean(EntityId obj) throws Exception {

		// se utiliza para asignarle o cambiar el bean al contenedor del formulario

		itemBI.setBean((Moneda) obj);
	}

	protected BeanItem<Moneda> getItemBIC() {

		// -----------------------------------------------------------------
		// Crea el Container del form, en base a al bean que queremos usar, y ademas
		// carga el form con un bean vacio
		// como este metodo se llama muchas veces, inicializar el contenedor una sola
		// vez

		if (itemBI == null) {
			itemBI = new BeanItem<Moneda>(new Moneda());
		}
		return itemBI;
	}

	// =================================================================================

}
