package com.massoftware.service.fondos.banco;

import java.util.List;
import java.util.ArrayList;
import java.util.UUID;

import com.massoftware.backend.BackendContextPG;
import com.massoftware.model.EntityId;
import com.massoftware.model.fondos.banco.Banco;
import com.massoftware.service.UtilNumeric;

public class BancoService {

	private int levelDefault = 0;

	// ---------------------------------------------------------------------------------------------------------------------------


	public String insert(Banco obj) throws Exception {

		if(obj == null){
			throw new IllegalArgumentException("Se esperaba un objeto Banco no nulo.");
		}

		Object id = UUID.randomUUID().toString();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object cuit = ( obj.getCuit() == null ) ? Long.class : obj.getCuit();
		Object bloqueado = ( obj.getBloqueado() == null ) ? Boolean.class : obj.getBloqueado();
		Object hoja = ( obj.getHoja() == null ) ? Integer.class : obj.getHoja();
		Object primeraFila = ( obj.getPrimeraFila() == null ) ? Integer.class : obj.getPrimeraFila();
		Object ultimaFila = ( obj.getUltimaFila() == null ) ? Integer.class : obj.getUltimaFila();
		Object fecha = ( obj.getFecha() == null ) ? String.class : obj.getFecha();
		Object descripcion = ( obj.getDescripcion() == null ) ? String.class : obj.getDescripcion();
		Object referencia1 = ( obj.getReferencia1() == null ) ? String.class : obj.getReferencia1();
		Object importe = ( obj.getImporte() == null ) ? String.class : obj.getImporte();
		Object referencia2 = ( obj.getReferencia2() == null ) ? String.class : obj.getReferencia2();
		Object saldo = ( obj.getSaldo() == null ) ? String.class : obj.getSaldo();

		String sql = "SELECT * FROM massoftware.i_Banco(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, cuit, bloqueado, hoja, primeraFila, ultimaFila, fecha, descripcion, referencia1, importe, referencia2, saldo};

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


	public String update(Banco obj) throws Exception {

		if(obj == null){
			throw new IllegalArgumentException("Se esperaba un objeto Banco no nulo.");
		}
		if(obj.getId() == null || obj.getId().trim().length() == 0){
			throw new IllegalArgumentException("Se esperaba un objeto Banco con id no nulo/vacio.");
		}

		Object id = ( obj.getId() == null ) ? String.class : obj.getId();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object cuit = ( obj.getCuit() == null ) ? Long.class : obj.getCuit();
		Object bloqueado = ( obj.getBloqueado() == null ) ? Boolean.class : obj.getBloqueado();
		Object hoja = ( obj.getHoja() == null ) ? Integer.class : obj.getHoja();
		Object primeraFila = ( obj.getPrimeraFila() == null ) ? Integer.class : obj.getPrimeraFila();
		Object ultimaFila = ( obj.getUltimaFila() == null ) ? Integer.class : obj.getUltimaFila();
		Object fecha = ( obj.getFecha() == null ) ? String.class : obj.getFecha();
		Object descripcion = ( obj.getDescripcion() == null ) ? String.class : obj.getDescripcion();
		Object referencia1 = ( obj.getReferencia1() == null ) ? String.class : obj.getReferencia1();
		Object importe = ( obj.getImporte() == null ) ? String.class : obj.getImporte();
		Object referencia2 = ( obj.getReferencia2() == null ) ? String.class : obj.getReferencia2();
		Object saldo = ( obj.getSaldo() == null ) ? String.class : obj.getSaldo();

		String sql = "SELECT * FROM massoftware.u_Banco(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, cuit, bloqueado, hoja, primeraFila, ultimaFila, fecha, descripcion, referencia1, importe, referencia2, saldo};

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
			throw new IllegalArgumentException("Se esperaba un id (Banco.id) no nulo/vacio.");
		}

		id = id.trim();

		String sql = "SELECT * FROM massoftware.d_BancoById(?)";

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
			throw new IllegalArgumentException("Se esperaba un arg (Banco.numero) no nulo/vacio.");
		}

