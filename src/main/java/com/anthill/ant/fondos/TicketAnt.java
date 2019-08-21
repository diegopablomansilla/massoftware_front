package com.anthill.ant.fondos;

import java.math.BigDecimal;

import com.anthill.Anthill;
import com.anthill.ant.Ant;
import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeInteger;

public class TicketAnt extends Ant {
	
	private Ant ticketControlDenunciadosAnt;

	public TicketAnt(Anthill anthill, Ant ticketControlDenunciadosAnt) {
		super(anthill);
		this.ticketControlDenunciadosAnt = ticketControlDenunciadosAnt;
	}

	public Clazz build() throws Exception {

		// SELECT  A.TICKET, A.DESCRIPCION, A.FECHAACTUALIZACIONSQL FROM Tickets A ORDER BY  A.DESCRIPCION,  A.TICKET
		
		
		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("Ticket");
		c.setNamePlural("Tickets");

		c.setNamePackage("fondos");
		c.setSingular("Ticket");
		c.setPlural("Tickets");
		c.setSingularPre("el ticket");
		c.setPluralPre("los tickets");

		// -------- Atts

		Att numero = new Att("numero", "Nº ticket");
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
		
		Att fechaActualizacion = new Att("fechaActualizacion", "Fecha actualización");
		fechaActualizacion.setDataTypeDate();		
//		fechaActualizacion.setRequired(true);				
		c.addAtt(fechaActualizacion);
		
		Att cantidadPorLotes = new Att("cantidadPorLotes", "Cantidad por lotes");
		cantidadPorLotes.setDataTypeInteger(1, null);		
		c.addAtt(cantidadPorLotes);
		
		Att ticketControlDenunciados = new Att("ticketControlDenunciados", "Control denunciados");
		ticketControlDenunciados.setDataTypeClazz(ticketControlDenunciadosAnt.build());
		ticketControlDenunciados.setRequired(true);
		c.addAtt(ticketControlDenunciados);
		
		Att valorMaximo = new Att("valorMaximo", "Valor máximo");
		valorMaximo.setDataTypeBigDecimal(new BigDecimal("0"), new BigDecimal("99999.9999"), 13, 5);
//		((DataTypeBigDecimal) valorMaximo.getDataType()).setDefValueInsert(new BigDecimal("1"));
//		valorMaximo.setRequired(true);
//		valorMaximo.setReadOnlyGUI(true);
		c.addAtt(valorMaximo);

		
		// -------- SBX Args

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

		return c;

		// ------------------------------------------------
	}

}
