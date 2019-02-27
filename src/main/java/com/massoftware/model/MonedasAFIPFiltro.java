package com.massoftware.model;

import com.massoftware.backend.annotation.FieldConfAnont;

public class MonedasAFIPFiltro extends Entity {

	@FieldConfAnont(label = "Código")
	private String codigo;

	@FieldConfAnont(label = "Nombre")
	private String nombre;

	public String getCodigo() {
		return codigo;
	}

	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

}