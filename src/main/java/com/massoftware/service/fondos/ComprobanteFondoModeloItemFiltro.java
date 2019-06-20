package com.massoftware.service.fondos;

import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.service.AbstractFilter;
import com.massoftware.model.fondos.CuentaFondo;

public class ComprobanteFondoModeloItemFiltro extends AbstractFilter {

	// ---------------------------------------------------------------------------------------------------------------------------

	public ComprobanteFondoModeloItemFiltro() {
		_levelDefault = 3;
	}

	// Nº modelo (desde)
	@FieldConfAnont(label = "Nº modelo (desde)", labelError = "", readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numeroFrom;

	// Nº modelo (hasta)
	@FieldConfAnont(label = "Nº modelo (hasta)", labelError = "", readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numeroTo;

	// Cuenta fondo
	@FieldConfAnont(label = "Cuenta fondo", labelError = "", readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private CuentaFondo cuentaFondo;

	// ---------------------------------------------------------------------------------------------------------------------------


	// GET Nº modelo (desde)
	public Integer getNumeroFrom() {
		return this.numeroFrom;
	}

	// SET Nº modelo (desde)
	public void setNumeroFrom(Integer numeroFrom ){
		this.numeroFrom = numeroFrom;
	}

	// GET Nº modelo (hasta)
	public Integer getNumeroTo() {
		return this.numeroTo;
	}

	// SET Nº modelo (hasta)
	public void setNumeroTo(Integer numeroTo ){
		this.numeroTo = numeroTo;
	}

	// GET Cuenta fondo
	public CuentaFondo getCuentaFondo() {
		return this.cuentaFondo;
	}

	// SET Cuenta fondo
	public void setCuentaFondo(CuentaFondo cuentaFondo ){
		this.cuentaFondo = cuentaFondo;
	}
		
	public boolean equals(Object obj) {
		
		if (super.equals(obj) == false) {
			return false;
		}
		
		if (obj == this) {
			return true;
		}
		
		ComprobanteFondoModeloItemFiltro other = (ComprobanteFondoModeloItemFiltro) obj;
		
		
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
		
		if (other.getCuentaFondo() == null && this.getCuentaFondo() != null) {
			return false;
		}
		
		if (other.getCuentaFondo() != null && this.getCuentaFondo() == null) {
			return false;
		}
		
		if (other.getCuentaFondo() != null && this.getCuentaFondo() != null) {
		
			if (other.getCuentaFondo().equals(this.getCuentaFondo()) == false) {
				return false;
			}
		
		}
		
		// -------------------------------------------------------------------
		
		return true;
		
		// -------------------------------------------------------------------
	}

} // END CLASS ----------------------------------------------------------------------------------------------------------