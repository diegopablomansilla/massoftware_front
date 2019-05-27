package com.massoftware.dao.clientes;

import java.util.List;
import java.util.ArrayList;
import java.util.UUID;
import com.massoftware.UtilNumeric;
import com.massoftware.backend.BackendContextPG;
import com.massoftware.model.EntityId;
import com.massoftware.model.clientes.MotivoBloqueoCliente;

public class MotivoBloqueoClienteDAO {

	private int levelDefault = 1;

	// ---------------------------------------------------------------------------------------------------------------------------


	public String insert(MotivoBloqueoCliente obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto MotivoBloqueoCliente no nulo.");

		}


		Object id = UUID.randomUUID().toString();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object clasificacionCliente = ( obj.getClasificacionCliente() != null && obj.getClasificacionCliente().getId() != null) ? obj.getClasificacionCliente().getId() : String.class;

		String sql = "SELECT * FROM massoftware.i_MotivoBloqueoCliente(?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, clasificacionCliente};

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


	public String update(MotivoBloqueoCliente obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto MotivoBloqueoCliente no nulo.");

		}


		if(obj.getId() == null || obj.getId().trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un objeto MotivoBloqueoCliente con id no nulo/vacio.");

		}


		Object id = ( obj.getId() == null ) ? String.class : obj.getId();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object clasificacionCliente = ( obj.getClasificacionCliente() != null && obj.getClasificacionCliente().getId() != null) ? obj.getClasificacionCliente().getId() : String.class;

		String sql = "SELECT * FROM massoftware.u_MotivoBloqueoCliente(?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, clasificacionCliente};

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

