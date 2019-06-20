
package com.massoftware.x.geo;

import com.massoftware.x.util.UtilUI;
import com.vaadin.ui.Component;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.VerticalLayout;

@SuppressWarnings("serial")
public class WFProvinciaCustom extends WFProvincia {

	// -------------------------------------------------------------

	public WFProvinciaCustom(String mode, String id) {
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

		// ------------------------------------------------------------------

		aHL.addComponent(numeroTXT);
		aHL.addComponent(abreviaturaTXT);
		aHL.addComponent(nombreTXT);

		generalVL.addComponent(aHL);

		bHL.addComponent(numeroAFIPTXT);
		bHL.addComponent(numeroIngresosBrutosTXT);
		bHL.addComponent(numeroRENATEATXT);

		generalVL.addComponent(bHL);

		if (paisCBX != null) {
			cHL.addComponent(paisCBX);
		}
		if (paisSBX != null) {
			cHL.addComponent(paisSBX);
		}

		generalVL.addComponent(cHL);

		// ---------------------------------------------------------------------------------------------------------

		return generalVL;

		// ---------------------------------------------------------------------------------------------------------
	}

}