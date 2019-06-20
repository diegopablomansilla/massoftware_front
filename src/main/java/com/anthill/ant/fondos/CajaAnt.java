package com.anthill.ant.fondos;

import com.anthill.Anthill;
import com.anthill.ant.Ant;
import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeInteger;

public class CajaAnt extends Ant {
	
	private Ant seguridadPuertaAnt;

	public CajaAnt(Anthill anthill, Ant seguridadPuertaAnt) {
		super(anthill);
		this.seguridadPuertaAnt = seguridadPuertaAnt;
	}

	public Clazz build() throws Exception {

		// SELECT  A.CAJA, A.NOMBRE FROM Cajas A ORDER BY  A.CAJA
		
		
		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("Caja");

		c.setNamePackage("fondos");
		c.setSingular("Caja");
		c.setPlural("Cajas");
		c.setSingularPre("la caja");
		c.setPluralPre("las cajas");

		// -------- Atts

		Att numero = new Att("numero", "Nº caja");
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
		
		Att seguridadPuerta = new Att("seguridadPuerta", "Puerta");
		seguridadPuerta.setDataTypeClazz(seguridadPuertaAnt.build());
//		seguridadPuerta.setRequired(true);
		c.addAtt(seguridadPuerta);

		
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
