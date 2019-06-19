package com.massoftware.model.fondos.banco;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.model.EntityId;

@ClassLabelAnont(singular = "Firmante", plural = "Firmantes", singularPre = "el firmante", pluralPre = "los Firmantes")
public class BancoFirmante extends EntityId {

	// ---------------------------------------------------------------------------------------------------------------------------


	@FieldConfAnont(label = "ID")
	private String id;

	// Nº firmante
	@FieldConfAnont(label = "Nº firmante", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numero;

	// Nombre
	@FieldConfAnont(label = "Nombre", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String nombre;

	// Cargo
	@FieldConfAnont(label = "Cargo", labelError = "", unique = true, readOnly = false, required = false, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String cargo;

	// Obsoleto
	@FieldConfAnont(label = "Obsoleto", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Boolean bloqueado = false;

	// ---------------------------------------------------------------------------------------------------------------------------


	public BancoFirmante() throws Exception {
	}

	public BancoFirmante(String idArg0, Integer numeroArg1, String nombreArg2, String cargoArg3, Boolean bloqueadoArg4) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, cargoArg3, bloqueadoArg4);

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

	// GET Nº firmante
	public Integer getNumero() {
		return this.numero;
	}

	// SET Nº firmante
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

	// GET Cargo
	public String getCargo() {
		return this.cargo;
	}

	// SET Cargo
	public void setCargo(String cargo ){
		cargo = (cargo != null) ? cargo.trim() : null;
		this.cargo = (cargo != null && cargo.length() == 0) ? null : cargo;
	}

	// GET Obsoleto
	public Boolean getBloqueado() {
		return this.bloqueado;
	}

	// SET Obsoleto
	public void setBloqueado(Boolean bloqueado ){
		this.bloqueado = (bloqueado == null) ? false : bloqueado;
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String cargoArg3, Boolean bloqueadoArg4) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.setCargo(cargoArg3);
		this.setBloqueado(bloqueadoArg4);

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