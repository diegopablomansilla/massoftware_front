package com.massoftware.model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;

@ClassLabelAnont(singular = "Marca de ticket", plural = "Marcas de ticket", singularPre = "la marca de ticket", pluralPre = "las marcas de ticket")
public class MarcaTicket extends EntityId {

	@FieldConfAnont(label = "ID")
	private String id;

	@FieldConfAnont(label = "Nº marca de ticket", required = true, unique = true)
	private Integer numero;

	@FieldConfAnont(label = "Nombre", required = true, unique = true)
	private String nombre;

	@FieldConfAnont(label = "Fecha actualización", readOnly = true)
	private Timestamp fecha;

	@FieldConfAnont(label = "Cantidad por lotes")
	private Integer cantidadPorLotes;

	@FieldConfAnont(label = "Control denunciados")
	private ControlDenunciado controlDenunciado;

	@FieldConfAnont(label = "Porcentaje")
	private BigDecimal valorMaximo;

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

	public Timestamp getFecha() {
		return fecha;
	}

	public void setFecha(Timestamp fecha) {
		this.fecha = fecha;
	}

	public Integer getCantidadPorLotes() {
		return cantidadPorLotes;
	}

	public void setCantidadPorLotes(Integer cantidadPorLotes) {
		this.cantidadPorLotes = cantidadPorLotes;
	}

	public ControlDenunciado getControlDenunciado() {
		return controlDenunciado;
	}

	public void setControlDenunciado(ControlDenunciado controlDenunciado) {
		this.controlDenunciado = controlDenunciado;
	}

	public BigDecimal getValorMaximo() {
		return valorMaximo;
	}

	public void setValorMaximo(BigDecimal valorMaximo) {
		this.valorMaximo = valorMaximo;
	}

	@Override
	public String toString() {
		return "(" + numero + ") " + nombre;
	}

	public List<MarcaTicket> find(int limit, int offset, Map<String, Boolean> orderBy, MarcasTicketFiltro filtro) throws Exception {

		filtro.setterTrim();

		List<MarcaTicket> listado = new ArrayList<MarcaTicket>();

		String orderBySQL = "numero";
		String whereSQL = "";

		ArrayList<Object> filtros = new ArrayList<Object>();

		if (filtro.getNumero() != null) {
			filtros.add(filtro.getNumero());
			whereSQL += "numero" + " = ? AND ";
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

		List<EntityId> items = findUtil(orderBySQL, whereSQL, limit, offset, filtros.toArray(), 0);

		for (EntityId item : items) {
			listado.add((MarcaTicket) item);
		}

		return listado;
	}

}
