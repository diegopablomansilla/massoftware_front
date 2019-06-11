package com.massoftware.anthill.ant.logistica;

import java.math.BigDecimal;

import com.massoftware.anthill.Ant;
import com.massoftware.anthill.Anthill;
import com.massoftware.anthill.Att;
import com.massoftware.anthill.Clazz;
import com.massoftware.anthill.DataTypeBigDecimal;
import com.massoftware.anthill.DataTypeInteger;
import com.massoftware.anthill.Order;

public class TransporteTarifaAnt extends Ant {

	private Ant transporteAnt;
	private Ant cargaAnt;
	private Ant ciudadAnt;

	public TransporteTarifaAnt(Anthill anthill, Ant transporteAnt, Ant cargaAnt, Ant ciudadAnt) {
		super(anthill);
		this.transporteAnt = transporteAnt;
		this.cargaAnt = cargaAnt;
		this.ciudadAnt = ciudadAnt;
	}

	public Clazz build() throws Exception {

		// SELECT A.TRANSPORTE, A.CARGA, A.OPCIONPRECIO, A.PRECIOFIJO,
		// A.PRECIOPORUNIDADSTOCK, A.PRECIOPORUNIDADFACTURACION, A.PRECIOPORBULTOS,
		// A.CIUDAD, A.IMPORTEMINIMOPORENTREGA, B.CIUDAD, B.PAIS, B.PROVINCIA, B.NOMBRE,
		// C.CARGA, C.NOMBRE FROM {oj TransportesPrecios A LEFT OUTER JOIN Ciudades B ON
		// A.CIUDAD= B.CIUDAD LEFT OUTER JOIN Cargas C ON A.CARGA= C.CARGA } WHERE (
		// A.TRANSPORTE = 64 ) ORDER BY A.TRANSPORTE, A.CARGA, A.OPCIONPRECIO, A.CIUDAD

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("TransporteTarifa");

		c.setNamePackage("logistica");
		c.setSingular("Tarifa de transporte");
		c.setPlural("Tarifas de transporte");
		c.setSingularPre("la tarifa de transporte");
		c.setPluralPre("las tarifas de transporte");

		// -------- Atts

		Att transporte = new Att("transporte", "Transporte");
		transporte.setDataTypeClazz(transporteAnt.build());
		transporte.setRequired(true);
		transporte.setUnique(false);
//		c.addAtt(transporte);

		Att numero = new Att("numero", "Nº opción");
		numero.setDataTypeInteger(1, null);
		((DataTypeInteger) numero.getDataType()).setNextValueProposed(true);
		numero.setRequired(true);
		numero.setUnique(false);
		c.addAtt(numero);

		Att carga = new Att("carga", "Carga");
		carga.setDataTypeClazz(cargaAnt.build());
		carga.setRequired(true);
		c.addAtt(carga);

		Att ciudad = new Att("ciudad", "Ciudad");
		ciudad.setDataTypeClazz(ciudadAnt.build());
		ciudad.setRequired(true);
		c.addAtt(ciudad);

		Att precioFlete = new Att("precioFlete", "Precio flete");
		precioFlete.setDataTypeBigDecimal(new BigDecimal("-9999.9999"), new BigDecimal("99999.9999"), 13, 5);
		((DataTypeBigDecimal) precioFlete.getDataType()).setDefValueInsert(new BigDecimal("0"));
		precioFlete.setRequired(true);		
		c.addAtt(precioFlete);

		Att precioUnidadFacturacion = new Att("precioUnidadFacturacion", "Precio unidad facturación");
		precioUnidadFacturacion.setDataTypeBigDecimal(new BigDecimal("-9999.9999"), new BigDecimal("99999.9999"), 13,
				5);
		((DataTypeBigDecimal) precioUnidadFacturacion.getDataType()).setDefValueInsert(new BigDecimal("0"));
		precioUnidadFacturacion.setRequired(false);		
		c.addAtt(precioUnidadFacturacion);

		Att precioUnidadStock = new Att("precioUnidadStock", "Precio unidad stock");
		precioUnidadStock.setDataTypeBigDecimal(new BigDecimal("-9999.9999"), new BigDecimal("99999.9999"), 13, 5);
		((DataTypeBigDecimal) precioUnidadStock.getDataType()).setDefValueInsert(new BigDecimal("0"));
		precioUnidadStock.setRequired(false);		
		c.addAtt(precioUnidadStock);

		Att precioBultos = new Att("precioBultos", "Precio bultos");
		precioBultos.setDataTypeBigDecimal(new BigDecimal("-9999.9999"), new BigDecimal("99999.9999"), 13, 5);
		((DataTypeBigDecimal) precioBultos.getDataType()).setDefValueInsert(new BigDecimal("0"));
		precioBultos.setRequired(false);		
		c.addAtt(precioBultos);

		Att importeMinimoEntrega = new Att("importeMinimoEntrega", "Importe mínimo por entrega");
		importeMinimoEntrega.setDataTypeBigDecimal(new BigDecimal("-9999.9999"), new BigDecimal("99999.9999"), 13, 5);
		((DataTypeBigDecimal) importeMinimoEntrega.getDataType()).setDefValueInsert(new BigDecimal("0"));
		importeMinimoEntrega.setRequired(false);		
		c.addAtt(importeMinimoEntrega);

		Att importeMinimoCarga = new Att("importeMinimoCarga", "Importe mínimo por carga");
		importeMinimoCarga.setDataTypeBigDecimal(new BigDecimal("-9999.9999"), new BigDecimal("99999.9999"), 13, 5);
		((DataTypeBigDecimal) importeMinimoCarga.getDataType()).setDefValueInsert(new BigDecimal("0"));
		importeMinimoCarga.setRequired(false);
		c.addAtt(importeMinimoCarga);

		// -------- SBX Args

		c.addArgument(transporte, true);
		c.getLastArgument().setRequired(true);
		c.getLastArgument().setOnlyVisual(true);
		c.addArgumentSBX(c.getLastArgument());

		// -------- Simple Args

		// -------- Order

		c.addOrderAllAtts();
		
		c.setOrderDefault(new Order(numero));

		c.getOrderDefault().setDesc(true);

		// ------------------------------------------------

		return c;

		// ------------------------------------------------
	}

}
