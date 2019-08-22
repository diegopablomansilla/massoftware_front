package com.anthill.ant.clientes;

import com.anthill.Anthill;
import com.anthill.ant.Ant;
import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeInteger;

public class MotivoBloqueoClienteAnt extends Ant {
	
	private Ant clasificacionClienteAnt;

	public MotivoBloqueoClienteAnt(Anthill anthill, Ant clasificacionClienteAnt) {
		super(anthill);
		this.clasificacionClienteAnt = clasificacionClienteAnt;
	}

	public Clazz build() throws Exception {

		// SELECT A.MOTIVOBLOQUEO, A.DETALLE, A.CLASIFCLIENTE, B.CLASIFCLIENTE, B.NOMBRE
		// FROM {oj TablaDeBloqueos A LEFT OUTER JOIN TablaClasifClientes B ON
		// A.CLASIFCLIENTE= B.CLASIFCLIENTE } ORDER BY A.MOTIVOBLOQUEO

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("MotivoBloqueoCliente");
		c.setNamePlural("MotivosBloqueosClientes");

		c.setNamePackage("clientes");
		c.setSingular("Motivo bloqueo a cliente");
		c.setPlural("Motivos bloqueo a clientes");
		c.setSingularPre("el motivo bloqueo a cliente");
		c.setPluralPre("los motivos bloqueo a clientes");

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

		Att clasificacionCliente = new Att("clasificacionCliente", "Clasificación de cliente");
		clasificacionCliente.setDataTypeClazz(clasificacionClienteAnt.build());
		clasificacionCliente.setRequired(true);
		c.addAtt(clasificacionCliente);

		// -------- SBX Args

		c.addArgument(numero, true);
		c.getLastArgument().setRequired(false);
		c.addArgumentSBX(c.getLastArgument());

		c.addArgument(nombre);
		c.getLastArgument().setRequired(false);
		c.addArgumentSBX(c.getLastArgument());

		// -------- Simple Args

		c.addArgument(clasificacionCliente);
		c.getLastArgument().setRequired(false);

		// -------- Order

		c.addOrderAllAtts();

		c.getOrderDefault().setDesc(true);

		// ------------------------------------------------

		return c;

		// ------------------------------------------------
	}

}
