package com.anthill.ant.fondos;

import com.anthill.Anthill;
import com.anthill.ant.Ant;
import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeInteger;

public class ClaseComprobanteAnt extends Ant {

	public ClaseComprobanteAnt(Anthill anthill) {
		super(anthill);
	}

	public Clazz build() throws Exception {

		//

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("ClaseComprobante");

		c.setNamePackage("fondos");
		c.setSingular("Clase");
		c.setPlural("Clases");
		c.setSingularPre("la clase");
		c.setPluralPre("las clases");

		// -------- Atts

		Att numero = new Att("numero", "Nº clase");
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
