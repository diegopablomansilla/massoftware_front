package com.massoftware.model.clientes;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.model.EntityId;
import com.massoftware.model.clientes.ClasificacionCliente;

@ClassLabelAnont(singular = "Motivo bloqueo a cliente", plural = "Motivos bloqueo a clientes", singularPre = "el motivo bloqueo a cliente", pluralPre = "los motivos bloqueo a clientes")
public class MotivoBloqueoCliente extends EntityId {

	// ---------------------------------------------------------------------------------------------------------------------------


	@FieldConfAnont(label = "ID")
	private String id;

	// Nº motivo
	@FieldConfAnont(label = "Nº motivo", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numero;

	// Nombre
	@FieldConfAnont(label = "Nombre", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String nombre;

	// Clasificación de cliente
	@FieldConfAnont(label = "Clasificación de cliente", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private ClasificacionCliente clasificacionCliente;

	// ---------------------------------------------------------------------------------------------------------------------------


	public MotivoBloqueoCliente() throws Exception {
	}

	public MotivoBloqueoCliente(String idArg0, Integer numeroArg1, String nombreArg2, String idClasificacionClienteArg3) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, idClasificacionClienteArg3);

	}

	public MotivoBloqueoCliente(String idArg0, Integer numeroArg1, String nombreArg2, String idArg3, Integer numeroArg4, String nombreArg5, Integer colorArg6) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, idArg3, numeroArg4, nombreArg5, colorArg6);

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

	// GET Nº motivo
	public Integer getNumero() {
		return this.numero;
	}

	// SET Nº motivo
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

	// BUILD IF NULL AND GET Clasificación de cliente
	public ClasificacionCliente buildClasificacionCliente() throws Exception {
		this.clasificacionCliente = (this.clasificacionCliente == null) ? new ClasificacionCliente() : this.clasificacionCliente;
		return this.clasificacionCliente;
	}

	// GET Clasificación de cliente
	public ClasificacionCliente getClasificacionCliente() {
		this.clasificacionCliente = (this.clasificacionCliente != null && this.clasificacionCliente.getId() == null) ? null : this.clasificacionCliente ;
		return this.clasificacionCliente;
	}

	// SET Clasificación de cliente
	public void setClasificacionCliente(ClasificacionCliente clasificacionCliente ){
		this.clasificacionCliente = clasificacionCliente;
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String idClasificacionClienteArg3) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.buildClasificacionCliente().setId(idClasificacionClienteArg3);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String idArg3, Integer numeroArg4, String nombreArg5, Integer colorArg6) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.buildClasificacionCliente().setId(idArg3);
		this.buildClasificacionCliente().setNumero(numeroArg4);
		this.buildClasificacionCliente().setNombre(nombreArg5);
		this.buildClasificacionCliente().setColor(colorArg6);

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