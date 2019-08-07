package com.massoftware.service.contabilidad;

import java.util.List;
import java.util.ArrayList;
import java.util.UUID;

import com.massoftware.backend.BackendContextPG;
import com.massoftware.model.EntityId;
import com.massoftware.model.contabilidad.PuntoEquilibrio;
import com.massoftware.service.UtilNumeric;

public class PuntoEquilibrioService {

	private int levelDefault = 1;

	// ---------------------------------------------------------------------------------------------------------------------------


	public String insert(PuntoEquilibrio obj) throws Exception {

		if(obj == null){
			throw new IllegalArgumentException("Se esperaba un objeto PuntoEquilibrio no nulo.");
		}

		Object id = UUID.randomUUID().toString();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object tipoPuntoEquilibrio = ( obj.getTipoPuntoEquilibrio() != null && obj.getTipoPuntoEquilibrio().getId() != null) ? obj.getTipoPuntoEquilibrio().getId() : String.class;
		Object ejercicioContable = ( obj.getEjercicioContable() != null && obj.getEjercicioContable().getId() != null) ? obj.getEjercicioContable().getId() : String.class;

		String sql = "SELECT * FROM massoftware.i_PuntoEquilibrio(?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, tipoPuntoEquilibrio, ejercicioContable};

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


	public String update(PuntoEquilibrio obj) throws Exception {

		if(obj == null){
			throw new IllegalArgumentException("Se esperaba un objeto PuntoEquilibrio no nulo.");
		}
		if(obj.getId() == null || obj.getId().trim().length() == 0){
			throw new IllegalArgumentException("Se esperaba un objeto PuntoEquilibrio con id no nulo/vacio.");
		}

		Object id = ( obj.getId() == null ) ? String.class : obj.getId();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object tipoPuntoEquilibrio = ( obj.getTipoPuntoEquilibrio() != null && obj.getTipoPuntoEquilibrio().getId() != null) ? obj.getTipoPuntoEquilibrio().getId() : String.class;
		Object ejercicioContable = ( obj.getEjercicioContable() != null && obj.getEjercicioContable().getId() != null) ? obj.getEjercicioContable().getId() : String.class;

		String sql = "SELECT * FROM massoftware.u_PuntoEquilibrio(?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, tipoPuntoEquilibrio, ejercicioContable};

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
			throw new IllegalArgumentException("Se esperaba un id (PuntoEquilibrio.id) no nulo/vacio.");
		}

		id = id.trim();

		String sql = "SELECT * FROM massoftware.d_PuntoEquilibrioById(?)";

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
			throw new IllegalArgumentException("Se esperaba un arg (PuntoEquilibrio.numero) no nulo/vacio.");
		}

