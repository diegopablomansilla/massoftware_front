package com.anthill.ant.geo;

import com.anthill.Anthill;
import com.anthill.ant.Ant;
import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeInteger;

public class PaisAnt extends Ant {

	public PaisAnt(Anthill anthill) {
		super(anthill);
	}

	public Clazz build() throws Exception {

		// SELECT A.PAIS, A.NOMBRE, A.ABREVIATURA FROM Paises A ORDER BY A.NOMBRE,
		// A.PAIS

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("Pais");

		c.setNamePackage("geo");
		c.setSingular("País");
		c.setPlural("Países");
		c.setSingularPre("el país");
		c.setPluralPre("los países");

		// -------- Atts

		Att numero = new Att("numero", "Nº país");
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

		Att abreviatura = new Att("abreviatura", "Abreviatura");
		abreviatura.setRequired(true);
		abreviatura.setUnique(true);
		abreviatura.setLength(null, 5);
		abreviatura.setColumns((float) 5);
		c.addAtt(abreviatura);

		// -------- SBX Args

		c.addArgument(numero, true);
		c.getLastArgument().setRequired(false);
		c.addArgumentSBX(c.getLastArgument());

		c.addArgument(nombre);
		c.getLastArgument().setRequired(false);
		c.addArgumentSBX(c.getLastArgument());

		// -------- Simple Args

		c.addArgument(abreviatura);
		c.getLastArgument().setRequired(false);

		// -------- Order

		c.addOrderAllAtts();

		c.getOrderDefault().setDesc(true);

		// ------------------------------------------------

		return c;

		// ------------------------------------------------
	}

}