			throw new IllegalArgumentException("Se esperaba un id (MotivoBloqueoCliente.id) no nulo/vacio.");

		}


		id = id.trim();

		String sql = "SELECT * FROM massoftware.d_MotivoBloqueoClienteById(?)";

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


	public boolean isExistsNumero(Integer arg) throws Exception {


		if(arg == null || arg.toString().trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un arg (MotivoBloqueoCliente.numero) no nulo/vacio.");

		}

		String sql = "SELECT * FROM massoftware.f_exists_MotivoBloqueoCliente_numero(?)";

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

			throw new IllegalArgumentException("Se esperaba un arg (MotivoBloqueoCliente.nombre) no nulo/vacio.");

		}

		arg = arg.trim();

		String sql = "SELECT * FROM massoftware.f_exists_MotivoBloqueoCliente_nombre(?)";

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


	public Integer nextValueNumero() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_MotivoBloqueoCliente_numero()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Integer) row[0];

		} else {

			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public Long count() throws Exception {

		String sql = "SELECT COUNT(*) FROM massoftware.MotivoBloqueoCliente;";

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


	public List<MotivoBloqueoCliente> findByNumeroOrNombre(String arg) throws Exception {


		if (arg == null || arg.trim().length() == 0) {

			throw new IllegalArgumentException("Se esperaba un arg (MotivoBloqueoCliente.numero o MotivoBloqueoCliente.nombre) no nulo/vacio.");

		}


		arg = arg.trim();


		//------------ buscar por Nº motivo

		if(UtilNumeric.isInteger(arg)) {

			MotivoBloqueoClienteFiltro filtroNumero = new MotivoBloqueoClienteFiltro();

			filtroNumero.setUnlimited(true);

			filtroNumero.setNumeroFrom(new Integer(arg));

			filtroNumero.setNumeroTo(new Integer(arg));

			List<MotivoBloqueoCliente> listadoNumero = find(filtroNumero);

			if(listadoNumero.size() > 0) {

				return listadoNumero;

			}

		}


		//------------ buscar por Nombre

		MotivoBloqueoClienteFiltro filtroNombre = new MotivoBloqueoClienteFiltro();

		filtroNombre.setUnlimited(true);

		filtroNombre.setNombre(arg);

		List<MotivoBloqueoCliente> listadoNombre = find(filtroNombre);

		if(listadoNombre.size() > 0) {

			return listadoNombre;

		}


		return new ArrayList<MotivoBloqueoCliente>();

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public MotivoBloqueoCliente findById(String id) throws Exception {

		return findById(id, levelDefault);
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public MotivoBloqueoCliente findById(String id, Integer level) throws Exception {


		if(id == null || id.trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un id (MotivoBloqueoCliente.id) no nulo/vacio.");

		}


		id = id.trim();


		MotivoBloqueoCliente obj = null;

		level = (level == null || level < 0 || level > 3) ? levelDefault : level;

		String levelString = (level > 0) ? "_" + level : "";

		String sql = "SELECT * FROM massoftware.f_MotivoBloqueoClienteById" + levelString + "(?)";

		Object[] args = new Object[] {id};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 3) {

				obj = mapper3Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 7) {

				obj = mapper7Fields(row);

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


	public List<MotivoBloqueoCliente> find(MotivoBloqueoClienteFiltro filtro) throws Exception {

		List<MotivoBloqueoCliente> listado = new ArrayList<MotivoBloqueoCliente>();

		String levelString = (filtro.getLevel() > 0) ? "_" + filtro.getLevel() : "";
		String orderByString = (filtro.getOrderBy() == null || filtro.getOrderBy().equals("id")) ? "" : "_" + filtro.getOrderBy();
		String orderByASCString = "";
		if(orderByString != null && orderByString.trim().length() > 0) {

			orderByString = "MotivoBloqueoCliente" + orderByString;
			orderByASCString = "_asc_";
			if(filtro.getOrderByDesc() == true) {
				orderByASCString = "_des_";
			}
			orderByString = orderByASCString + orderByString;
		}
		String params = (filtro.getUnlimited() == true) ? "" : "?, ?, ";

		String sql = "SELECT * FROM massoftware.f_MotivoBloqueoCliente" + orderByString + levelString + "(" + params + "?, ?, ?, ?, ?, ?, ?, ?)";

		Object numeroFrom = ( filtro.getNumeroFrom() == null ) ? Integer.class : filtro.getNumeroFrom();
		Object numeroTo = ( filtro.getNumeroTo() == null ) ? Integer.class : filtro.getNumeroTo();

		String[] nombreWords = ( filtro.getNombre() == null ) ? new String[0] : filtro.getNombre().split(" ");
		Object nombreWord0 = ( nombreWords.length > 0 && nombreWords[0].trim().length() > 0) ? nombreWords[0].trim() : String.class;
		Object nombreWord1 = ( nombreWords.length > 1 && nombreWords[1].trim().length() > 0) ? nombreWords[1].trim() : String.class;
		Object nombreWord2 = ( nombreWords.length > 2 && nombreWords[2].trim().length() > 0) ? nombreWords[2].trim() : String.class;
		Object nombreWord3 = ( nombreWords.length > 3 && nombreWords[3].trim().length() > 0) ? nombreWords[3].trim() : String.class;
		Object nombreWord4 = ( nombreWords.length > 4 && nombreWords[4].trim().length() > 0) ? nombreWords[4].trim() : String.class;
		Object clasificacionCliente = ( filtro.getClasificacionCliente() != null && filtro.getClasificacionCliente().getId() != null) ? filtro.getClasificacionCliente().getId() : String.class;

		Object[] args = null;
		if(filtro.getUnlimited()){
			args = new Object[] {numeroFrom, numeroTo, nombreWord0, nombreWord1, nombreWord2, nombreWord3, nombreWord4, clasificacionCliente};
		} else {
			args = new Object[] {filtro.getLimit(), filtro.getOffset(), numeroFrom, numeroTo, nombreWord0, nombreWord1, nombreWord2, nombreWord3, nombreWord4, clasificacionCliente};
		}

		Object[][] table = BackendContextPG.get().find(sql, args);

		for(int i = 0; i < table.length; i++){

			Object[] row = table[i];

			if(row.length == 3) {

				MotivoBloqueoCliente obj = mapper3Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 7) {

				MotivoBloqueoCliente obj = mapper7Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else {

				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva una fila con  " + row.length + " columnas.");

			}

		}

		return listado;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private MotivoBloqueoCliente mapper3Fields(Object[] row) throws Exception {

		int c = -1;

		String idMotivoBloqueoClienteArg0 = (String) row[++c];
		Integer numeroMotivoBloqueoClienteArg1 = (Integer) row[++c];
		String nombreMotivoBloqueoClienteArg2 = (String) row[++c];

		MotivoBloqueoCliente obj = new MotivoBloqueoCliente(idMotivoBloqueoClienteArg0, numeroMotivoBloqueoClienteArg1, nombreMotivoBloqueoClienteArg2);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private MotivoBloqueoCliente mapper7Fields(Object[] row) throws Exception {

		int c = -1;

		String idMotivoBloqueoClienteArg0 = (String) row[++c];
		Integer numeroMotivoBloqueoClienteArg1 = (Integer) row[++c];
		String nombreMotivoBloqueoClienteArg2 = (String) row[++c];
		String idClasificacionClienteArg3 = (String) row[++c];
		Integer numeroClasificacionClienteArg4 = (Integer) row[++c];
		String nombreClasificacionClienteArg5 = (String) row[++c];
		Integer colorClasificacionClienteArg6 = (Integer) row[++c];

		MotivoBloqueoCliente obj = new MotivoBloqueoCliente(idMotivoBloqueoClienteArg0, numeroMotivoBloqueoClienteArg1, nombreMotivoBloqueoClienteArg2, idClasificacionClienteArg3, numeroClasificacionClienteArg4, nombreClasificacionClienteArg5, colorClasificacionClienteArg6);

		return obj;

	}

} // END CLASS ----------------------------------------------------------------------------------------------------------