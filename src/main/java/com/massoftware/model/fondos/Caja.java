package com.massoftware.model.fondos;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.model.EntityId;
import com.massoftware.model.seguridad.SeguridadPuerta;

@ClassLabelAnont(singular = "Caja", plural = "Cajas", singularPre = "la caja", pluralPre = "las cajas")
public class Caja extends EntityId {

	// ---------------------------------------------------------------------------------------------------------------------------


	@FieldConfAnont(label = "ID")
	private String id;

	// Nº caja
	@FieldConfAnont(label = "Nº caja", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numero;

	// Nombre
	@FieldConfAnont(label = "Nombre", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String nombre;

	// Puerta
	@FieldConfAnont(label = "Puerta", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private SeguridadPuerta seguridadPuerta;

	// ---------------------------------------------------------------------------------------------------------------------------


	public Caja() throws Exception {
	}

	public Caja(String idArg0, Integer numeroArg1, String nombreArg2, String idSeguridadPuertaArg3) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, idSeguridadPuertaArg3);

	}

	public Caja(String idArg0, Integer numeroArg1, String nombreArg2, String idArg3, Integer numeroArg4, String nombreArg5, String equateArg6, String idSeguridadModuloArg7) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, idArg3, numeroArg4, nombreArg5, equateArg6, idSeguridadModuloArg7);

	}

	public Caja(String idArg0, Integer numeroArg1, String nombreArg2, String idArg3, Integer numeroArg4, String nombreArg5, String equateArg6, String idArg7, Integer numeroArg8, String nombreArg9) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, idArg3, numeroArg4, nombreArg5, equateArg6, idArg7, numeroArg8, nombreArg9);

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

	// GET Nº caja
	public Integer getNumero() {
		return this.numero;
	}

	// SET Nº caja
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

	// BUILD IF NULL AND GET Puerta
	public SeguridadPuerta buildSeguridadPuerta() throws Exception {
		this.seguridadPuerta = (this.seguridadPuerta == null) ? new SeguridadPuerta() : this.seguridadPuerta;
		return this.seguridadPuerta;
	}

	// GET Puerta
	public SeguridadPuerta getSeguridadPuerta() {
		this.seguridadPuerta = (this.seguridadPuerta != null && this.seguridadPuerta.getId() == null) ? null : this.seguridadPuerta ;
		return this.seguridadPuerta;
	}

	// SET Puerta
	public void setSeguridadPuerta(SeguridadPuerta seguridadPuerta ){
		this.seguridadPuerta = seguridadPuerta;
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String idSeguridadPuertaArg3) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.buildSeguridadPuerta().setId(idSeguridadPuertaArg3);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String idArg3, Integer numeroArg4, String nombreArg5, String equateArg6, String idSeguridadModuloArg7) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.buildSeguridadPuerta().setId(idArg3);
		this.buildSeguridadPuerta().setNumero(numeroArg4);
		this.buildSeguridadPuerta().setNombre(nombreArg5);
		this.buildSeguridadPuerta().setEquate(equateArg6);
		this.buildSeguridadPuerta().buildSeguridadModulo().setId(idSeguridadModuloArg7);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String idArg3, Integer numeroArg4, String nombreArg5, String equateArg6, String idArg7, Integer numeroArg8, String nombreArg9) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.buildSeguridadPuerta().setId(idArg3);
		this.buildSeguridadPuerta().setNumero(numeroArg4);
		this.buildSeguridadPuerta().setNombre(nombreArg5);
		this.buildSeguridadPuerta().setEquate(equateArg6);
		this.buildSeguridadPuerta().buildSeguridadModulo().setId(idArg7);
		this.buildSeguridadPuerta().buildSeguridadModulo().setNumero(numeroArg8);
		this.buildSeguridadPuerta().buildSeguridadModulo().setNombre(nombreArg9);

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