package com.anthill.ant.fondos;

import com.anthill.Anthill;
import com.anthill.ant.Ant;
import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeInteger;

public class TicketModeloAnt extends Ant {

	private Ant ticketAnt;

	public TicketModeloAnt(Anthill anthill, Ant ticketAnt) {
		super(anthill);
		this.ticketAnt = ticketAnt;
	}

	public Clazz build() throws Exception {

		// SELECT A.TICKET, A.MODELO, A.DESCRIPCION, B.TICKET, B.DESCRIPCION FROM {oj
		// TicketsModelos A LEFT OUTER JOIN Tickets B ON A.TICKET= B.TICKET } ORDER BY
		// A.TICKET DESC, A.MODELO

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("TicketModelo");

		c.setNamePackage("fondos");
		c.setSingular("Ticket modelo");
		c.setPlural("Tickets modelos");
		c.setSingularPre("el ticket modelo");
		c.setPluralPre("los tickets modelo");

		// -------- Atts

		Att numero = new Att("numero", "Nº modelo");
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

		Att ticket = new Att("ticket", "ticket");
		ticket.setDataTypeClazz(ticketAnt.build());
		ticket.setRequired(true);
		c.addAtt(ticket);

		Att pruebaLectura = new Att("pruebaLectura", "Prueba lectura");
		pruebaLectura.setLength(null, 50);
		c.addAtt(pruebaLectura);

		Att activo = new Att("activo", "activo");
		activo.setDataTypeBoolean();
		activo.setRequired(true);
		c.addAtt(activo);

		Att longitudLectura = new Att("longitudLectura", "Longitud lectura");
		longitudLectura.setDataTypeInteger(0, null);
		c.addAtt(longitudLectura);

		Att identificacionPosicion = new Att("identificacionPosicion", "Posición");
		identificacionPosicion.setDataTypeInteger(0, null);
		c.addAtt(identificacionPosicion);

		Att identificacion = new Att("identificacion", "Identificación");
		identificacion.setDataTypeInteger(0, null);
		c.addAtt(identificacion);

		Att importePosicion = new Att("importePosicion", "Posición");
		importePosicion.setDataTypeInteger(0, null);
		c.addAtt(importePosicion);

		Att longitud = new Att("longitud", "Longitud");
		longitud.setDataTypeInteger(0, null);
		c.addAtt(longitud);

		Att cantidadDecimales = new Att("cantidadDecimales", "Cantidad decimales");
		cantidadDecimales.setDataTypeInteger(0, null);
		c.addAtt(cantidadDecimales);

		Att numeroPosicion = new Att("numeroPosicion", "Número posición");
		numeroPosicion.setDataTypeInteger(0, null);
		c.addAtt(numeroPosicion);

		Att numeroLongitud = new Att("numeroLongitud", "Número longitud");
		numeroLongitud.setDataTypeInteger(0, null);
		c.addAtt(numeroLongitud);

		Att prefijoIdentificacion = new Att("prefijoIdentificacion", "Prefijo identificación importación");
		prefijoIdentificacion.setLength(null, 10);
		c.addAtt(prefijoIdentificacion);

		Att posicionPrefijo = new Att("posicionPrefijo", "Posición prefijo");
		posicionPrefijo.setDataTypeInteger(0, null);
		c.addAtt(posicionPrefijo);

		// -------- SBX Args

		c.addArgument(numero, true);
		c.getLastArgument().setRequired(false);
		c.addArgumentSBX(c.getLastArgument());

		c.addArgument(nombre);
		c.getLastArgument().setRequired(false);
		c.addArgumentSBX(c.getLastArgument());

		// -------- Simple Args

		c.addArgument(ticket);
		c.getLastArgument().setRequired(true);

		// -------- Order

		c.addOrderAllAtts();

		c.getOrderDefault().setDesc(true);

		// ------------------------------------------------

		return c;

		// ------------------------------------------------
	}

}
