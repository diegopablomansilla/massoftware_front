package com.massoftware.anthill.ant;

import java.math.BigDecimal;

import com.massoftware.anthill.Ant;
import com.massoftware.anthill.Anthill;
import com.massoftware.anthill.Argument;
import com.massoftware.anthill.Att;
import com.massoftware.anthill.Clazz;

public class ZonaAnt extends Ant {

	public ZonaAnt(Anthill anthill) {
		super(anthill);
	}

	public Clazz build() throws Exception {

		// 'SELECT A.ZONA, A.NOMBRE, A.BONIFICACION, A.RECARGO FROM Zonas A ORDER BY
		// A.ZONA'

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("Zona");

		c.setNamePackage("geo");
		c.setSingular("Zona");
		c.setPlural("Zonas");
		c.setSingularPre("la zona");
		c.setPluralPre("las zonas");

		Att codigo = new Att("codigo", "Código");
		codigo.setRequired(true);
		codigo.setUnique(true);
		codigo.setLength(null, 3);
		codigo.setColumns((float) 6);
		c.addAtt(codigo);

		// -------- Atts

		Att nombre = new Att("nombre", "Nombre");
		nombre.setRequired(true);
		nombre.setUnique(true);
		nombre.setLength(null, 50);
		c.addAtt(nombre);

		Att bonificacion = new Att("bonificacion", "Bonificación");
		bonificacion.setDataTypeBigDecimal(new BigDecimal("0"), new BigDecimal("99999.9999"), 13, 5);
		bonificacion.setRequired(false);
		c.addAtt(bonificacion);

		Att recargo = new Att("recargo", "Recargo");
		recargo.setDataTypeBigDecimal(new BigDecimal("0"), new BigDecimal("99999.9999"), 13, 5);
		recargo.setRequired(false);
		c.addAtt(recargo);

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
