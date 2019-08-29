package com.anthill.ant.contabilidad;

import com.anthill.Anthill;
import com.anthill.ant.Ant;
import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeInteger;

public class TipoPuntoEquilibrioAnt extends Ant {

	public TipoPuntoEquilibrioAnt(Anthill anthill) {
		super(anthill);
	}

	public Clazz build() throws Exception {

		//

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("TipoPuntoEquilibrio");
		c.setNamePlural("TiposPuntosEquilibrios");

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

		// -------- GRID

		c.addAttGrid(numero);
		c.addAttGrid(nombre);

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
