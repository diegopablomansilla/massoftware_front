package com.massoftware.dao.monedas;

import java.util.List;
import java.util.ArrayList;
import java.util.UUID;
import com.massoftware.backend.BackendContextPG;
import com.massoftware.model.EntityId;
import com.massoftware.model.monedas.Moneda;

public class MonedaDAO {

	// ---------------------------------------------------------------------------------------------------------------------------


	public String insert(Moneda obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto Moneda no nulo.");

		}


		Object id = UUID.randomUUID().toString();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object abreviatura = ( obj.getAbreviatura() == null ) ? String.class : obj.getAbreviatura();
		Object cotizacion = ( obj.getCotizacion() == null ) ? java.math.BigDecimal.class : obj.getCotizacion();
		Object cotizacionFecha = ( obj.getCotizacionFecha() == null ) ? java.sql.Timestamp.class : obj.getCotizacionFecha();
		Object controlActualizacion = ( obj.getControlActualizacion() == null ) ? Boolean.class : obj.getControlActualizacion();
		Object monedaAFIP = ( obj.getMonedaAFIP() != null && obj.getMonedaAFIP().getId() != null) ? obj.getMonedaAFIP().getId() : String.class;

		String sql = "SELECT * FROM massoftware.i_Moneda(?, ?, ?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, abreviatura, cotizacion, cotizacionFecha, controlActualizacion, monedaAFIP};

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


	public String update(Moneda obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto Moneda no nulo.");

		}


		if(obj.getId() == null || obj.getId().trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un objeto Moneda con id no nulo/vacio.");

		}


		Object id = ( obj.getId() == null ) ? String.class : obj.getId();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object abreviatura = ( obj.getAbreviatura() == null ) ? String.class : obj.getAbreviatura();
		Object cotizacion = ( obj.getCotizacion() == null ) ? java.math.BigDecimal.class : obj.getCotizacion();
		Object cotizacionFecha = ( obj.getCotizacionFecha() == null ) ? java.sql.Timestamp.class : obj.getCotizacionFecha();
		Object controlActualizacion = ( obj.getControlActualizacion() == null ) ? Boolean.class : obj.getControlActualizacion();
		Object monedaAFIP = ( obj.getMonedaAFIP() != null && obj.getMonedaAFIP().getId() != null) ? obj.getMonedaAFIP().getId() : String.class;

		String sql = "SELECT * FROM massoftware.u_Moneda(?, ?, ?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, abreviatura, cotizacion, cotizacionFecha, controlActualizacion, monedaAFIP};

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

