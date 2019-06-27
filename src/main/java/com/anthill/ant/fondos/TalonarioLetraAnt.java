package com.anthill.ant.fondos;

import com.anthill.Anthill;
import com.anthill.ant.Ant;
import com.anthill.model.Att;
import com.anthill.model.Clazz;

public class TalonarioLetraAnt extends Ant {

	public TalonarioLetraAnt(Anthill anthill) {
		super(anthill);
	}

	public Clazz build() throws Exception {

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("TalonarioLetra");

		c.setNamePackage("fondos");
		c.setSingular("Letra");
		c.setPlural("Letras");
		c.setSingularPre("la letra");
		c.setPluralPre("las letras");

		// -------- Atts

//		Att numero = new Att("numero", "Nº letra");
//		numero.setDataTypeInteger(1, null);
//		((DataTypeInteger) numero.getDataType()).setNextValueProposed(true);
//		numero.setRequired(true);
//		numero.setUnique(true);
//		c.addAtt(numero);

		Att nombre = new Att("nombre", "Nombre");
		nombre.setRequired(true);
		nombre.setUnique(true);
		nombre.setLength(null, 50);
		c.addAtt(nombre);

		// -------- SBX Args

//		c.addArgument(numero, true);
//		c.getLastArgument().setRequired(false);
//		c.addArgumentSBX(c.getLastArgument());

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
