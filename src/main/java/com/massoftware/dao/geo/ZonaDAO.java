package com.massoftware.dao.geo;

import java.util.List;
import java.util.ArrayList;
import java.util.UUID;
import com.massoftware.backend.BackendContextPG;
import com.massoftware.model.EntityId;
import com.massoftware.model.geo.Zona;

public class ZonaDAO {

	private int levelDefault = 0;

	// ---------------------------------------------------------------------------------------------------------------------------


	public String insert(Zona obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto Zona no nulo.");

		}


		Object id = UUID.randomUUID().toString();
		Object codigo = ( obj.getCodigo() == null ) ? String.class : obj.getCodigo();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object bonificacion = ( obj.getBonificacion() == null ) ? java.math.BigDecimal.class : obj.getBonificacion();
		Object recargo = ( obj.getRecargo() == null ) ? java.math.BigDecimal.class : obj.getRecargo();

		String sql = "SELECT * FROM massoftware.i_Zona(?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, codigo, nombre, bonificacion, recargo};

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


	public String update(Zona obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto Zona no nulo.");

		}


		if(obj.getId() == null || obj.getId().trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un objeto Zona con id no nulo/vacio.");

		}


		Object id = ( obj.getId() == null ) ? String.class : obj.getId();
		Object codigo = ( obj.getCodigo() == null ) ? String.class : obj.getCodigo();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object bonificacion = ( obj.getBonificacion() == null ) ? java.math.BigDecimal.class : obj.getBonificacion();
		Object recargo = ( obj.getRecargo() == null ) ? java.math.BigDecimal.class : obj.getRecargo();

		String sql = "SELECT * FROM massoftware.u_Zona(?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, codigo, nombre, bonificacion, recargo};

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

