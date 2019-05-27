package com.massoftware.anthill.ant;

import com.massoftware.anthill.Ant;
import com.massoftware.anthill.Anthill;
import com.massoftware.anthill.Argument;
import com.massoftware.anthill.Att;
import com.massoftware.anthill.Clazz;

public class MonedaAFIPAnt extends Ant {

	public MonedaAFIPAnt(Anthill anthill) {
		super(anthill);

	}

	public Clazz build() throws Exception {

		// SELECT A.MONEDAAFIP, A.DESCRIPCION FROM AfipMonedas A ORDER BY A.MONEDAAFIP

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("MonedaAFIP");

		c.setNamePackage("afip.monedas");
		c.setSingular("Moneda AFIP");
		c.setPlural("Monedas AFIP");
		c.setSingularPre("la moneda AFIP");
		c.setPluralPre("las monedas AFIP");

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

		// monedaAFIP.addOrder(codigo);
		// monedaAFIP.addOrder(nombre);

		c.addOrderAllAtts();

		// ------------------------------------------------

		return c;

		// ------------------------------------------------
	}

}
