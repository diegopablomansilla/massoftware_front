package com.massoftware.model.contabilidad;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.model.EntityId;
import com.massoftware.model.contabilidad.EjercicioContable;

@ClassLabelAnont(singular = "Centro de costo", plural = "Centros de costo", singularPre = "el centro de costo", pluralPre = "los centros de costo")
public class CentroCostoContable extends EntityId {

	// ---------------------------------------------------------------------------------------------------------------------------


	@FieldConfAnont(label = "ID")
	private String id;

	// Nº cc
	@FieldConfAnont(label = "Nº cc", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numero;

	// Nombre
	@FieldConfAnont(label = "Nombre", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String nombre;

	// Abreviatura
	@FieldConfAnont(label = "Abreviatura", labelError = "", unique = true, readOnly = false, required = true, columns = 5.0f, maxLength = 5, minValue = "", maxValue = "", mask = "")
	private String abreviatura;

	// Ejercicio
	@FieldConfAnont(label = "Ejercicio", labelError = "", unique = false, readOnly = true, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private EjercicioContable ejercicioContable;

	// ---------------------------------------------------------------------------------------------------------------------------


	public CentroCostoContable() throws Exception {
	}

	public CentroCostoContable(String idArg0, Integer numeroArg1, String nombreArg2, String abreviaturaArg3, String idEjercicioContableArg4) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, abreviaturaArg3, idEjercicioContableArg4);

	}

	public CentroCostoContable(String idArg0, Integer numeroArg1, String nombreArg2, String abreviaturaArg3, String idArg4, Integer numeroArg5, java.util.Date aperturaArg6, java.util.Date cierreArg7, Boolean cerradoArg8, Boolean cerradoModulosArg9, String comentarioArg10) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, abreviaturaArg3, idArg4, numeroArg5, aperturaArg6, cierreArg7, cerradoArg8, cerradoModulosArg9, comentarioArg10);

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

	// GET Nº cc
	public Integer getNumero() {
		return this.numero;
	}

	// SET Nº cc
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


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String abreviaturaArg3, String idEjercicioContableArg4) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.setAbreviatura(abreviaturaArg3);
		this.buildEjercicioContable().setId(idEjercicioContableArg4);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String abreviaturaArg3, String idArg4, Integer numeroArg5, java.util.Date aperturaArg6, java.util.Date cierreArg7, Boolean cerradoArg8, Boolean cerradoModulosArg9, String comentarioArg10) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.setAbreviatura(abreviaturaArg3);
		this.buildEjercicioContable().setId(idArg4);
		this.buildEjercicioContable().setNumero(numeroArg5);
		this.buildEjercicioContable().setApertura(aperturaArg6);
		this.buildEjercicioContable().setCierre(cierreArg7);
		this.buildEjercicioContable().setCerrado(cerradoArg8);
		this.buildEjercicioContable().setCerradoModulos(cerradoModulosArg9);
		this.buildEjercicioContable().setComentario(comentarioArg10);

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