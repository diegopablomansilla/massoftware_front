package com.massoftware.model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.model.monedas.Moneda;
import com.massoftware.model.seguridad.Usuario;

@ClassLabelAnont(singular = "Cotización de moneda", plural = "Cotizaciones de monedas", singularPre = "la cotización de moneda", pluralPre = "las cotizaciones de monedas")
public class MonedaCotizacion2 extends EntityId {

	@FieldConfAnont(label = "ID")
	private String id;

	@FieldConfAnont(label = "Moneda", required = true)
	private Moneda moneda;

	@FieldConfAnont(label = "Fecha cotización", required = true)
	private Timestamp fecha;

	@FieldConfAnont(label = "Compra", maxValue = "99999.9999", minValue = "-9999.9999", required = true)
	private BigDecimal compra;

	@FieldConfAnont(label = "Venta", maxValue = "99999.9999", minValue = "-9999.9999", required = true)
	private BigDecimal venta;

	@FieldConfAnont(label = "Fecha ingreso", readOnly = true)
	private Timestamp auditoriaFecha;

	@FieldConfAnont(label = "Usuario", readOnly = true)
	private Usuario usuario;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Moneda getMoneda() {
		return moneda;
	}

	public void setMoneda(Moneda moneda) {
		this.moneda = moneda;
	}

	public Timestamp getFecha() {
		return fecha;
	}

	public void setFecha(Timestamp fecha) {
		this.fecha = fecha;
	}

	public BigDecimal getCompra() {
		return compra;
	}

	public void setCompra(BigDecimal compra) {
		this.compra = compra;
	}

	public BigDecimal getVenta() {
		return venta;
	}

	public void setVenta(BigDecimal venta) {
		this.venta = venta;
	}

	public Timestamp getAuditoriaFecha() {
		return auditoriaFecha;
	}

	public void setAuditoriaFecha(Timestamp auditoriaFecha) {
		this.auditoriaFecha = auditoriaFecha;
	}

	public Usuario getUsuario() {
		return usuario;
	}

	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}

	@Override
	public String toString() {

		SimpleDateFormat d = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		return d.format(fecha) + " - " + moneda;
	}

	public List<MonedaCotizacion2> find(MonedasCotizacionFiltro filtro) throws Exception {
		return find(-1, -1, null, filtro);
	}

	public List<MonedaCotizacion2> find(int limit, int offset, Map<String, Boolean> orderBy,
			MonedasCotizacionFiltro filtro) throws Exception {

		filtro.setterTrim();

		List<MonedaCotizacion2> listado = new ArrayList<MonedaCotizacion2>();

		String orderBySQL = "moneda, fecha desc";
		String whereSQL = "";

		ArrayList<Object> filtros = new ArrayList<Object>();

		if (filtro.getMoneda() != null && filtro.getMoneda().getId() != null) {
			filtros.add(filtro.getMoneda().getId());
			whereSQL += "moneda" + " = ? AND ";
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
			listado.add((MonedaCotizacion2) item);
		}

		return listado;
	}

	public String insert() throws Exception {

		this.setAuditoriaFecha(new Timestamp(System.currentTimeMillis()));

		return super.insert();
	}

}