			throw new IllegalArgumentException("Se esperaba un id (Zona.id) no nulo/vacio.");

		}


		id = id.trim();

		String sql = "SELECT * FROM massoftware.d_ZonaById(?)";

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


	public boolean isExistsCodigo(String arg) throws Exception {


		if(arg == null || arg.toString().trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un arg (Zona.codigo) no nulo/vacio.");

		}

		arg = arg.trim();

		String sql = "SELECT * FROM massoftware.f_exists_Zona_codigo(?)";

		Object[] args = new Object[] {arg};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 1){

				return (Boolean) row[0];

			} else { 

				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + row.length + " columnas.");

			}

		} else {

			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	public boolean isExistsNombre(String arg) throws Exception {


		if(arg == null || arg.toString().trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un arg (Zona.nombre) no nulo/vacio.");

		}

		arg = arg.trim();

		String sql = "SELECT * FROM massoftware.f_exists_Zona_nombre(?)";

		Object[] args = new Object[] {arg};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 1){

				return (Boolean) row[0];

			} else { 

				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + row.length + " columnas.");

			}

		} else {

			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public java.math.BigDecimal nextValueBonificacion() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_Zona_bonificacion()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (java.math.BigDecimal) row[0];

		} else {

			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	public java.math.BigDecimal nextValueRecargo() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_Zona_recargo()";

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

		String sql = "SELECT COUNT(*) FROM massoftware.Zona;";

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


	public List<Zona> findByCodigoOrNombre(String arg) throws Exception {


		if (arg == null || arg.trim().length() == 0) {

			throw new IllegalArgumentException("Se esperaba un arg (Zona.codigo o Zona.nombre) no nulo/vacio.");

		}


		arg = arg.trim();


		//------------ buscar por Código

		ZonaFiltro filtroCodigo = new ZonaFiltro();

		filtroCodigo.setUnlimited(true);

		filtroCodigo.setCodigo(arg);

		List<Zona> listadoCodigo = find(filtroCodigo);

		if(listadoCodigo.size() > 0) {

			return listadoCodigo;

		}


		//------------ buscar por Nombre

		ZonaFiltro filtroNombre = new ZonaFiltro();

		filtroNombre.setUnlimited(true);

		filtroNombre.setNombre(arg);

		List<Zona> listadoNombre = find(filtroNombre);

		if(listadoNombre.size() > 0) {

			return listadoNombre;

		}


		return new ArrayList<Zona>();

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public Zona findById(String id) throws Exception {

		return findById(id, levelDefault);
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public Zona findById(String id, Integer level) throws Exception {


		if(id == null || id.trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un id (Zona.id) no nulo/vacio.");

		}


		id = id.trim();


		Zona obj = null;

		level = (level == null || level < 0 || level > 3) ? levelDefault : level;

		String levelString = (level > 0) ? "_" + level : "";

		String sql = "SELECT * FROM massoftware.f_ZonaById" + levelString + "(?)";

		Object[] args = new Object[] {id};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 5) {

				obj = mapper5Fields(row);

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


	public List<Zona> find(ZonaFiltro filtro) throws Exception {

		List<Zona> listado = new ArrayList<Zona>();

		String levelString = (filtro.getLevel() > 0) ? "_" + filtro.getLevel() : "";
		String orderByString = (filtro.getOrderBy() == null || filtro.getOrderBy().equals("id")) ? "" : "_" + filtro.getOrderBy();
		String orderByASCString = "";
		if(orderByString != null && orderByString.trim().length() > 0) {

			orderByString = "Zona" + orderByString;
			orderByASCString = "_asc_";
			if(filtro.getOrderByDesc() == true) {
				orderByASCString = "_des_";
			}
			orderByString = orderByASCString + orderByString;
		}
		String params = (filtro.getUnlimited() == true) ? "" : "?, ?, ";

		String sql = "SELECT * FROM massoftware.f_Zona" + orderByString + levelString + "(" + params + "?, ?, ?, ?, ?, ?)";

		Object codigo = ( filtro.getCodigo() == null ) ? String.class : filtro.getCodigo();

		String[] nombreWords = ( filtro.getNombre() == null ) ? new String[0] : filtro.getNombre().split(" ");
		Object nombreWord0 = ( nombreWords.length > 0 && nombreWords[0].trim().length() > 0) ? nombreWords[0].trim() : String.class;
		Object nombreWord1 = ( nombreWords.length > 1 && nombreWords[1].trim().length() > 0) ? nombreWords[1].trim() : String.class;
		Object nombreWord2 = ( nombreWords.length > 2 && nombreWords[2].trim().length() > 0) ? nombreWords[2].trim() : String.class;
		Object nombreWord3 = ( nombreWords.length > 3 && nombreWords[3].trim().length() > 0) ? nombreWords[3].trim() : String.class;
		Object nombreWord4 = ( nombreWords.length > 4 && nombreWords[4].trim().length() > 0) ? nombreWords[4].trim() : String.class;

		Object[] args = null;
		if(filtro.getUnlimited()){
			args = new Object[] {codigo, nombreWord0, nombreWord1, nombreWord2, nombreWord3, nombreWord4};
		} else {
			args = new Object[] {filtro.getLimit(), filtro.getOffset(), codigo, nombreWord0, nombreWord1, nombreWord2, nombreWord3, nombreWord4};
		}

		Object[][] table = BackendContextPG.get().find(sql, args);

		for(int i = 0; i < table.length; i++){

			Object[] row = table[i];

			if(row.length == 5) {

				Zona obj = mapper5Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else {

				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva una fila con  " + row.length + " columnas.");

			}

		}

		return listado;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private Zona mapper5Fields(Object[] row) throws Exception {

		int c = -1;

		String idZonaArg0 = (String) row[++c];
		String codigoZonaArg1 = (String) row[++c];
		String nombreZonaArg2 = (String) row[++c];
		java.math.BigDecimal bonificacionZonaArg3 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal recargoZonaArg4 = (java.math.BigDecimal) row[++c];

		Zona obj = new Zona(idZonaArg0, codigoZonaArg1, nombreZonaArg2, bonificacionZonaArg3, recargoZonaArg4);

		return obj;

	}

} // END CLASS ----------------------------------------------------------------------------------------------------------