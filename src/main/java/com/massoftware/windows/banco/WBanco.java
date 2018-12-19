package com.massoftware.windows.banco;

import com.massoftware.windows.LogAndNotification;
import com.massoftware.windows.UtilUI;
import com.massoftware.windows.comprobante_de_fondo.Cajas;
import com.massoftware.windows.comprobante_de_fondo.ComprobanteDeFondo;
import com.massoftware.windows.comprobante_de_fondo.ComprobanteDeFondoFiltro;
import com.vaadin.data.util.BeanItem;
import com.vaadin.event.ShortcutListener;
import com.vaadin.event.ShortcutAction.KeyCode;
import com.vaadin.event.ShortcutAction.ModifierKey;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.Button;
import com.vaadin.ui.CheckBox;
import com.vaadin.ui.DateField;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.TextField;
import com.vaadin.ui.VerticalLayout;
import com.vaadin.ui.Window;

public class WBanco extends Window {

	private static final long serialVersionUID = -6410625501465383928L;

	// -------------------------------------------------------------

	public final static String INSERT_MODE = "INSERT_MODE";
	public final static String UPDATE_MODE = "UPDATE_MODE";
	public final static String COPY_MODE = "COPY_MODE";

	private String mode;

	// -------------------------------------------------------------

	private BeanItem<BancoFiltro> filterBI;
	private BeanItem<Banco> itemBI;

	// -------------------------------------------------------------

	private Button agregarBTN;
	private Button modificarBTN;

	// -------------------------------------------------------------

	private TextField numero;
	private TextField nombre;
	private TextField nombreOficial;
	private TextField cuit;
	private CheckBox bloqueado;
	private TextField hoja;
	private TextField primeraFila;
	private TextField ultimaFila;
	private TextField fecha;
	private TextField descripcion;
	private TextField referencia1;
	private TextField importe;
	private TextField referencia2;
	private TextField saldo;

	// -------------------------------------------------------------

	public WBanco(BancoFiltro filtro) {
		init(filtro);
	}

	public void init(BancoFiltro filtro) {

		try {

			if (filtro != null) {
				filterBI = new BeanItem<BancoFiltro>(filtro);
			} else {
				filterBI = new BeanItem<BancoFiltro>(new BancoFiltro());
			}

			itemBI = new BeanItem<Banco>(new Banco());

			UtilUI.confWinForm(this, "Banco");
			this.setModal(true);

			// =======================================================
			// -------------------------------------------------------
			// FORM

			// =======================================================
			// -------------------------------------------------------
			// BOTONERA 1

			HorizontalLayout filaBotoneraHL = new HorizontalLayout();
			filaBotoneraHL.setSpacing(true);

			agregarBTN = UtilUI.buildButtonAgregar();
			agregarBTN.addClickListener(e -> {
				// save();
			});
			modificarBTN = UtilUI.buildButtonModificar();
			modificarBTN.addClickListener(e -> {
				// save();
			});

			agregarBTN.setVisible(INSERT_MODE.equals(mode));
			modificarBTN.setVisible(UPDATE_MODE.equals(mode));

			filaBotoneraHL.addComponents(agregarBTN, modificarBTN);

			// -------------------------------------------------------

			content.addComponents(hl, filaBotoneraHL);
			content.setComponentAlignment(filaBotoneraHL, Alignment.MIDDLE_LEFT);

			this.setContent(content);

			// =======================================================
			// -------------------------------------------------------
			// KEY EVENTs

			// Si tenemos la necesidad de un CBOX descomentamos este codigo
			// this.addShortcutListener(new ShortcutListener("ENTER",
			// KeyCode.ENTER, new int[] {}) {
			//
			// private static final long serialVersionUID = 1L;
			//
			// @Override
			// public void handleAction(Object sender, Object target) {
			// if (target.equals(control)) {
			//
			// }
			//
			// }
			// });

			// --------------------------------------------------

			this.addShortcutListener(new ShortcutListener("CTRL+S", KeyCode.S, new int[] { ModifierKey.CTRL }) {

				private static final long serialVersionUID = 1L;

				@Override
				public void handleAction(Object sender, Object target) {
					save();
				}
			});

			this.addShortcutListener(new ShortcutListener("DELETE", KeyCode.DELETE, new int[] {}) {

				private static final long serialVersionUID = 1L;

				@Override
				public void handleAction(Object sender, Object target) {
					if (target instanceof TextField && ((TextField) target).isEnabled()
							&& ((TextField) target).isReadOnly() == false) {
						((TextField) target).setValue(null);
					} else if (target instanceof DateField && ((DateField) target).isEnabled()
							&& ((DateField) target).isReadOnly() == false) {
						((DateField) target).setValue(null);
					}
				}
			});

			// =======================================================
			// -------------------------------------------------------

			loadData();

			if (INSERT_MODE.equalsIgnoreCase(mode)) {
				this.setCaption("Agregar " + getCaption().toLowerCase());
			} else if (UPDATE_MODE.equalsIgnoreCase(mode)) {
				this.setCaption("Modificar " + getCaption().toLowerCase() + " : " + itemBI.getBean());
			} else if (COPY_MODE.equalsIgnoreCase(mode)) {
				this.setCaption("Copiar " + getCaption() + " : " + itemBI.getBean());
			}

		} catch (Exception e) {
			LogAndNotification.print(e);
		}
	}

	private void buildContent() throws Exception {

		UtilUI.confWinForm(this, "Comprobante de fondo");
		this.setModal(false);

		// =======================================================

		VerticalLayout content = UtilUI.buildWinContentVertical();

		// =======================================================

		// =======================================================
		// FORM

		// =======================================================

		// BOTONERA 1

		HorizontalLayout filaBotoneraHL = new HorizontalLayout();
		filaBotoneraHL.setSpacing(true);

		agregarBTN = UtilUI.buildButtonAgregar();
		agregarBTN.addClickListener(e -> {
			// save();
		});
		modificarBTN = UtilUI.buildButtonModificar();
		modificarBTN.addClickListener(e -> {
			// save();
		});

		agregarBTN.setVisible(INSERT_MODE.equals(mode));
		modificarBTN.setVisible(UPDATE_MODE.equals(mode));

		filaBotoneraHL.addComponents(agregarBTN, modificarBTN);

		// -------------------------------------------------------

		content.addComponents(hl, filaBotoneraHL);
		content.setComponentAlignment(filaBotoneraHL, Alignment.MIDDLE_LEFT);

		this.setContent(content);

	}

}
