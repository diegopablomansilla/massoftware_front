package com.massoftware.service.contabilidad;

import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.service.AbstractFilter;
import com.massoftware.model.contabilidad.AsientoModelo;

public class AsientoModeloItemFiltro extends AbstractFilter {

	// ---------------------------------------------------------------------------------------------------------------------------

	public AsientoModeloItemFiltro() {
		_levelDefault = 3;
	}

	// Asiento modelo
	@FieldConfAnont(label = "Asiento modelo", labelError = "", readOnly = true, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private AsientoModelo asientoModelo;

	// ---------------------------------------------------------------------------------------------------------------------------


	// GET Asiento modelo
	public AsientoModelo getAsientoModelo() {
		return this.asientoModelo;
	}

	// SET Asiento modelo
	public void setAsientoModelo(AsientoModelo asientoModelo){
		this.asientoModelo = asientoModelo;
	}
		
	public boolean equals(Object obj) {
		
		if (super.equals(obj) == false) {
			return false;
		}
		
		if (obj == this) {
			return true;
		}
		
		AsientoModeloItemFiltro other = (AsientoModeloItemFiltro) obj;
		
		
		// -------------------------------------------------------------------
		
		if (other.getAsientoModelo() == null && this.getAsientoModelo() != null) {
			return false;
		}
		
		if (other.getAsientoModelo() != null && this.getAsientoModelo() == null) {
			return false;
		}
		
		if (other.getAsientoModelo() != null && this.getAsientoModelo() != null) {
		
			if (other.getAsientoModelo().equals(this.getAsientoModelo()) == false) {
				return false;
			}
		
		}
		
		// -------------------------------------------------------------------
		
		return true;
		
		// -------------------------------------------------------------------
	}

} // END CLASS ----------------------------------------------------------------------------------------------------------