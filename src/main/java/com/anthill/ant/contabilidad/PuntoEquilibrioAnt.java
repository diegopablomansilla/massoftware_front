package com.anthill.ant.contabilidad;

import com.anthill.Anthill;
import com.anthill.ant.Ant;
import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeInteger;

public class PuntoEquilibrioAnt extends Ant {

	private Ant ejercicioContableAnt;
	private Ant tipoPuntoEquilibrioAnt;

	public PuntoEquilibrioAnt(Anthill anthill, Ant ejercicioContableAnt, Ant tipoPuntoEquilibrioAnt) {
		super(anthill);
		this.ejercicioContableAnt = ejercicioContableAnt;
		this.tipoPuntoEquilibrioAnt = tipoPuntoEquilibrioAnt;
	}

	public Clazz build() throws Exception {

		// SELECT A.EJERCICIO, A.CENTRODECOSTOCONTABLE, A.NOMBRE, A.ABREVIATURA,
		// A.PRUEBA FROM CentrosDeCostoContable A WHERE ( A.EJERCICIO = 0 ) ORDER BY
		// A.EJERCICIO, A.CENTRODECOSTOCONTABLE, A.PRUEBA

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("PuntoEquilibrio");
		c.setNamePlural("PuntosEquilibrios");

		c.setNamePackage("contabilidad");
		c.setSingular("Punto equilibrio");
		c.setPlural("Puntos equilibrio");
		c.setSingularPre("el punto equilibrio");
		c.setPluralPre("los puntos equilibrio");

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

		Att tipoPuntoEquilibrio = new Att("tipoPuntoEquilibrio", "Tipo");
		tipoPuntoEquilibrio.setDataTypeClazz(tipoPuntoEquilibrioAnt.build());
		tipoPuntoEquilibrio.setRequired(true);
		c.addAtt(tipoPuntoEquilibrio);

		Att ejercicioContable = new Att("ejercicioContable", "Ejercicio");
		ejercicioContable.setDataTypeClazz(ejercicioContableAnt.build());
		ejercicioContable.setRequired(true);
		ejercicioContable.setReadOnlyGUI(true);
		c.addAtt(ejercicioContable);

		// -------- GRID

		Att nombreEjercicioContable = new Att("nombreEjercicioContable", "Ejercicio");
		nombreEjercicioContable.setDataTypeInteger(1, null);

		Att nombreTipoPuntoEquilibrio = new Att("nombreTipoPuntoEquilibrio", "Tipo punto equilibrio");

		c.addAttGrid(nombreEjercicioContable);
		c.addAttGrid(numero);
		c.addAttGrid(nombre);
		c.addAttGrid(nombreTipoPuntoEquilibrio);

		// -------- SBX Args

		c.addArgument(ejercicioContable);
		c.getLastArgument().setRequired(true);

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

		c.setStmAtts(
				", EjercicioContable.numero AS nombreEjercicioContable, PuntoEquilibrio.numero, PuntoEquilibrio.nombre, TipoPuntoEquilibrio.nombre AS nombreTipoPuntoEquilibrio");
		c.setStmJoins(
				" LEFT JOIN massoftware.EjercicioContable ON EjercicioContable.id = PuntoEquilibrio.ejercicioContable"
						+ " LEFT JOIN massoftware.TipoPuntoEquilibrio ON TipoPuntoEquilibrio.id = PuntoEquilibrio.tipoPuntoEquilibrio");

		return c;

		// ------------------------------------------------
	}

}
