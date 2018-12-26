package com.massoftware.windows.bancos;

import com.massoftware.windows.UtilModel;

public class Bancos implements Comparable<Bancos> {

	private Integer numero;
	private String nombre;
	private String nombreOficial;
	private Boolean bloqueado;

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

	public Boolean getBloqueado() {
		return bloqueado;
	}

	public void setBloqueado(Boolean bloqueado) {
		this.bloqueado = UtilModel.format(bloqueado);
	}

	@Override
	public String toString() {
		return "(" + numero + ") " + nombre;
	}

	@Override
	public Bancos clone() throws CloneNotSupportedException {
		Bancos o = new Bancos();
		o.setNumero(this.getNumero());
		o.setNombre(this.getNombre());
		o.setNombreOficial(this.getNombreOficial());
		o.setBloqueado(this.getBloqueado());

		return o;
	}

	@Override
	public int compareTo(Bancos bancos) {

		return this.getNumero().compareTo(bancos.getNumero());
	}

	@Override
	public boolean equals(Object obj) {
		if (obj == null) {
			return false;
		}
		if (obj == this) {
			return true;
		}
		if (obj instanceof Bancos) {
			Bancos dto = (Bancos) obj;

			if (this.getNumero() != null && dto.getNumero() != null) {
				return this.getNumero().equals(dto.getNumero());
			}

			return false;
		}

		return false;
	}

}
