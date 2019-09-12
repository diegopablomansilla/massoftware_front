package com.anthill.ant.monedas;

import java.math.BigDecimal;

import com.anthill.Anthill;
import com.anthill.ant.Ant;
import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeBigDecimal;
import com.anthill.model.DataTypeInteger;
import com.anthill.model.DataTypeTimestamp;

public class MonedaAnt extends Ant {

	private Ant monedaAFIPAnt;

	public MonedaAnt(Anthill anthill, Ant monedaAFIPAnt) {
		super(anthill);
		this.monedaAFIPAnt = monedaAFIPAnt;
	}

	public Clazz build() throws Exception {

		// SELECT A.MONEDA, A.DESCRIPCION, A.ABREVIATURA, A.COTIZACION, A.FECHASQL FROM
		// Monedas A ORDER BY A.MONEDA

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("Moneda");
		c.setNamePlural("Monedas");

		c.setNamePackage("monedas");
		c.setSingular("Moneda");
		c.setPlural("Monedas");
		c.setSingularPre("la moneda");
		c.setPluralPre("las monedas");

		// -------- Atts

		Att numero = new Att("numero", "Nº moneda");
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

		Att cotizacion = new Att("cotizacion", "Cotización");
		cotizacion.setDataTypeBigDecimal(new BigDecimal("-9999.9999"), new BigDecimal("99999.9999"), 13, 5);
		((DataTypeBigDecimal) cotizacion.getDataType()).setDefValueInsert(new BigDecimal("1"));
		cotizacion.setRequired(true);
		cotizacion.setReadOnlyGUI(true);
		c.addAtt(cotizacion);

		Att cotizacionFecha = new Att("cotizacionFecha", "Fecha cotización");
		cotizacionFecha.setDataTypeTimestamp();
		((DataTypeTimestamp) cotizacionFecha.getDataType()).setDefNowInsert(true);
		cotizacionFecha.setRequired(true);
		cotizacionFecha.setReadOnlyGUI(true);
		c.addAtt(cotizacionFecha);

		Att controlActualizacion = new Att("controlActualizacion", "Control de actualizacion");
		controlActualizacion.setDataTypeBoolean();
		c.addAtt(controlActualizacion);

		Att monedaAFIP = new Att("monedaAFIP", "Moneda AFIP");
		monedaAFIP.setDataTypeClazz(monedaAFIPAnt.build());
		monedaAFIP.setRequired(true);
		c.addAtt(monedaAFIP);

		// -------- GRID

		c.addAttGrid(numero);
		c.addAttGrid(nombre);

		// -------- SBX Args

		c.addArgument(numero, true);
		c.getLastArgument().setRequired(false);
		c.addArgumentSBX(c.getLastArgument());

		c.addArgument(abreviatura);
		c.getLastArgument().setRequired(false);

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
