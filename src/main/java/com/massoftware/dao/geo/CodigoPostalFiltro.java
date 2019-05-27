package com.massoftware.dao.geo;

import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.dao.AbstractFilter;
import com.massoftware.model.geo.Pais;
import com.massoftware.model.geo.Provincia;
import com.massoftware.model.geo.Ciudad;

public class CodigoPostalFiltro extends AbstractFilter {

	// ---------------------------------------------------------------------------------------------------------------------------

	public CodigoPostalFiltro() {
		_levelDefault = 3;
	}

	// Código
	@FieldConfAnont(label = "Código", labelError = "", readOnly = false, required = false, columns = 20.0f, maxLength = 12, minValue = "", maxValue = "", mask = "")
	private String codigo;

	// Secuencia (desde)
	@FieldConfAnont(label = "Secuencia (desde)", labelError = "", readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numeroFrom;

	// Secuencia (hasta)
	@FieldConfAnont(label = "Secuencia (hasta)", labelError = "", readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numeroTo;

	// País
	@FieldConfAnont(label = "País", labelError = "", readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Pais pais;

	// Provincia
	@FieldConfAnont(label = "Provincia", labelError = "", readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Provincia provincia;

	// Ciudad
	@FieldConfAnont(label = "Ciudad", labelError = "", readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Ciudad ciudad;

	// ---------------------------------------------------------------------------------------------------------------------------


	// GET Código
	public String getCodigo() {
		return this.codigo;
	}

	// SET Código
	public void setCodigo(String codigo ){
		this.codigo = (codigo != null && codigo.trim().length() == 0) ? null : codigo;
	}

	// GET Secuencia (desde)
	public Integer getNumeroFrom() {
		return this.numeroFrom;
	}

	// SET Secuencia (desde)
	public void setNumeroFrom(Integer numeroFrom ){
		this.numeroFrom = numeroFrom;
	}

	// GET Secuencia (hasta)
	public Integer getNumeroTo() {
		return this.numeroTo;
	}

	// SET Secuencia (hasta)
	public void setNumeroTo(Integer numeroTo ){
		this.numeroTo = numeroTo;
	}

	// GET País
	public Pais getPais() {
		return this.pais;
	}

	// SET País
	public void setPais(Pais pais ){
		this.pais = pais;
	}

	// GET Provincia
	public Provincia getProvincia() {
		return this.provincia;
	}

	// SET Provincia
	public void setProvincia(Provincia provincia ){
		this.provincia = provincia;
	}

	// GET Ciudad
	public Ciudad getCiudad() {
		return this.ciudad;
	}

	// SET Ciudad
	public void setCiudad(Ciudad ciudad ){
		this.ciudad = ciudad;
	}
		
	public boolean equals(Object obj) {
		
		if (super.equals(obj) == false) {
			return false;
		}
		
		if (obj == this) {
			return true;
		}
		
		CodigoPostalFiltro other = (CodigoPostalFiltro) obj;
		
		
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
		
		if (other.getPais() == null && this.getPais() != null) {
			return false;
		}
		
		if (other.getPais() != null && this.getPais() == null) {
			return false;
		}
		
		if (other.getPais() != null && this.getPais() != null) {
		
			if (other.getPais().equals(this.getPais()) == false) {
				return false;
			}
		
		}
		
		// -------------------------------------------------------------------
		
		if (other.getProvincia() == null && this.getProvincia() != null) {
			return false;
		}
		
		if (other.getProvincia() != null && this.getProvincia() == null) {
			return false;
		}
		
		if (other.getProvincia() != null && this.getProvincia() != null) {
		
			if (other.getProvincia().equals(this.getProvincia()) == false) {
				return false;
			}
		
		}
		
		// -------------------------------------------------------------------
		
		if (other.getCiudad() == null && this.getCiudad() != null) {
			return false;
		}
		
		if (other.getCiudad() != null && this.getCiudad() == null) {
			return false;
		}
		
		if (other.getCiudad() != null && this.getCiudad() != null) {
		
			if (other.getCiudad().equals(this.getCiudad()) == false) {
				return false;
			}
		
		}
		
		// -------------------------------------------------------------------
		
		return true;
		
		// -------------------------------------------------------------------
	}

} // END CLASS ----------------------------------------------------------------------------------------------------------