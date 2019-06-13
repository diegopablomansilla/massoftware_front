package com.massoftware.anthill.ant.contabilidad;

import com.massoftware.anthill.Ant;
import com.massoftware.anthill.Anthill;
import com.massoftware.anthill.Att;
import com.massoftware.anthill.Clazz;
import com.massoftware.anthill.DataTypeInteger;

public class TipoPuntoEquilibrioAnt extends Ant {

	public TipoPuntoEquilibrioAnt(Anthill anthill) {
		super(anthill);
	}

	public Clazz build() throws Exception {

		// 

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("TipoPuntoEquilibrio");

		c.setNamePackage("contabilidad");
		c.setSingular("Tipo punto equilibrio");
		c.setPlural("Tipos de puntos equilibrio");
		c.setSingularPre("el tipo de punto equilibrio");
		c.setPluralPre("los tipos de puntos equilibrio");

		// -------- Atts

		Att numero = new Att("numero", "Nº tipo");
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
