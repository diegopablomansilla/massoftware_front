package com.massoftware.model;

import java.util.ArrayList;
import java.util.List;

public class CuentaFondoTipo extends EntityId {

	private String id;
	private Integer numero;
	private String nombre;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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
	
	public List<CuentaFondoTipo> find() throws Exception {

		List<CuentaFondoTipo> listado = new ArrayList<CuentaFondoTipo>();

		List<EntityId> items = findUtil("numero", null, -1, -1, null, 1);

		for (EntityId item : items) {
			listado.add((CuentaFondoTipo) item);
		}

		return listado;
	}

}
