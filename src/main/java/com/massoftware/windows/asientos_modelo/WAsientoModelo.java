package com.massoftware.windows.asientos_modelo;

import java.util.ArrayList;
import java.util.List;

import com.massoftware.model.AsientoModelo;
import com.massoftware.model.AsientoModeloItem;
import com.massoftware.model.AsientoModeloItemFiltro;
import com.massoftware.model.EjercicioContable;
import com.massoftware.model.EntityId;
import com.massoftware.windows.ComboBoxEntity;
import com.massoftware.windows.LogAndNotification;
import com.massoftware.windows.TextFieldEntity;
import com.massoftware.windows.UtilUI;
import com.massoftware.windows.WindowForm;
import com.vaadin.data.Property;
import com.vaadin.data.Property.ValueChangeEvent;
import com.vaadin.data.util.BeanItem;
import com.vaadin.event.ShortcutAction.KeyCode;
import com.vaadin.event.ShortcutAction.ModifierKey;
import com.vaadin.event.ShortcutListener;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.Label;
import com.vaadin.ui.Panel;
import com.vaadin.ui.TextField;
import com.vaadin.ui.VerticalLayout;

@SuppressWarnings("serial")
public class WAsientoModelo extends WindowForm {

	// -------------------------------------------------------------

	private BeanItem<AsientoModelo> itemBI;

	private List<BeanItem<AsientoModeloItem>> itemsBI;

	// -------------------------------------------------------------

	private ComboBoxEntity ejercicioContableCBX;
	private TextFieldEntity numeroTXT;
	private TextFieldEntity nombreTXT;

	private VerticalLayout grillaVL;

	// -------------------------------------------------------------

	// public WPuntoEquilibrio(String mode, String id) {
	// super(mode, id);
	// }

