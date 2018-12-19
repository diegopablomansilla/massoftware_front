package com.massoftware.windows.bancos;

public class BancosFiltro {

	private Integer numero;
	private String nombre;
	private String nombreOficial;
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

	public String getNombreOficial() {
		return nombreOficial;
	}

	public void setNombreOficial(String nombreOficial) {
		this.nombreOficial = nombreOficial;
	}

	public Integer getBloqueado() {
		return bloqueado;
	}

	public void setBloqueado(Integer bloqueado) {
		this.bloqueado = bloqueado;
	}

	@Override
	public String toString() {
		return "BancosFiltro [numero=" + numero + ", nombre=" + nombre
				+ ", nombreOficial=" + nombreOficial + ", bloqueado="
				+ bloqueado + "]";
	}

}
