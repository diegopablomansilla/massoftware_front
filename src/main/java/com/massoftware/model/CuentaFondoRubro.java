package com.massoftware.model;

import java.util.ArrayList;
import java.util.List;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldLabelAnont;

@ClassLabelAnont(singular = "Rubro", plural = "Rubros")
public class CuentaFondoRubro extends EntityId {

	@FieldLabelAnont(value = "ID")
	private String id;
	
	@FieldLabelAnont(value = "Nº rubro")
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

	public List<CuentaFondoRubro> find() throws Exception {

		List<CuentaFondoRubro> listado = new ArrayList<CuentaFondoRubro>();

		List<EntityId> items = findUtil("numero", null, -1, -1, null, 1);

		for (EntityId item : items) {
			listado.add((CuentaFondoRubro) item);
		}

		return listado;
	}

}
