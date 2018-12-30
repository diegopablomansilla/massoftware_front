package com.massoftware.model;

public class Banco extends EntityId {

	private String id;
	private Integer numero;
	private String nombre;
	private Long cuit;
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

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

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
		this.nombre = nombre;
	}

	public Long getCuit() {
		return cuit;
	}

	public void setCuit(Long cuit) {
		this.cuit = cuit;
	}

	public Boolean getBloqueado() {
		return bloqueado;
	}

	public void setBloqueado(Boolean bloqueado) {
		this.bloqueado = bloqueado;
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
		this.fecha = fecha;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public String getReferencia1() {
		return referencia1;
	}

	public void setReferencia1(String referencia1) {
		this.referencia1 = referencia1;
	}

	public String getImporte() {
		return importe;
	}

	public void setImporte(String importe) {
		this.importe = importe;
	}

	public String getReferencia2() {
		return referencia2;
	}

	public void setReferencia2(String referencia2) {
		this.referencia2 = referencia2;
	}

	public String getSaldo() {
		return saldo;
	}

	public void setSaldo(String saldo) {
		this.saldo = saldo;
	}

	@Override
	public String toString() {
		return "Banco [id=" + id + ", numero=" + numero + ", nombre=" + nombre + ", cuit=" + cuit + ", bloqueado="
				+ bloqueado + ", hoja=" + hoja + ", primeraFila=" + primeraFila + ", ultimaFila=" + ultimaFila
				+ ", fecha=" + fecha + ", descripcion=" + descripcion + ", referencia1=" + referencia1 + ", importe="
				+ importe + ", referencia2=" + referencia2 + ", saldo=" + saldo + "]";
	}

}