		String sql = "SELECT * FROM massoftware.f_exists_PuntoEquilibrio_numero(?)";

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
			throw new IllegalArgumentException("Se esperaba un arg (PuntoEquilibrio.nombre) no nulo/vacio.");
		}

		arg = arg.trim();

		String sql = "SELECT * FROM massoftware.f_exists_PuntoEquilibrio_nombre(?)";

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

		String sql = "SELECT * FROM massoftware.f_next_PuntoEquilibrio_numero()";

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

		String sql = "SELECT COUNT(*) FROM massoftware.PuntoEquilibrio;";

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


	public List<PuntoEquilibrio> findByNumeroOrNombre(String arg) throws Exception {


		if (arg == null || arg.trim().length() == 0) {

			throw new IllegalArgumentException("Se esperaba un arg (PuntoEquilibrio.numero o PuntoEquilibrio.nombre) no nulo/vacio.");

		}


		arg = arg.trim();


		//------------ buscar por Nº cc

		if(UtilNumeric.isInteger(arg)) {

			PuntoEquilibrioFiltro filtroNumero = new PuntoEquilibrioFiltro();

			filtroNumero.setUnlimited(true);

			filtroNumero.setNumeroFrom(new Integer(arg));

			filtroNumero.setNumeroTo(new Integer(arg));

			List<PuntoEquilibrio> listadoNumero = find(filtroNumero);

			if(listadoNumero.size() > 0) {

				return listadoNumero;

			}

		}


		//------------ buscar por Nombre

		PuntoEquilibrioFiltro filtroNombre = new PuntoEquilibrioFiltro();

		filtroNombre.setUnlimited(true);

		filtroNombre.setNombre(arg);

		List<PuntoEquilibrio> listadoNombre = find(filtroNombre);

		if(listadoNombre.size() > 0) {

			return listadoNombre;

		}


		return new ArrayList<PuntoEquilibrio>();

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public PuntoEquilibrio findById(String id) throws Exception {

		return findById(id, levelDefault);
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public PuntoEquilibrio findById(String id, Integer level) throws Exception {

		if(id == null || id.trim().length() == 0){
			throw new IllegalArgumentException("Se esperaba un id (PuntoEquilibrio.id) no nulo/vacio.");
		}

		id = id.trim();

		PuntoEquilibrio obj = null;

		level = (level == null || level < 0 || level > 3) ? levelDefault : level;

		String levelString = (level > 0) ? "_" + level : "";

		String sql = "SELECT * FROM massoftware.f_PuntoEquilibrioById" + levelString + "(?)";

		Object[] args = new Object[] {id};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 5) {

				obj = mapper5Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 13) {

				obj = mapper13Fields(row);

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


	public List<PuntoEquilibrio> find(PuntoEquilibrioFiltro filtro) throws Exception {

		List<PuntoEquilibrio> listado = new ArrayList<PuntoEquilibrio>();

		String levelString = (filtro.getLevel() > 0) ? "_" + filtro.getLevel() : "";

		String sql = "SELECT * FROM massoftware.f_PuntoEquilibrio" + levelString + "(?, ?, ?, ?, ? , ?, ?, ?, ?)";

		Object numeroFrom = ( filtro.getNumeroFrom() == null ) ? Integer.class : filtro.getNumeroFrom();
		Object numeroTo = ( filtro.getNumeroTo() == null ) ? Integer.class : filtro.getNumeroTo();
		Object nombre = ( filtro.getNombre() == null ) ? String.class : filtro.getNombre();
		Object ejercicioContable = ( filtro.getEjercicioContable() != null && filtro.getEjercicioContable().getId() != null) ? filtro.getEjercicioContable().getId() : String.class;

		Object[] args = null;
		if(filtro.getUnlimited()){
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), Long.class, Long.class, numeroFrom, numeroTo, nombre, ejercicioContable};
		} else {
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), filtro.getLimit(), filtro.getOffset(), numeroFrom, numeroTo, nombre, ejercicioContable};
		}

		Object[][] table = BackendContextPG.get().find(sql, args);

		for(int i = 0; i < table.length; i++){

			Object[] row = table[i];

			if(row.length == 5) {

				PuntoEquilibrio obj = mapper5Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 13) {

				PuntoEquilibrio obj = mapper13Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else {

				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva una fila con  " + row.length + " columnas.");

			}

		}

		return listado;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private PuntoEquilibrio mapper5Fields(Object[] row) throws Exception {

		int c = -1;

		String idPuntoEquilibrioArg0 = (String) row[++c];
		Integer numeroPuntoEquilibrioArg1 = (Integer) row[++c];
		String nombrePuntoEquilibrioArg2 = (String) row[++c];
		String tipoPuntoEquilibrioPuntoEquilibrioArg3 = (String) row[++c]; // TipoPuntoEquilibrio.id
		String ejercicioContablePuntoEquilibrioArg4 = (String) row[++c]; // EjercicioContable.id

		PuntoEquilibrio obj = new PuntoEquilibrio(idPuntoEquilibrioArg0, numeroPuntoEquilibrioArg1, nombrePuntoEquilibrioArg2, tipoPuntoEquilibrioPuntoEquilibrioArg3, ejercicioContablePuntoEquilibrioArg4);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private PuntoEquilibrio mapper13Fields(Object[] row) throws Exception {

		int c = -1;

		String idPuntoEquilibrioArg0 = (String) row[++c];
		Integer numeroPuntoEquilibrioArg1 = (Integer) row[++c];
		String nombrePuntoEquilibrioArg2 = (String) row[++c];
		String idTipoPuntoEquilibrioArg3 = (String) row[++c];
		Integer numeroTipoPuntoEquilibrioArg4 = (Integer) row[++c];
		String nombreTipoPuntoEquilibrioArg5 = (String) row[++c];
		String idEjercicioContableArg6 = (String) row[++c];
		Integer numeroEjercicioContableArg7 = (Integer) row[++c];
		java.util.Date aperturaEjercicioContableArg8 = (java.util.Date) row[++c];
		java.util.Date cierreEjercicioContableArg9 = (java.util.Date) row[++c];
		Boolean cerradoEjercicioContableArg10 = (Boolean) row[++c];
		Boolean cerradoModulosEjercicioContableArg11 = (Boolean) row[++c];
		String comentarioEjercicioContableArg12 = (String) row[++c];

		PuntoEquilibrio obj = new PuntoEquilibrio(idPuntoEquilibrioArg0, numeroPuntoEquilibrioArg1, nombrePuntoEquilibrioArg2, idTipoPuntoEquilibrioArg3, numeroTipoPuntoEquilibrioArg4, nombreTipoPuntoEquilibrioArg5, idEjercicioContableArg6, numeroEjercicioContableArg7, aperturaEjercicioContableArg8, cierreEjercicioContableArg9, cerradoEjercicioContableArg10, cerradoModulosEjercicioContableArg11, comentarioEjercicioContableArg12);

		return obj;

	}

} // END CLASS ----------------------------------------------------------------------------------------------------------