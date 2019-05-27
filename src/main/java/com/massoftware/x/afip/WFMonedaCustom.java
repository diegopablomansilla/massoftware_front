
package com.massoftware.x.afip;

import com.massoftware.windows.UtilUI;
import com.massoftware.x.monedas.WFMoneda;
import com.vaadin.ui.Component;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.VerticalLayout;

@SuppressWarnings("serial")
public class WFMonedaCustom extends WFMoneda {

	// -------------------------------------------------------------

	public WFMonedaCustom(String mode, String id) {
		super(mode, id);
	}

	protected Component buildCuerpoLayout() throws Exception {
		
		this.setWidth(33f, Unit.EM);

		VerticalLayout generalVL = UtilUI.buildVL();

		HorizontalLayout aHL = UtilUI.buildHL();
		aHL.setMargin(false);
		HorizontalLayout bHL = UtilUI.buildHL();
		bHL.setMargin(false);
		HorizontalLayout cHL = UtilUI.buildHL();
		cHL.setMargin(false);
		HorizontalLayout dHL = UtilUI.buildHL();
		dHL.setMargin(false);

		// ------------------------------------------------------------------

		aHL.addComponent(numeroTXT);
		aHL.addComponent(abreviaturaTXT);
		aHL.addComponent(nombreTXT);						

		generalVL.addComponent(aHL);

		bHL.addComponent(cotizacionTXT);
		bHL.addComponent(cotizacionFechaDAF);						

		generalVL.addComponent(bHL);
		
		cHL.addComponent(controlActualizacionCHK);				

		generalVL.addComponent(cHL);

		if (monedaAFIPCBX != null) {
			dHL.addComponent(monedaAFIPCBX);
		}
		if (monedaAFIPSBX != null) {
			dHL.addComponent(monedaAFIPSBX);
		}

		generalVL.addComponent(dHL);

		// ---------------------------------------------------------------------------------------------------------

		return generalVL;

		// ---------------------------------------------------------------------------------------------------------
	}

}