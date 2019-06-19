package com.anthill.ant.seguridad;

import com.anthill.Anthill;
import com.anthill.ant.Ant;
import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeInteger;

public class SeguridadPuertaAnt extends Ant {

	// SELECT A."NO", A.DGRPNO, A.EQUATE, A.DESCRIPTION FROM dbo.SSECUR_Door A WHERE
	// ( A.DGRPNO = 3 ) ORDER BY A.DGRPNO, {fn UCASE( A.DESCRIPTION)}

	private Ant seguridadModuloAnt;

	public SeguridadPuertaAnt(Anthill anthill, Ant seguridadModuloAnt) {
		super(anthill);
		this.seguridadModuloAnt = seguridadModuloAnt;
	}

	public Clazz build() throws Exception {

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("SeguridadPuerta");

		c.setNamePackage("seguridad");
		c.setSingular("Puerta");
		c.setPlural("Puertas");
		c.setSingularPre("la puerta");
		c.setPluralPre("las puertas");

		// -------- Atts

		Att numero = new Att("numero", "Nº puerta");
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

		Att equate = new Att("equate", "I.D");
		equate.setRequired(true);
		// equate.setUnique(true);
		equate.setLength(null, 30);
		// equate.setColumns((float) 30);
		c.addAtt(equate);

		Att seguridadModulo = new Att("seguridadModulo", "Módulo");
		seguridadModulo.setDataTypeClazz(seguridadModuloAnt.build());
		seguridadModulo.setRequired(true);
		c.addAtt(seguridadModulo);

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
