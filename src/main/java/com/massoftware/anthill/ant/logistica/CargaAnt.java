package com.massoftware.anthill.ant.logistica;

import com.massoftware.anthill.Ant;
import com.massoftware.anthill.Anthill;
import com.massoftware.anthill.Att;
import com.massoftware.anthill.Clazz;
import com.massoftware.anthill.DataTypeInteger;

public class CargaAnt extends Ant {

	private Ant transporteAnt;

	public CargaAnt(Anthill anthill, Ant transporteAnt) {
		super(anthill);
		this.transporteAnt = transporteAnt;
	}

	public Clazz build() throws Exception {

		// SELECT A.CARGA, A.NOMBRE FROM Cargas A ORDER BY A.CARGA

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("Carga");

		c.setNamePackage("logistica");
		c.setSingular("Carga");
		c.setPlural("Cargas");
		c.setSingularPre("la carga");
		c.setPluralPre("las cargas");

		// -------- Atts

		Att numero = new Att("numero", "Nº carga");
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

		Att transporte = new Att("transporte", "Transporte");
		transporte.setDataTypeClazz(transporteAnt.build());
		transporte.setRequired(true);
		c.addAtt(transporte);

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
