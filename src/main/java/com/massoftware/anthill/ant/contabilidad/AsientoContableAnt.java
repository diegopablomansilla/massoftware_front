package com.massoftware.anthill.ant.contabilidad;

import com.massoftware.anthill.Ant;
import com.massoftware.anthill.Anthill;
import com.massoftware.anthill.Att;
import com.massoftware.anthill.Clazz;
import com.massoftware.anthill.DataTypeInteger;

public class AsientoContableAnt extends Ant {

	private Ant ejercicioContableAnt;
	private Ant minutaContableAnt;
	private Ant sucursalAnt;
	private Ant asientoContableModuloAnt;

	public AsientoContableAnt(Anthill anthill, Ant ejercicioContableAnt, Ant minutaContableAnt, Ant sucursalAnt,
			Ant asientoContableModuloAnt) {
		super(anthill);
		this.ejercicioContableAnt = ejercicioContableAnt;
		this.minutaContableAnt = minutaContableAnt;
		this.sucursalAnt = sucursalAnt;
		this.asientoContableModuloAnt = asientoContableModuloAnt;
	}

	public Clazz build() throws Exception {

		// SELECT A.FECHASQL, A.TIPOASIENTO, A.EJERCICIO, A.NUMEROASIENTO, A.DETALLE,
		// A.MODULO, A.SUCURSAL, A.NROLOTE, A.TIPOID, A.NUMEROID, A.COMPROBANTE,
		// B.EJERCICIO, B.EJERCICIOCERRADOMODULOS, C.TIPO, C.STOCK, C.VENTAS, C.FONDOS,
		// C.COMPRAS, C.TAMBOS, C.PRODUCCION, C.DEVOLUCIONESGARANTIAS,
		// C.RECURSOSHUMANOS, C.NOMBRE, C.ABREVIATURA, C.CLASECBTE, C.MULTIPROPOSITO
		// FROM {oj Contabilidad A LEFT OUTER JOIN EjerciciosContables B ON A.EJERCICIO=
		// B.EJERCICIO LEFT OUTER JOIN TablaDeComprobantes C ON A.TIPOID= C.TIPO } WHERE
		// ( A.EJERCICIO = 2016 ) ORDER BY A.EJERCICIO DESC, A.NUMEROASIENTO DESC

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("AsientoContable");

		c.setNamePackage("contabilidad");
		c.setSingular("Asiento contable");
		c.setPlural("Asientos contables");
		c.setSingularPre("el asiento contable");
		c.setPluralPre("los asientos contables");

		// -------- Atts

		Att numero = new Att("numero", "Nº asiento");
		numero.setDataTypeInteger(1, null);
		((DataTypeInteger) numero.getDataType()).setNextValueProposed(true);
		numero.setRequired(true);
		numero.setUnique(true);
		c.addAtt(numero);

		Att fecha = new Att("fecha", "Fecha");
		fecha.setDataTypeDate();
		fecha.setRequired(true);
		c.addAtt(fecha);

		Att detalle = new Att("detalle", "Detalle");
		detalle.setLength(null, 100);
		c.addAtt(detalle);

		Att ejercicioContable = new Att("ejercicioContable", "Ejercicio");
		ejercicioContable.setDataTypeClazz(ejercicioContableAnt.build());
		ejercicioContable.setRequired(true);
		ejercicioContable.setReadOnlyGUI(true);
		c.addAtt(ejercicioContable);
		
		Att minutaContable = new Att("minutaContable", "Minuta contable");
		minutaContable.setDataTypeClazz(minutaContableAnt.build());
		minutaContable.setRequired(true);
		minutaContable.setReadOnlyGUI(true);
		c.addAtt(minutaContable);
		
		Att sucursal = new Att("sucursal", "Sucursal");
		sucursal.setDataTypeClazz(sucursalAnt.build());
		sucursal.setRequired(true);
		sucursal.setReadOnlyGUI(true);
		c.addAtt(sucursal);
		
		Att asientoContableModulo = new Att("asientoContableModulo", "Módulo");
		asientoContableModulo.setDataTypeClazz(asientoContableModuloAnt.build());
		asientoContableModulo.setRequired(true);
		asientoContableModulo.setReadOnlyGUI(true);
		c.addAtt(asientoContableModulo);

		// -------- SBX Args

		c.addArgument(numero, true);
		c.getLastArgument().setRequired(false);
		c.addArgumentSBX(c.getLastArgument());

		c.addArgument(detalle);
		c.getLastArgument().setRequired(false);
		c.addArgumentSBX(c.getLastArgument());

		// -------- Simple Args
		
		c.addArgument(fecha, true);
		c.getLastArgument().setRequired(false);		

		c.addArgument(ejercicioContable);
		c.getLastArgument().setRequired(true);
		
		c.addArgument(minutaContable);
		c.getLastArgument().setRequired(false);
		
		c.addArgument(asientoContableModulo);
		c.getLastArgument().setRequired(false);
		
		c.addArgument(sucursal);
		c.getLastArgument().setRequired(false);

		// -------- Order

		c.addOrderAllAtts();

		c.getOrderDefault().setDesc(true);

		// ------------------------------------------------

		return c;

		// ------------------------------------------------
	}

}
