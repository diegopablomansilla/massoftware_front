package com.massoftware.model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;

@ClassLabelAnont(singular = "Moneda", plural = "Monedas", singularPre = "la moneda", pluralPre = "las monedas")
public class Moneda extends EntityId {

	@FieldConfAnont(label = "ID")
	private String id;

	@FieldConfAnont(label = "Nº moneda", required = true, unique = true)
	private Integer numero;

	@FieldConfAnont(label = "Nombre", required = true, unique = true)
	private String nombre;

	@FieldConfAnont(label = "Abreviatura", required = true, unique = true, columns = 5)
	private String abreviatura;

	@FieldConfAnont(label = "Cotización", maxValue = "99999.9999", minValue = "-9999.9999", readOnly = true)
	private BigDecimal cotizacion;

	@FieldConfAnont(label = "Fecha cotización", readOnly = true)
	private Timestamp cotizacionFecha;

	@FieldConfAnont(label = "Control de actualizacion", required = true)
	private Boolean controlActualizacion;

	@FieldConfAnont(label = "Moneda AFIP")
	private MonedaAFIP monedaAFIP;

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

	public String getAbreviatura() {
		return abreviatura;
	}

	public void setAbreviatura(String abreviatura) {
		this.abreviatura = abreviatura;
	}

	public BigDecimal getCotizacion() {
		return cotizacion;
	}

	public void setCotizacion(BigDecimal cotizacion) {
		this.cotizacion = cotizacion;
	}

	public Timestamp getCotizacionFecha() {
		return cotizacionFecha;
	}

	public void setCotizacionFecha(Timestamp cotizacionFecha) {
		this.cotizacionFecha = cotizacionFecha;
	}

	public Boolean getControlActualizacion() {
		return controlActualizacion;
	}

	public void setControlActualizacion(Boolean controlActualizacion) {
		this.controlActualizacion = controlActualizacion;
	}

	public MonedaAFIP getMonedaAFIP() {
		return monedaAFIP;
	}

	public void setMonedaAFIP(MonedaAFIP monedaAFIP) {
		this.monedaAFIP = monedaAFIP;
	}

	@Override
	public String toString() {
		if (numero != null && nombre != null) {
			return "(" + numero + ") " + nombre;
		}

		return null;
	}
	
	public List<Moneda> find() throws Exception {
		return find(-1, -1, null, new MonedasFiltro());
	}

	public List<Moneda> find(MonedasFiltro filtro) throws Exception {
		return find(-1, -1, null, filtro);
	}

	public List<Moneda> find(int limit, int offset, Map<String, Boolean> orderBy, MonedasFiltro filtro)
			throws Exception {

		filtro.setterTrim();

		List<Moneda> listado = new ArrayList<Moneda>();

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

		List<EntityId> items = findUtil(orderBySQL, whereSQL, limit, offset, filtros.toArray(), 1);

		for (EntityId item : items) {
			listado.add((Moneda) item);
		}

		return listado;
	}
	
	public String insert() throws Exception {
		
		this.setCotizacion(new BigDecimal(1));
		this.setCotizacionFecha(new Timestamp(System.currentTimeMillis()));
		
		return super.insert();
	}

}
