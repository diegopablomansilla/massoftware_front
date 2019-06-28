package com.anthill.ant.fondos;

import com.anthill.Anthill;
import com.anthill.ant.Ant;
import com.anthill.model.Argument;
import com.anthill.model.Att;
import com.anthill.model.Clazz;

public class TipoComprobanteConceptoAnt extends Ant {

	public TipoComprobanteConceptoAnt(Anthill anthill) {
		super(anthill);
	}

	public Clazz build() throws Exception {

		//

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("TipoComprobanteConcepto");

		c.setNamePackage("fondos");
		c.setSingular("Concepto");
		c.setPlural("Conceptos");
		c.setSingularPre("el concepto");
		c.setPluralPre("los conceptos");

		// -------- Atts

		Att codigo = new Att("codigo", "Código");
		codigo.setRequired(true);
		codigo.setUnique(true);
		codigo.setLength(null, 3);
		codigo.setColumns((float) 6);
		c.addAtt(codigo);

		Att nombre = new Att("nombre", "Nombre");
		nombre.setRequired(true);
		nombre.setUnique(true);
		nombre.setLength(null, 50);
		c.addAtt(nombre);

		// -------- SBX Args

		c.addArgument(codigo, Argument.EQUALS_IGNORE_CASE);
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
