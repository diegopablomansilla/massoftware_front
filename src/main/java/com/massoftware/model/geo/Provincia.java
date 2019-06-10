package com.massoftware.model.geo;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.model.EntityId;
import com.massoftware.model.geo.Pais;

@ClassLabelAnont(singular = "Provincia", plural = "Provincias", singularPre = "la provincia", pluralPre = "las provincias")
public class Provincia extends EntityId {

	// ---------------------------------------------------------------------------------------------------------------------------


	@FieldConfAnont(label = "ID")
	private String id;

	// Nº provincia
	@FieldConfAnont(label = "Nº provincia", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numero;

	// Nombre
	@FieldConfAnont(label = "Nombre", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String nombre;

	// Abreviatura
	@FieldConfAnont(label = "Abreviatura", labelError = "", unique = true, readOnly = false, required = true, columns = 5.0f, maxLength = 5, minValue = "", maxValue = "", mask = "")
	private String abreviatura;

	// Nº provincia AFIP
	@FieldConfAnont(label = "Nº provincia AFIP", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numeroAFIP;

	// Nº provincia ingresos brutos
	@FieldConfAnont(label = "Nº provincia ingresos brutos", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numeroIngresosBrutos;

	// Nº provincia RENATEA
	@FieldConfAnont(label = "Nº provincia RENATEA", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numeroRENATEA;

	// País
	@FieldConfAnont(label = "País", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Pais pais;

	// ---------------------------------------------------------------------------------------------------------------------------


	public Provincia() throws Exception {
	}

	public Provincia(String idArg0, Integer numeroArg1, String nombreArg2, String abreviaturaArg3, Integer numeroAFIPArg4, Integer numeroIngresosBrutosArg5, Integer numeroRENATEAArg6, String idPaisArg7) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, abreviaturaArg3, numeroAFIPArg4, numeroIngresosBrutosArg5, numeroRENATEAArg6, idPaisArg7);

	}

	public Provincia(String idArg0, Integer numeroArg1, String nombreArg2, String abreviaturaArg3, Integer numeroAFIPArg4, Integer numeroIngresosBrutosArg5, Integer numeroRENATEAArg6, String idArg7, Integer numeroArg8, String nombreArg9, String abreviaturaArg10) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, abreviaturaArg3, numeroAFIPArg4, numeroIngresosBrutosArg5, numeroRENATEAArg6, idArg7, numeroArg8, nombreArg9, abreviaturaArg10);

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

	// GET Nº provincia
	public Integer getNumero() {
		return this.numero;
	}

	// SET Nº provincia
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

	// GET Nº provincia AFIP
	public Integer getNumeroAFIP() {
		return this.numeroAFIP;
	}

	// SET Nº provincia AFIP
	public void setNumeroAFIP(Integer numeroAFIP ){
		this.numeroAFIP = numeroAFIP;
	}

	// GET Nº provincia ingresos brutos
	public Integer getNumeroIngresosBrutos() {
		return this.numeroIngresosBrutos;
	}

	// SET Nº provincia ingresos brutos
	public void setNumeroIngresosBrutos(Integer numeroIngresosBrutos ){
		this.numeroIngresosBrutos = numeroIngresosBrutos;
	}

	// GET Nº provincia RENATEA
	public Integer getNumeroRENATEA() {
		return this.numeroRENATEA;
	}

	// SET Nº provincia RENATEA
	public void setNumeroRENATEA(Integer numeroRENATEA ){
		this.numeroRENATEA = numeroRENATEA;
	}

	// BUILD IF NULL AND GET País
	public Pais buildPais() throws Exception {
		this.pais = (this.pais == null) ? new Pais() : this.pais;
		return this.pais;
	}

	// GET País
	public Pais getPais() {
		this.pais = (this.pais != null && this.pais.getId() == null) ? null : this.pais ;
		return this.pais;
	}

	// SET País
	public void setPais(Pais pais ){
		this.pais = pais;
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String abreviaturaArg3, Integer numeroAFIPArg4, Integer numeroIngresosBrutosArg5, Integer numeroRENATEAArg6, String idPaisArg7) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.setAbreviatura(abreviaturaArg3);
		this.setNumeroAFIP(numeroAFIPArg4);
		this.setNumeroIngresosBrutos(numeroIngresosBrutosArg5);
		this.setNumeroRENATEA(numeroRENATEAArg6);
		this.buildPais().setId(idPaisArg7);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String abreviaturaArg3, Integer numeroAFIPArg4, Integer numeroIngresosBrutosArg5, Integer numeroRENATEAArg6, String idArg7, Integer numeroArg8, String nombreArg9, String abreviaturaArg10) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.setAbreviatura(abreviaturaArg3);
		this.setNumeroAFIP(numeroAFIPArg4);
		this.setNumeroIngresosBrutos(numeroIngresosBrutosArg5);
		this.setNumeroRENATEA(numeroRENATEAArg6);
		this.buildPais().setId(idArg7);
		this.buildPais().setNumero(numeroArg8);
		this.buildPais().setNombre(nombreArg9);
		this.buildPais().setAbreviatura(abreviaturaArg10);

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