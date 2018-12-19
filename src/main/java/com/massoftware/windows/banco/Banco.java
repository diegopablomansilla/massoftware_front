package com.massoftware.windows.banco;

import com.massoftware.windows.UtilModel;

public class Banco {

	private Integer numero;
	private String nombre;
	private String nombreOficial;
	private String cuit;
	private Boolean bloqueado;
	private Integer hoja;
	private Integer primeraFila;
	private Integer ultimaFila;
	private String fecha;
	private String descripcion;
	private String referencia1;
	private String importe;
	private String referencia2;
	private String saldo;

	public Integer getNumero() {
		return numero;
	}

	public void setNumero(Integer numero) {
		this.numero = numero;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = UtilModel.format(nombre);
	}

	public String getNombreOficial() {
		return nombreOficial;
	}

	public void setNombreOficial(String nombreOficial) {
		this.nombreOficial = UtilModel.format(nombreOficial);
	}

	public String getCuit() {
		return cuit;
	}

	public void setCuit(String cuit) {
		this.cuit = UtilModel.format(cuit);
	}

	public Boolean getBloqueado() {
		return bloqueado;
	}

	public void setBloqueado(Boolean bloqueado) {
		this.bloqueado = UtilModel.format(bloqueado);
	}

	public Integer getHoja() {
		return hoja;
	}

	public void setHoja(Integer hoja) {
		this.hoja = hoja;
	}

	public Integer getPrimeraFila() {
		return primeraFila;
	}

	public void setPrimeraFila(Integer primeraFila) {
		this.primeraFila = primeraFila;
	}

	public Integer getUltimaFila() {
		return ultimaFila;
	}

	public void setUltimaFila(Integer ultimaFila) {
		this.ultimaFila = ultimaFila;
	}

	public String getFecha() {
		return fecha;
	}

	public void setFecha(String fecha) {
		this.fecha = UtilModel.format(fecha);
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = UtilModel.format(descripcion);
	}

	public String getReferencia1() {
		return referencia1;
	}

	public void setReferencia1(String referencia1) {
		this.referencia1 = UtilModel.format(referencia1);
	}

	public String getImporte() {
		return importe;
	}

	public void setImporte(String importe) {
		this.importe = UtilModel.format(importe);
	}

	public String getReferencia2() {
		return referencia2;
	}

	public void setReferencia2(String referencia2) {
		this.referencia2 = UtilModel.format(referencia2);
	}

	public String getSaldo() {
		return saldo;
	}

	public void setSaldo(String saldo) {
		this.saldo = UtilModel.format(saldo);
	}

	@Override
	public String toString() {
		return "(" + numero + ") " + nombre;
	}

}