			throw new IllegalArgumentException("Se esperaba un id (Moneda.id) no nulo/vacio.");

		}

		String sql = "SELECT * FROM massoftware.d_MonedaById(?)";

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


	public boolean isUniqueNumero(Integer arg) throws Exception {


		if(arg == null || arg.toString().trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un arg (Moneda.numero) no nulo/vacio.");

		}

		String sql = "SELECT * FROM massoftware.f_u_Moneda_numero(?)";

		Object[] args = new Object[] {arg};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Long) row[0] > 0;

		} else {

			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	public boolean isUniqueNombre(String arg) throws Exception {


		if(arg == null || arg.toString().trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un arg (Moneda.nombre) no nulo/vacio.");

		}

		String sql = "SELECT * FROM massoftware.f_u_Moneda_nombre(?)";

		Object[] args = new Object[] {arg};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Long) row[0] > 0;

		} else {

			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	public boolean isUniqueAbreviatura(String arg) throws Exception {


		if(arg == null || arg.toString().trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un arg (Moneda.abreviatura) no nulo/vacio.");

		}

		String sql = "SELECT * FROM massoftware.f_u_Moneda_abreviatura(?)";

		Object[] args = new Object[] {arg};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Long) row[0] > 0;

		} else {

			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public Moneda findById(String id, Integer level) throws Exception {


		if(id == null || id.trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un id (Moneda.id) no nulo/vacio.");

		}


		Moneda obj = null;

		level = (level == null || level < 0) ? 0 : level;
		level = (level != null && level > 3) ? 3 : level;

		String levelString = (level > 0) ? "_" + level : "";

		String sql = "SELECT * FROM massoftware.f_MonedaById" + levelString + "(?)";

		Object[] args = new Object[] {id};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 7) {

				obj = mapper7Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 10) {

				obj = mapper10Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 10) {

				obj = mapper10Fields(row);

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


	public List<Moneda> find(MonedaFiltro filtro) throws Exception {

		List<Moneda> listado = new ArrayList<Moneda>();

		String levelString = (filtro.getLevel() > 0) ? "_" + filtro.getLevel() : "";
		String orderByString = (filtro.getOrderBy() == null) ? "" : "_" + filtro.getOrderBy();
		String params = (filtro.getUnlimited() == true) ? "" : "?, ?, ";

		String sql = "SELECT * FROM massoftware.f_Moneda" + orderByString + levelString + "(" + params + "?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		Object numeroFrom = ( filtro.getNumeroFrom() == null ) ? Integer.class : filtro.getNumeroFrom();
		Object numeroTo = ( filtro.getNumeroTo() == null ) ? Integer.class : filtro.getNumeroTo();

		String[] nombreWords = ( filtro.getNombre() == null ) ? new String[0] : filtro.getNombre().split(" ");
		Object nombreWord0 = ( nombreWords.length > 0 && nombreWords[0].trim().length() > 0) ? nombreWords[0].trim() : String.class;
		Object nombreWord1 = ( nombreWords.length > 1 && nombreWords[1].trim().length() > 0) ? nombreWords[1].trim() : String.class;
		Object nombreWord2 = ( nombreWords.length > 2 && nombreWords[2].trim().length() > 0) ? nombreWords[2].trim() : String.class;
		Object nombreWord3 = ( nombreWords.length > 3 && nombreWords[3].trim().length() > 0) ? nombreWords[3].trim() : String.class;
		Object nombreWord4 = ( nombreWords.length > 4 && nombreWords[4].trim().length() > 0) ? nombreWords[4].trim() : String.class;

		String[] abreviaturaWords = ( filtro.getAbreviatura() == null ) ? new String[0] : filtro.getAbreviatura().split(" ");
		Object abreviaturaWord0 = ( abreviaturaWords.length > 0 && abreviaturaWords[0].trim().length() > 0) ? abreviaturaWords[0].trim() : String.class;
		Object abreviaturaWord1 = ( abreviaturaWords.length > 1 && abreviaturaWords[1].trim().length() > 0) ? abreviaturaWords[1].trim() : String.class;
		Object abreviaturaWord2 = ( abreviaturaWords.length > 2 && abreviaturaWords[2].trim().length() > 0) ? abreviaturaWords[2].trim() : String.class;
		Object abreviaturaWord3 = ( abreviaturaWords.length > 3 && abreviaturaWords[3].trim().length() > 0) ? abreviaturaWords[3].trim() : String.class;
		Object abreviaturaWord4 = ( abreviaturaWords.length > 4 && abreviaturaWords[4].trim().length() > 0) ? abreviaturaWords[4].trim() : String.class;

		Object[] args = null;
		if(filtro.getUnlimited()){
			args = new Object[] {numeroFrom, numeroTo, nombreWord0, nombreWord1, nombreWord2, nombreWord3, nombreWord4, abreviaturaWord0, abreviaturaWord1, abreviaturaWord2, abreviaturaWord3, abreviaturaWord4};
		} else {
			args = new Object[] {filtro.getLimit(), filtro.getOffset(), numeroFrom, numeroTo, nombreWord0, nombreWord1, nombreWord2, nombreWord3, nombreWord4, abreviaturaWord0, abreviaturaWord1, abreviaturaWord2, abreviaturaWord3, abreviaturaWord4};
		}

		Object[][] table = BackendContextPG.get().find(sql, args);

		for(int i = 0; i < table.length; i++){

			Object[] row = table[i];

			if(row.length == 7) {

				Moneda obj = mapper7Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 10) {

				Moneda obj = mapper10Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else {

				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva una fila con  " + row.length + " columnas.");

			}

		}

		return listado;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	// ---------------------------------------------------------------------------------------------------------------------------


	private Moneda mapper7Fields(Object[] row) throws Exception {

		int c = -1;

		String idMonedaArg0 = (String) row[++c];
		Integer numeroMonedaArg1 = (Integer) row[++c];
		String nombreMonedaArg2 = (String) row[++c];
		String abreviaturaMonedaArg3 = (String) row[++c];
		java.math.BigDecimal cotizacionMonedaArg4 = (java.math.BigDecimal) row[++c];
		java.sql.Timestamp cotizacionFechaMonedaArg5 = (java.sql.Timestamp) row[++c];
		Boolean controlActualizacionMonedaArg6 = (Boolean) row[++c];

		Moneda obj = new Moneda(idMonedaArg0, numeroMonedaArg1, nombreMonedaArg2, abreviaturaMonedaArg3, cotizacionMonedaArg4, cotizacionFechaMonedaArg5, controlActualizacionMonedaArg6);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private Moneda mapper10Fields(Object[] row) throws Exception {

		int c = -1;

		String idMonedaArg0 = (String) row[++c];
		Integer numeroMonedaArg1 = (Integer) row[++c];
		String nombreMonedaArg2 = (String) row[++c];
		String abreviaturaMonedaArg3 = (String) row[++c];
		java.math.BigDecimal cotizacionMonedaArg4 = (java.math.BigDecimal) row[++c];
		java.sql.Timestamp cotizacionFechaMonedaArg5 = (java.sql.Timestamp) row[++c];
		Boolean controlActualizacionMonedaArg6 = (Boolean) row[++c];
		String idMonedaAFIPArg7 = (String) row[++c];
		String codigoMonedaAFIPArg8 = (String) row[++c];
		String nombreMonedaAFIPArg9 = (String) row[++c];

		Moneda obj = new Moneda(idMonedaArg0, numeroMonedaArg1, nombreMonedaArg2, abreviaturaMonedaArg3, cotizacionMonedaArg4, cotizacionFechaMonedaArg5, controlActualizacionMonedaArg6, idMonedaAFIPArg7, codigoMonedaAFIPArg8, nombreMonedaAFIPArg9);

		return obj;

	}

} // END CLASS ----------------------------------------------------------------------------------------------------------