	public WAsientoModelo(String mode, String id, EjercicioContable ejercicioContable) {

		getItemBIC().getBean().setEjercicioContable(ejercicioContable);

		init(mode, id);
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

		this.addShortcutListener(new ShortcutListener("CTRL+1", KeyCode.NUM1, new int[] { ModifierKey.CTRL }) {

			private static final long serialVersionUID = 1L;

			@Override
			public void handleAction(Object sender, Object target) {
				addRow(1);
			}
		});
		this.addShortcutListener(new ShortcutListener("CTRL+2", KeyCode.NUM2, new int[] { ModifierKey.CTRL }) {

			private static final long serialVersionUID = 1L;

			@Override
			public void handleAction(Object sender, Object target) {
				addRow(2);
			}
		});
		this.addShortcutListener(new ShortcutListener("CTRL+3", KeyCode.NUM3, new int[] { ModifierKey.CTRL }) {

			private static final long serialVersionUID = 1L;

			@Override
			public void handleAction(Object sender, Object target) {
				addRow(3);
			}
		});
		this.addShortcutListener(new ShortcutListener("CTRL+4", KeyCode.NUM4, new int[] { ModifierKey.CTRL }) {

			private static final long serialVersionUID = 1L;

			@Override
			public void handleAction(Object sender, Object target) {
				addRow(4);
			}
		});
		this.addShortcutListener(new ShortcutListener("CTRL+5", KeyCode.NUM5, new int[] { ModifierKey.CTRL }) {

			private static final long serialVersionUID = 1L;

			@Override
			public void handleAction(Object sender, Object target) {
				addRow(5);
			}
		});
		this.addShortcutListener(new ShortcutListener("CTRL+6", KeyCode.NUM6, new int[] { ModifierKey.CTRL }) {

			private static final long serialVersionUID = 1L;

			@Override
			public void handleAction(Object sender, Object target) {
				addRow(6);
			}
		});
		this.addShortcutListener(new ShortcutListener("CTRL+7", KeyCode.NUM7, new int[] { ModifierKey.CTRL }) {

			private static final long serialVersionUID = 1L;

			@Override
			public void handleAction(Object sender, Object target) {
				addRow(7);
			}
		});
		this.addShortcutListener(new ShortcutListener("CTRL+8", KeyCode.NUM8, new int[] { ModifierKey.CTRL }) {

			private static final long serialVersionUID = 1L;

			@Override
			public void handleAction(Object sender, Object target) {
				addRow(8);
			}
		});
		this.addShortcutListener(new ShortcutListener("CTRL+9", KeyCode.NUM9, new int[] { ModifierKey.CTRL }) {

			private static final long serialVersionUID = 1L;

			@Override
			public void handleAction(Object sender, Object target) {
				addRow(9);
			}
		});
		this.addShortcutListener(new ShortcutListener("CTRL+10", KeyCode.NUM0, new int[] { ModifierKey.CTRL }) {

			private static final long serialVersionUID = 1L;

			@Override
			public void handleAction(Object sender, Object target) {
				addRow(10);
			}
		});

		this.addShortcutListener(new ShortcutListener("ENTER", KeyCode.ENTER, new int[] {}) {

			private static final long serialVersionUID = 1L;

			@Override
			public void handleAction(Object sender, Object target) {
				if (target instanceof TextField) {
					TextField txt = (TextField) target;

					int x = new Integer(txt.getId().split("-")[0].trim());
					int y = new Integer(txt.getId().split("-")[1].trim());

					TextField txtCell = getCell(x + 1, y);
					if (txtCell != null) {
						txtCell.focus();
					} else if(y == 2 && txt.getParent() instanceof WCCuentaContableSB) {
						WCCuentaContableSB cuentaContableSB = (WCCuentaContableSB) txt.getParent();
						cuentaContableSB.blur();
					}
				}
			}
		});

		this.addShortcutListener(new ShortcutListener("ARROW_DOWN", KeyCode.ARROW_DOWN, new int[] {}) {

			private static final long serialVersionUID = 1L;

			@Override
			public void handleAction(Object sender, Object target) {
				if (target instanceof TextField) {
					TextField txt = (TextField) target;

					int x = new Integer(txt.getId().split("-")[0].trim());
					int y = new Integer(txt.getId().split("-")[1].trim());

					TextField txtCell = getCell(x + 1, y);
					if (txtCell != null) {
						txtCell.focus();
					}

				}
			}
		});

		this.addShortcutListener(new ShortcutListener("ARROW_DOWN", KeyCode.ARROW_UP, new int[] {}) {

			private static final long serialVersionUID = 1L;

			@Override
			public void handleAction(Object sender, Object target) {
				if (target instanceof TextField) {
					TextField txt = (TextField) target;

					int x = new Integer(txt.getId().split("-")[0].trim());
					int y = new Integer(txt.getId().split("-")[1].trim());

					TextField txtCell = getCell(x - 1, y);
					if (txtCell != null) {
						txtCell.focus();
					}

				}
			}
		});
		
		this.addShortcutListener(new ShortcutListener("CTRL+ARROW_LEFT", KeyCode.ARROW_LEFT, new int[] { ModifierKey.CTRL }) {

			private static final long serialVersionUID = 1L;

			@Override
			public void handleAction(Object sender, Object target) {
				if (target instanceof TextField) {
					TextField txt = (TextField) target;

					int x = new Integer(txt.getId().split("-")[0].trim());
					int y = new Integer(txt.getId().split("-")[1].trim());

					TextField txtCell = getCell(x, y -1);
					if (txtCell != null) {
						txtCell.focus();
					}

				}
			}
		});
		
		this.addShortcutListener(new ShortcutListener("CTRL+ARROW_RIGHT", KeyCode.ARROW_RIGHT, new int[] { ModifierKey.CTRL }) {

			private static final long serialVersionUID = 1L;

			@Override
			public void handleAction(Object sender, Object target) {
				if (target instanceof TextField) {
					TextField txt = (TextField) target;

					int x = new Integer(txt.getId().split("-")[0].trim());
					int y = new Integer(txt.getId().split("-")[1].trim());

					TextField txtCell = getCell(x, y + 1);
					if (txtCell != null) {
						txtCell.focus();
					}

				}
			}
		});
	}

