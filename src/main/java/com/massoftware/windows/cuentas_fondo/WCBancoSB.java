package com.massoftware.windows.cuentas_fondo;

import java.util.List;

import com.massoftware.model.Banco;
import com.massoftware.model.BancosFiltro;
import com.massoftware.windows.LogAndNotification;
import com.massoftware.windows.SelectorBox;
import com.massoftware.windows.bancos.WBancos;

class WCBancoSB extends SelectorBox {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7587377265502188967L;

	private WCuentasFondo window;

	public WCBancoSB(WCuentasFondo window) throws Exception {
		super(window.filterBI, "nombreBanco", new Banco().labelSingular(), false);

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

			window.filterBI.getBean().setterTrim();

			window.filterBI.getBean().setIdBanco(null);
			window.filterBI.getBean().setNumeroBanco(null);

			if (window.filterBI.getBean().getNombreBanco() != null) {

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
					bancosFiltro.setNombre(window.filterBI.getBean().getNombreBanco());
				}

				List<Banco> bancos = new Banco().find(bancosFiltro);

				if (bancos.size() == 1) {
					setValue(bancos.get(0));
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

			window.filterBI.getBean().setIdBanco(null);
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

			Banco item = (Banco) windowPopup.itemsGRD.getSelectedRow();

			if (item != null) {

				setValue(item);
				windowPopup.close();
				window.loadDataResetPaged();

			} else {

				setValueNull();
			}

		} catch (Exception ex) {
			LogAndNotification.print(ex);
		}
	}

	private void setValue(Banco item) {
		valueTXT.setValue(item.toString());
		window.filterBI.getBean().setIdBanco(item.getId());
		window.filterBI.getBean().setNumeroBanco(item.getNumero());
		window.filterBI.getBean().setNombreBanco(item.toString());
	}

	private void setValueNull() {
		try {
			valueTXT.setValue(null);
			window.filterBI.getBean().setIdBanco(null);
			window.filterBI.getBean().setNumeroBanco(null);
			window.filterBI.getBean().setNombreBanco(null);
			window.loadDataResetPaged();
		} catch (Exception ex) {
			LogAndNotification.print(ex);
		}
	}

}
