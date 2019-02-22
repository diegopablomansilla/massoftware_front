package com.massoftware.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;

@ClassLabelAnont(singular = "Zona", plural = "Zonas", singularPre = "la zona", pluralPre = "las zonas")
public class Zona extends EntityId {

	@FieldConfAnont(label = "ID")
	private String id;

	@FieldConfAnont(label = "Código", required = true, unique = true, columns = 5, maxLength = 3)
	private String codigo;

	@FieldConfAnont(label = "Nombre", required = true, unique = true)
	private String nombre;

	@FieldConfAnont(label = "Bonificación", columns = 8, minValue = "0", maxValue = "99999.99")
	private Double bonificacion;

	@FieldConfAnont(label = "Recargo", columns = 8, minValue = "0", maxValue = "99999.99")
	private Double recargo;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

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

	public Double getBonificacion() {
		return bonificacion;
	}

	public void setBonificacion(Double bonificacion) {
		this.bonificacion = bonificacion;
	}

	public Double getRecargo() {
		return recargo;
	}

	public void setRecargo(Double recargo) {
		this.recargo = recargo;
	}

	@Override
	public String toString() {
		return "(" + codigo + ") " + nombre;
	}

	public List<Zona> find(int limit, int offset, Map<String, Boolean> orderBy, ZonasFiltro filtro) throws Exception {

		filtro.setterTrim();

		List<Zona> listado = new ArrayList<Zona>();

		String orderBySQL = "codigo";
		String whereSQL = "";

		ArrayList<Object> filtros = new ArrayList<Object>();

		if (filtro.getCodigo() != null) {
			filtros.add(filtro.getCodigo());
			whereSQL += "codigo" + " = ? AND ";
		}
		if (filtro.getNombre() != null) {
			String[] palabras = filtro.getNombre().split(" ");
			for (String palabra : palabras) {
				filtros.add(palabra.trim());
				whereSQL += "TRIM(massoftware.TRANSLATE(" + "nombre"
						+ "))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(?)) || '%')::VARCHAR AND ";
			}
		}

		// ==================================================================

		whereSQL = whereSQL.trim();
		if (whereSQL.length() > 0) {
			whereSQL = whereSQL.substring(0, whereSQL.length() - 4);
		} else {
			whereSQL = null;
		}

		// ==================================================================

		List<EntityId> items = findUtil(orderBySQL, whereSQL, limit, offset, filtros.toArray(), 1);

		for (EntityId item : items) {
			listado.add((Zona) item);
		}

		return listado;
	}

}