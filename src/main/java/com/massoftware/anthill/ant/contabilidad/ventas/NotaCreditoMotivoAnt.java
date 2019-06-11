package com.massoftware.anthill.ant.contabilidad.ventas;

import com.massoftware.anthill.Ant;
import com.massoftware.anthill.Anthill;
import com.massoftware.anthill.Att;
import com.massoftware.anthill.Clazz;
import com.massoftware.anthill.DataTypeInteger;

public class NotaCreditoMotivoAnt extends Ant {

	// 'SELECT A.MOTIVO, A.NOMBRE FROM TablaMotivosNotasDeCredito A ORDER BY
	// A.NOMBRE, A.MOTIVO'

	public NotaCreditoMotivoAnt(Anthill anthill) {
		super(anthill);
	}

	public Clazz build() throws Exception {

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("NotaCreditoMotivo");

		c.setNamePackage("contabilidad.ventas");
		c.setSingular("Motivo de nota credito");
		c.setPlural("Motivos de nota credito");
		c.setSingularPre("el motivo de nota credito");
		c.setPluralPre("los motivos de nota credito");

		// -------- Atts

		Att numero = new Att("numero", "Nº motivo");
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
