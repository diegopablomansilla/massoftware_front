package com.anthill.ant.clientes;

import com.anthill.Anthill;
import com.anthill.ant.Ant;
import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeInteger;

public class MotivoComentarioAnt extends Ant {

	public MotivoComentarioAnt(Anthill anthill) {
		super(anthill);
	}

	public Clazz build() throws Exception {

		// SELECT A.MOTIVO, A.NOMBRE FROM TablaMotivosComentarios A ORDER BY A.NOMBRE,
		// A.MOTIVO

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("MotivoComentario");
		c.setNamePlural("MotivosComentario");

		c.setNamePackage("clientes");
		c.setSingular("Motivo de comentario");
		c.setPlural("Motivos de comentario");
		c.setSingularPre("el motivo de comentario");
		c.setPluralPre("los motivos de comentario");

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
