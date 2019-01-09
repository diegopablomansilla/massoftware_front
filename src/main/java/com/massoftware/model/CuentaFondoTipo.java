package com.massoftware.model;

import java.util.ArrayList;
import java.util.List;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldLabelAnont;

@ClassLabelAnont(singular = "Tipo", plural = "Tipos")
public class CuentaFondoTipo extends EntityId {

	@FieldLabelAnont(value = "ID")
	private String id;
	
	@FieldLabelAnont(value = "Nº tipo")
	private Integer numero;
	
	@FieldLabelAnont(value = "Nombre")
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
