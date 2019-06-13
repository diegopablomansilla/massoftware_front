package com.massoftware.service.contabilidad;

import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.service.AbstractFilter;

public class EjercicioContableFiltro extends AbstractFilter {

	// ---------------------------------------------------------------------------------------------------------------------------

	public EjercicioContableFiltro() {
		_levelDefault = 0;
	}

	// Nº ejercicio (desde)
	@FieldConfAnont(label = "Nº ejercicio (desde)", labelError = "", readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numeroFrom;

	// Nº ejercicio (hasta)
	@FieldConfAnont(label = "Nº ejercicio (hasta)", labelError = "", readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numeroTo;

	// ---------------------------------------------------------------------------------------------------------------------------


	// GET Nº ejercicio (desde)
	public Integer getNumeroFrom() {
		return this.numeroFrom;
	}

	// SET Nº ejercicio (desde)
	public void setNumeroFrom(Integer numeroFrom ){
		this.numeroFrom = numeroFrom;
	}

	// GET Nº ejercicio (hasta)
	public Integer getNumeroTo() {
		return this.numeroTo;
	}

	// SET Nº ejercicio (hasta)
	public void setNumeroTo(Integer numeroTo ){
		this.numeroTo = numeroTo;
	}
		
	public boolean equals(Object obj) {
		
		if (super.equals(obj) == false) {
			return false;
		}
		
		if (obj == this) {
			return true;
		}
		
		EjercicioContableFiltro other = (EjercicioContableFiltro) obj;
		
		
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
		
		return true;
		
		// -------------------------------------------------------------------
	}

} // END CLASS ----------------------------------------------------------------------------------------------------------