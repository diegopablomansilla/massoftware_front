package com.massoftware.windows.cuentas_fondo;

import com.massoftware.windows.UtilModel;

class Rubro implements Comparable<Rubro> {

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
	public Rubro clone() throws CloneNotSupportedException {
		Rubro o = new Rubro();
		o.setNumero(this.getNumero());
		o.setNombre(this.getNombre());

		return o;
	}

	@Override
	public int compareTo(Rubro rubros) {

		return this.getNumero().compareTo(rubros.getNumero());
	}
	
	@Override
	public boolean equals(Object obj) {
		if(obj == null) {
			return false;
		}
		if(obj == this) {
			return true;
		}
		if(obj instanceof Rubro) {
			Rubro rubro = (Rubro) obj;
			
			if(this.getNumero() != null && rubro.getNumero() != null) {
				return this.getNumero().equals(rubro.getNumero());
			}
			
			return false;
		}
		
		return false;
	}

}
