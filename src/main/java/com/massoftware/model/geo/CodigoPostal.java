package com.massoftware.model.geo;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.model.EntityId;
import com.massoftware.model.geo.Ciudad;

@ClassLabelAnont(singular = "Código postal", plural = "Códigos postales", singularPre = "el código postal", pluralPre = "los códigos postales")
public class CodigoPostal extends EntityId {

	// ---------------------------------------------------------------------------------------------------------------------------


	@FieldConfAnont(label = "ID")
	private String id;

	// Código
	@FieldConfAnont(label = "Código", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 12, minValue = "", maxValue = "", mask = "")
	private String codigo;

	// Secuencia
	@FieldConfAnont(label = "Secuencia", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numero;

	// Calle
	@FieldConfAnont(label = "Calle", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = 200, minValue = "", maxValue = "", mask = "")
	private String nombreCalle;

	// Número calle
	@FieldConfAnont(label = "Número calle", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = 20, minValue = "", maxValue = "", mask = "")
	private String numeroCalle;

	// Ciudad
	@FieldConfAnont(label = "Ciudad", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Ciudad ciudad;

	// ---------------------------------------------------------------------------------------------------------------------------


	public CodigoPostal() throws Exception {
	}

	public CodigoPostal(String idArg0, String codigoArg1, Integer numeroArg2, String nombreCalleArg3, String numeroCalleArg4) throws Exception {

		setter(idArg0, codigoArg1, numeroArg2, nombreCalleArg3, numeroCalleArg4);

	}

	public CodigoPostal(String idArg0, String codigoArg1, Integer numeroArg2, String nombreCalleArg3, String numeroCalleArg4, String idArg5, Integer numeroArg6, String nombreArg7, String departamentoArg8, Integer numeroAFIPArg9) throws Exception {

		setter(idArg0, codigoArg1, numeroArg2, nombreCalleArg3, numeroCalleArg4, idArg5, numeroArg6, nombreArg7, departamentoArg8, numeroAFIPArg9);

	}

	public CodigoPostal(String idArg0, String codigoArg1, Integer numeroArg2, String nombreCalleArg3, String numeroCalleArg4, String idArg5, Integer numeroArg6, String nombreArg7, String departamentoArg8, Integer numeroAFIPArg9, String idArg10, Integer numeroArg11, String nombreArg12, String abreviaturaArg13, Integer numeroAFIPArg14, Integer numeroIngresosBrutosArg15, Integer numeroRENATEAArg16) throws Exception {

		setter(idArg0, codigoArg1, numeroArg2, nombreCalleArg3, numeroCalleArg4, idArg5, numeroArg6, nombreArg7, departamentoArg8, numeroAFIPArg9, idArg10, numeroArg11, nombreArg12, abreviaturaArg13, numeroAFIPArg14, numeroIngresosBrutosArg15, numeroRENATEAArg16);

	}

	public CodigoPostal(String idArg0, String codigoArg1, Integer numeroArg2, String nombreCalleArg3, String numeroCalleArg4, String idArg5, Integer numeroArg6, String nombreArg7, String departamentoArg8, Integer numeroAFIPArg9, String idArg10, Integer numeroArg11, String nombreArg12, String abreviaturaArg13, Integer numeroAFIPArg14, Integer numeroIngresosBrutosArg15, Integer numeroRENATEAArg16, String idArg17, Integer numeroArg18, String nombreArg19, String abreviaturaArg20) throws Exception {

		setter(idArg0, codigoArg1, numeroArg2, nombreCalleArg3, numeroCalleArg4, idArg5, numeroArg6, nombreArg7, departamentoArg8, numeroAFIPArg9, idArg10, numeroArg11, nombreArg12, abreviaturaArg13, numeroAFIPArg14, numeroIngresosBrutosArg15, numeroRENATEAArg16, idArg17, numeroArg18, nombreArg19, abreviaturaArg20);

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

	// GET Código
	public String getCodigo() {
		return this.codigo;
	}

	// SET Código
	public void setCodigo(String codigo ){
		codigo = (codigo != null) ? codigo.trim() : null;
		this.codigo = (codigo != null && codigo.length() == 0) ? null : codigo;
	}

	// GET Secuencia
	public Integer getNumero() {
		return this.numero;
	}

	// SET Secuencia
	public void setNumero(Integer numero ){
		this.numero = numero;
	}

	// GET Calle
	public String getNombreCalle() {
		return this.nombreCalle;
	}

	// SET Calle
	public void setNombreCalle(String nombreCalle ){
		nombreCalle = (nombreCalle != null) ? nombreCalle.trim() : null;
		this.nombreCalle = (nombreCalle != null && nombreCalle.length() == 0) ? null : nombreCalle;
	}

	// GET Número calle
	public String getNumeroCalle() {
		return this.numeroCalle;
	}

	// SET Número calle
	public void setNumeroCalle(String numeroCalle ){
		numeroCalle = (numeroCalle != null) ? numeroCalle.trim() : null;
		this.numeroCalle = (numeroCalle != null && numeroCalle.length() == 0) ? null : numeroCalle;
	}

	// BUILD IF NULL AND GET Ciudad
	public Ciudad buildCiudad() throws Exception {
		this.ciudad = (this.ciudad == null) ? new Ciudad() : this.ciudad;
		return this.ciudad;
	}

	// GET Ciudad
	public Ciudad getCiudad() {
		this.ciudad = (this.ciudad != null && this.ciudad.getId() == null) ? null : this.ciudad ;
		return this.ciudad;
	}

	// SET Ciudad
	public void setCiudad(Ciudad ciudad ){
		this.ciudad = ciudad;
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, String codigoArg1, Integer numeroArg2, String nombreCalleArg3, String numeroCalleArg4) throws Exception {

		this.setId(idArg0);
		this.setCodigo(codigoArg1);
		this.setNumero(numeroArg2);
		this.setNombreCalle(nombreCalleArg3);
		this.setNumeroCalle(numeroCalleArg4);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, String codigoArg1, Integer numeroArg2, String nombreCalleArg3, String numeroCalleArg4, String idArg5, Integer numeroArg6, String nombreArg7, String departamentoArg8, Integer numeroAFIPArg9) throws Exception {

		this.setId(idArg0);
		this.setCodigo(codigoArg1);
		this.setNumero(numeroArg2);
		this.setNombreCalle(nombreCalleArg3);
		this.setNumeroCalle(numeroCalleArg4);
		this.buildCiudad().setId(idArg5);
		this.buildCiudad().setNumero(numeroArg6);
		this.buildCiudad().setNombre(nombreArg7);
		this.buildCiudad().setDepartamento(departamentoArg8);
		this.buildCiudad().setNumeroAFIP(numeroAFIPArg9);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, String codigoArg1, Integer numeroArg2, String nombreCalleArg3, String numeroCalleArg4, String idArg5, Integer numeroArg6, String nombreArg7, String departamentoArg8, Integer numeroAFIPArg9, String idArg10, Integer numeroArg11, String nombreArg12, String abreviaturaArg13, Integer numeroAFIPArg14, Integer numeroIngresosBrutosArg15, Integer numeroRENATEAArg16) throws Exception {

		this.setId(idArg0);
		this.setCodigo(codigoArg1);
		this.setNumero(numeroArg2);
		this.setNombreCalle(nombreCalleArg3);
		this.setNumeroCalle(numeroCalleArg4);
		this.buildCiudad().setId(idArg5);
		this.buildCiudad().setNumero(numeroArg6);
		this.buildCiudad().setNombre(nombreArg7);
		this.buildCiudad().setDepartamento(departamentoArg8);
		this.buildCiudad().setNumeroAFIP(numeroAFIPArg9);
		this.buildCiudad().buildProvincia().setId(idArg10);
		this.buildCiudad().buildProvincia().setNumero(numeroArg11);
		this.buildCiudad().buildProvincia().setNombre(nombreArg12);
		this.buildCiudad().buildProvincia().setAbreviatura(abreviaturaArg13);
		this.buildCiudad().buildProvincia().setNumeroAFIP(numeroAFIPArg14);
		this.buildCiudad().buildProvincia().setNumeroIngresosBrutos(numeroIngresosBrutosArg15);
		this.buildCiudad().buildProvincia().setNumeroRENATEA(numeroRENATEAArg16);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, String codigoArg1, Integer numeroArg2, String nombreCalleArg3, String numeroCalleArg4, String idArg5, Integer numeroArg6, String nombreArg7, String departamentoArg8, Integer numeroAFIPArg9, String idArg10, Integer numeroArg11, String nombreArg12, String abreviaturaArg13, Integer numeroAFIPArg14, Integer numeroIngresosBrutosArg15, Integer numeroRENATEAArg16, String idArg17, Integer numeroArg18, String nombreArg19, String abreviaturaArg20) throws Exception {

		this.setId(idArg0);
		this.setCodigo(codigoArg1);
		this.setNumero(numeroArg2);
		this.setNombreCalle(nombreCalleArg3);
		this.setNumeroCalle(numeroCalleArg4);
		this.buildCiudad().setId(idArg5);
		this.buildCiudad().setNumero(numeroArg6);
		this.buildCiudad().setNombre(nombreArg7);
		this.buildCiudad().setDepartamento(departamentoArg8);
		this.buildCiudad().setNumeroAFIP(numeroAFIPArg9);
		this.buildCiudad().buildProvincia().setId(idArg10);
		this.buildCiudad().buildProvincia().setNumero(numeroArg11);
		this.buildCiudad().buildProvincia().setNombre(nombreArg12);
		this.buildCiudad().buildProvincia().setAbreviatura(abreviaturaArg13);
		this.buildCiudad().buildProvincia().setNumeroAFIP(numeroAFIPArg14);
		this.buildCiudad().buildProvincia().setNumeroIngresosBrutos(numeroIngresosBrutosArg15);
		this.buildCiudad().buildProvincia().setNumeroRENATEA(numeroRENATEAArg16);
		this.buildCiudad().buildProvincia().buildPais().setId(idArg17);
		this.buildCiudad().buildProvincia().buildPais().setNumero(numeroArg18);
		this.buildCiudad().buildProvincia().buildPais().setNombre(nombreArg19);
		this.buildCiudad().buildProvincia().buildPais().setAbreviatura(abreviaturaArg20);

	}

	// ---------------------------------------------------------------------------------------------------------------------------

	public String toString() {
		if(this.getCodigo() != null && this.getNumero() != null){
			return this.getCodigo() + " - " +  this.getNumero();
		} else if(this.getCodigo() != null && this.getNumero() == null){
			return this.getCodigo();
		} else if(this.getCodigo() == null && this.getNumero() != null){
			return this.getNumero().toString();
		} else {
			return super.toString();
		}
	}

} // END CLASS ----------------------------------------------------------------------------------------------------------