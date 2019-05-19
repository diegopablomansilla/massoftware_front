package com.massoftware.windows.a.cuentas_contable;

import java.util.Iterator;
import java.util.List;

import com.massoftware.model.CuentaContable;
import com.massoftware.model.SeguridadPuerta;
import com.massoftware.model.SeguridadPuertasFiltro;
import com.massoftware.windows.LogAndNotification;
import com.massoftware.windows.SelectorBoxOld;
import com.massoftware.windows.a.seguridad_puertas.WSeguridadPuertas;
import com.vaadin.data.util.BeanItem;
import com.vaadin.ui.Window;

class WCPuertaSB extends SelectorBoxOld {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7587377265502188967L;

	@SuppressWarnings("rawtypes")
	public WCPuertaSB(BeanItem dtoBI) throws Exception {
		super(dtoBI, "seguridadPuerta", "");
		init();
	}

	private void init() {
//		valueTXT.addBlurListener(e -> {
//			blur();
//		});
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

	}

	@SuppressWarnings({ "rawtypes" })
	void blur() {
		try {

			String value = getValue();

			if (value != null) {

				List items = new SeguridadPuerta().find(buildFiltro(true));

				if (items.size() == 1) {

					setSelectedItem(items.get(0));

				} else if (items.size() == 0) {

					open(false);

				} else {

					open(true);

				}
			} else {

				setSelectedItem(null);
				open(false);

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
				if (w.getClass() == WSeguridadPuertas.class && w.getId() != null && w.getId().equals(uuid)) {
					return;
				}
			}

			WSeguridadPuertas windowPopup = new WSeguridadPuertas(buildFiltro(filter));
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

			((CuentaContable) dtoBI.getBean()).setSeguridadPuerta((SeguridadPuerta) null);

		} else {

//			valueTXT.setValue(((SeguridadPuerta) item).getNumero() + " - " + ((SeguridadPuerta) item).getNombre());
			
			valueTXT.setValue(item.toString());

			((CuentaContable) dtoBI.getBean()).setSeguridadPuerta((SeguridadPuerta) item);

		}

	}

	private SeguridadPuertasFiltro buildFiltro(boolean filter) {

//		String value = getValue();

		SeguridadPuertasFiltro filtro = new SeguridadPuertasFiltro();

		// if (filter) {
		//
		// if (value != null && value.contains("-")) {
		//
		// String value1 = null;
		// String value2 = null;
		//
		// value1 = value.split("-")[0].trim();
		// value2 = value.split("-")[1].trim();
		//
		// try {
		//
		// filtro.setNumero(new Integer(value1));
		// filtro.setNombre(value2);
		//
		// } catch (NumberFormatException e) {
		//
		// filtro.setNumero(null);
		// filtro.setNombre(value2);
		// }
		//
		// } else if (value != null) {
		//
		// try {
		//
		// filtro.setNumero(new Integer(value));
		// filtro.setNombre(null);
		//
		// } catch (NumberFormatException e) {
		//
		// filtro.setNumero(null);
		// filtro.setNombre(value);
		// }
		//
		// }
		//
		// }

		return filtro;

	}

}
