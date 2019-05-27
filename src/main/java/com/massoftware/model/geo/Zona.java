package com.massoftware.model.geo;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.model.EntityId;

@ClassLabelAnont(singular = "Zona", plural = "Zonas", singularPre = "la zona", pluralPre = "las zonas")
public class Zona extends EntityId {

	// ---------------------------------------------------------------------------------------------------------------------------


	@FieldConfAnont(label = "ID")
	private String id;

	// Código
	@FieldConfAnont(label = "Código", labelError = "", unique = true, readOnly = false, required = true, columns = 6.0f, maxLength = 3, minValue = "", maxValue = "", mask = "")
	private String codigo;

	// Nombre
	@FieldConfAnont(label = "Nombre", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String nombre;

	// Bonificación
	@FieldConfAnont(label = "Bonificación", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "0", maxValue = "99999.9999", mask = "")
	private java.math.BigDecimal bonificacion;

	// Recargo
	@FieldConfAnont(label = "Recargo", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "0", maxValue = "99999.9999", mask = "")
	private java.math.BigDecimal recargo;

	// ---------------------------------------------------------------------------------------------------------------------------


	public Zona() throws Exception {
	}

	public Zona(String idArg0, String codigoArg1, String nombreArg2, java.math.BigDecimal bonificacionArg3, java.math.BigDecimal recargoArg4) throws Exception {

		setter(idArg0, codigoArg1, nombreArg2, bonificacionArg3, recargoArg4);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	// GET ID
	public String getId() {
		return this.id;
	}
	// SET ID
	public void setId(String id){
		id = (id != null) ? id.trim() : null;
		this.id = (id != null && id.length() == 0) ? null : id;
	}

	// GET Código
	public String getCodigo() {
		return this.codigo;
	}

	// SET Código
	public void setCodigo(String codigo ){
		codigo = (codigo != null) ? codigo.trim() : null;
		this.codigo = (codigo != null && codigo.length() == 0) ? null : codigo;
	}

	// GET Nombre
	public String getNombre() {
		return this.nombre;
	}

	// SET Nombre
	public void setNombre(String nombre ){
		nombre = (nombre != null) ? nombre.trim() : null;
		this.nombre = (nombre != null && nombre.length() == 0) ? null : nombre;
	}

	// GET Bonificación
	public java.math.BigDecimal getBonificacion() {
		return this.bonificacion;
	}

	// SET Bonificación
	public void setBonificacion(java.math.BigDecimal bonificacion ){
		this.bonificacion = bonificacion;
	}

	// GET Recargo
	public java.math.BigDecimal getRecargo() {
		return this.recargo;
	}

	// SET Recargo
	public void setRecargo(java.math.BigDecimal recargo ){
		this.recargo = recargo;
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, String codigoArg1, String nombreArg2, java.math.BigDecimal bonificacionArg3, java.math.BigDecimal recargoArg4) throws Exception {

		this.setId(idArg0);
		this.setCodigo(codigoArg1);
		this.setNombre(nombreArg2);
		this.setBonificacion(bonificacionArg3);
		this.setRecargo(recargoArg4);

	}

	// ---------------------------------------------------------------------------------------------------------------------------

	public String toString() {
		if(this.getCodigo() != null && this.getNombre() != null){
			return this.getCodigo() + " - " +  this.getNombre();
		} else if(this.getCodigo() != null && this.getNombre() == null){
			return this.getCodigo();
		} else if(this.getCodigo() == null && this.getNombre() != null){
			return this.getNombre();
		} else {
			return super.toString();
		}
	}

} // END CLASS ----------------------------------------------------------------------------------------------------------