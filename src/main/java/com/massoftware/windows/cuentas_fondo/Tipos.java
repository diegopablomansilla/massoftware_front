package com.massoftware.windows.cuentas_fondo;

import com.massoftware.windows.UtilModel;

class Tipos implements Comparable<Tipos> {

	private Integer numero;
	private String nombre;

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

	@Override
	public String toString() {
		return "(" + numero + ") " + nombre;
	}

	@Override
	public Tipos clone() throws CloneNotSupportedException {
		Tipos o = new Tipos();
		o.setNumero(this.getNumero());
		o.setNombre(this.getNombre());

		return o;
	}

	@Override
	public int compareTo(Tipos rubros) {

		return this.getNumero().compareTo(rubros.getNumero());
	}

	@Override
	public boolean equals(Object obj) {
		if (obj == null) {
			return false;
		}
		if (obj == this) {
			return true;
		}
		if (obj instanceof Tipos) {
			Tipos rubros = (Tipos) obj;

			if (this.getNumero() != null && rubros.getNumero() != null) {
				return this.getNumero().equals(rubros.getNumero());
			}

			return false;
		}

		return false;
	}

}
