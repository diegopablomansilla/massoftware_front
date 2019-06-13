package com.massoftware.model.contabilidad;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.model.EntityId;

@ClassLabelAnont(singular = "Ejercicio", plural = "Ejercicios", singularPre = "el ejercicio", pluralPre = "los ejercicios")
public class EjercicioContable extends EntityId {

	// ---------------------------------------------------------------------------------------------------------------------------


	@FieldConfAnont(label = "ID")
	private String id;

	// Nº ejercicio
	@FieldConfAnont(label = "Nº ejercicio", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numero;

	// Apertura
	@FieldConfAnont(label = "Apertura", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private java.util.Date apertura;

	// Cierre
	@FieldConfAnont(label = "Cierre", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private java.util.Date cierre;

	// Cerrado
	@FieldConfAnont(label = "Cerrado", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Boolean cerrado = false;

	// Cerrado módulos
	@FieldConfAnont(label = "Cerrado módulos", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Boolean cerradoModulos = false;

	// Coemntario
	@FieldConfAnont(label = "Coemntario", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 250, minValue = "", maxValue = "", mask = "")
	private String comentario;

	// ---------------------------------------------------------------------------------------------------------------------------


	public EjercicioContable() throws Exception {
	}

	public EjercicioContable(String idArg0, Integer numeroArg1, java.util.Date aperturaArg2, java.util.Date cierreArg3, Boolean cerradoArg4, Boolean cerradoModulosArg5, String comentarioArg6) throws Exception {

		setter(idArg0, numeroArg1, aperturaArg2, cierreArg3, cerradoArg4, cerradoModulosArg5, comentarioArg6);

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

	// GET Nº ejercicio
	public Integer getNumero() {
		return this.numero;
	}

	// SET Nº ejercicio
	public void setNumero(Integer numero ){
		this.numero = numero;
	}

	// GET Apertura
	public java.util.Date getApertura() {
		return this.apertura;
	}

	// SET Apertura
	public void setApertura(java.util.Date apertura ){
		this.apertura = apertura;
	}

	// GET Cierre
	public java.util.Date getCierre() {
		return this.cierre;
	}

	// SET Cierre
	public void setCierre(java.util.Date cierre ){
		this.cierre = cierre;
	}

	// GET Cerrado
	public Boolean getCerrado() {
		return this.cerrado;
	}

	// SET Cerrado
	public void setCerrado(Boolean cerrado ){
		this.cerrado = (cerrado == null) ? false : cerrado;
	}

	// GET Cerrado módulos
	public Boolean getCerradoModulos() {
		return this.cerradoModulos;
	}

	// SET Cerrado módulos
	public void setCerradoModulos(Boolean cerradoModulos ){
		this.cerradoModulos = (cerradoModulos == null) ? false : cerradoModulos;
	}

	// GET Coemntario
	public String getComentario() {
		return this.comentario;
	}

	// SET Coemntario
	public void setComentario(String comentario ){
		comentario = (comentario != null) ? comentario.trim() : null;
		this.comentario = (comentario != null && comentario.length() == 0) ? null : comentario;
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, java.util.Date aperturaArg2, java.util.Date cierreArg3, Boolean cerradoArg4, Boolean cerradoModulosArg5, String comentarioArg6) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setApertura(aperturaArg2);
		this.setCierre(cierreArg3);
		this.setCerrado(cerradoArg4);
		this.setCerradoModulos(cerradoModulosArg5);
		this.setComentario(comentarioArg6);

	}

	// ---------------------------------------------------------------------------------------------------------------------------

	public String toString() {
		if(this.getNumero() != null && this.getApertura() != null){
			return this.getNumero() + " - " +  this.getApertura();
		} else if(this.getNumero() != null && this.getApertura() == null){
			return this.getNumero().toString();
		} else if(this.getNumero() == null && this.getApertura() != null){
			return this.getApertura().toString();
		} else {
			return super.toString();
		}
	}

} // END CLASS ----------------------------------------------------------------------------------------------------------