		String sql = "SELECT * FROM massoftware.f_exists_Banco_numero(?)";

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
			throw new IllegalArgumentException("Se esperaba un arg (Banco.nombre) no nulo/vacio.");
		}

		arg = arg.trim();

		String sql = "SELECT * FROM massoftware.f_exists_Banco_nombre(?)";

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

	public boolean isExistsCuit(Long arg) throws Exception {

		if(arg == null || arg.toString().trim().length() == 0){
			throw new IllegalArgumentException("Se esperaba un arg (Banco.cuit) no nulo/vacio.");
		}

		String sql = "SELECT * FROM massoftware.f_exists_Banco_cuit(?)";

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

		String sql = "SELECT * FROM massoftware.f_next_Banco_numero()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Integer) row[0];

		} else {
			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

	}

	public Long nextValueCuit() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_Banco_cuit()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Long) row[0];

		} else {
			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

	}

	public Integer nextValueHoja() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_Banco_hoja()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Integer) row[0];

		} else {
			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

	}

	public Integer nextValuePrimeraFila() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_Banco_primeraFila()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Integer) row[0];

		} else {
			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

	}

	public Integer nextValueUltimaFila() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_Banco_ultimaFila()";

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

		String sql = "SELECT COUNT(*) FROM massoftware.Banco;";

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


	public List<Banco> findByNumeroOrNombre(String arg) throws Exception {


		if (arg == null || arg.trim().length() == 0) {

			throw new IllegalArgumentException("Se esperaba un arg (Banco.numero o Banco.nombre) no nulo/vacio.");

		}


		arg = arg.trim();


		//------------ buscar por Nº banco

		if(UtilNumeric.isInteger(arg)) {

			BancoFiltro filtroNumero = new BancoFiltro();

			filtroNumero.setUnlimited(true);

			filtroNumero.setNumeroFrom(new Integer(arg));

			filtroNumero.setNumeroTo(new Integer(arg));

			List<Banco> listadoNumero = find(filtroNumero);

			if(listadoNumero.size() > 0) {

				return listadoNumero;

			}

		}


		//------------ buscar por Nombre

		BancoFiltro filtroNombre = new BancoFiltro();

		filtroNombre.setUnlimited(true);

		filtroNombre.setNombre(arg);

		List<Banco> listadoNombre = find(filtroNombre);

		if(listadoNombre.size() > 0) {

			return listadoNombre;

		}


		return new ArrayList<Banco>();

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public Banco findById(String id) throws Exception {

		return findById(id, levelDefault);
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public Banco findById(String id, Integer level) throws Exception {

		if(id == null || id.trim().length() == 0){
			throw new IllegalArgumentException("Se esperaba un id (Banco.id) no nulo/vacio.");
		}

		id = id.trim();

		Banco obj = null;

		level = (level == null || level < 0 || level > 3) ? levelDefault : level;

		String levelString = (level > 0) ? "_" + level : "";

		String sql = "SELECT * FROM massoftware.f_BancoById" + levelString + "(?)";

		Object[] args = new Object[] {id};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 14) {

				obj = mapper14Fields(row);

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


	public List<Banco> find(BancoFiltro filtro) throws Exception {

		List<Banco> listado = new ArrayList<Banco>();

		String levelString = (filtro.getLevel() > 0) ? "_" + filtro.getLevel() : "";

		String sql = "SELECT * FROM massoftware.f_Banco" + levelString + "(?, ?, ?, ?, ? , ?, ?, ?, ?)";

		Object numeroFrom = ( filtro.getNumeroFrom() == null ) ? Integer.class : filtro.getNumeroFrom();
		Object numeroTo = ( filtro.getNumeroTo() == null ) ? Integer.class : filtro.getNumeroTo();
		Object nombre = ( filtro.getNombre() == null ) ? String.class : filtro.getNombre();
		Object bloqueado = ( filtro.getBloqueado() == null ) ? Boolean.class : filtro.getBloqueado();

		Object[] args = null;
		if(filtro.getUnlimited()){
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), Long.class, Long.class, numeroFrom, numeroTo, nombre, bloqueado};
		} else {
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), filtro.getLimit(), filtro.getOffset(), numeroFrom, numeroTo, nombre, bloqueado};
		}

		Object[][] table = BackendContextPG.get().find(sql, args);

		for(int i = 0; i < table.length; i++){

			Object[] row = table[i];

			if(row.length == 14) {

				Banco obj = mapper14Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else {

				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva una fila con  " + row.length + " columnas.");

			}

		}

		return listado;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private Banco mapper14Fields(Object[] row) throws Exception {

		int c = -1;

		String idBancoArg0 = (String) row[++c];
		Integer numeroBancoArg1 = (Integer) row[++c];
		String nombreBancoArg2 = (String) row[++c];
		Long cuitBancoArg3 = (Long) row[++c];
		Boolean bloqueadoBancoArg4 = (Boolean) row[++c];
		Integer hojaBancoArg5 = (Integer) row[++c];
		Integer primeraFilaBancoArg6 = (Integer) row[++c];
		Integer ultimaFilaBancoArg7 = (Integer) row[++c];
		String fechaBancoArg8 = (String) row[++c];
		String descripcionBancoArg9 = (String) row[++c];
		String referencia1BancoArg10 = (String) row[++c];
		String importeBancoArg11 = (String) row[++c];
		String referencia2BancoArg12 = (String) row[++c];
		String saldoBancoArg13 = (String) row[++c];

		Banco obj = new Banco(idBancoArg0, numeroBancoArg1, nombreBancoArg2, cuitBancoArg3, bloqueadoBancoArg4, hojaBancoArg5, primeraFilaBancoArg6, ultimaFilaBancoArg7, fechaBancoArg8, descripcionBancoArg9, referencia1BancoArg10, importeBancoArg11, referencia2BancoArg12, saldoBancoArg13);

		return obj;

	}

} // END CLASS ----------------------------------------------------------------------------------------------------------