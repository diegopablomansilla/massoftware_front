package com.massoftware.model.fondos;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.model.EntityId;

@ClassLabelAnont(singular = "Banco", plural = "Bancos", singularPre = "el banco", pluralPre = "los bancos")
public class Banco extends EntityId {

	// ---------------------------------------------------------------------------------------------------------------------------


	@FieldConfAnont(label = "ID")
	private String id;

	// Nº banco
	@FieldConfAnont(label = "Nº banco", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numero;

	// Nombre
	@FieldConfAnont(label = "Nombre", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String nombre;

	// CUIT
	@FieldConfAnont(label = "CUIT", labelError = "", unique = true, readOnly = false, required = true, columns = 11.0f, maxLength = 11, minValue = "1", maxValue = "99999999999", mask = "99-99999999-9")
	private Long cuit;

	// Obsoleto
	@FieldConfAnont(label = "Obsoleto", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Boolean bloqueado = false;

	// Hoja
	@FieldConfAnont(label = "Hoja", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 3, minValue = "1", maxValue = "100", mask = "")
	private Integer hoja;

	// Primera fila
	@FieldConfAnont(label = "Primera fila", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 4, minValue = "1", maxValue = "1000", mask = "")
	private Integer primeraFila;

	// Última fila
	@FieldConfAnont(label = "Última fila", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 4, minValue = "1", maxValue = "1000", mask = "")
	private Integer ultimaFila;

	// Fecha
	@FieldConfAnont(label = "Fecha", labelError = "", unique = false, readOnly = false, required = false, columns = 6.0f, maxLength = 3, minValue = "", maxValue = "", mask = "")
	private String fecha;

	// Descripción
	@FieldConfAnont(label = "Descripción", labelError = "", unique = false, readOnly = false, required = false, columns = 6.0f, maxLength = 3, minValue = "", maxValue = "", mask = "")
	private String descripcion;

	// Referencia 1
	@FieldConfAnont(label = "Referencia 1", labelError = "", unique = false, readOnly = false, required = false, columns = 6.0f, maxLength = 3, minValue = "", maxValue = "", mask = "")
	private String referencia1;

	// Importe
	@FieldConfAnont(label = "Importe", labelError = "", unique = false, readOnly = false, required = false, columns = 6.0f, maxLength = 3, minValue = "", maxValue = "", mask = "")
	private String importe;

	// Referencia 2
	@FieldConfAnont(label = "Referencia 2", labelError = "", unique = false, readOnly = false, required = false, columns = 6.0f, maxLength = 3, minValue = "", maxValue = "", mask = "")
	private String referencia2;

	// Saldo
	@FieldConfAnont(label = "Saldo", labelError = "", unique = false, readOnly = false, required = false, columns = 6.0f, maxLength = 3, minValue = "", maxValue = "", mask = "")
	private String saldo;

	// ---------------------------------------------------------------------------------------------------------------------------


	public Banco() throws Exception {
	}

	public Banco(String idArg0, Integer numeroArg1, String nombreArg2, Long cuitArg3, Boolean bloqueadoArg4, Integer hojaArg5, Integer primeraFilaArg6, Integer ultimaFilaArg7, String fechaArg8, String descripcionArg9, String referencia1Arg10, String importeArg11, String referencia2Arg12, String saldoArg13) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, cuitArg3, bloqueadoArg4, hojaArg5, primeraFilaArg6, ultimaFilaArg7, fechaArg8, descripcionArg9, referencia1Arg10, importeArg11, referencia2Arg12, saldoArg13);

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

	// GET Nº banco
	public Integer getNumero() {
		return this.numero;
	}

	// SET Nº banco
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

	// GET Obsoleto
	public Boolean getBloqueado() {
		return this.bloqueado;
	}

	// SET Obsoleto
	public void setBloqueado(Boolean bloqueado ){
		this.bloqueado = (bloqueado == null) ? false : bloqueado;
	}

	// GET Hoja
	public Integer getHoja() {
		return this.hoja;
	}

	// SET Hoja
	public void setHoja(Integer hoja ){
		this.hoja = hoja;
	}

	// GET Primera fila
	public Integer getPrimeraFila() {
		return this.primeraFila;
	}

	// SET Primera fila
	public void setPrimeraFila(Integer primeraFila ){
		this.primeraFila = primeraFila;
	}

	// GET Última fila
	public Integer getUltimaFila() {
		return this.ultimaFila;
	}

	// SET Última fila
	public void setUltimaFila(Integer ultimaFila ){
		this.ultimaFila = ultimaFila;
	}

	// GET Fecha
	public String getFecha() {
		return this.fecha;
	}

	// SET Fecha
	public void setFecha(String fecha ){
		fecha = (fecha != null) ? fecha.trim() : null;
		this.fecha = (fecha != null && fecha.length() == 0) ? null : fecha;
	}

	// GET Descripción
	public String getDescripcion() {
		return this.descripcion;
	}

	// SET Descripción
	public void setDescripcion(String descripcion ){
		descripcion = (descripcion != null) ? descripcion.trim() : null;
		this.descripcion = (descripcion != null && descripcion.length() == 0) ? null : descripcion;
	}

	// GET Referencia 1
	public String getReferencia1() {
		return this.referencia1;
	}

	// SET Referencia 1
	public void setReferencia1(String referencia1 ){
		referencia1 = (referencia1 != null) ? referencia1.trim() : null;
		this.referencia1 = (referencia1 != null && referencia1.length() == 0) ? null : referencia1;
	}

	// GET Importe
	public String getImporte() {
		return this.importe;
	}

	// SET Importe
	public void setImporte(String importe ){
		importe = (importe != null) ? importe.trim() : null;
		this.importe = (importe != null && importe.length() == 0) ? null : importe;
	}

	// GET Referencia 2
	public String getReferencia2() {
		return this.referencia2;
	}

	// SET Referencia 2
	public void setReferencia2(String referencia2 ){
		referencia2 = (referencia2 != null) ? referencia2.trim() : null;
		this.referencia2 = (referencia2 != null && referencia2.length() == 0) ? null : referencia2;
	}

	// GET Saldo
	public String getSaldo() {
		return this.saldo;
	}

	// SET Saldo
	public void setSaldo(String saldo ){
		saldo = (saldo != null) ? saldo.trim() : null;
		this.saldo = (saldo != null && saldo.length() == 0) ? null : saldo;
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, Long cuitArg3, Boolean bloqueadoArg4, Integer hojaArg5, Integer primeraFilaArg6, Integer ultimaFilaArg7, String fechaArg8, String descripcionArg9, String referencia1Arg10, String importeArg11, String referencia2Arg12, String saldoArg13) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.setCuit(cuitArg3);
		this.setBloqueado(bloqueadoArg4);
		this.setHoja(hojaArg5);
		this.setPrimeraFila(primeraFilaArg6);
		this.setUltimaFila(ultimaFilaArg7);
		this.setFecha(fechaArg8);
		this.setDescripcion(descripcionArg9);
		this.setReferencia1(referencia1Arg10);
		this.setImporte(importeArg11);
		this.setReferencia2(referencia2Arg12);
		this.setSaldo(saldoArg13);

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