package com.massoftware.windows.cuentas_fondo;

import com.massoftware.windows.LogAndNotification;
import com.massoftware.windows.TextFieldBox;
import com.massoftware.windows.UtilUI;

class NombreTB extends TextFieldBox {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7877127761450061348L;

	public NombreTB(WCuentasFondo window) {

		super(window.filterBI, "nombre", "Nombre", false, 20, -1, 25, false, false, null, false,
				UtilUI.CONTAINS_WORDS_AND);

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
