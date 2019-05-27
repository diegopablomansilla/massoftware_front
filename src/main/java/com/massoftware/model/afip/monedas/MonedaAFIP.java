package com.massoftware.model.afip.monedas;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.model.EntityId;

@ClassLabelAnont(singular = "Moneda AFIP", plural = "Monedas AFIP", singularPre = "la moneda AFIP", pluralPre = "las monedas AFIP")
public class MonedaAFIP extends EntityId {

	// ---------------------------------------------------------------------------------------------------------------------------


	@FieldConfAnont(label = "ID")
	private String id;

	// Código
	@FieldConfAnont(label = "Código", labelError = "", unique = true, readOnly = false, required = true, columns = 6.0f, maxLength = 3, minValue = "", maxValue = "", mask = "")
	private String codigo;

	// Nombre
	@FieldConfAnont(label = "Nombre", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String nombre;

	// ---------------------------------------------------------------------------------------------------------------------------


	public MonedaAFIP() throws Exception {
	}

	public MonedaAFIP(String idArg0, String codigoArg1, String nombreArg2) throws Exception {

		setter(idArg0, codigoArg1, nombreArg2);

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

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, String codigoArg1, String nombreArg2) throws Exception {

		this.setId(idArg0);
		this.setCodigo(codigoArg1);
		this.setNombre(nombreArg2);

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