package com.massoftware.service.fondos;

import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.service.AbstractFilter;
import com.massoftware.model.fondos.CuentaFondoRubro;

public class CuentaFondoGrupoFiltro extends AbstractFilter {

	// ---------------------------------------------------------------------------------------------------------------------------

	public CuentaFondoGrupoFiltro() {
		_levelDefault = 1;
	}

	// Nº grupo (desde)
	@FieldConfAnont(label = "Nº grupo (desde)", labelError = "", readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numeroFrom;

	// Nº grupo (hasta)
	@FieldConfAnont(label = "Nº grupo (hasta)", labelError = "", readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numeroTo;

	// Nombre
	@FieldConfAnont(label = "Nombre", labelError = "", readOnly = false, required = false, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String nombre;

	// Rubro
	@FieldConfAnont(label = "Rubro", labelError = "", readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private CuentaFondoRubro cuentaFondoRubro;

	// ---------------------------------------------------------------------------------------------------------------------------


	// GET Nº grupo (desde)
	public Integer getNumeroFrom() {
		return this.numeroFrom;
	}

	// SET Nº grupo (desde)
	public void setNumeroFrom(Integer numeroFrom){
		this.numeroFrom = numeroFrom;
	}

	// GET Nº grupo (hasta)
	public Integer getNumeroTo() {
		return this.numeroTo;
	}

	// SET Nº grupo (hasta)
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

	// GET Rubro
	public CuentaFondoRubro getCuentaFondoRubro() {
		return this.cuentaFondoRubro;
	}

	// SET Rubro
	public void setCuentaFondoRubro(CuentaFondoRubro cuentaFondoRubro){
		this.cuentaFondoRubro = cuentaFondoRubro;
	}
		
	public boolean equals(Object obj) {
		
		if (super.equals(obj) == false) {
			return false;
		}
		
		if (obj == this) {
			return true;
		}
		
		CuentaFondoGrupoFiltro other = (CuentaFondoGrupoFiltro) obj;
		
		
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
		
		if (other.getCuentaFondoRubro() == null && this.getCuentaFondoRubro() != null) {
			return false;
		}
		
		if (other.getCuentaFondoRubro() != null && this.getCuentaFondoRubro() == null) {
			return false;
		}
		
		if (other.getCuentaFondoRubro() != null && this.getCuentaFondoRubro() != null) {
		
			if (other.getCuentaFondoRubro().equals(this.getCuentaFondoRubro()) == false) {
				return false;
			}
		
		}
		
		// -------------------------------------------------------------------
		
		return true;
		
		// -------------------------------------------------------------------
	}

} // END CLASS ----------------------------------------------------------------------------------------------------------