package com.massoftware.windows.cuentas_fondo;

class GruposFiltro {

	private Integer numeroRubro;
	private Integer numero;
	private String nombre;

	public Integer getNumeroRubro() {
		return numeroRubro;
	}

	public void setNumeroRubro(Integer numeroRubro) {
		this.numeroRubro = numeroRubro;
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

	@Override
	public String toString() {
		return "GruposFiltro [numeroRubro=" + numeroRubro + ", numero=" + numero + ", nombre=" + nombre + "]";
	}

}
