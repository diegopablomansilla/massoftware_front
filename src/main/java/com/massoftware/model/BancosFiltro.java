package com.massoftware.model;

import com.massoftware.backend.annotation.FieldLabelAnont;

public class BancosFiltro extends Entity {

	@FieldLabelAnont(value = "Nº banco")
	private Integer numero;

	@FieldLabelAnont(value = "Nombre")
	private String nombre;

	@FieldLabelAnont(value = "Obsoleto")
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

}
