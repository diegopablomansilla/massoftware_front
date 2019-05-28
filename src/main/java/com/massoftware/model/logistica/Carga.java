package com.massoftware.model.logistica;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.model.EntityId;
import com.massoftware.model.logistica.Transporte;

@ClassLabelAnont(singular = "Carga", plural = "Cargas", singularPre = "la carga", pluralPre = "las cargas")
public class Carga extends EntityId {

	// ---------------------------------------------------------------------------------------------------------------------------


	@FieldConfAnont(label = "ID")
	private String id;

	// Nº carga
	@FieldConfAnont(label = "Nº carga", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numero;

	// Nombre
	@FieldConfAnont(label = "Nombre", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String nombre;

	// Transporte
	@FieldConfAnont(label = "Transporte", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Transporte transporte;

	// ---------------------------------------------------------------------------------------------------------------------------


	public Carga() throws Exception {
	}

	public Carga(String idArg0, Integer numeroArg1, String nombreArg2) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2);

	}

	public Carga(String idArg0, Integer numeroArg1, String nombreArg2, String idArg3, Integer numeroArg4, String nombreArg5, Long cuitArg6, String ingresosBrutosArg7, String telefonoArg8, String faxArg9, String domicilioArg10, String comentarioArg11) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, idArg3, numeroArg4, nombreArg5, cuitArg6, ingresosBrutosArg7, telefonoArg8, faxArg9, domicilioArg10, comentarioArg11);

	}

	public Carga(String idArg0, Integer numeroArg1, String nombreArg2, String idArg3, Integer numeroArg4, String nombreArg5, Long cuitArg6, String ingresosBrutosArg7, String telefonoArg8, String faxArg9, String idArg10, String codigoArg11, Integer numeroArg12, String nombreCalleArg13, String numeroCalleArg14, String domicilioArg15, String comentarioArg16) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, idArg3, numeroArg4, nombreArg5, cuitArg6, ingresosBrutosArg7, telefonoArg8, faxArg9, idArg10, codigoArg11, numeroArg12, nombreCalleArg13, numeroCalleArg14, domicilioArg15, comentarioArg16);

	}

	public Carga(String idArg0, Integer numeroArg1, String nombreArg2, String idArg3, Integer numeroArg4, String nombreArg5, Long cuitArg6, String ingresosBrutosArg7, String telefonoArg8, String faxArg9, String idArg10, String codigoArg11, Integer numeroArg12, String nombreCalleArg13, String numeroCalleArg14, String idArg15, Integer numeroArg16, String nombreArg17, String departamentoArg18, Integer numeroAFIPArg19, String domicilioArg20, String comentarioArg21) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, idArg3, numeroArg4, nombreArg5, cuitArg6, ingresosBrutosArg7, telefonoArg8, faxArg9, idArg10, codigoArg11, numeroArg12, nombreCalleArg13, numeroCalleArg14, idArg15, numeroArg16, nombreArg17, departamentoArg18, numeroAFIPArg19, domicilioArg20, comentarioArg21);

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

	// GET Nº carga
	public Integer getNumero() {
		return this.numero;
	}

	// SET Nº carga
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

	// BUILD IF NULL AND GET Transporte
	public Transporte buildTransporte() throws Exception {
		this.transporte = (this.transporte == null) ? new Transporte() : this.transporte;
		return this.transporte;
	}

	// GET Transporte
	public Transporte getTransporte() {
		this.transporte = (this.transporte != null && this.transporte.getId() == null) ? null : this.transporte ;
		return this.transporte;
	}

	// SET Transporte
	public void setTransporte(Transporte transporte ){
		this.transporte = transporte;
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String idArg3, Integer numeroArg4, String nombreArg5, Long cuitArg6, String ingresosBrutosArg7, String telefonoArg8, String faxArg9, String domicilioArg10, String comentarioArg11) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.buildTransporte().setId(idArg3);
		this.buildTransporte().setNumero(numeroArg4);
		this.buildTransporte().setNombre(nombreArg5);
		this.buildTransporte().setCuit(cuitArg6);
		this.buildTransporte().setIngresosBrutos(ingresosBrutosArg7);
		this.buildTransporte().setTelefono(telefonoArg8);
		this.buildTransporte().setFax(faxArg9);
		this.buildTransporte().setDomicilio(domicilioArg10);
		this.buildTransporte().setComentario(comentarioArg11);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String idArg3, Integer numeroArg4, String nombreArg5, Long cuitArg6, String ingresosBrutosArg7, String telefonoArg8, String faxArg9, String idArg10, String codigoArg11, Integer numeroArg12, String nombreCalleArg13, String numeroCalleArg14, String domicilioArg15, String comentarioArg16) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.buildTransporte().setId(idArg3);
		this.buildTransporte().setNumero(numeroArg4);
		this.buildTransporte().setNombre(nombreArg5);
		this.buildTransporte().setCuit(cuitArg6);
		this.buildTransporte().setIngresosBrutos(ingresosBrutosArg7);
		this.buildTransporte().setTelefono(telefonoArg8);
		this.buildTransporte().setFax(faxArg9);
		this.buildTransporte().buildCodigoPostal().setId(idArg10);
		this.buildTransporte().buildCodigoPostal().setCodigo(codigoArg11);
		this.buildTransporte().buildCodigoPostal().setNumero(numeroArg12);
		this.buildTransporte().buildCodigoPostal().setNombreCalle(nombreCalleArg13);
		this.buildTransporte().buildCodigoPostal().setNumeroCalle(numeroCalleArg14);
		this.buildTransporte().setDomicilio(domicilioArg15);
		this.buildTransporte().setComentario(comentarioArg16);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String idArg3, Integer numeroArg4, String nombreArg5, Long cuitArg6, String ingresosBrutosArg7, String telefonoArg8, String faxArg9, String idArg10, String codigoArg11, Integer numeroArg12, String nombreCalleArg13, String numeroCalleArg14, String idArg15, Integer numeroArg16, String nombreArg17, String departamentoArg18, Integer numeroAFIPArg19, String domicilioArg20, String comentarioArg21) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.buildTransporte().setId(idArg3);
		this.buildTransporte().setNumero(numeroArg4);
		this.buildTransporte().setNombre(nombreArg5);
		this.buildTransporte().setCuit(cuitArg6);
		this.buildTransporte().setIngresosBrutos(ingresosBrutosArg7);
		this.buildTransporte().setTelefono(telefonoArg8);
		this.buildTransporte().setFax(faxArg9);
		this.buildTransporte().buildCodigoPostal().setId(idArg10);
		this.buildTransporte().buildCodigoPostal().setCodigo(codigoArg11);
		this.buildTransporte().buildCodigoPostal().setNumero(numeroArg12);
		this.buildTransporte().buildCodigoPostal().setNombreCalle(nombreCalleArg13);
		this.buildTransporte().buildCodigoPostal().setNumeroCalle(numeroCalleArg14);
		this.buildTransporte().buildCodigoPostal().buildCiudad().setId(idArg15);
		this.buildTransporte().buildCodigoPostal().buildCiudad().setNumero(numeroArg16);
		this.buildTransporte().buildCodigoPostal().buildCiudad().setNombre(nombreArg17);
		this.buildTransporte().buildCodigoPostal().buildCiudad().setDepartamento(departamentoArg18);
		this.buildTransporte().buildCodigoPostal().buildCiudad().setNumeroAFIP(numeroAFIPArg19);
		this.buildTransporte().setDomicilio(domicilioArg20);
		this.buildTransporte().setComentario(comentarioArg21);

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