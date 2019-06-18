package com.massoftware.service.contabilidad;

import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.service.AbstractFilter;

public class MinutaContableFiltro extends AbstractFilter {

	// ---------------------------------------------------------------------------------------------------------------------------

	public MinutaContableFiltro() {
		_levelDefault = 0;
	}

	// Nº minuta (desde)
	@FieldConfAnont(label = "Nº minuta (desde)", labelError = "", readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numeroFrom;

	// Nº minuta (hasta)
	@FieldConfAnont(label = "Nº minuta (hasta)", labelError = "", readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numeroTo;

	// Nombre
	@FieldConfAnont(label = "Nombre", labelError = "", readOnly = false, required = false, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String nombre;

	// ---------------------------------------------------------------------------------------------------------------------------


	// GET Nº minuta (desde)
	public Integer getNumeroFrom() {
		return this.numeroFrom;
	}

	// SET Nº minuta (desde)
	public void setNumeroFrom(Integer numeroFrom ){
		this.numeroFrom = numeroFrom;
	}

	// GET Nº minuta (hasta)
	public Integer getNumeroTo() {
		return this.numeroTo;
	}

	// SET Nº minuta (hasta)
	public void setNumeroTo(Integer numeroTo ){
		this.numeroTo = numeroTo;
	}

	// GET Nombre
	public String getNombre() {
		return this.nombre;
	}

	// SET Nombre
	public void setNombre(String nombre ){
		this.nombre = (nombre != null && nombre.trim().length() == 0) ? null : nombre;
	}
		
	public boolean equals(Object obj) {
		
		if (super.equals(obj) == false) {
			return false;
		}
		
		if (obj == this) {
			return true;
		}
		
		MinutaContableFiltro other = (MinutaContableFiltro) obj;
		
		
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
		
		return true;
		
		// -------------------------------------------------------------------
	}

} // END CLASS ----------------------------------------------------------------------------------------------------------