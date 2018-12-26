package com.massoftware.windows.cuentas_fondo;

import com.massoftware.windows.UtilModel;

class Grupo implements Comparable<Grupo> {

	private Rubro rubro;
	private Integer numero;
	private String nombre;

	public Rubro getRubro() {
		return rubro;
	}

	public void setRubro(Rubro rubro) {
		this.rubro = rubro;
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
		this.nombre = UtilModel.format(nombre);
	}

	@Override
	public String toString() {
		return "(" + numero + ") " + nombre;
	}

	@Override
	public Grupo clone() throws CloneNotSupportedException {
		Grupo o = new Grupo();
		o.setNumero(this.getNumero());
		o.setNombre(this.getNombre());
		if (this.getRubro() != null) {
			o.setRubro(this.getRubro());
		}

		return o;
	}

	@Override
	public int compareTo(Grupo grupo) {

		return this.getNumero().compareTo(grupo.getNumero());
	}

}
