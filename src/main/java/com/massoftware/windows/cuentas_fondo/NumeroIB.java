package com.massoftware.windows.cuentas_fondo;

import com.massoftware.windows.LogAndNotification;
import com.massoftware.windows.TextFieldIntegerBox;
import com.massoftware.windows.UtilUI;

class NumeroIB extends TextFieldIntegerBox {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7877127761450061348L;

	public NumeroIB(WCuentasFondo window) {

		super(window.filterBI, "numero", "Cuenta", false, 5, -1, 3, false, false, null, false, UtilUI.EQUALS, 0, 255);

		valueTXT.addTextChangeListener(e -> {
			try {
				valueTXT.setValue(e.getText());
				window.loadDataResetPaged();
			} catch (Exception ex) {
				LogAndNotification.print(ex);
			}
		});

		removeFilterBTN.addClickListener(e -> {
			window.loadDataResetPaged();
		});
	}

}
