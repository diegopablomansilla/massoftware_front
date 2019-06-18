package com.massoftware.anthill.ant.empresa;

import com.massoftware.anthill.Ant;
import com.massoftware.anthill.Anthill;
import com.massoftware.anthill.Att;
import com.massoftware.anthill.Clazz;
import com.massoftware.anthill.DataTypeInteger;

public class EmpresaAnt extends Ant {

	// SELECT Empresa

	private Ant ejercicioContableAnt;

	public EmpresaAnt(Anthill anthill, Ant ejercicioContableAnt) {
		super(anthill);
		this.ejercicioContableAnt = ejercicioContableAnt;
	}

	public Clazz build() throws Exception {

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("Empresa");

		c.setNamePackage("empresa");
		c.setSingular("Empresa");
		c.setPlural("Empresas");
		c.setSingularPre("la empresa");
		c.setPluralPre("las empresas");

		// -------- Atts
		
		Att ejercicioContable = new Att("ejercicioContable", "Ejercicio");
		ejercicioContable.setDataTypeClazz(ejercicioContableAnt.build());
		ejercicioContable.setRequired(true);
//		ejercicioContable.setReadOnlyGUI(true);
		c.addAtt(ejercicioContable);

		// --------------------------------------------------------------

		Att fechaCierreVentas = new Att("fechaCierreVentas", "Fecha cierre ventas");
		fechaCierreVentas.setDataTypeDate();
		c.addAtt(fechaCierreVentas);

		Att fechaCierreStock = new Att("fechaCierreStock", "Fecha cierre stock");
		fechaCierreStock.setDataTypeDate();
		c.addAtt(fechaCierreStock);

		Att fechaCierreFondo = new Att("fechaCierreFondo", "Fecha cierre fondo");
		fechaCierreFondo.setDataTypeDate();
		c.addAtt(fechaCierreFondo);

		Att fechaCierreCompras = new Att("fechaCierreCompras", "Fecha cierre compras");
		fechaCierreCompras.setDataTypeDate();
		c.addAtt(fechaCierreCompras);

		Att fechaCierreContabilidad = new Att("fechaCierreContabilidad", "Fecha cierre contabilidad");
		fechaCierreContabilidad.setDataTypeDate();
		c.addAtt(fechaCierreContabilidad);

		Att fechaCierreGarantiaDevoluciones = new Att("fechaCierreGarantiaDevoluciones",
				"Fecha cierre garantia y devoluciones");
		fechaCierreGarantiaDevoluciones.setDataTypeDate();
		c.addAtt(fechaCierreGarantiaDevoluciones);

		Att fechaCierreTambos = new Att("fechaCierreTambos", "Fecha cierre tambos");
		fechaCierreTambos.setDataTypeDate();
		c.addAtt(fechaCierreTambos);

		Att fechaCierreRRHH = new Att("fechaCierreRRHH", "Fecha cierre RRHH");
		fechaCierreRRHH.setDataTypeDate();
		c.addAtt(fechaCierreRRHH);

		// --------------------------------------------------------------

		// -------- SBX Args

		// -------- Simple Args

		// -------- Order

		c.addOrderAllAtts();

		c.getOrderDefault().setDesc(true);

		// ------------------------------------------------

		return c;

		// ------------------------------------------------
	}

}
