package com.massoftware.service.clientes;

import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.service.AbstractFilter;
import com.massoftware.model.clientes.ClasificacionCliente;

public class MotivoBloqueoClienteFiltro extends AbstractFilter {

	// ---------------------------------------------------------------------------------------------------------------------------

	public MotivoBloqueoClienteFiltro() {
		_levelDefault = 1;
	}

	// Nº motivo (desde)
	@FieldConfAnont(label = "Nº motivo (desde)", labelError = "", readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numeroFrom;

	// Nº motivo (hasta)
	@FieldConfAnont(label = "Nº motivo (hasta)", labelError = "", readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numeroTo;

	// Nombre
	@FieldConfAnont(label = "Nombre", labelError = "", readOnly = false, required = false, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String nombre;

	// Clasificación de cliente
	@FieldConfAnont(label = "Clasificación de cliente", labelError = "", readOnly = false, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private ClasificacionCliente clasificacionCliente;

	// ---------------------------------------------------------------------------------------------------------------------------


	// GET Nº motivo (desde)
	public Integer getNumeroFrom() {
		return this.numeroFrom;
	}

	// SET Nº motivo (desde)
	public void setNumeroFrom(Integer numeroFrom){
		this.numeroFrom = numeroFrom;
	}

	// GET Nº motivo (hasta)
	public Integer getNumeroTo() {
		return this.numeroTo;
	}

	// SET Nº motivo (hasta)
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

	// GET Clasificación de cliente
	public ClasificacionCliente getClasificacionCliente() {
		return this.clasificacionCliente;
	}

	// SET Clasificación de cliente
	public void setClasificacionCliente(ClasificacionCliente clasificacionCliente){
		this.clasificacionCliente = clasificacionCliente;
	}
		
	public boolean equals(Object obj) {
		
		if (super.equals(obj) == false) {
			return false;
		}
		
		if (obj == this) {
			return true;
		}
		
		MotivoBloqueoClienteFiltro other = (MotivoBloqueoClienteFiltro) obj;
		
		
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
		
		if (other.getClasificacionCliente() == null && this.getClasificacionCliente() != null) {
			return false;
		}
		
		if (other.getClasificacionCliente() != null && this.getClasificacionCliente() == null) {
			return false;
		}
		
		if (other.getClasificacionCliente() != null && this.getClasificacionCliente() != null) {
		
			if (other.getClasificacionCliente().equals(this.getClasificacionCliente()) == false) {
				return false;
			}
		
		}
		
		// -------------------------------------------------------------------
		
		return true;
		
		// -------------------------------------------------------------------
	}

} // END CLASS ----------------------------------------------------------------------------------------------------------