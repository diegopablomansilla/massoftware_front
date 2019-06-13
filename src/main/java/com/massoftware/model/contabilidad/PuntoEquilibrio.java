package com.massoftware.model.contabilidad;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.model.EntityId;
import com.massoftware.model.contabilidad.TipoPuntoEquilibrio;
import com.massoftware.model.contabilidad.EjercicioContable;

@ClassLabelAnont(singular = "Punto equilibrio", plural = "Puntos equilibrio", singularPre = "el punto equilibrio", pluralPre = "los puntos equilibrio")
public class PuntoEquilibrio extends EntityId {

	// ---------------------------------------------------------------------------------------------------------------------------


	@FieldConfAnont(label = "ID")
	private String id;

	// Nº cc
	@FieldConfAnont(label = "Nº cc", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numero;

	// Nombre
	@FieldConfAnont(label = "Nombre", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String nombre;

	// Tipo
	@FieldConfAnont(label = "Tipo", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private TipoPuntoEquilibrio tipoPuntoEquilibrio;

	// Ejercicio
	@FieldConfAnont(label = "Ejercicio", labelError = "", unique = false, readOnly = true, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private EjercicioContable ejercicioContable;

	// ---------------------------------------------------------------------------------------------------------------------------


	public PuntoEquilibrio() throws Exception {
	}

	public PuntoEquilibrio(String idArg0, Integer numeroArg1, String nombreArg2, String idTipoPuntoEquilibrioArg3, String idEjercicioContableArg4) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, idTipoPuntoEquilibrioArg3, idEjercicioContableArg4);

	}

	public PuntoEquilibrio(String idArg0, Integer numeroArg1, String nombreArg2, String idArg3, Integer numeroArg4, String nombreArg5, String idArg6, Integer numeroArg7, java.util.Date aperturaArg8, java.util.Date cierreArg9, Boolean cerradoArg10, Boolean cerradoModulosArg11, String comentarioArg12) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, idArg3, numeroArg4, nombreArg5, idArg6, numeroArg7, aperturaArg8, cierreArg9, cerradoArg10, cerradoModulosArg11, comentarioArg12);

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

	// BUILD IF NULL AND GET Tipo
	public TipoPuntoEquilibrio buildTipoPuntoEquilibrio() throws Exception {
		this.tipoPuntoEquilibrio = (this.tipoPuntoEquilibrio == null) ? new TipoPuntoEquilibrio() : this.tipoPuntoEquilibrio;
		return this.tipoPuntoEquilibrio;
	}

	// GET Tipo
	public TipoPuntoEquilibrio getTipoPuntoEquilibrio() {
		this.tipoPuntoEquilibrio = (this.tipoPuntoEquilibrio != null && this.tipoPuntoEquilibrio.getId() == null) ? null : this.tipoPuntoEquilibrio ;
		return this.tipoPuntoEquilibrio;
	}

	// SET Tipo
	public void setTipoPuntoEquilibrio(TipoPuntoEquilibrio tipoPuntoEquilibrio ){
		this.tipoPuntoEquilibrio = tipoPuntoEquilibrio;
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


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String idTipoPuntoEquilibrioArg3, String idEjercicioContableArg4) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.buildTipoPuntoEquilibrio().setId(idTipoPuntoEquilibrioArg3);
		this.buildEjercicioContable().setId(idEjercicioContableArg4);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String idArg3, Integer numeroArg4, String nombreArg5, String idArg6, Integer numeroArg7, java.util.Date aperturaArg8, java.util.Date cierreArg9, Boolean cerradoArg10, Boolean cerradoModulosArg11, String comentarioArg12) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.buildTipoPuntoEquilibrio().setId(idArg3);
		this.buildTipoPuntoEquilibrio().setNumero(numeroArg4);
		this.buildTipoPuntoEquilibrio().setNombre(nombreArg5);
		this.buildEjercicioContable().setId(idArg6);
		this.buildEjercicioContable().setNumero(numeroArg7);
		this.buildEjercicioContable().setApertura(aperturaArg8);
		this.buildEjercicioContable().setCierre(cierreArg9);
		this.buildEjercicioContable().setCerrado(cerradoArg10);
		this.buildEjercicioContable().setCerradoModulos(cerradoModulosArg11);
		this.buildEjercicioContable().setComentario(comentarioArg12);

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