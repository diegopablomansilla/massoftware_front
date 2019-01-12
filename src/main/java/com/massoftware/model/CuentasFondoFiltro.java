package com.massoftware.model;

import com.massoftware.backend.annotation.FieldConfAnont;

public class CuentasFondoFiltro extends Entity {

	@FieldConfAnont(label = "Rubro")
	private String idRubro;

	@FieldConfAnont(label = "Grupo")
	private String idGrupo;

	@FieldConfAnont(label = "Banco")
	private String idBanco;

	@FieldConfAnont(label = "Banco")
	private Integer numeroBanco;

	@FieldConfAnont(label = "Banco")
	private String nombreBanco;

	@FieldConfAnont(label = "Nº cuenta")
	private Integer numero;

	@FieldConfAnont(label = "Nombre")
	private String nombre;

	@FieldConfAnont(label = "Obsoleta")
	private Integer bloqueado;

	public String getIdRubro() {
		return idRubro;
	}

	public void setIdRubro(String idRubro) {
		this.idRubro = idRubro;
	}

	public String getIdGrupo() {
		return idGrupo;
	}

	public void setIdGrupo(String idGrupo) {
		this.idGrupo = idGrupo;
	}

	public String getIdBanco() {
		return idBanco;
	}

	public void setIdBanco(String idBanco) {
		this.idBanco = idBanco;
	}

	public Integer getNumeroBanco() {
		return numeroBanco;
	}

	public void setNumeroBanco(Integer numeroBanco) {
		this.numeroBanco = numeroBanco;
	}

	public String getNombreBanco() {
		return nombreBanco;
	}

	public void setNombreBanco(String nombreBanco) {
		this.nombreBanco = nombreBanco;
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

	public Integer getBloqueado() {
		return bloqueado;
	}

	public void setBloqueado(Integer bloqueado) {
		this.bloqueado = bloqueado;
	}
}