	private VerticalLayout buildCuerpo() throws Exception {

		// ---------------------------------------------------------------------------------------------------------
		List<EjercicioContable> ejrcicios = new EjercicioContable().find();
		ejercicioContableCBX = new ComboBoxEntity(this.itemBI, "ejercicioContable", this.mode, ejrcicios);
		ejercicioContableCBX.addValueChangeListener(e -> {
			try {
				validateEjercicioContableAndNumero();
				validateEjercicioContableAndNombre();
			} catch (Exception e1) {
				LogAndNotification.print(e1);
			}
		});
		// ---------------------------------------------------------------------------------------------------------
		numeroTXT = new TextFieldEntity(this.itemBI, "numero", this.mode);
		numeroTXT.addValueChangeListener(new Property.ValueChangeListener() {
			public void valueChange(ValueChangeEvent event) {
				// String value = (String) event.getProperty().getValue();
				try {
					validateEjercicioContableAndNumero();
				} catch (Exception e) {
					LogAndNotification.print(e);
				}
			}
		});
		// ---------------------------------------------------------------------------------------------------------
		nombreTXT = new TextFieldEntity(this.itemBI, "nombre", this.mode);
		nombreTXT.addValueChangeListener(new Property.ValueChangeListener() {
			public void valueChange(ValueChangeEvent event) {
				try {
					validateEjercicioContableAndNombre();
				} catch (Exception e) {
					LogAndNotification.print(e);
				}
			}
		});
		// ---------------------------------------------------------------------------------------------------------

		Label label1 = new Label("Orden");
		label1.addStyleName("v-labeltext");
		// label1.setWidth("300px");
		label1.setWidth(10f, Unit.EM);

		Label label2 = new Label("Cuenta contable");
		label2.addStyleName("v-labeltext");

		VerticalLayout columnalVL = UtilUI.buildVL();
		columnalVL.setMargin(false);
		columnalVL.setSpacing(false);
		columnalVL.addComponents(label1);

		VerticalLayout columna2VL = UtilUI.buildVL();
		columna2VL.setMargin(false);
		columna2VL.setSpacing(false);
		columna2VL.addComponents(label2);

		HorizontalLayout cabeceraHL = UtilUI.buildHL();
		cabeceraHL.setMargin(false);
		cabeceraHL.setSpacing(false);
		cabeceraHL.addComponents(columnalVL, columna2VL);

		grillaVL = UtilUI.buildVL();
		grillaVL.setMargin(false);
		grillaVL.setSpacing(false);

		Panel panelGrid = new Panel();
		panelGrid.setSizeFull();
		panelGrid.setHeight(20.5f, Unit.EM);
		// seccionIzquierda.setWidth(25f, Unit.EM);
		// panelGrid.setHeight(5f, Unit.EM);
		panelGrid.setContent(grillaVL);

		VerticalLayout grillaVL = UtilUI.buildVL();
		grillaVL.setSizeFull();
		grillaVL.setMargin(false);
		grillaVL.setSpacing(false);
		grillaVL.addComponents(cabeceraHL, panelGrid);

		HorizontalLayout cabeceraVL = UtilUI.buildHL();
		cabeceraVL.setMargin(false);
		cabeceraVL.addComponents(ejercicioContableCBX, numeroTXT, nombreTXT);

		VerticalLayout generalVL = UtilUI.buildVL();
		generalVL.addComponents(cabeceraVL, grillaVL);

		// ---------------------------------------------------------------------------------------------------------

		return generalVL;

		// ---------------------------------------------------------------------------------------------------------
	}

	// =================================================================================

	private void validateEjercicioContableAndNumero() throws Exception {
		if (this.itemBI.getBean()._originalDTO != null && COPY_MODE.equals(mode)) {
			this.itemBI.getBean()._originalDTO.setterNull();
		}

		this.itemBI.getBean().checkUniqueEjercicioContableAndNumero();
	}

	private void validateEjercicioContableAndNombre() throws Exception {
		if (this.itemBI.getBean()._originalDTO != null && COPY_MODE.equals(mode)) {
			this.itemBI.getBean()._originalDTO.setterNull();
		}

		this.itemBI.getBean().checkUniqueEjercicioContableAndNombre();
	}

	protected void setMaxValues(EntityId item) throws Exception {
		// Al momento de insertar o copiar a veces se necesita el maximo valor de ese
		// atributo, + 1, esto es asi para hacer una especie de numero incremental de
		// ese atributo
		// Este metodo se ejecuta despues de consultar a la base de datos el bean en
		// base a su id

		AsientoModelo centroCostoContable = (AsientoModelo) item;

		Integer maxValue = (Integer) centroCostoContable.maxValue(new String[] { "ejercicioContable" }, "numero");

		centroCostoContable.setNumero(maxValue);
	}

	protected void setBean(EntityId obj) throws Exception {

		// se utiliza para asignarle o cambiar el bean al contenedor del formulario

		itemBI.setBean((AsientoModelo) obj);
	}

