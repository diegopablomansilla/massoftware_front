package com.massoftware.service.monedas;

import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.service.AbstractFilter;
import com.massoftware.model.monedas.Moneda;

public class MonedaCotizacionFiltro extends AbstractFilter {

	// ---------------------------------------------------------------------------------------------------------------------------

	public MonedaCotizacionFiltro() {
		_levelDefault = 2;
	}

	// Moneda
	@FieldConfAnont(label = "Moneda", labelError = "", readOnly = false, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Moneda moneda;

	// Fecha cotización (desde)
	@FieldConfAnont(label = "Fecha cotización (desde)", labelError = "", readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private java.sql.Timestamp cotizacionFechaFrom;

	// Fecha cotización (hasta)
	@FieldConfAnont(label = "Fecha cotización (hasta)", labelError = "", readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private java.sql.Timestamp cotizacionFechaTo;

	// ---------------------------------------------------------------------------------------------------------------------------


	// GET Moneda
	public Moneda getMoneda() {
		return this.moneda;
	}

	// SET Moneda
	public void setMoneda(Moneda moneda ){
		this.moneda = moneda;
	}

	// GET Fecha cotización (desde)
	public java.sql.Timestamp getCotizacionFechaFrom() {
		return this.cotizacionFechaFrom;
	}

	// SET Fecha cotización (desde)
	public void setCotizacionFechaFrom(java.sql.Timestamp cotizacionFechaFrom ){
		this.cotizacionFechaFrom = cotizacionFechaFrom;
	}

	// GET Fecha cotización (hasta)
	public java.sql.Timestamp getCotizacionFechaTo() {
		return this.cotizacionFechaTo;
	}

	// SET Fecha cotización (hasta)
	public void setCotizacionFechaTo(java.sql.Timestamp cotizacionFechaTo ){
		this.cotizacionFechaTo = cotizacionFechaTo;
	}
		
	public boolean equals(Object obj) {
		
		if (super.equals(obj) == false) {
			return false;
		}
		
		if (obj == this) {
			return true;
		}
		
		MonedaCotizacionFiltro other = (MonedaCotizacionFiltro) obj;
		
		
		// -------------------------------------------------------------------
		
		if (other.getMoneda() == null && this.getMoneda() != null) {
			return false;
		}
		
		if (other.getMoneda() != null && this.getMoneda() == null) {
			return false;
		}
		
		if (other.getMoneda() != null && this.getMoneda() != null) {
		
			if (other.getMoneda().equals(this.getMoneda()) == false) {
				return false;
			}
		
		}
		
		// -------------------------------------------------------------------
		
		if (other.getCotizacionFechaFrom() == null && this.getCotizacionFechaFrom() != null) {
			return false;
		}
		
		if (other.getCotizacionFechaFrom() != null && this.getCotizacionFechaFrom() == null) {
			return false;
		}
		
		if (other.getCotizacionFechaFrom() != null && this.getCotizacionFechaFrom() != null) {
		
			if (other.getCotizacionFechaFrom().equals(this.getCotizacionFechaFrom()) == false) {
				return false;
			}
		
		}
		
		// -------------------------------------------------------------------
		
		if (other.getCotizacionFechaTo() == null && this.getCotizacionFechaTo() != null) {
			return false;
		}
		
		if (other.getCotizacionFechaTo() != null && this.getCotizacionFechaTo() == null) {
			return false;
		}
		
		if (other.getCotizacionFechaTo() != null && this.getCotizacionFechaTo() != null) {
		
			if (other.getCotizacionFechaTo().equals(this.getCotizacionFechaTo()) == false) {
				return false;
			}
		
		}
		
		// -------------------------------------------------------------------
		
		return true;
		
		// -------------------------------------------------------------------
	}

} // END CLASS ----------------------------------------------------------------------------------------------------------