package com.massoftware.windows.asientos_modelo;

import java.util.List;

import com.massoftware.model.AsientoModeloItem;
import com.massoftware.model.CuentaContable;
import com.massoftware.model.CuentasContableFiltro;
import com.massoftware.windows.LogAndNotification;
import com.massoftware.windows.SelectorBox;
import com.massoftware.windows.cuentas_contable.WCuentasContable;
import com.vaadin.data.util.BeanItem;
import com.vaadin.server.Sizeable.Unit;

class WCCuentaContableSB extends SelectorBox {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7587377265502188967L;

	private WAsientoModelo window;

	private BeanItem<AsientoModeloItem> itemBI;

	public WCCuentaContableSB(BeanItem<AsientoModeloItem> itemBI, WAsientoModelo window) throws Exception {
		super(itemBI, "cuentaContable", "");

		setCaption(null);
		valueTXT.setCaption(null);
		valueTXT.setRequired(false);

		this.itemBI = itemBI;
		this.window = window;

		valueTXT.addBlurListener(e -> {
			blur();
		});
		openSelectorBTN.addClickListener(e -> {
			open();
		});
		removeFilterBTN.addClickListener(e -> {
			try {

				valueTXT.setValue(null);
				setSelectedItem(null);

			} catch (Exception ex) {
				LogAndNotification.print(ex);
			}
		});
		
		this.setWidth("100%");		
		valueTXT.setWidth(25f, Unit.EM);
	}

	@SuppressWarnings({ "rawtypes" })
	protected void blur() {
		try {

			String value = getValue();

			if (value != null) {

				CuentasContableFiltro filtro = new CuentasContableFiltro();
				filtro.setEjercicioContable(window.getItemBIC().getBean().getEjercicioContable());

				if (value.contains("-")) {
					value = value.split("-")[0].trim();
				}

				filtro.setCodigo(value);

				List items = new CuentaContable().find(filtro);

				if (items.size() == 1) {

					setSelectedItem(items.get(0));

				} else {

					open();

				}
			} else {

				setSelectedItem(null);

			}
		} catch (Exception e) {
			LogAndNotification.print(e);
		}
	}

	protected void open() {
		try {

			CuentasContableFiltro filtro = new CuentasContableFiltro();
			filtro.setEjercicioContable(window.getItemBIC().getBean().getEjercicioContable());
			// filtro.setNombre(this.getValue());

			WCuentasContable windowPopup = new WCuentasContable(filtro, true);

			windowPopup.addCloseListener(e -> {
				try {

					setSelectedItem(windowPopup.itemsGRD.getSelectedRow());

				} catch (Exception ex) {
					LogAndNotification.print(ex);
				}
			});

			windowPopup.seleccionarBTN.addClickListener(e -> {
				try {

					if (windowPopup.itemsGRD.getSelectedRow() != null) {

						setSelectedItem(windowPopup.itemsGRD.getSelectedRow());

						windowPopup.close();

					}

				} catch (Exception ex) {
					LogAndNotification.print(ex);
				}
			});

			getUI().addWindow(windowPopup);

		} catch (Exception e) {
			LogAndNotification.print(e);
		}
	}

	public void setSelectedItem(Object item) {

		if (item == null) {
			item = new CuentaContable();
		}

		if (((CuentaContable) item).getCodigo() != null) {
			valueTXT.setValue(((CuentaContable) item).getCodigo() + " - " + ((CuentaContable) item).getNombre());
			itemBI.getBean().setCuentaContable((CuentaContable) item);
		} else {
			valueTXT.setValue(null);
			itemBI.getBean().setCuentaContable(null);
		}

	}

}