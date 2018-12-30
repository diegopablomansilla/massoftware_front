package com.massoftware.windows.cuentas_fondo.grupos;

import com.massoftware.windows.UtilModel;

class Grupos implements Comparable<Grupos> {

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
		this.nombre = UtilModel.format(nombre);
	}

	@Override
	public String toString() {
		return "(" + numeroRubro + "-" + numero + ") " + nombre;
	}

	@Override
	public Grupos clone() throws CloneNotSupportedException {
		Grupos o = new Grupos();
		o.setNumero(this.getNumero());
		o.setNombre(this.getNombre());
		if (this.getNumeroRubro() != null) {
			o.setNumeroRubro(this.getNumeroRubro());
		}

		return o;
	}

	@Override
	public int compareTo(Grupos grupos) {

		int c = this.getNumeroRubro().compareTo(grupos.getNumeroRubro());

		if (c > 0) {
			return c;
		} else if (c < 0) {
			return c;
		} else {
			return this.getNumero().compareTo(grupos.getNumero());
		}
	}

	@Override
	public boolean equals(Object obj) {
		if (obj == null) {
			return false;
		}
		if (obj == this) {
			return true;
		}
		if (obj instanceof Grupos) {
			Grupos grupos = (Grupos) obj;

			if (this.getNumeroRubro() != null && grupos.getNumeroRubro() != null && this.getNumero() != null
					&& grupos.getNumero() != null) {
				return this.getNumeroRubro().equals(grupos.getNumeroRubro())
						&& this.getNumero().equals(grupos.getNumero());
			}

			return false;
		}

		return false;
	}

}
