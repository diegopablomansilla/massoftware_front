package com.massoftware.dao.geo;

import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.dao.AbstractFilter;

public class PaisFiltro extends AbstractFilter {

	// ---------------------------------------------------------------------------------------------------------------------------

	public PaisFiltro() {
		_levelDefault = 0;
	}

	// Nº país (desde)
	@FieldConfAnont(label = "Nº país (desde)", labelError = "", readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numeroFrom;

	// Nº país (hasta)
	@FieldConfAnont(label = "Nº país (hasta)", labelError = "", readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numeroTo;

	// Nombre
	@FieldConfAnont(label = "Nombre", labelError = "", readOnly = false, required = false, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String nombre;

	// Abreviatura
	@FieldConfAnont(label = "Abreviatura", labelError = "", readOnly = false, required = false, columns = 5.0f, maxLength = 5, minValue = "", maxValue = "", mask = "")
	private String abreviatura;

	// ---------------------------------------------------------------------------------------------------------------------------


	// GET Nº país (desde)
	public Integer getNumeroFrom() {
		return this.numeroFrom;
	}

	// SET Nº país (desde)
	public void setNumeroFrom(Integer numeroFrom ){
		this.numeroFrom = numeroFrom;
	}

	// GET Nº país (hasta)
	public Integer getNumeroTo() {
		return this.numeroTo;
	}

	// SET Nº país (hasta)
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

	// GET Abreviatura
	public String getAbreviatura() {
		return this.abreviatura;
	}

	// SET Abreviatura
	public void setAbreviatura(String abreviatura ){
		this.abreviatura = (abreviatura != null && abreviatura.trim().length() == 0) ? null : abreviatura;
	}
		
	public boolean equals(Object obj) {
		
		if (super.equals(obj) == false) {
			return false;
		}
		
		if (obj == this) {
			return true;
		}
		
		PaisFiltro other = (PaisFiltro) obj;
		
		
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
		
		if (other.getAbreviatura() == null && this.getAbreviatura() != null) {
			return false;
		}
		
		if (other.getAbreviatura() != null && this.getAbreviatura() == null) {
			return false;
		}
		
		if (other.getAbreviatura() != null && this.getAbreviatura() != null) {
		
			if (other.getAbreviatura().equals(this.getAbreviatura()) == false) {
				return false;
			}
		
		}
		
		// -------------------------------------------------------------------
		
		return true;
		
		// -------------------------------------------------------------------
	}

} // END CLASS ----------------------------------------------------------------------------------------------------------