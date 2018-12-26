package com.massoftware.windows.cuentas_fondo;

import com.massoftware.windows.UtilModel;

public class CuentaFondo implements Comparable<CuentaFondo> {

	private Rubro rubro;
	private Grupo grupo;
	private Integer numero;
	private String nombre;
	private Tipo tipo;
	private Integer numeroBanco;
	private Boolean bloqueado;

	public Rubro getRubro() {
		return rubro;
	}

	public void setRubro(Rubro rubro) {
		this.rubro = rubro;
	}

	public Grupo getGrupo() {
		return grupo;
	}

	public void setGrupo(Grupo grupo) {
		this.grupo = grupo;
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

	public Tipo getTipo() {
		return tipo;
	}

	public void setTipo(Tipo tipo) {
		this.tipo = tipo;
	}

	public Integer getNumeroBanco() {
		return numeroBanco;
	}

	public void setNumeroBanco(Integer numeroBanco) {
		this.numeroBanco = numeroBanco;
	}

	public Boolean getBloqueado() {
		return bloqueado;
	}

	public void setBloqueado(Boolean bloqueado) {
		this.bloqueado = UtilModel.format(bloqueado);
	}

	@Override
	public String toString() {
		return "(" + grupo.getRubro().getNumero() + "-" + grupo.getNumero() + "-" + numero + ") " + nombre;
	}

	@Override
	public CuentaFondo clone() throws CloneNotSupportedException {

		CuentaFondo o = new CuentaFondo();

		if (this.getRubro() != null) {
			o.setRubro(this.getRubro().clone());
		}
		if (this.getGrupo() != null) {
			o.setGrupo(this.getGrupo().clone());
		}
		o.setNumero(this.getNumero());
		o.setNombre(this.getNombre());
		o.setTipo(this.getTipo());
		o.setNumeroBanco(this.getNumeroBanco());
		o.setBloqueado(this.getBloqueado());

		return o;
	}

	@Override
	public int compareTo(CuentaFondo cuentasFondo) {

		return this.getNumero().compareTo(cuentasFondo.getNumero());
	}

	@Override
	public boolean equals(Object obj) {
		if (obj == null) {
			return false;
		}
		if (obj == this) {
			return true;
		}
		if (obj instanceof CuentaFondo) {
			CuentaFondo dto = (CuentaFondo) obj;

			if (this.getNumero() != null && dto.getNumero() != null) {
				return this.getNumero().equals(dto.getNumero());
			}

			return false;
		}

		return false;
	}

}
