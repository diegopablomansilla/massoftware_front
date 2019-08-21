package com.anthill.ant.contabilidad;

import com.anthill.Anthill;
import com.anthill.ant.Ant;
import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeInteger;

public class AsientoModeloAnt extends Ant {
	
	private Ant ejercicioContableAnt;

	public AsientoModeloAnt(Anthill anthill, Ant ejercicioContableAnt) {
		super(anthill);
		this.ejercicioContableAnt = ejercicioContableAnt;
	}

	public Clazz build() throws Exception {

		// SELECT ASIENTOMODELO,DENOMINACION FROM AsientosModelos

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("AsientoModelo");
		c.setNamePlural("AsientosModelos");

		c.setNamePackage("contabilidad");
		c.setSingular("Asiento modelo");
		c.setPlural("Asientos modelo");
		c.setSingularPre("el asiento modelo");
		c.setPluralPre("los asientos modelo");

		// -------- Atts

		Att numero = new Att("numero", "Nº asiento");
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
		
		Att ejercicioContable = new Att("ejercicioContable", "Ejercicio");
		ejercicioContable.setDataTypeClazz(ejercicioContableAnt.build());
		ejercicioContable.setRequired(true);
		ejercicioContable.setReadOnlyGUI(true);
		c.addAtt(ejercicioContable);

		// -------- SBX Args

		c.addArgument(numero, true);
		c.getLastArgument().setRequired(false);
		c.addArgumentSBX(c.getLastArgument());

		c.addArgument(nombre);
		c.getLastArgument().setRequired(false);
		c.addArgumentSBX(c.getLastArgument());

		// -------- Simple Args

		c.addArgument(ejercicioContable);
		c.getLastArgument().setRequired(true);
		
		// -------- Order

		c.addOrderAllAtts();

		c.getOrderDefault().setDesc(true);

		// ------------------------------------------------

		return c;

		// ------------------------------------------------
	}

}
