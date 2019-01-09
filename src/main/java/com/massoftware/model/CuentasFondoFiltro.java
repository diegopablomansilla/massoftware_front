package com.massoftware.model;

import com.massoftware.backend.annotation.FieldLabelAnont;

public class CuentasFondoFiltro extends Entity {

	@FieldLabelAnont(value = "Rubro")
	private String idRubro;

	@FieldLabelAnont(value = "Grupo")
	private String idGrupo;

	@FieldLabelAnont(value = "Banco")
	private String idBanco;

	@FieldLabelAnont(value = "Banco")
	private Integer numeroBanco;

	@FieldLabelAnont(value = "Banco")
	private String nombreBanco;

	@FieldLabelAnont(value = "Nº cuenta")
	private Integer numero;

	@FieldLabelAnont(value = "Nombre")
	private String nombre;

	@FieldLabelAnont(value = "Obsoleta")
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
