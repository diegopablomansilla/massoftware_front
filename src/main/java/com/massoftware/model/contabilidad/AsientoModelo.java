package com.massoftware.model.contabilidad;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.model.EntityId;
import com.massoftware.model.contabilidad.EjercicioContable;

@ClassLabelAnont(singular = "Asiento modelo", plural = "Asientos modelo", singularPre = "el asiento modelo", pluralPre = "los asientos modelo")
public class AsientoModelo extends EntityId {

	// ---------------------------------------------------------------------------------------------------------------------------


	@FieldConfAnont(label = "ID")
	private String id;

	// Nº asiento
	@FieldConfAnont(label = "Nº asiento", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numero;

	// Nombre
	@FieldConfAnont(label = "Nombre", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String nombre;

	// Ejercicio
	@FieldConfAnont(label = "Ejercicio", labelError = "", unique = false, readOnly = true, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private EjercicioContable ejercicioContable;

	// ---------------------------------------------------------------------------------------------------------------------------


	public AsientoModelo() throws Exception {
	}

	public AsientoModelo(String idArg0, Integer numeroArg1, String nombreArg2, String idEjercicioContableArg3) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, idEjercicioContableArg3);

	}

	public AsientoModelo(String idArg0, Integer numeroArg1, String nombreArg2, String idArg3, Integer numeroArg4, java.util.Date aperturaArg5, java.util.Date cierreArg6, Boolean cerradoArg7, Boolean cerradoModulosArg8, String comentarioArg9) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, idArg3, numeroArg4, aperturaArg5, cierreArg6, cerradoArg7, cerradoModulosArg8, comentarioArg9);

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

	// GET Nº asiento
	public Integer getNumero() {
		return this.numero;
	}

	// SET Nº asiento
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

	// BUILD IF NULL AND GET Ejercicio
	public EjercicioContable buildEjercicioContable() throws Exception {
		this.ejercicioContable = (this.ejercicioContable == null) ? new EjercicioContable() : this.ejercicioContable;
		return this.ejercicioContable;
	}

	// GET Ejercicio
	public EjercicioContable getEjercicioContable() {
		this.ejercicioContable = (this.ejercicioContable != null && this.ejercicioContable.getId() == null) ? null : this.ejercicioContable ;
		return this.ejercicioContable;
	}

	// SET Ejercicio
	public void setEjercicioContable(EjercicioContable ejercicioContable ){
		this.ejercicioContable = ejercicioContable;
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String idEjercicioContableArg3) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.buildEjercicioContable().setId(idEjercicioContableArg3);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String idArg3, Integer numeroArg4, java.util.Date aperturaArg5, java.util.Date cierreArg6, Boolean cerradoArg7, Boolean cerradoModulosArg8, String comentarioArg9) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.buildEjercicioContable().setId(idArg3);
		this.buildEjercicioContable().setNumero(numeroArg4);
		this.buildEjercicioContable().setApertura(aperturaArg5);
		this.buildEjercicioContable().setCierre(cierreArg6);
		this.buildEjercicioContable().setCerrado(cerradoArg7);
		this.buildEjercicioContable().setCerradoModulos(cerradoModulosArg8);
		this.buildEjercicioContable().setComentario(comentarioArg9);

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