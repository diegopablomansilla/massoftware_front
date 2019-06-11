package com.massoftware.service.logistica;

import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.service.AbstractFilter;
import com.massoftware.model.logistica.Transporte;

public class TransporteTarifaFiltro extends AbstractFilter {

	// ---------------------------------------------------------------------------------------------------------------------------

	public TransporteTarifaFiltro() {
		_levelDefault = 3;
	}

	// Transporte
	@FieldConfAnont(label = "Transporte", labelError = "", readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Transporte transporte;

	// ---------------------------------------------------------------------------------------------------------------------------


	// GET Transporte
	public Transporte getTransporte() {
		return this.transporte;
	}

	// SET Transporte
	public void setTransporte(Transporte transporte ){
		this.transporte = transporte;
	}
		
	public boolean equals(Object obj) {
		
		if (super.equals(obj) == false) {
			return false;
		}
		
		if (obj == this) {
			return true;
		}
		
		TransporteTarifaFiltro other = (TransporteTarifaFiltro) obj;
		
		
		// -------------------------------------------------------------------
		
		if (other.getTransporte() == null && this.getTransporte() != null) {
			return false;
		}
		
		if (other.getTransporte() != null && this.getTransporte() == null) {
			return false;
		}
		
		if (other.getTransporte() != null && this.getTransporte() != null) {
		
			if (other.getTransporte().equals(this.getTransporte()) == false) {
				return false;
			}
		
		}
		
		// -------------------------------------------------------------------
		
		return true;
		
		// -------------------------------------------------------------------
	}

} // END CLASS ----------------------------------------------------------------------------------------------------------