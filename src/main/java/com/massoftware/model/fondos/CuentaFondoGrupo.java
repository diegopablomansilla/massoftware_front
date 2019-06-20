package com.massoftware.model.fondos;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.model.EntityId;
import com.massoftware.model.fondos.CuentaFondoRubro;

@ClassLabelAnont(singular = "Grupo de cuenta fondo", plural = "Grupos de cuenta fondo", singularPre = "el grupo de cuenta fondo", pluralPre = "los grupos de cuenta fondo")
public class CuentaFondoGrupo extends EntityId {

	// ---------------------------------------------------------------------------------------------------------------------------


	@FieldConfAnont(label = "ID")
	private String id;

	// Nº grupo
	@FieldConfAnont(label = "Nº grupo", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numero;

	// Nombre
	@FieldConfAnont(label = "Nombre", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String nombre;

	// Rubro
	@FieldConfAnont(label = "Rubro", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private CuentaFondoRubro cuentaFondoRubro;

	// ---------------------------------------------------------------------------------------------------------------------------


	public CuentaFondoGrupo() throws Exception {
	}

	public CuentaFondoGrupo(String idArg0, Integer numeroArg1, String nombreArg2, String idCuentaFondoRubroArg3) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, idCuentaFondoRubroArg3);

	}

	public CuentaFondoGrupo(String idArg0, Integer numeroArg1, String nombreArg2, String idArg3, Integer numeroArg4, String nombreArg5) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, idArg3, numeroArg4, nombreArg5);

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

	// GET Nº grupo
	public Integer getNumero() {
		return this.numero;
	}

	// SET Nº grupo
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

	// BUILD IF NULL AND GET Rubro
	public CuentaFondoRubro buildCuentaFondoRubro() throws Exception {
		this.cuentaFondoRubro = (this.cuentaFondoRubro == null) ? new CuentaFondoRubro() : this.cuentaFondoRubro;
		return this.cuentaFondoRubro;
	}

	// GET Rubro
	public CuentaFondoRubro getCuentaFondoRubro() {
		this.cuentaFondoRubro = (this.cuentaFondoRubro != null && this.cuentaFondoRubro.getId() == null) ? null : this.cuentaFondoRubro ;
		return this.cuentaFondoRubro;
	}

	// SET Rubro
	public void setCuentaFondoRubro(CuentaFondoRubro cuentaFondoRubro ){
		this.cuentaFondoRubro = cuentaFondoRubro;
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String idCuentaFondoRubroArg3) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.buildCuentaFondoRubro().setId(idCuentaFondoRubroArg3);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String idArg3, Integer numeroArg4, String nombreArg5) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.buildCuentaFondoRubro().setId(idArg3);
		this.buildCuentaFondoRubro().setNumero(numeroArg4);
		this.buildCuentaFondoRubro().setNombre(nombreArg5);

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