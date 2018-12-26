package com.massoftware.windows.cuentas_fondo;

import com.massoftware.windows.UtilModel;

public class CuentasFondo implements Comparable<CuentasFondo> {

	private Integer numeroRubro;
	private Integer numeroGrupo;
	private Integer numero;
	private String nombre;
	private String tipo;
	private Integer numeroBanco;
	private Boolean bloqueado;

	public Integer getNumeroRubro() {
		return numeroRubro;
	}

	public void setNumeroRubro(Integer numeroRubro) {
		this.numeroRubro = numeroRubro;
	}

	public Integer getNumeroGrupo() {
		return numeroGrupo;
	}

	public void setNumeroGrupo(Integer numeroGrupo) {
		this.numeroGrupo = numeroGrupo;
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

	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = UtilModel.format(tipo);
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
		return "(" + numeroRubro + "-" + numeroGrupo + "-" + numero + ") "
				+ numero;
	}
	
	@Override
	public CuentasFondo clone() throws CloneNotSupportedException {
		
		CuentasFondo o = new CuentasFondo();
		
		o.setNumeroRubro(this.getNumeroRubro());
		o.setNumeroGrupo(this.getNumeroGrupo());
		o.setNumero(this.getNumero());
		o.setNombre(this.getNombre());
		o.setTipo(this.getTipo());
		o.setNumeroBanco(this.getNumeroBanco());
		o.setBloqueado(this.getBloqueado());

		return o;
	}

	@Override
	public int compareTo(CuentasFondo cuentasFondo) {

		return this.getNumero().compareTo(cuentasFondo.getNumero());
	}
	
	@Override
	public boolean equals(Object obj) {
		if(obj == null) {
			return false;
		}
		if(obj == this) {
			return true;
		}
		if(obj instanceof CuentasFondo) {
			CuentasFondo dto = (CuentasFondo) obj;
			
			if(this.getNumero() != null && dto.getNumero() != null) {
				return this.getNumero().equals(dto.getNumero());
			}
			
			return false;
		}
		
		return false;
	}
	
	

}
