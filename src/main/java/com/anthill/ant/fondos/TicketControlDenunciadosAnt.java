package com.anthill.ant.fondos;

import com.anthill.Anthill;
import com.anthill.ant.Ant;
import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeInteger;

public class TicketControlDenunciadosAnt extends Ant {

	public TicketControlDenunciadosAnt(Anthill anthill) {
		super(anthill);
	}

	public Clazz build() throws Exception {

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("TicketControlDenunciados");
		c.setNamePlural("TicketsControlesDenunciados");

		c.setNamePackage("fondos");
		c.setSingular("Control denunciados");
		c.setPlural("Control denunciados");
		c.setSingularPre("el control denunciados");
		c.setPluralPre("los controles denunciados");

		// -------- Atts

		Att numero = new Att("numero", "Nº control");
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

		c.getOrderDefault().setDesc(true);

		// ------------------------------------------------

		return c;

		// ------------------------------------------------
	}

}
