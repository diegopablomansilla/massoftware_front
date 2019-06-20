package com.massoftware.windows.a.jurisdicciones_convenio_multilateral;

import java.util.Iterator;
import java.util.List;

import com.massoftware.model.CuentaFondo;
import com.massoftware.model.CuentasFondoFiltro;
import com.massoftware.model.JuridiccionConvnioMultilateral;
import com.massoftware.model.JuridiccionConvnioMultilateralFiltro;
import com.massoftware.windows.cuentas_fondo.WCuentasFondo;
import com.massoftware.x.util.controls.SelectorBoxOld;
import com.massoftware.x.util.windows.LogAndNotification;
import com.vaadin.data.util.BeanItem;
import com.vaadin.ui.Window;

class WCCuentaFondoSB extends SelectorBoxOld {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7587377265502188967L;

	private WJuridiccionesConvnioMultilateral window;

	public WCCuentaFondoSB(WJuridiccionesConvnioMultilateral window) throws Exception {
		super(window.filterBI, "cuentaFondo", "");
		this.window = window;
		init();
	}

	@SuppressWarnings("rawtypes")
	public WCCuentaFondoSB(BeanItem dtoBI) throws Exception {
		super(dtoBI, "cuentaFondo", "");
		init();
	}

	private void init() {
		valueTXT.addBlurListener(e -> {
			blur();
		});
		openSelectorBTN.addClickListener(e -> {
			open(true);
		});
		removeFilterBTN.addClickListener(e -> {
			try {

				valueTXT.setValue(null);
				setSelectedItem(null);

			} catch (Exception ex) {
				LogAndNotification.print(ex);
			}
		});

		// valueTXT.addValueChangeListener(e -> {
		// try {
		//
		// System.err.println("valueTXT.getValue() " + valueTXT.getValue());
		// if (valueTXT.getValue() == null || valueTXT.getValue().trim().length() == 0)
		// {
		// if(window != null) {
		// window.loadDataResetPaged();
		// }
		// }
		// } catch (Exception ex) {
		// LogAndNotification.print(ex);
		// }
		// });

	}

	@SuppressWarnings({ "rawtypes" })
	void blur() {
		try {

			String value = getValue();

			if (value != null) {

				List items = new CuentaFondo().find(buildFiltro(true));

				if (items.size() == 1) {

					setSelectedItem(items.get(0));

				} else if (items.size() == 0) {
					
					open(false);
					
				} else {

					open(true);

				}
			} else {

				setSelectedItem(null);

			}
		} catch (Exception e) {
			LogAndNotification.print(e);
		}
	}

	@SuppressWarnings("rawtypes")
	protected void open(boolean filter) {
		try {

			Iterator it = getUI().getWindows().iterator();
			while (it.hasNext()) {
				Window w = (Window) it.next();
				if (w.getClass() == WCuentasFondo.class && w.getId() != null && w.getId().equals(uuid)) {
					return;
				}
			}

			WCuentasFondo windowPopup = new WCuentasFondo(buildFiltro(filter));
			windowPopup.setId(uuid);

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

			valueTXT.setValue(null);

			if (dtoBI.getBean() instanceof JuridiccionConvnioMultilateral) {

				((JuridiccionConvnioMultilateral) dtoBI.getBean()).setCuentaFondo((CuentaFondo) null);

			} else {
				((JuridiccionConvnioMultilateralFiltro) dtoBI.getBean()).setCuentaFondo((CuentaFondo) null);
			}

		} else {

			valueTXT.setValue(((CuentaFondo) item).getNumero() + " - " + ((CuentaFondo) item).getNombre());

			if (dtoBI.getBean() instanceof JuridiccionConvnioMultilateral) {

				((JuridiccionConvnioMultilateral) dtoBI.getBean()).setCuentaFondo((CuentaFondo) item);

			} else {
				((JuridiccionConvnioMultilateralFiltro) dtoBI.getBean()).setCuentaFondo((CuentaFondo) item);
			}

		}

		if (window != null) {
			window.loadDataResetPaged();
		}
	}

	private CuentasFondoFiltro buildFiltro(boolean filter) {

		String value = getValue();

		CuentasFondoFiltro filtro = new CuentasFondoFiltro();

		if (filter) {

			if (value != null && value.contains("-")) {

				String value1 = null;
				String value2 = null;

				value1 = value.split("-")[0].trim();
				value2 = value.split("-")[1].trim();

				try {

					filtro.setNumero(new Integer(value1));
					filtro.setNombre(value2);

				} catch (NumberFormatException e) {

					filtro.setNumero(null);
					filtro.setNombre(value2);
				}

			} else if (value != null) {

				try {

					filtro.setNumero(new Integer(value));
					filtro.setNombre(null);

				} catch (NumberFormatException e) {

					filtro.setNumero(null);
					filtro.setNombre(value);
				}

			}

		}

		return filtro;

	}

}
