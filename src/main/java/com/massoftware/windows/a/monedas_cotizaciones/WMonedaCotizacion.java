package com.massoftware.windows.a.monedas_cotizaciones;

import java.util.ArrayList;
import java.util.List;

import com.massoftware.model.EntityId;
import com.massoftware.model.Moneda;
import com.massoftware.model.MonedaCotizacion;
import com.massoftware.model.Usuario;
import com.massoftware.windows.CheckBoxEntity;
import com.massoftware.windows.ComboBoxEntity;
import com.massoftware.windows.DateFieldEntity;
import com.massoftware.windows.TextFieldEntity;
import com.massoftware.windows.UtilUI;
import com.massoftware.windows.WindowForm;
import com.vaadin.data.util.BeanItem;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.Label;
import com.vaadin.ui.VerticalLayout;

@SuppressWarnings("serial")
public class WMonedaCotizacion extends WindowForm {

	// -------------------------------------------------------------

	private BeanItem<MonedaCotizacion> itemBI;

	private BeanItem<ActualizacionDatosVigentes> itemActualizacionDatosVigentesBI;

	// -------------------------------------------------------------

	private ComboBoxEntity monedaCBX;
	private DateFieldEntity fechaDFT;
	private TextFieldEntity compraTXT;
	private TextFieldEntity ventaTXT;
	private DateFieldEntity auditoriaFechaDFT;
	private ComboBoxEntity usuarioCBX;
	private CheckBoxEntity cotizacionCHK;
	private CheckBoxEntity cotizacionFechaCHK;

	private HorizontalLayout r4HL;

	private Usuario usuario;

	// -------------------------------------------------------------

	public WMonedaCotizacion(String mode, String id, Usuario usuario) {
		super(mode, id);
		this.usuario = usuario;
		itemBI.getBean().setUsuario(usuario);
		r4HL.setVisible(UPDATE_MODE.equals(mode));

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
		List<Moneda> monedas = new Moneda().find();
		monedaCBX = new ComboBoxEntity(this.itemBI, "moneda", this.mode, monedas);
		// ---------------------------------------------------------------------------------------------------------
		fechaDFT = new DateFieldEntity(this.itemBI, "fecha", this.mode, true);
		// ---------------------------------------------------------------------------------------------------------
		compraTXT = new TextFieldEntity(this.itemBI, "compra", this.mode);
		// ---------------------------------------------------------------------------------------------------------
		ventaTXT = new TextFieldEntity(this.itemBI, "venta", this.mode);
		// ---------------------------------------------------------------------------------------------------------
		auditoriaFechaDFT = new DateFieldEntity(this.itemBI, "auditoriaFecha", this.mode, true);
		// --------------------------------------------------------------------------------------------------------
		List<Usuario> usuarios = new ArrayList<Usuario>();
		usuarios.add(usuario);
		usuarioCBX = new ComboBoxEntity(this.itemBI, "usuario", this.mode, usuarios);
		// ---------------------------------------------------------------------------------------------------------
		Label label = new Label("Actualización de datos vigentes");
		label.addStyleName("v-labeltext");
		// ---------------------------------------------------------------------------------------------------------
		cotizacionCHK = new CheckBoxEntity(this.itemActualizacionDatosVigentesBI, "cotizacion");
		// ---------------------------------------------------------------------------------------------------------
		cotizacionFechaCHK = new CheckBoxEntity(this.itemActualizacionDatosVigentesBI, "cotizacionFecha");
		// ---------------------------------------------------------------------------------------------------------

		HorizontalLayout r1HL = UtilUI.buildHL();
		r1HL.setMargin(false);
		r1HL.addComponents(monedaCBX, fechaDFT);

		HorizontalLayout r2HL = UtilUI.buildHL();
		r2HL.setMargin(false);
		r2HL.addComponents(compraTXT, ventaTXT);

		HorizontalLayout r3HL = UtilUI.buildHL();
		r3HL.setMargin(false);
		r3HL.addComponents(cotizacionCHK, cotizacionFechaCHK);

		r4HL = UtilUI.buildHL();
		r4HL.setMargin(false);
		r4HL.addComponents(auditoriaFechaDFT, usuarioCBX);

		VerticalLayout generalVL = UtilUI.buildVL();
		generalVL.addComponents(r1HL, r2HL, r4HL, label, r3HL);

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

		// ((Moneda) item).setNumero(this.itemBI.getBean().maxValueInteger("numero"));
	}

	protected void setBean(EntityId obj) throws Exception {

		// se utiliza para asignarle o cambiar el bean al contenedor del formulario

		itemBI.setBean((MonedaCotizacion) obj);
	}

	protected BeanItem<MonedaCotizacion> getItemBIC() {

		// -----------------------------------------------------------------
		// Crea el Container del form, en base a al bean que queremos usar, y ademas
		// carga el form con un bean vacio
		// como este metodo se llama muchas veces, inicializar el contenedor una sola
		// vez

		if (itemBI == null) {
			itemBI = new BeanItem<MonedaCotizacion>(new MonedaCotizacion());
			itemActualizacionDatosVigentesBI = new BeanItem<ActualizacionDatosVigentes>(
					new ActualizacionDatosVigentes());
		}
		return itemBI;
	}

	// =================================================================================

}
