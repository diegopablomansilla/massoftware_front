package com.anthill.ant.monedas;

import java.math.BigDecimal;

import com.anthill.Anthill;
import com.anthill.ant.Ant;
import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeTimestamp;

public class MonedaCotizacionAnt extends Ant {

	private Ant monedaAnt;
	private Ant usuarioAnt;

	public MonedaCotizacionAnt(Anthill anthill, Ant monedaAnt, Ant usuarioAnt) {
		super(anthill);
		this.monedaAnt = monedaAnt;
		this.usuarioAnt = usuarioAnt;
	}

	public Clazz build() throws Exception {

		// SELECT A.MONEDA, A.FECHASQL, A.COMPRA, A.VENTA, A.USUARIO, A.FECHAINGRESOSQL,
		// B.MONEDA, B.DESCRIPCION, C."NO", C.GROUPFLAG, C.LASTNAME, C.FIRSTNAME,
		// C."LEVEL" FROM {oj MonedasCotizaciones A LEFT OUTER JOIN Monedas B ON
		// A.MONEDA= B.MONEDA LEFT OUTER JOIN dbo.SSECUR_User C ON A.USUARIO= C."NO" }
		// WHERE ( A.MONEDA = 6 ) ORDER BY A.MONEDA, A.FECHASQL

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("MonedaCotizacion");

		c.setNamePackage("monedas");
		c.setSingular("Cotización de moneda");
		c.setPlural("Cotizaciones de monedas");
		c.setSingularPre("la cotización de moneda");
		c.setPluralPre("las cotizaciones de monedas");

		// -------- Atts

		Att cotizacionFecha = new Att("cotizacionFecha", "Fecha cotización");
		cotizacionFecha.setDataTypeTimestamp();
		// ((DataTypeTimestamp) cotizacionFecha.getDataType()).setDefNowInsert(true);
		cotizacionFecha.setRequired(true);
		// cotizacionFecha.setReadOnlyGUI(true);
		c.addAtt(cotizacionFecha);

		Att compra = new Att("compra", "Compra");
		compra.setDataTypeBigDecimal(new BigDecimal("-9999.9999"), new BigDecimal("99999.9999"), 13, 5);
		// ((DataTypeBigDecimal) compra.getDataType()).setDefValueInsert(new
		// BigDecimal("1"));
		compra.setRequired(true);
		c.addAtt(compra);

		Att venta = new Att("venta", "Venta");
		venta.setDataTypeBigDecimal(new BigDecimal("-9999.9999"), new BigDecimal("99999.9999"), 13, 5);
		// ((DataTypeBigDecimal) venta.getDataType()).setDefValueInsert(new
		// BigDecimal("1"));
		venta.setRequired(true);
		c.addAtt(venta);

		Att cotizacionFechaAuditoria = new Att("cotizacionFechaAuditoria", "Fecha cotización (Auditoria)");
		cotizacionFechaAuditoria.setDataTypeTimestamp();
		((DataTypeTimestamp) cotizacionFechaAuditoria.getDataType()).setDefNowInsert(true);
		cotizacionFechaAuditoria.setRequired(true);
		cotizacionFechaAuditoria.setReadOnlyGUI(true);
		c.addAtt(cotizacionFechaAuditoria);

		Att moneda = new Att("moneda", "Moneda");
		moneda.setDataTypeClazz(monedaAnt.build());
		moneda.setRequired(true);
		c.addAtt(moneda);

		Att usuario = new Att("usuario", "Usuario");
		usuario.setDataTypeClazz(usuarioAnt.build());
		usuario.setRequired(true);
		c.addAtt(usuario);

		// -------- SBX Args

		// -------- Simple Args

		c.addArgument(moneda);
		c.getLastArgument().setRequired(false);

		c.addArgument(cotizacionFecha, true);
		// c.getLastArgument().setRequired(false);

		// -------- Order

		c.addOrderAllAtts();

		c.getOrderDefault().setDesc(true);

		// ------------------------------------------------

		return c;

		// ------------------------------------------------
	}

}
