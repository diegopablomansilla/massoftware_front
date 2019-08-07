package com.massoftware.service.fondos;

import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.service.AbstractFilter;
import com.massoftware.model.fondos.Ticket;

public class TicketModeloFiltro extends AbstractFilter {

	// ---------------------------------------------------------------------------------------------------------------------------

	public TicketModeloFiltro() {
		_levelDefault = 2;
	}

	// Nº modelo (desde)
	@FieldConfAnont(label = "Nº modelo (desde)", labelError = "", readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numeroFrom;

	// Nº modelo (hasta)
	@FieldConfAnont(label = "Nº modelo (hasta)", labelError = "", readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numeroTo;

	// Nombre
	@FieldConfAnont(label = "Nombre", labelError = "", readOnly = false, required = false, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String nombre;

	// ticket
	@FieldConfAnont(label = "ticket", labelError = "", readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Ticket ticket;

	// ---------------------------------------------------------------------------------------------------------------------------


	// GET Nº modelo (desde)
	public Integer getNumeroFrom() {
		return this.numeroFrom;
	}

	// SET Nº modelo (desde)
	public void setNumeroFrom(Integer numeroFrom){
		this.numeroFrom = numeroFrom;
	}

	// GET Nº modelo (hasta)
	public Integer getNumeroTo() {
		return this.numeroTo;
	}

	// SET Nº modelo (hasta)
	public void setNumeroTo(Integer numeroTo){
		this.numeroTo = numeroTo;
	}

	// GET Nombre
	public String getNombre() {
		return this.nombre;
	}

	// SET Nombre
	public void setNombre(String nombre){
		this.nombre = (nombre != null && nombre.trim().length() == 0) ? null : nombre;
	}

	// GET ticket
	public Ticket getTicket() {
		return this.ticket;
	}

	// SET ticket
	public void setTicket(Ticket ticket){
		this.ticket = ticket;
	}
		
	public boolean equals(Object obj) {
		
		if (super.equals(obj) == false) {
			return false;
		}
		
		if (obj == this) {
			return true;
		}
		
		TicketModeloFiltro other = (TicketModeloFiltro) obj;
		
		
		// -------------------------------------------------------------------
		
		if (other.getNumeroFrom() == null && this.getNumeroFrom() != null) {
			return false;
		}
		
		if (other.getNumeroFrom() != null && this.getNumeroFrom() == null) {
			return false;
		}
		
		if (other.getNumeroFrom() != null && this.getNumeroFrom() != null) {
		
			if (other.getNumeroFrom().equals(this.getNumeroFrom()) == false) {
				return false;
			}
		
		}
		
		// -------------------------------------------------------------------
		
		if (other.getNumeroTo() == null && this.getNumeroTo() != null) {
			return false;
		}
		
		if (other.getNumeroTo() != null && this.getNumeroTo() == null) {
			return false;
		}
		
		if (other.getNumeroTo() != null && this.getNumeroTo() != null) {
		
			if (other.getNumeroTo().equals(this.getNumeroTo()) == false) {
				return false;
			}
		
		}
		
		// -------------------------------------------------------------------
		
		if (other.getNombre() == null && this.getNombre() != null) {
			return false;
		}
		
		if (other.getNombre() != null && this.getNombre() == null) {
			return false;
		}
		
		if (other.getNombre() != null && this.getNombre() != null) {
		
			if (other.getNombre().equals(this.getNombre()) == false) {
				return false;
			}
		
		}
		
		// -------------------------------------------------------------------
		
		if (other.getTicket() == null && this.getTicket() != null) {
			return false;
		}
		
		if (other.getTicket() != null && this.getTicket() == null) {
			return false;
		}
		
		if (other.getTicket() != null && this.getTicket() != null) {
		
			if (other.getTicket().equals(this.getTicket()) == false) {
				return false;
			}
		
		}
		
		// -------------------------------------------------------------------
		
		return true;
		
		// -------------------------------------------------------------------
	}

} // END CLASS ----------------------------------------------------------------------------------------------------------