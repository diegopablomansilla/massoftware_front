package com.massoftware.model.seguridad;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.model.EntityId;
import com.massoftware.model.seguridad.SeguridadModulo;

@ClassLabelAnont(singular = "Puerta", plural = "Puertas", singularPre = "la puerta", pluralPre = "las puertas")
public class SeguridadPuerta extends EntityId {

	// ---------------------------------------------------------------------------------------------------------------------------


	@FieldConfAnont(label = "ID")
	private String id;

	// Nº puerta
	@FieldConfAnont(label = "Nº puerta", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numero;

	// Nombre
	@FieldConfAnont(label = "Nombre", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String nombre;

	// I.D
	@FieldConfAnont(label = "I.D", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = 30, minValue = "", maxValue = "", mask = "")
	private String equate;

	// Módulo
	@FieldConfAnont(label = "Módulo", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private SeguridadModulo seguridadModulo;

	// ---------------------------------------------------------------------------------------------------------------------------


	public SeguridadPuerta() throws Exception {
	}

	public SeguridadPuerta(String idArg0, Integer numeroArg1, String nombreArg2, String equateArg3, String idSeguridadModuloArg4) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, equateArg3, idSeguridadModuloArg4);

	}

	public SeguridadPuerta(String idArg0, Integer numeroArg1, String nombreArg2, String equateArg3, String idArg4, Integer numeroArg5, String nombreArg6) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, equateArg3, idArg4, numeroArg5, nombreArg6);

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

	// GET Nº puerta
	public Integer getNumero() {
		return this.numero;
	}

	// SET Nº puerta
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

	// GET I.D
	public String getEquate() {
		return this.equate;
	}

	// SET I.D
	public void setEquate(String equate ){
		equate = (equate != null) ? equate.trim() : null;
		this.equate = (equate != null && equate.length() == 0) ? null : equate;
	}

	// BUILD IF NULL AND GET Módulo
	public SeguridadModulo buildSeguridadModulo() throws Exception {
		this.seguridadModulo = (this.seguridadModulo == null) ? new SeguridadModulo() : this.seguridadModulo;
		return this.seguridadModulo;
	}

	// GET Módulo
	public SeguridadModulo getSeguridadModulo() {
		this.seguridadModulo = (this.seguridadModulo != null && this.seguridadModulo.getId() == null) ? null : this.seguridadModulo ;
		return this.seguridadModulo;
	}

	// SET Módulo
	public void setSeguridadModulo(SeguridadModulo seguridadModulo ){
		this.seguridadModulo = seguridadModulo;
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String equateArg3, String idSeguridadModuloArg4) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.setEquate(equateArg3);
		this.buildSeguridadModulo().setId(idSeguridadModuloArg4);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String equateArg3, String idArg4, Integer numeroArg5, String nombreArg6) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.setEquate(equateArg3);
		this.buildSeguridadModulo().setId(idArg4);
		this.buildSeguridadModulo().setNumero(numeroArg5);
		this.buildSeguridadModulo().setNombre(nombreArg6);

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