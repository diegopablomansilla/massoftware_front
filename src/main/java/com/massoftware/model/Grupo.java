package com.massoftware.model;

public class Grupo extends EntityId {

	private String id;
	private Rubro rubro;
	private Integer numero;
	private String nombre;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Rubro getRubro() {
		return rubro;
	}

	public Rubro loadRubro() throws Exception {
		if (rubro != null) {
			rubro.loadById();
		}
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
		this.nombre = nombre;
	}

	@Override
	public String toString() {
		return "(" + numero + ") " + nombre;
	}

}
