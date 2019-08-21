package com.anthill.ant.contabilidad;

import com.anthill.Anthill;
import com.anthill.ant.Ant;
import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeInteger;

public class CentroCostoContableAnt extends Ant {

	private Ant ejercicioContableAnt;

	public CentroCostoContableAnt(Anthill anthill, Ant ejercicioContableAnt) {
		super(anthill);
		this.ejercicioContableAnt = ejercicioContableAnt;
	}

	public Clazz build() throws Exception {

		// SELECT A.EJERCICIO, A.CENTRODECOSTOCONTABLE, A.NOMBRE, A.ABREVIATURA,
		// A.PRUEBA FROM CentrosDeCostoContable A WHERE ( A.EJERCICIO = 0 ) ORDER BY
		// A.EJERCICIO, A.CENTRODECOSTOCONTABLE, A.PRUEBA

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("CentroCostoContable");
		c.setNamePlural("CentrosCostosContables");

		c.setNamePackage("contabilidad");
		c.setSingular("Centro de costo");
		c.setPlural("Centros de costo");
		c.setSingularPre("el centro de costo");
		c.setPluralPre("los centros de costo");

		// -------- Atts

		Att numero = new Att("numero", "Nº cc");
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

		Att abreviatura = new Att("abreviatura", "Abreviatura");
		abreviatura.setRequired(true);
		abreviatura.setUnique(true);
		abreviatura.setLength(null, 5);
		abreviatura.setColumns((float) 5);
		c.addAtt(abreviatura);

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

		c.addArgument(abreviatura);
		// c.getLastArgument().setRequired(false);

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
