package com.massoftware.windows.cuentas_fondo;

class GrupoFiltro {

	private Integer numeroRubro;
	private Integer numero;

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

	@Override
	public String toString() {
		return "GrupoFiltro [numeroRubro=" + numeroRubro + ", numero=" + numero + "]";
	}

}
