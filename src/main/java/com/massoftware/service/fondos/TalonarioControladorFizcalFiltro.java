package com.massoftware.service.fondos;

import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.service.AbstractFilter;

public class TalonarioControladorFizcalFiltro extends AbstractFilter {

	// ---------------------------------------------------------------------------------------------------------------------------

	public TalonarioControladorFizcalFiltro() {
		_levelDefault = 0;
	}

	// Nº controlador
	@FieldConfAnont(label = "Nº controlador", labelError = "", readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "", maxValue = "", mask = "")
	private String codigo;

	// Nombre
	@FieldConfAnont(label = "Nombre", labelError = "", readOnly = false, required = false, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String nombre;

	// ---------------------------------------------------------------------------------------------------------------------------


	// GET Nº controlador
	public String getCodigo() {
		return this.codigo;
	}

	// SET Nº controlador
	public void setCodigo(String codigo ){
		this.codigo = (codigo != null && codigo.trim().length() == 0) ? null : codigo;
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
		
		TalonarioControladorFizcalFiltro other = (TalonarioControladorFizcalFiltro) obj;
		
		
		// -------------------------------------------------------------------
		
		if (other.getCodigo() == null && this.getCodigo() != null) {
			return false;
		}
		
		if (other.getCodigo() != null && this.getCodigo() == null) {
			return false;
		}
		
		if (other.getCodigo() != null && this.getCodigo() != null) {
		
			if (other.getCodigo().equals(this.getCodigo()) == false) {
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