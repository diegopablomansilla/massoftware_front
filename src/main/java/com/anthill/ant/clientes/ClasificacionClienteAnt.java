package com.anthill.ant.clientes;

import com.anthill.Anthill;
import com.anthill.ant.Ant;
import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeInteger;

public class ClasificacionClienteAnt extends Ant {

	public ClasificacionClienteAnt(Anthill anthill) {
		super(anthill);
	}

	public Clazz build() throws Exception {

		// SELECT A.CLASIFCLIENTE, A.NOMBRE, A.COLOR FROM TablaClasifClientes A ORDER BY
		// A.CLASIFCLIENTE

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("ClasificacionCliente");
		c.setNamePlural("ClasificacionesClientes");

		c.setNamePackage("clientes");
		c.setSingular("Clasificación de cliente");
		c.setPlural("Clasificaciones de clientes");
		c.setSingularPre("la clasificación de liente");
		c.setPluralPre("las clasificaciones clientes");

		// -------- Atts

		Att numero = new Att("numero", "Nº clasificación");
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

		Att color = new Att("color", "Color");
		color.setDataTypeInteger(1, null);
		color.setRequired(true);
		color.setUnique(false);
		c.addAtt(color);

		// -------- GRID

		c.addAttGrid(numero);
		c.addAttGrid(nombre);
		c.addAttGrid(color);

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
