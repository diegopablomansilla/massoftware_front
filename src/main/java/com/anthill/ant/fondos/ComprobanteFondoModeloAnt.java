package com.anthill.ant.fondos;

import com.anthill.Anthill;
import com.anthill.ant.Ant;
import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeInteger;

public class ComprobanteFondoModeloAnt extends Ant {

	public ComprobanteFondoModeloAnt(Anthill anthill) {
		super(anthill);
	}

	public Clazz build() throws Exception {

		// SELECT  A.NUMERO, A.NOMBRE FROM FondosMod A ORDER BY  A.NUMERO

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("ComprobanteFondoModelo");

		c.setNamePackage("fondos");
		c.setSingular("Modelo de comprobante de fondo");
		c.setPlural("Modelos de comprobante de fondo");
		c.setSingularPre("el nodelo de comprobante de fondo");
		c.setPluralPre("los modelos de comprobante de fondo");

		// -------- Atts

		Att numero = new Att("numero", "Nº modelo");
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
