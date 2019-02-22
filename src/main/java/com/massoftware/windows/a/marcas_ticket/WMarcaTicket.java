package com.massoftware.windows.a.marcas_ticket;

import java.sql.Timestamp;

import com.massoftware.model.ControlDenunciado;
import com.massoftware.model.EntityId;
import com.massoftware.model.MarcaTicket;
import com.massoftware.windows.DateFieldEntity;
import com.massoftware.windows.LogAndNotification;
import com.massoftware.windows.OptionGroupEntity;
import com.massoftware.windows.TextFieldEntity;
import com.massoftware.windows.UtilUI;
import com.massoftware.windows.WindowForm;
import com.vaadin.data.util.BeanItem;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.VerticalLayout;

@SuppressWarnings("serial")
public class WMarcaTicket extends WindowForm {

	// -------------------------------------------------------------

	private BeanItem<MarcaTicket> itemBI;

	// -------------------------------------------------------------

	private TextFieldEntity numeroTXT;
	private TextFieldEntity nombreTXT;
	private DateFieldEntity fechaDFT;
	private TextFieldEntity cantidadPorLotesTXT;
	private OptionGroupEntity controlDenunciadoOGE;
	private TextFieldEntity valorMaximoTXT;

	// -------------------------------------------------------------

	public WMarcaTicket(String mode, String id) {
		super(mode, id);

		if (COPY_MODE.equals(mode)) {
			itemBI.getBean().setFecha(null);
		}

		fechaDFT.setVisible(UPDATE_MODE.equals(mode));
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
		numeroTXT = new TextFieldEntity(this.itemBI, "numero", this.mode);
		// ---------------------------------------------------------------------------------------------------------
		nombreTXT = new TextFieldEntity(this.itemBI, "nombre", this.mode);
		// ---------------------------------------------------------------------------------------------------------
		fechaDFT = new DateFieldEntity(this.itemBI, "fecha", this.mode, true);
		// ---------------------------------------------------------------------------------------------------------
		cantidadPorLotesTXT = new TextFieldEntity(this.itemBI, "cantidadPorLotes", this.mode);
		// ---------------------------------------------------------------------------------------------------------
		ControlDenunciado controlDenunciado = new ControlDenunciado();
		controlDenunciado.setId("1");
		controlDenunciadoOGE = new OptionGroupEntity(this.itemBI, "controlDenunciado", new ControlDenunciado().find(),
				false, controlDenunciado);
		// ---------------------------------------------------------------------------------------------------------
		valorMaximoTXT = new TextFieldEntity(this.itemBI, "valorMaximo", this.mode);
		// ---------------------------------------------------------------------------------------------------------

		VerticalLayout generalVL = UtilUI.buildVL();
		generalVL.addComponents(numeroTXT, nombreTXT, fechaDFT, controlDenunciadoOGE, cantidadPorLotesTXT,
				valorMaximoTXT);

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

		((MarcaTicket) item).setNumero(((MarcaTicket) item).maxValueInteger("numero"));
	}

	protected void setBean(EntityId obj) throws Exception {

		// se utiliza para asignarle o cambiar el bean al contenedor del formulario

		itemBI.setBean((MarcaTicket) obj);
	}

	protected BeanItem<MarcaTicket> getItemBIC() {

		// -----------------------------------------------------------------
		// Crea el Container del form, en base a al bean que queremos usar, y ademas
		// carga el form con un bean vacio
		// como este metodo se llama muchas veces, inicializar el contenedor una sola
		// vez

		if (itemBI == null) {
			itemBI = new BeanItem<MarcaTicket>(new MarcaTicket());
		}
		return itemBI;
	}

	protected Object insert() throws Exception {

		try {
			((MarcaTicket) getItemBIC().getBean()).setFecha(new Timestamp(System.currentTimeMillis()));
			((EntityId) getItemBIC().getBean()).insert();
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
