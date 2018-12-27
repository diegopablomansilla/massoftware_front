package com.massoftware.windows.cuentas_fondo;

import java.util.List;

import com.massoftware.Context;
import com.massoftware.windows.LogAndNotification;
import com.massoftware.windows.SelectorBox;
import com.massoftware.windows.bancos.Bancos;
import com.massoftware.windows.bancos.BancosFiltro;
import com.massoftware.windows.bancos.WBancos;

class WCBancoSB extends SelectorBox {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7587377265502188967L;

	private WCuentasFondo window;

	public WCBancoSB(WCuentasFondo window) throws Exception {
		super(window.filterBI, "nombreBanco", "Banco", false);

		this.window = window;

		valueTXT.addBlurListener(e -> {
			blur();
		});
		openSelectorBTN.addClickListener(e -> {
			open();
		});
		removeFilterBTN.addClickListener(e -> {
			setValueNull();
		});
	}

	protected void blur() {
		try {
			window.filterBI.getBean().setNumeroBanco(null);
			if (window.filterBI.getBean().getNombreBanco() != null
					&& window.filterBI.getBean().getNombreBanco().length() > 0) {
				BancosFiltro bancosFiltro = new BancosFiltro();
				Integer n = null;
				try {
					n = new Integer(window.filterBI.getBean().getNombreBanco().trim());
				} catch (Exception e) {
				}
				if (n != null) {
					bancosFiltro.setNumero(n);
					bancosFiltro.setNombre(null);
					window.filterBI.getBean().setNumeroBanco(n);
					window.filterBI.getBean().setNombre(null);
				} else {
					bancosFiltro.setNumero(null);
					window.filterBI.getBean().setNumeroBanco(null);
					bancosFiltro.setNombre(window.filterBI.getBean().getNombre());
				}
				List<Bancos> bancos = null;//Context.getBancosBO().find(bancosFiltro);777
				if (bancos.size() == 1) {
					window.filterBI.getBean().setNumeroBanco(bancos.get(0).getNumero());
					window.filterBI.getBean().setNombreBanco(bancos.get(0).toString());
					window.loadDataResetPaged();
				} else {
					open();
				}
			} else {
				setValueNull();
			}
		} catch (Exception e) {
			LogAndNotification.print(e);
		}
	}

	protected void open() {
		try {
			window.filterBI.getBean().setNumeroBanco(null);
			BancosFiltro bancosFiltro = new BancosFiltro();
			bancosFiltro.setNombre(window.filterBI.getBean().getNombreBanco());
			WBancos window = new WBancos(bancosFiltro);
			window.addCloseListener(e -> {
				setValue(window);
			});
			window.seleccionarBTN.addClickListener(e -> {
				setValue(window);
			});
			getUI().addWindow(window);
		} catch (Exception e) {
			LogAndNotification.print(e);
		}
	}

	private void setValue(WBancos windowPopup) {
		try {
			Bancos item = (Bancos) windowPopup.itemsGRD.getSelectedRow();
			if (item != null) {
				valueTXT.setValue(item.toString());
				window.filterBI.getBean().setNumeroBanco(item.getNumero());
				window.filterBI.getBean().setNombreBanco(item.toString());
				windowPopup.close();
				window.loadDataResetPaged();
			} else {
				setValueNull();
			}
		} catch (Exception ex) {
			LogAndNotification.print(ex);
		}
	}

	private void setValueNull() {
		try {
			valueTXT.setValue(null);
			window.filterBI.getBean().setNumeroBanco(null);
			window.filterBI.getBean().setNombreBanco(null);
			window.loadDataResetPaged();
		} catch (Exception ex) {
			LogAndNotification.print(ex);
		}
	}

}
