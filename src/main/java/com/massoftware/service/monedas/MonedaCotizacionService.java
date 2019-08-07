package com.massoftware.service.monedas;

import java.util.List;
import java.util.ArrayList;
import java.util.UUID;
import com.massoftware.backend.BackendContextPG;
import com.massoftware.model.EntityId;
import com.massoftware.model.monedas.MonedaCotizacion;

public class MonedaCotizacionService {

	private int levelDefault = 2;

	// ---------------------------------------------------------------------------------------------------------------------------


	public String insert(MonedaCotizacion obj) throws Exception {

		if(obj == null){
			throw new IllegalArgumentException("Se esperaba un objeto MonedaCotizacion no nulo.");
		}

		Object id = UUID.randomUUID().toString();
		Object cotizacionFecha = ( obj.getCotizacionFecha() == null ) ? java.sql.Timestamp.class : obj.getCotizacionFecha();
		Object compra = ( obj.getCompra() == null ) ? java.math.BigDecimal.class : obj.getCompra();
		Object venta = ( obj.getVenta() == null ) ? java.math.BigDecimal.class : obj.getVenta();
		Object cotizacionFechaAuditoria = ( obj.getCotizacionFechaAuditoria() == null ) ? java.sql.Timestamp.class : obj.getCotizacionFechaAuditoria();
		Object moneda = ( obj.getMoneda() != null && obj.getMoneda().getId() != null) ? obj.getMoneda().getId() : String.class;
		Object usuario = ( obj.getUsuario() != null && obj.getUsuario().getId() != null) ? obj.getUsuario().getId() : String.class;

		String sql = "SELECT * FROM massoftware.i_MonedaCotizacion(?, ?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, cotizacionFecha, compra, venta, cotizacionFechaAuditoria, moneda, usuario};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 1){

				Boolean ok = (Boolean) row[0];
				if(ok){
					return id.toString();
				} else { 
					throw new IllegalStateException("No se esperaba que la sentencia no insertara en la base de datos.");
				}

			} else {
				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + row.length + " columnas.");
			}
		} else {
			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public String update(MonedaCotizacion obj) throws Exception {

		if(obj == null){
			throw new IllegalArgumentException("Se esperaba un objeto MonedaCotizacion no nulo.");
		}
		if(obj.getId() == null || obj.getId().trim().length() == 0){
			throw new IllegalArgumentException("Se esperaba un objeto MonedaCotizacion con id no nulo/vacio.");
		}

		Object id = ( obj.getId() == null ) ? String.class : obj.getId();
		Object cotizacionFecha = ( obj.getCotizacionFecha() == null ) ? java.sql.Timestamp.class : obj.getCotizacionFecha();
		Object compra = ( obj.getCompra() == null ) ? java.math.BigDecimal.class : obj.getCompra();
		Object venta = ( obj.getVenta() == null ) ? java.math.BigDecimal.class : obj.getVenta();
		Object cotizacionFechaAuditoria = ( obj.getCotizacionFechaAuditoria() == null ) ? java.sql.Timestamp.class : obj.getCotizacionFechaAuditoria();
		Object moneda = ( obj.getMoneda() != null && obj.getMoneda().getId() != null) ? obj.getMoneda().getId() : String.class;
		Object usuario = ( obj.getUsuario() != null && obj.getUsuario().getId() != null) ? obj.getUsuario().getId() : String.class;

		String sql = "SELECT * FROM massoftware.u_MonedaCotizacion(?, ?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, cotizacionFecha, compra, venta, cotizacionFechaAuditoria, moneda, usuario};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 1){

				Boolean ok = (Boolean) row[0];

				if(ok){
					return id.toString();
				} else { 
					throw new IllegalStateException("No se esperaba que la sentencia no actualizara en la base de datos.");
				}

			} else {
				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + row.length + " columnas.");
			}
		} else {
			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public boolean deleteById(String id) throws Exception {

		if(id == null || id.trim().length() == 0){
			throw new IllegalArgumentException("Se esperaba un id (MonedaCotizacion.id) no nulo/vacio.");
		}

		id = id.trim();

		String sql = "SELECT * FROM massoftware.d_MonedaCotizacionById(?)";

		Object[] args = new Object[] {id};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return row[0].equals(true);

		} else if(table.length > 1 ) {
			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

		return false;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	// ---------------------------------------------------------------------------------------------------------------------------


	public java.math.BigDecimal nextValueCompra() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_MonedaCotizacion_compra()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (java.math.BigDecimal) row[0];

		} else {
			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

	}

	public java.math.BigDecimal nextValueVenta() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_MonedaCotizacion_venta()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (java.math.BigDecimal) row[0];

		} else {
			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public Long count() throws Exception {

		String sql = "SELECT COUNT(*) FROM massoftware.MonedaCotizacion;";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Long) row[0];

		} else {

			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public MonedaCotizacion findById(String id) throws Exception {

		return findById(id, levelDefault);
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public MonedaCotizacion findById(String id, Integer level) throws Exception {

		if(id == null || id.trim().length() == 0){
			throw new IllegalArgumentException("Se esperaba un id (MonedaCotizacion.id) no nulo/vacio.");
		}

		id = id.trim();

		MonedaCotizacion obj = null;

		level = (level == null || level < 0 || level > 3) ? levelDefault : level;

		String levelString = (level > 0) ? "_" + level : "";

		String sql = "SELECT * FROM massoftware.f_MonedaCotizacionById" + levelString + "(?)";

		Object[] args = new Object[] {id};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 7) {

				obj = mapper7Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 16) {

				obj = mapper16Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 18) {

				obj = mapper18Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else {
				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva una fila con  " + row.length + " columnas.");
			}
		} else if(table.length > 1 ) {
				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

		return null;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public List<MonedaCotizacion> find(MonedaCotizacionFiltro filtro) throws Exception {

		List<MonedaCotizacion> listado = new ArrayList<MonedaCotizacion>();

		String levelString = (filtro.getLevel() > 0) ? "_" + filtro.getLevel() : "";

		String sql = "SELECT * FROM massoftware.f_MonedaCotizacion" + levelString + "(?, ?, ?, ?, ? , ?, ?, ?)";

		Object moneda = ( filtro.getMoneda() != null && filtro.getMoneda().getId() != null) ? filtro.getMoneda().getId() : String.class;
		Object cotizacionFechaFrom = ( filtro.getCotizacionFechaFrom() == null ) ? java.sql.Timestamp.class : filtro.getCotizacionFechaFrom();
		Object cotizacionFechaTo = ( filtro.getCotizacionFechaTo() == null ) ? java.sql.Timestamp.class : filtro.getCotizacionFechaTo();

		Object[] args = null;
		if(filtro.getUnlimited()){
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), Long.class, Long.class, moneda, cotizacionFechaFrom, cotizacionFechaTo};
		} else {
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), filtro.getLimit(), filtro.getOffset(), moneda, cotizacionFechaFrom, cotizacionFechaTo};
		}

		Object[][] table = BackendContextPG.get().find(sql, args);

		for(int i = 0; i < table.length; i++){

			Object[] row = table[i];

			if(row.length == 7) {

				MonedaCotizacion obj = mapper7Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 16) {

				MonedaCotizacion obj = mapper16Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 18) {

				MonedaCotizacion obj = mapper18Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else {

				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva una fila con  " + row.length + " columnas.");

			}

		}

		return listado;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private MonedaCotizacion mapper7Fields(Object[] row) throws Exception {

		int c = -1;

		String idMonedaCotizacionArg0 = (String) row[++c];
		java.sql.Timestamp cotizacionFechaMonedaCotizacionArg1 = (java.sql.Timestamp) row[++c];
		java.math.BigDecimal compraMonedaCotizacionArg2 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal ventaMonedaCotizacionArg3 = (java.math.BigDecimal) row[++c];
		java.sql.Timestamp cotizacionFechaAuditoriaMonedaCotizacionArg4 = (java.sql.Timestamp) row[++c];
		String monedaMonedaCotizacionArg5 = (String) row[++c]; // Moneda.id
		String usuarioMonedaCotizacionArg6 = (String) row[++c]; // Usuario.id

		MonedaCotizacion obj = new MonedaCotizacion(idMonedaCotizacionArg0, cotizacionFechaMonedaCotizacionArg1, compraMonedaCotizacionArg2, ventaMonedaCotizacionArg3, cotizacionFechaAuditoriaMonedaCotizacionArg4, monedaMonedaCotizacionArg5, usuarioMonedaCotizacionArg6);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private MonedaCotizacion mapper16Fields(Object[] row) throws Exception {

		int c = -1;

		String idMonedaCotizacionArg0 = (String) row[++c];
		java.sql.Timestamp cotizacionFechaMonedaCotizacionArg1 = (java.sql.Timestamp) row[++c];
		java.math.BigDecimal compraMonedaCotizacionArg2 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal ventaMonedaCotizacionArg3 = (java.math.BigDecimal) row[++c];
		java.sql.Timestamp cotizacionFechaAuditoriaMonedaCotizacionArg4 = (java.sql.Timestamp) row[++c];
		String idMonedaArg5 = (String) row[++c];
		Integer numeroMonedaArg6 = (Integer) row[++c];
		String nombreMonedaArg7 = (String) row[++c];
		String abreviaturaMonedaArg8 = (String) row[++c];
		java.math.BigDecimal cotizacionMonedaArg9 = (java.math.BigDecimal) row[++c];
		java.sql.Timestamp cotizacionFechaMonedaArg10 = (java.sql.Timestamp) row[++c];
		Boolean controlActualizacionMonedaArg11 = (Boolean) row[++c];
		String monedaAFIPMonedaArg12 = (String) row[++c]; // MonedaAFIP.id
		String idUsuarioArg13 = (String) row[++c];
		Integer numeroUsuarioArg14 = (Integer) row[++c];
		String nombreUsuarioArg15 = (String) row[++c];

		MonedaCotizacion obj = new MonedaCotizacion(idMonedaCotizacionArg0, cotizacionFechaMonedaCotizacionArg1, compraMonedaCotizacionArg2, ventaMonedaCotizacionArg3, cotizacionFechaAuditoriaMonedaCotizacionArg4, idMonedaArg5, numeroMonedaArg6, nombreMonedaArg7, abreviaturaMonedaArg8, cotizacionMonedaArg9, cotizacionFechaMonedaArg10, controlActualizacionMonedaArg11, monedaAFIPMonedaArg12, idUsuarioArg13, numeroUsuarioArg14, nombreUsuarioArg15);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private MonedaCotizacion mapper18Fields(Object[] row) throws Exception {

		int c = -1;

		String idMonedaCotizacionArg0 = (String) row[++c];
		java.sql.Timestamp cotizacionFechaMonedaCotizacionArg1 = (java.sql.Timestamp) row[++c];
		java.math.BigDecimal compraMonedaCotizacionArg2 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal ventaMonedaCotizacionArg3 = (java.math.BigDecimal) row[++c];
		java.sql.Timestamp cotizacionFechaAuditoriaMonedaCotizacionArg4 = (java.sql.Timestamp) row[++c];
		String idMonedaArg5 = (String) row[++c];
		Integer numeroMonedaArg6 = (Integer) row[++c];
		String nombreMonedaArg7 = (String) row[++c];
		String abreviaturaMonedaArg8 = (String) row[++c];
		java.math.BigDecimal cotizacionMonedaArg9 = (java.math.BigDecimal) row[++c];
		java.sql.Timestamp cotizacionFechaMonedaArg10 = (java.sql.Timestamp) row[++c];
		Boolean controlActualizacionMonedaArg11 = (Boolean) row[++c];
		String idMonedaAFIPArg12 = (String) row[++c];
		String codigoMonedaAFIPArg13 = (String) row[++c];
		String nombreMonedaAFIPArg14 = (String) row[++c];
		String idUsuarioArg15 = (String) row[++c];
		Integer numeroUsuarioArg16 = (Integer) row[++c];
		String nombreUsuarioArg17 = (String) row[++c];

		MonedaCotizacion obj = new MonedaCotizacion(idMonedaCotizacionArg0, cotizacionFechaMonedaCotizacionArg1, compraMonedaCotizacionArg2, ventaMonedaCotizacionArg3, cotizacionFechaAuditoriaMonedaCotizacionArg4, idMonedaArg5, numeroMonedaArg6, nombreMonedaArg7, abreviaturaMonedaArg8, cotizacionMonedaArg9, cotizacionFechaMonedaArg10, controlActualizacionMonedaArg11, idMonedaAFIPArg12, codigoMonedaAFIPArg13, nombreMonedaAFIPArg14, idUsuarioArg15, numeroUsuarioArg16, nombreUsuarioArg17);

		return obj;

	}

} // END CLASS ----------------------------------------------------------------------------------------------------------