	protected BeanItem<AsientoModelo> getItemBIC() {

		// -----------------------------------------------------------------
		// Crea el Container del form, en base a al bean que queremos usar, y ademas
		// carga el form con un bean vacio
		// como este metodo se llama muchas veces, inicializar el contenedor una sola
		// vez

		if (itemBI == null) {
			itemBI = new BeanItem<AsientoModelo>(new AsientoModelo());
		}
		return itemBI;
	}

	protected void validateForm() throws Exception {
		validateEjercicioContableAndNumero();
		validateEjercicioContableAndNombre();
		super.validateForm();
	}

	// metodo que realiza la consulta a la base de datos
	protected EntityId queryData() throws Exception {
		try {

			AsientoModelo item = (AsientoModelo) getItemBIC().getBean();
			item.loadById(id); // consulta a DB
			addBeansToItemsBIC(item);

			return item;

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

		return (EntityId) getItemBIC().getBean();
	}

	protected void addBeansToItemsBIC(AsientoModelo asientoModelo) {

		// -----------------------------------------------------------------
		// Consulta a la base de datos y agrega los beans conseguidos al contenedor de
		// la grilla

		try {

			// -----------------------------------------------------------------

			AsientoModeloItemFiltro filtro = new AsientoModeloItemFiltro();
			filtro.setAsientoModelo(asientoModelo);

			// realiza la consulta a la base de datos
			List<AsientoModeloItem> items = new AsientoModeloItem().find(filtro);

			itemsBI = new ArrayList<BeanItem<AsientoModeloItem>>();

			// -----------------------------------------------------------------
			// Agrega los resultados a la grilla
			for (int i = 0; i < items.size(); i++) {

				BeanItem<AsientoModeloItem> itemBI = new BeanItem<AsientoModeloItem>(items.get(i));

				addRow(i + 1, itemBI);

				itemsBI.add(itemBI);
			}

			// -----------------------------------------------------------------

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

	}

	private void addRow(int n) {

		try {

			int c = itemsBI.get(itemsBI.size() - 1).getBean().getNumero();

			for (int i = 0; i < n; i++) {

				c++;
				AsientoModeloItem item = new AsientoModeloItem();
				item.setNumero(c);
				BeanItem<AsientoModeloItem> itemBI = new BeanItem<AsientoModeloItem>(item);
				itemsBI.add(itemBI);
				addRow(c, itemBI);

			}

		} catch (Exception e) {
			LogAndNotification.print(e);
		}
	}

	private List<TextField> cajasCol1 = new ArrayList<TextField>();
	private List<TextField> cajasCol2 = new ArrayList<TextField>();

	private void addRow(int index, BeanItem<AsientoModeloItem> itemBI) throws Exception {

		TextFieldEntity itemNumeroTXT = new TextFieldEntity(itemBI, "numero", this.mode);
		itemNumeroTXT.setWidth(10f, Unit.EM);
		itemNumeroTXT.setCaption(null);
		// itemNumeroTXT.setReadOnly(true);
		itemNumeroTXT.setRequired(false);
		itemNumeroTXT.setId(cajasCol1.size() + "-" + 1);

		WCCuentaContableSB cuentaContableSB = new WCCuentaContableSB(itemBI, this);
		cuentaContableSB.valueTXT.setId(cajasCol2.size() + "-" + 2);

		cajasCol1.add(itemNumeroTXT);
		cajasCol2.add(cuentaContableSB.valueTXT);

		HorizontalLayout filaHL = UtilUI.buildHL();
		filaHL.setMargin(false);
		filaHL.setSpacing(false);

		filaHL.addComponents(itemNumeroTXT, cuentaContableSB);

		filaHL.setComponentAlignment(itemNumeroTXT, Alignment.BOTTOM_LEFT);

		grillaVL.addComponents(filaHL);

	}

	private TextField getCell(int x, int y) {

		if (y == 1) {

			for (TextField txtItem : cajasCol1) {

				int xx = new Integer(txtItem.getId().split("-")[0].trim());
				int yy = new Integer(txtItem.getId().split("-")[1].trim());

				if (x == xx && y == yy) {
					return txtItem;
				}

			}
		} else if (y == 2) {
			for (TextField txtItem : cajasCol2) {

				int xx = new Integer(txtItem.getId().split("-")[0].trim());
				int yy = new Integer(txtItem.getId().split("-")[1].trim());

				if (x == xx && y == yy) {
					return txtItem;
				}

			}
		}

		return null;
	}

	// =================================================================================

}
