package com.anthill.ant.clientes;

import com.anthill.Anthill;
import com.anthill.ant.Ant;
import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeInteger;

public class TipoClienteAnt extends Ant {

	public TipoClienteAnt(Anthill anthill) {
		super(anthill);
	}

	public Clazz build() throws Exception {

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("TipoCliente");
		c.setNamePlural("TiposClientes");

		c.setNamePackage("clientes");
		c.setSingular("Tipo de cliente");
		c.setPlural("Tipos de clientes");
		c.setSingularPre("el tipo de cliente");
		c.setPluralPre("los tipos de clientes");

		// -------- Atts

		Att numero = new Att("numero", "Nº tipo de cliente");
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

		// -------- GRID

		c.addAttGrid(numero);
		c.addAttGrid(nombre);

		// -------- Simple Args

		// -------- Order

		c.addOrderAllAtts();

		c.getOrderDefault().setDesc(true);

		// ------------------------------------------------

		return c;

		// ------------------------------------------------
	}

}
