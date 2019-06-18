package com.massoftware.service.empresa;

import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.service.AbstractFilter;

public class EmpresaFiltro extends AbstractFilter {

	// ---------------------------------------------------------------------------------------------------------------------------

	public EmpresaFiltro() {
		_levelDefault = 1;
	}

	// ---------------------------------------------------------------------------------------------------------------------------

		
	public boolean equals(Object obj) {
		
		if (super.equals(obj) == false) {
			return false;
		}
		
		if (obj == this) {
			return true;
		}
		
		EmpresaFiltro other = (EmpresaFiltro) obj;
		
		
		// -------------------------------------------------------------------
		
		return true;
		
		// -------------------------------------------------------------------
	}

} // END CLASS ----------------------------------------------------------------------------------------------------------