package com.massoftware.model;

import com.massoftware.backend.annotation.FieldConfAnont;

public class JuridiccionConvnioMultilateralFiltro extends Entity {

	@FieldConfAnont(label = "Cuenta de fondo")
	private CuentaFondo cuentaFondo;

	@FieldConfAnont(label = "Nº juridicción")
	private Integer numero;

	@FieldConfAnont(label = "Nombre")
	private String nombre;

	public CuentaFondo getCuentaFondo() {
		return cuentaFondo;
	}

	public void setCuentaFondo(CuentaFondo cuentaFondo) {
		this.cuentaFondo = cuentaFondo;
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

}
