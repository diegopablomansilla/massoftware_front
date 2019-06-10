package com.massoftware.model.logistica;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.model.EntityId;
import com.massoftware.model.geo.CodigoPostal;

@ClassLabelAnont(singular = "Transporte", plural = "Transportes", singularPre = "el transporte", pluralPre = "los transportes")
public class Transporte extends EntityId {

	// ---------------------------------------------------------------------------------------------------------------------------


	@FieldConfAnont(label = "ID")
	private String id;

	// Nº transporte
	@FieldConfAnont(label = "Nº transporte", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numero;

	// Nombre
	@FieldConfAnont(label = "Nombre", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String nombre;

	// CUIT
	@FieldConfAnont(label = "CUIT", labelError = "", unique = true, readOnly = false, required = true, columns = 11.0f, maxLength = 11, minValue = "1", maxValue = "99999999999", mask = "99-99999999-9")
	private Long cuit;

	// Ingresos brutos
	@FieldConfAnont(label = "Ingresos brutos", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 13, minValue = "", maxValue = "", mask = "")
	private String ingresosBrutos;

	// Teléfono
	@FieldConfAnont(label = "Teléfono", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String telefono;

	// Fax
	@FieldConfAnont(label = "Fax", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String fax;

	// Código postal
	@FieldConfAnont(label = "Código postal", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private CodigoPostal codigoPostal;

	// Domicilio
	@FieldConfAnont(label = "Domicilio", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 150, minValue = "", maxValue = "", mask = "")
	private String domicilio;

	// Comentario
	@FieldConfAnont(label = "Comentario", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 300, minValue = "", maxValue = "", mask = "")
	private String comentario;

	// ---------------------------------------------------------------------------------------------------------------------------


	public Transporte() throws Exception {
	}

	public Transporte(String idArg0, Integer numeroArg1, String nombreArg2, Long cuitArg3, String ingresosBrutosArg4, String telefonoArg5, String faxArg6, String idCodigoPostalArg7, String domicilioArg8, String comentarioArg9) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, cuitArg3, ingresosBrutosArg4, telefonoArg5, faxArg6, idCodigoPostalArg7, domicilioArg8, comentarioArg9);

	}

	public Transporte(String idArg0, Integer numeroArg1, String nombreArg2, Long cuitArg3, String ingresosBrutosArg4, String telefonoArg5, String faxArg6, String idArg7, String codigoArg8, Integer numeroArg9, String nombreCalleArg10, String numeroCalleArg11, String idCiudadArg12, String domicilioArg13, String comentarioArg14) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, cuitArg3, ingresosBrutosArg4, telefonoArg5, faxArg6, idArg7, codigoArg8, numeroArg9, nombreCalleArg10, numeroCalleArg11, idCiudadArg12, domicilioArg13, comentarioArg14);

	}

	public Transporte(String idArg0, Integer numeroArg1, String nombreArg2, Long cuitArg3, String ingresosBrutosArg4, String telefonoArg5, String faxArg6, String idArg7, String codigoArg8, Integer numeroArg9, String nombreCalleArg10, String numeroCalleArg11, String idArg12, Integer numeroArg13, String nombreArg14, String departamentoArg15, Integer numeroAFIPArg16, String idProvinciaArg17, String domicilioArg18, String comentarioArg19) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, cuitArg3, ingresosBrutosArg4, telefonoArg5, faxArg6, idArg7, codigoArg8, numeroArg9, nombreCalleArg10, numeroCalleArg11, idArg12, numeroArg13, nombreArg14, departamentoArg15, numeroAFIPArg16, idProvinciaArg17, domicilioArg18, comentarioArg19);

	}

	public Transporte(String idArg0, Integer numeroArg1, String nombreArg2, Long cuitArg3, String ingresosBrutosArg4, String telefonoArg5, String faxArg6, String idArg7, String codigoArg8, Integer numeroArg9, String nombreCalleArg10, String numeroCalleArg11, String idArg12, Integer numeroArg13, String nombreArg14, String departamentoArg15, Integer numeroAFIPArg16, String idArg17, Integer numeroArg18, String nombreArg19, String abreviaturaArg20, Integer numeroAFIPArg21, Integer numeroIngresosBrutosArg22, Integer numeroRENATEAArg23, String idPaisArg24, String domicilioArg25, String comentarioArg26) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, cuitArg3, ingresosBrutosArg4, telefonoArg5, faxArg6, idArg7, codigoArg8, numeroArg9, nombreCalleArg10, numeroCalleArg11, idArg12, numeroArg13, nombreArg14, departamentoArg15, numeroAFIPArg16, idArg17, numeroArg18, nombreArg19, abreviaturaArg20, numeroAFIPArg21, numeroIngresosBrutosArg22, numeroRENATEAArg23, idPaisArg24, domicilioArg25, comentarioArg26);

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

	// GET Nº transporte
	public Integer getNumero() {
		return this.numero;
	}

	// SET Nº transporte
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

	// GET CUIT
	public Long getCuit() {
		return this.cuit;
	}

	// SET CUIT
	public void setCuit(Long cuit ){
		this.cuit = cuit;
	}

	// GET Ingresos brutos
	public String getIngresosBrutos() {
		return this.ingresosBrutos;
	}

	// SET Ingresos brutos
	public void setIngresosBrutos(String ingresosBrutos ){
		ingresosBrutos = (ingresosBrutos != null) ? ingresosBrutos.trim() : null;
		this.ingresosBrutos = (ingresosBrutos != null && ingresosBrutos.length() == 0) ? null : ingresosBrutos;
	}

	// GET Teléfono
	public String getTelefono() {
		return this.telefono;
	}

	// SET Teléfono
	public void setTelefono(String telefono ){
		telefono = (telefono != null) ? telefono.trim() : null;
		this.telefono = (telefono != null && telefono.length() == 0) ? null : telefono;
	}

	// GET Fax
	public String getFax() {
		return this.fax;
	}

	// SET Fax
	public void setFax(String fax ){
		fax = (fax != null) ? fax.trim() : null;
		this.fax = (fax != null && fax.length() == 0) ? null : fax;
	}

	// BUILD IF NULL AND GET Código postal
	public CodigoPostal buildCodigoPostal() throws Exception {
		this.codigoPostal = (this.codigoPostal == null) ? new CodigoPostal() : this.codigoPostal;
		return this.codigoPostal;
	}

	// GET Código postal
	public CodigoPostal getCodigoPostal() {
		this.codigoPostal = (this.codigoPostal != null && this.codigoPostal.getId() == null) ? null : this.codigoPostal ;
		return this.codigoPostal;
	}

	// SET Código postal
	public void setCodigoPostal(CodigoPostal codigoPostal ){
		this.codigoPostal = codigoPostal;
	}

	// GET Domicilio
	public String getDomicilio() {
		return this.domicilio;
	}

	// SET Domicilio
	public void setDomicilio(String domicilio ){
		domicilio = (domicilio != null) ? domicilio.trim() : null;
		this.domicilio = (domicilio != null && domicilio.length() == 0) ? null : domicilio;
	}

	// GET Comentario
	public String getComentario() {
		return this.comentario;
	}

	// SET Comentario
	public void setComentario(String comentario ){
		comentario = (comentario != null) ? comentario.trim() : null;
		this.comentario = (comentario != null && comentario.length() == 0) ? null : comentario;
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, Long cuitArg3, String ingresosBrutosArg4, String telefonoArg5, String faxArg6, String idCodigoPostalArg7, String domicilioArg8, String comentarioArg9) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.setCuit(cuitArg3);
		this.setIngresosBrutos(ingresosBrutosArg4);
		this.setTelefono(telefonoArg5);
		this.setFax(faxArg6);
		this.buildCodigoPostal().setId(idCodigoPostalArg7);
		this.setDomicilio(domicilioArg8);
		this.setComentario(comentarioArg9);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, Long cuitArg3, String ingresosBrutosArg4, String telefonoArg5, String faxArg6, String idArg7, String codigoArg8, Integer numeroArg9, String nombreCalleArg10, String numeroCalleArg11, String idCiudadArg12, String domicilioArg13, String comentarioArg14) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.setCuit(cuitArg3);
		this.setIngresosBrutos(ingresosBrutosArg4);
		this.setTelefono(telefonoArg5);
		this.setFax(faxArg6);
		this.buildCodigoPostal().setId(idArg7);
		this.buildCodigoPostal().setCodigo(codigoArg8);
		this.buildCodigoPostal().setNumero(numeroArg9);
		this.buildCodigoPostal().setNombreCalle(nombreCalleArg10);
		this.buildCodigoPostal().setNumeroCalle(numeroCalleArg11);
		this.buildCodigoPostal().buildCiudad().setId(idCiudadArg12);
		this.setDomicilio(domicilioArg13);
		this.setComentario(comentarioArg14);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, Long cuitArg3, String ingresosBrutosArg4, String telefonoArg5, String faxArg6, String idArg7, String codigoArg8, Integer numeroArg9, String nombreCalleArg10, String numeroCalleArg11, String idArg12, Integer numeroArg13, String nombreArg14, String departamentoArg15, Integer numeroAFIPArg16, String idProvinciaArg17, String domicilioArg18, String comentarioArg19) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.setCuit(cuitArg3);
		this.setIngresosBrutos(ingresosBrutosArg4);
		this.setTelefono(telefonoArg5);
		this.setFax(faxArg6);
		this.buildCodigoPostal().setId(idArg7);
		this.buildCodigoPostal().setCodigo(codigoArg8);
		this.buildCodigoPostal().setNumero(numeroArg9);
		this.buildCodigoPostal().setNombreCalle(nombreCalleArg10);
		this.buildCodigoPostal().setNumeroCalle(numeroCalleArg11);
		this.buildCodigoPostal().buildCiudad().setId(idArg12);
		this.buildCodigoPostal().buildCiudad().setNumero(numeroArg13);
		this.buildCodigoPostal().buildCiudad().setNombre(nombreArg14);
		this.buildCodigoPostal().buildCiudad().setDepartamento(departamentoArg15);
		this.buildCodigoPostal().buildCiudad().setNumeroAFIP(numeroAFIPArg16);
		this.buildCodigoPostal().buildCiudad().buildProvincia().setId(idProvinciaArg17);
		this.setDomicilio(domicilioArg18);
		this.setComentario(comentarioArg19);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, Long cuitArg3, String ingresosBrutosArg4, String telefonoArg5, String faxArg6, String idArg7, String codigoArg8, Integer numeroArg9, String nombreCalleArg10, String numeroCalleArg11, String idArg12, Integer numeroArg13, String nombreArg14, String departamentoArg15, Integer numeroAFIPArg16, String idArg17, Integer numeroArg18, String nombreArg19, String abreviaturaArg20, Integer numeroAFIPArg21, Integer numeroIngresosBrutosArg22, Integer numeroRENATEAArg23, String idPaisArg24, String domicilioArg25, String comentarioArg26) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.setCuit(cuitArg3);
		this.setIngresosBrutos(ingresosBrutosArg4);
		this.setTelefono(telefonoArg5);
		this.setFax(faxArg6);
		this.buildCodigoPostal().setId(idArg7);
		this.buildCodigoPostal().setCodigo(codigoArg8);
		this.buildCodigoPostal().setNumero(numeroArg9);
		this.buildCodigoPostal().setNombreCalle(nombreCalleArg10);
		this.buildCodigoPostal().setNumeroCalle(numeroCalleArg11);
		this.buildCodigoPostal().buildCiudad().setId(idArg12);
		this.buildCodigoPostal().buildCiudad().setNumero(numeroArg13);
		this.buildCodigoPostal().buildCiudad().setNombre(nombreArg14);
		this.buildCodigoPostal().buildCiudad().setDepartamento(departamentoArg15);
		this.buildCodigoPostal().buildCiudad().setNumeroAFIP(numeroAFIPArg16);
		this.buildCodigoPostal().buildCiudad().buildProvincia().setId(idArg17);
		this.buildCodigoPostal().buildCiudad().buildProvincia().setNumero(numeroArg18);
		this.buildCodigoPostal().buildCiudad().buildProvincia().setNombre(nombreArg19);
		this.buildCodigoPostal().buildCiudad().buildProvincia().setAbreviatura(abreviaturaArg20);
		this.buildCodigoPostal().buildCiudad().buildProvincia().setNumeroAFIP(numeroAFIPArg21);
		this.buildCodigoPostal().buildCiudad().buildProvincia().setNumeroIngresosBrutos(numeroIngresosBrutosArg22);
		this.buildCodigoPostal().buildCiudad().buildProvincia().setNumeroRENATEA(numeroRENATEAArg23);
		this.buildCodigoPostal().buildCiudad().buildProvincia().buildPais().setId(idPaisArg24);
		this.setDomicilio(domicilioArg25);
		this.setComentario(comentarioArg26);

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