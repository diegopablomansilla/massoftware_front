package com.massoftware.model.geo;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.model.EntityId;

@ClassLabelAnont(singular = "País", plural = "Países", singularPre = "el país", pluralPre = "los países")
public class Pais extends EntityId {

	// ---------------------------------------------------------------------------------------------------------------------------


	@FieldConfAnont(label = "ID")
	private String id;

	// Nº país
	@FieldConfAnont(label = "Nº país", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numero;

	// Nombre
	@FieldConfAnont(label = "Nombre", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String nombre;

	// Abreviatura
	@FieldConfAnont(label = "Abreviatura", labelError = "", unique = true, readOnly = false, required = true, columns = 5.0f, maxLength = 5, minValue = "", maxValue = "", mask = "")
	private String abreviatura;

	// ---------------------------------------------------------------------------------------------------------------------------


	public Pais() throws Exception {
	}

	public Pais(String idArg0, Integer numeroArg1, String nombreArg2, String abreviaturaArg3) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, abreviaturaArg3);

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

	// GET Nº país
	public Integer getNumero() {
		return this.numero;
	}

	// SET Nº país
	public void setNumero(Integer numero ){
		this.numero = numero;
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

	// GET Abreviatura
	public String getAbreviatura() {
		return this.abreviatura;
	}

	// SET Abreviatura
	public void setAbreviatura(String abreviatura ){
		abreviatura = (abreviatura != null) ? abreviatura.trim() : null;
		this.abreviatura = (abreviatura != null && abreviatura.length() == 0) ? null : abreviatura;
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String abreviaturaArg3) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.setAbreviatura(abreviaturaArg3);

	}

	// ---------------------------------------------------------------------------------------------------------------------------

	public String toString() {
		if(this.getNumero() != null && this.getNombre() != null){
			return this.getNumero() + " - " +  this.getNombre();
		} else if(this.getNumero() != null && this.getNombre() == null){
			return this.getNumero().toString();
		} else if(this.getNumero() == null && this.getNombre() != null){
			return this.getNombre();
		} else {
			return super.toString();
		}
	}

} // END CLASS ----------------------------------------------------------------------------------------------------------