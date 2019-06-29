package com.anthill.ant.fondos;

import com.anthill.Anthill;
import com.anthill.ant.Ant;
import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeInteger;

public class ComportamientoComprobanteAnt extends Ant {

	public ComportamientoComprobanteAnt(Anthill anthill) {
		super(anthill);
	}

	public Clazz build() throws Exception {

		//

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("ComportamientoComprobante");

		c.setNamePackage("fondos");
		c.setSingular("Comportamiento de comprobante");
		c.setPlural("Comportamientos de comprobante");
		c.setSingularPre("el comportamiento de comprobante");
		c.setPluralPre("los comportamientos de comprobante");

		// -------- Atts

		Att numero = new Att("numero", "Nº comportamiento");
		numero.setDataTypeInteger(1, null);
		((DataTypeInteger) numero.getDataType()).setNextValueProposed(true);
		numero.setRequired(true);
		numero.setUnique(true);
		c.addAtt(numero);

		Att nombre = new Att("nombre", "Nombre");
		nombre.setRequired(true);
		nombre.setUnique(true);
		nombre.setLength(null, 50);
		c.addAtt(nombre);

		// -------- SBX Args

		c.addArgument(numero, true);
		c.getLastArgument().setRequired(false);
		c.addArgumentSBX(c.getLastArgument());

		c.addArgument(nombre);
		c.getLastArgument().setRequired(false);
		c.addArgumentSBX(c.getLastArgument());

		// -------- Simple Args

		// -------- Order

		c.addOrderAllAtts();

		// ------------------------------------------------

		return c;

		// ------------------------------------------------
	}

}
