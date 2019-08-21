package com.anthill.ant.fondos;

import com.anthill.Anthill;
import com.anthill.ant.Ant;
import com.anthill.model.Att;
import com.anthill.model.Clazz;

public class TalonarioControladorFizcalAnt extends Ant {

	public TalonarioControladorFizcalAnt(Anthill anthill) {
		super(anthill);
	}

	public Clazz build() throws Exception {

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("TalonarioControladorFizcal");
		c.setNamePlural("TalonariosControladoresFizcales");

		c.setNamePackage("fondos");
		c.setSingular("Controlador fizcal");
		c.setPlural("Controladores fizcales");
		c.setSingularPre("el controlador fizcal");
		c.setPluralPre("los controladores fizcales");

		// -------- Atts

		Att codigo = new Att("codigo", "Nº controlador");
//		numero.setDataTypeInteger(1, null);
//		((DataTypeInteger) numero.getDataType()).setNextValueProposed(true);
		codigo.setLength(null, (Integer.MAX_VALUE + "").length());
		codigo.setRequired(true);
		codigo.setUnique(true);
		c.addAtt(codigo);

		Att nombre = new Att("nombre", "Nombre");
		nombre.setRequired(true);
		nombre.setUnique(true);
		nombre.setLength(null, 50);
		c.addAtt(nombre);

		// -------- SBX Args

		c.addArgument(codigo, true);
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
