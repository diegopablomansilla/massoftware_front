package com.massoftware.model.geo;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.model.EntityId;
import com.massoftware.model.geo.Provincia;

@ClassLabelAnont(singular = "Ciudad", plural = "Ciudades", singularPre = "la ciudad", pluralPre = "las ciudades")
public class Ciudad extends EntityId {

	// ---------------------------------------------------------------------------------------------------------------------------


	@FieldConfAnont(label = "ID")
	private String id;

	// Nº ciudad
	@FieldConfAnont(label = "Nº ciudad", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numero;

	// Nombre
	@FieldConfAnont(label = "Nombre", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String nombre;

	// Departamento
	@FieldConfAnont(label = "Departamento", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String departamento;

	// Nº provincia AFIP
	@FieldConfAnont(label = "Nº provincia AFIP", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numeroAFIP;

	// Provincia
	@FieldConfAnont(label = "Provincia", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Provincia provincia;

	// ---------------------------------------------------------------------------------------------------------------------------


	public Ciudad() throws Exception {
	}

	public Ciudad(String idArg0, Integer numeroArg1, String nombreArg2, String departamentoArg3, Integer numeroAFIPArg4, String idProvinciaArg5) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, departamentoArg3, numeroAFIPArg4, idProvinciaArg5);

	}

	public Ciudad(String idArg0, Integer numeroArg1, String nombreArg2, String departamentoArg3, Integer numeroAFIPArg4, String idArg5, Integer numeroArg6, String nombreArg7, String abreviaturaArg8, Integer numeroAFIPArg9, Integer numeroIngresosBrutosArg10, Integer numeroRENATEAArg11, String idPaisArg12) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, departamentoArg3, numeroAFIPArg4, idArg5, numeroArg6, nombreArg7, abreviaturaArg8, numeroAFIPArg9, numeroIngresosBrutosArg10, numeroRENATEAArg11, idPaisArg12);

	}

	public Ciudad(String idArg0, Integer numeroArg1, String nombreArg2, String departamentoArg3, Integer numeroAFIPArg4, String idArg5, Integer numeroArg6, String nombreArg7, String abreviaturaArg8, Integer numeroAFIPArg9, Integer numeroIngresosBrutosArg10, Integer numeroRENATEAArg11, String idArg12, Integer numeroArg13, String nombreArg14, String abreviaturaArg15) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, departamentoArg3, numeroAFIPArg4, idArg5, numeroArg6, nombreArg7, abreviaturaArg8, numeroAFIPArg9, numeroIngresosBrutosArg10, numeroRENATEAArg11, idArg12, numeroArg13, nombreArg14, abreviaturaArg15);

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

	// GET Nº ciudad
	public Integer getNumero() {
		return this.numero;
	}

	// SET Nº ciudad
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

	// GET Departamento
	public String getDepartamento() {
		return this.departamento;
	}

	// SET Departamento
	public void setDepartamento(String departamento ){
		departamento = (departamento != null) ? departamento.trim() : null;
		this.departamento = (departamento != null && departamento.length() == 0) ? null : departamento;
	}

	// GET Nº provincia AFIP
	public Integer getNumeroAFIP() {
		return this.numeroAFIP;
	}

	// SET Nº provincia AFIP
	public void setNumeroAFIP(Integer numeroAFIP ){
		this.numeroAFIP = numeroAFIP;
	}

	// BUILD IF NULL AND GET Provincia
	public Provincia buildProvincia() throws Exception {
		this.provincia = (this.provincia == null) ? new Provincia() : this.provincia;
		return this.provincia;
	}

	// GET Provincia
	public Provincia getProvincia() {
		this.provincia = (this.provincia != null && this.provincia.getId() == null) ? null : this.provincia ;
		return this.provincia;
	}

	// SET Provincia
	public void setProvincia(Provincia provincia ){
		this.provincia = provincia;
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String departamentoArg3, Integer numeroAFIPArg4, String idProvinciaArg5) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.setDepartamento(departamentoArg3);
		this.setNumeroAFIP(numeroAFIPArg4);
		this.buildProvincia().setId(idProvinciaArg5);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String departamentoArg3, Integer numeroAFIPArg4, String idArg5, Integer numeroArg6, String nombreArg7, String abreviaturaArg8, Integer numeroAFIPArg9, Integer numeroIngresosBrutosArg10, Integer numeroRENATEAArg11, String idPaisArg12) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.setDepartamento(departamentoArg3);
		this.setNumeroAFIP(numeroAFIPArg4);
		this.buildProvincia().setId(idArg5);
		this.buildProvincia().setNumero(numeroArg6);
		this.buildProvincia().setNombre(nombreArg7);
		this.buildProvincia().setAbreviatura(abreviaturaArg8);
		this.buildProvincia().setNumeroAFIP(numeroAFIPArg9);
		this.buildProvincia().setNumeroIngresosBrutos(numeroIngresosBrutosArg10);
		this.buildProvincia().setNumeroRENATEA(numeroRENATEAArg11);
		this.buildProvincia().buildPais().setId(idPaisArg12);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String departamentoArg3, Integer numeroAFIPArg4, String idArg5, Integer numeroArg6, String nombreArg7, String abreviaturaArg8, Integer numeroAFIPArg9, Integer numeroIngresosBrutosArg10, Integer numeroRENATEAArg11, String idArg12, Integer numeroArg13, String nombreArg14, String abreviaturaArg15) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.setDepartamento(departamentoArg3);
		this.setNumeroAFIP(numeroAFIPArg4);
		this.buildProvincia().setId(idArg5);
		this.buildProvincia().setNumero(numeroArg6);
		this.buildProvincia().setNombre(nombreArg7);
		this.buildProvincia().setAbreviatura(abreviaturaArg8);
		this.buildProvincia().setNumeroAFIP(numeroAFIPArg9);
		this.buildProvincia().setNumeroIngresosBrutos(numeroIngresosBrutosArg10);
		this.buildProvincia().setNumeroRENATEA(numeroRENATEAArg11);
		this.buildProvincia().buildPais().setId(idArg12);
		this.buildProvincia().buildPais().setNumero(numeroArg13);
		this.buildProvincia().buildPais().setNombre(nombreArg14);
		this.buildProvincia().buildPais().setAbreviatura(abreviaturaArg15);

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