package com.anthill.ant.fondos.banco;

import com.anthill.Anthill;
import com.anthill.ant.Ant;
import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeInteger;

public class BancoFirmanteAnt extends Ant {

	public BancoFirmanteAnt(Anthill anthill) {
		super(anthill);
	}

	public Clazz build() throws Exception {

		// SELECT  A.CODIGO, A.NOMBRE, A.CARGO, A.ACTIVO FROM BancosFirmantes A ORDER BY  A.CODIGO
		
		
		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("BancoFirmante");
		c.setNamePlural("BancosFirmantes");

		c.setNamePackage("fondos.banco");
		c.setSingular("Firmante");
		c.setPlural("Firmantes");
		c.setSingularPre("el firmante");
		c.setPluralPre("los Firmantes");

		// -------- Atts

		Att numero = new Att("numero", "Nº firmante");
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
		
		Att cargo = new Att("cargo", "Cargo");
//		cargo.setRequired(true);
		cargo.setUnique(true);
		cargo.setLength(null, 50);
		c.addAtt(cargo);
		
		Att bloqueado = new Att("bloqueado", "Obsoleto");
		bloqueado.setDataTypeBoolean();
		c.addAtt(bloqueado);

		
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
