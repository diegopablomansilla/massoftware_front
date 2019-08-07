
package com.massoftware.custom.x.fondos.banco;

import com.massoftware.x.fondos.banco.WFBanco;
import com.massoftware.x.util.UtilUI;
import com.vaadin.ui.Component;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.TabSheet;
import com.vaadin.ui.VerticalLayout;

@SuppressWarnings("serial")
public class WFBancoCustom extends WFBanco {

	// -------------------------------------------------------------

	public WFBancoCustom(String mode, String id) {
		super(mode, id);
	}

	protected Component buildCuerpoLayout() throws Exception {

		// ---------------------------------------------------------------------------------------------------------

		HorizontalLayout formatoExtractoRow0HL = UtilUI.buildHL();
		formatoExtractoRow0HL.setMargin(false);
		formatoExtractoRow0HL.addComponents(hojaTXT, primeraFilaTXT, ultimaFilaTXT);

		HorizontalLayout formatoExtractoRow3HL = UtilUI.buildHL();
		formatoExtractoRow3HL.setMargin(false);
		formatoExtractoRow3HL.addComponents(referencia1TXT, referencia2TXT);

		HorizontalLayout formatoExtractoRow4HL = UtilUI.buildHL();
		formatoExtractoRow4HL.setMargin(false);
		formatoExtractoRow4HL.addComponents(importeTXT, saldoTXT);

		VerticalLayout formatoExtractoVL = UtilUI.buildVL();
		formatoExtractoVL.addComponents(formatoExtractoRow0HL, fechaTXT, descripcionTXT, formatoExtractoRow3HL,
				formatoExtractoRow4HL);

		VerticalLayout generalVL = UtilUI.buildVL();
		generalVL.addComponents(numeroTXT, nombreTXT, cuitTXT, bloqueadoCHK);

		TabSheet tabSheet = UtilUI.buildTS();

		tabSheet.addTab(generalVL, "General");
		tabSheet.addTab(formatoExtractoVL, "Formato extracto");

		// ---------------------------------------------------------------------------------------------------------

		return tabSheet;
	}

	// =================================================================================

}