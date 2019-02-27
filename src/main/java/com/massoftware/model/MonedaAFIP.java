package com.massoftware.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;

@ClassLabelAnont(singular = "Moneda AFIP", plural = "Monedas AFIP", singularPre = "la moneda AFIP", pluralPre = "las monedas AFIP")
public class MonedaAFIP extends EntityId {

	@FieldConfAnont(label = "ID")
	private String id;

	@FieldConfAnont(label = "Código", required = true, unique = true, columns = 5, maxLength = 3)
	private String codigo;

	@FieldConfAnont(label = "Nombre", required = true, unique = true)
	private String nombre;

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

	@Override
	public String toString() {
		return "(" + codigo + ") " + nombre;
	}

	public List<MonedaAFIP> find()
			throws Exception {
		
		return find(-1, -1, null, new MonedasAFIPFiltro());
		
	}
	
	public List<MonedaAFIP> find(int limit, int offset, Map<String, Boolean> orderBy, MonedasAFIPFiltro filtro)
			throws Exception {

		filtro.setterTrim();

		List<MonedaAFIP> listado = new ArrayList<MonedaAFIP>();

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
			listado.add((MonedaAFIP) item);
		}

		return listado;
	}

}