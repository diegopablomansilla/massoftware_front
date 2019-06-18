package com.massoftware.service.contabilidad;

import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.service.AbstractFilter;
import com.massoftware.model.contabilidad.AsientoContable;

public class AsientoContableItemFiltro extends AbstractFilter {

	// ---------------------------------------------------------------------------------------------------------------------------

	public AsientoContableItemFiltro() {
		_levelDefault = 3;
	}

	// Nº item (desde)
	@FieldConfAnont(label = "Nº item (desde)", labelError = "", readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numeroFrom;

	// Nº item (hasta)
	@FieldConfAnont(label = "Nº item (hasta)", labelError = "", readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numeroTo;

	// Detalle
	@FieldConfAnont(label = "Detalle", labelError = "", readOnly = false, required = false, columns = 20.0f, maxLength = 100, minValue = "", maxValue = "", mask = "")
	private String detalle;

	// Asiento contable
	@FieldConfAnont(label = "Asiento contable", labelError = "", readOnly = true, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private AsientoContable asientoContable;

	// ---------------------------------------------------------------------------------------------------------------------------


	// GET Nº item (desde)
	public Integer getNumeroFrom() {
		return this.numeroFrom;
	}

	// SET Nº item (desde)
	public void setNumeroFrom(Integer numeroFrom ){
		this.numeroFrom = numeroFrom;
	}

	// GET Nº item (hasta)
	public Integer getNumeroTo() {
		return this.numeroTo;
	}

	// SET Nº item (hasta)
	public void setNumeroTo(Integer numeroTo ){
		this.numeroTo = numeroTo;
	}

	// GET Detalle
	public String getDetalle() {
		return this.detalle;
	}

	// SET Detalle
	public void setDetalle(String detalle ){
		this.detalle = (detalle != null && detalle.trim().length() == 0) ? null : detalle;
	}

	// GET Asiento contable
	public AsientoContable getAsientoContable() {
		return this.asientoContable;
	}

	// SET Asiento contable
	public void setAsientoContable(AsientoContable asientoContable ){
		this.asientoContable = asientoContable;
	}
		
	public boolean equals(Object obj) {
		
		if (super.equals(obj) == false) {
			return false;
		}
		
		if (obj == this) {
			return true;
		}
		
		AsientoContableItemFiltro other = (AsientoContableItemFiltro) obj;
		
		
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
		
		if (other.getDetalle() == null && this.getDetalle() != null) {
			return false;
		}
		
		if (other.getDetalle() != null && this.getDetalle() == null) {
			return false;
		}
		
		if (other.getDetalle() != null && this.getDetalle() != null) {
		
			if (other.getDetalle().equals(this.getDetalle()) == false) {
				return false;
			}
		
		}
		
		// -------------------------------------------------------------------
		
		if (other.getAsientoContable() == null && this.getAsientoContable() != null) {
			return false;
		}
		
		if (other.getAsientoContable() != null && this.getAsientoContable() == null) {
			return false;
		}
		
		if (other.getAsientoContable() != null && this.getAsientoContable() != null) {
		
			if (other.getAsientoContable().equals(this.getAsientoContable()) == false) {
				return false;
			}
		
		}
		
		// -------------------------------------------------------------------
		
		return true;
		
		// -------------------------------------------------------------------
	}

} // END CLASS ----------------------------------------------------------------------------------------------------------