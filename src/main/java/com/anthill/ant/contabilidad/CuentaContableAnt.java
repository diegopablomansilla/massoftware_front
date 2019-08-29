package com.anthill.ant.contabilidad;

import com.anthill.Anthill;
import com.anthill.ant.Ant;
import com.anthill.model.Att;
import com.anthill.model.Clazz;

public class CuentaContableAnt extends Ant {

	private Ant ejercicioContableAnt;
	private Ant cuentaContableEstadoAnt;
	private Ant centroCostoContableAnt;
	private Ant puntoEquilibrioAnt;
	private Ant costoVentaAnt;
	private Ant seguridadPuertaAnt;

	public CuentaContableAnt(Anthill anthill, Ant ejercicioContableAnt, Ant cuentaContableEstadoAnt,
			Ant centroCostoContableAnt, Ant puntoEquilibrioAnt, Ant costoVentaAnt, Ant seguridadPuertaAnt) {
		super(anthill);
		this.ejercicioContableAnt = ejercicioContableAnt;
		this.cuentaContableEstadoAnt = cuentaContableEstadoAnt;
		this.centroCostoContableAnt = centroCostoContableAnt;
		this.puntoEquilibrioAnt = puntoEquilibrioAnt;
		this.costoVentaAnt = costoVentaAnt;
		this.seguridadPuertaAnt = seguridadPuertaAnt;
	}

	public Clazz build() throws Exception {

		// PlanDeCuentas

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("CuentaContable");
		c.setNamePlural("CuentasContables");

		c.setNamePackage("contabilidad");
		c.setSingular("Cuenta contable");
		c.setPlural("Cuentas contables");
		c.setSingularPre("la cuenta contable");
		c.setPluralPre("las cuentas contables");

		// -------- Atts

		Att codigo = new Att("codigo", "Cuenta contable");
		codigo.setRequired(true);
		codigo.setUnique(true);
		codigo.setLength(null, 11);
		c.addAtt(codigo);

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

		Att integra = new Att("integra", "Integra");
		integra.setRequired(true);
		integra.setLength(16, 16);
		integra.setColumns(16f);
		integra.setReadOnlyGUI(true);
		integra.setMask("9.99.99.99.99.99");
		c.addAtt(integra);

		Att cuentaJerarquia = new Att("cuentaJerarquia", "Cuenta de jerarquia");
		cuentaJerarquia.setRequired(true);
		cuentaJerarquia.setLength(16, 16);
		cuentaJerarquia.setColumns(16f);
		cuentaJerarquia.setReadOnlyGUI(true);
		cuentaJerarquia.setMask("9.99.99.99.99.99");
		c.addAtt(cuentaJerarquia);

		// --------------------------------------------------------------------------

		Att imputable = new Att("imputable", "Imputable");
		imputable.setDataTypeBoolean();
		imputable.setRequired(true);
		c.addAtt(imputable);

		Att ajustaPorInflacion = new Att("ajustaPorInflacion", "Ajusta por inflación");
		ajustaPorInflacion.setDataTypeBoolean();
		ajustaPorInflacion.setRequired(true);
		c.addAtt(ajustaPorInflacion);

		Att cuentaContableEstado = new Att("cuentaContableEstado", "Estado");
		cuentaContableEstado.setDataTypeClazz(cuentaContableEstadoAnt.build());
		cuentaContableEstado.setRequired(true);
		c.addAtt(cuentaContableEstado);

		Att cuentaConApropiacion = new Att("cuentaConApropiacion", "Cuenta con apropiación");
		cuentaConApropiacion.setDataTypeBoolean();
		cuentaConApropiacion.setRequired(true);
		c.addAtt(cuentaConApropiacion);

		// --------------------------------------------------------------------------

		Att centroCostoContable = new Att("centroCostoContable", "Estado");
		centroCostoContable.setDataTypeClazz(centroCostoContableAnt.build());
		c.addAtt(centroCostoContable);

		Att cuentaAgrupadora = new Att("cuentaAgrupadora", "Cuenta agrupadora");
		cuentaAgrupadora.setLength(null, 50);
		c.addAtt(cuentaAgrupadora);

		Att porcentaje = new Att("porcentaje", "Porcentaje");
//		porcentaje.setDataTypeBigDecimal(new BigDecimal("0"), new BigDecimal("999.99"), 6, 3);
		porcentaje.setDataTypeDouble(0.0, 999.99);
		porcentaje.setColumns(6f);
		c.addAtt(porcentaje);

		Att puntoEquilibrio = new Att("puntoEquilibrio", "Punto de equilibrio");
		puntoEquilibrio.setDataTypeClazz(puntoEquilibrioAnt.build());
		c.addAtt(puntoEquilibrio);

		Att costoVenta = new Att("costoVenta", "Costo de venta");
		costoVenta.setDataTypeClazz(costoVentaAnt.build());
		c.addAtt(costoVenta);

		Att seguridadPuerta = new Att("seguridadPuerta", "Puerta");
		seguridadPuerta.setDataTypeClazz(seguridadPuertaAnt.build());
		c.addAtt(seguridadPuerta);

		// --------------------------------------------------------------------------

		// -------- GRID

		Att nombreEjercicioContable = new Att("nombreEjercicioContable", "Ejercicio");
		nombreEjercicioContable.setDataTypeInteger(1, null);
		
		Att nombreCentroCostoContable = new Att("nombreCentroCostoContable", "Ctro. Costo");

		c.addAttGrid(nombreEjercicioContable);
		c.addAttGrid(codigo);
		c.addAttGrid(nombre);
		c.addAttGrid(nombreCentroCostoContable);
		c.addAttGrid(cuentaAgrupadora);
		c.addAttGrid(porcentaje);

		// -------- SBX Args

		c.addArgument(ejercicioContable);
		c.getLastArgument().setRequired(true);
		
		c.addArgument(centroCostoContable);
		c.getLastArgument().setRequired(false);
		
		c.addArgument(puntoEquilibrio);
		c.getLastArgument().setRequired(false);
		
		c.addArgument(codigo, true);
		c.getLastArgument().setRequired(false);
		c.addArgumentSBX(c.getLastArgument());

		c.addArgument(cuentaAgrupadora);
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
		
		c.setStmAtts(", EjercicioContable.numero AS nombreEjercicioContable, CuentaContable.codigo, CuentaContable.nombre, CentroCostoContable.nombre AS nombreCentroCostoContable, CuentaContable.cuentaAgrupadora, CuentaContable.porcentaje");
		c.setStmJoins(
				" LEFT JOIN massoftware.EjercicioContable ON EjercicioContable.id = CuentaContable.ejercicioContable"
				+ " LEFT JOIN massoftware.CentroCostoContable ON CentroCostoContable.id = CuentaContable.centroCostoContable");

		return c;

		// ------------------------------------------------
	}

}
