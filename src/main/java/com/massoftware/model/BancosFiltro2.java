package com.massoftware.model;

public class BancosFiltro2 extends Entity {

	private Integer numero;
	private String nombre;
	private Integer bloqueado;

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

	public Integer getBloqueado() {
		return bloqueado;
	}

	public void setBloqueado(Integer bloqueado) {
		this.bloqueado = bloqueado;
	}

	@Override
	public String toString() {
		return "BancosFiltro2 [numero=" + numero + ", nombre=" + nombre + ", bloqueado=" + bloqueado + "]";
	}

}
