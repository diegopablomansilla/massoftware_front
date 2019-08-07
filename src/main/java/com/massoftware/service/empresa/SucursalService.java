package com.massoftware.service.empresa;

import java.util.List;
import java.util.ArrayList;
import java.util.UUID;

import com.massoftware.backend.BackendContextPG;
import com.massoftware.model.EntityId;
import com.massoftware.model.empresa.Sucursal;
import com.massoftware.service.UtilNumeric;

public class SucursalService {

	private int levelDefault = 1;

	// ---------------------------------------------------------------------------------------------------------------------------


	public String insert(Sucursal obj) throws Exception {

		if(obj == null){
			throw new IllegalArgumentException("Se esperaba un objeto Sucursal no nulo.");
		}

		Object id = UUID.randomUUID().toString();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object abreviatura = ( obj.getAbreviatura() == null ) ? String.class : obj.getAbreviatura();
		Object tipoSucursal = ( obj.getTipoSucursal() != null && obj.getTipoSucursal().getId() != null) ? obj.getTipoSucursal().getId() : String.class;
		Object cuentaClientesDesde = ( obj.getCuentaClientesDesde() == null ) ? String.class : obj.getCuentaClientesDesde();
		Object cuentaClientesHasta = ( obj.getCuentaClientesHasta() == null ) ? String.class : obj.getCuentaClientesHasta();
		Object cantidadCaracteresClientes = ( obj.getCantidadCaracteresClientes() == null ) ? Integer.class : obj.getCantidadCaracteresClientes();
		Object identificacionNumericaClientes = ( obj.getIdentificacionNumericaClientes() == null ) ? Boolean.class : obj.getIdentificacionNumericaClientes();
		Object permiteCambiarClientes = ( obj.getPermiteCambiarClientes() == null ) ? Boolean.class : obj.getPermiteCambiarClientes();
		Object cuentaProveedoresDesde = ( obj.getCuentaProveedoresDesde() == null ) ? String.class : obj.getCuentaProveedoresDesde();
		Object cuentaProveedoresHasta = ( obj.getCuentaProveedoresHasta() == null ) ? String.class : obj.getCuentaProveedoresHasta();
		Object cantidadCaracteresProveedores = ( obj.getCantidadCaracteresProveedores() == null ) ? Integer.class : obj.getCantidadCaracteresProveedores();
		Object identificacionNumericaProveedores = ( obj.getIdentificacionNumericaProveedores() == null ) ? Boolean.class : obj.getIdentificacionNumericaProveedores();
		Object permiteCambiarProveedores = ( obj.getPermiteCambiarProveedores() == null ) ? Boolean.class : obj.getPermiteCambiarProveedores();
		Object clientesOcacionalesDesde = ( obj.getClientesOcacionalesDesde() == null ) ? Integer.class : obj.getClientesOcacionalesDesde();
		Object clientesOcacionalesHasta = ( obj.getClientesOcacionalesHasta() == null ) ? Integer.class : obj.getClientesOcacionalesHasta();
		Object numeroCobranzaDesde = ( obj.getNumeroCobranzaDesde() == null ) ? Integer.class : obj.getNumeroCobranzaDesde();
		Object numeroCobranzaHasta = ( obj.getNumeroCobranzaHasta() == null ) ? Integer.class : obj.getNumeroCobranzaHasta();

		String sql = "SELECT * FROM massoftware.i_Sucursal(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, abreviatura, tipoSucursal, cuentaClientesDesde, cuentaClientesHasta, cantidadCaracteresClientes, identificacionNumericaClientes, permiteCambiarClientes, cuentaProveedoresDesde, cuentaProveedoresHasta, cantidadCaracteresProveedores, identificacionNumericaProveedores, permiteCambiarProveedores, clientesOcacionalesDesde, clientesOcacionalesHasta, numeroCobranzaDesde, numeroCobranzaHasta};

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


	public String update(Sucursal obj) throws Exception {

		if(obj == null){
			throw new IllegalArgumentException("Se esperaba un objeto Sucursal no nulo.");
		}
		if(obj.getId() == null || obj.getId().trim().length() == 0){
			throw new IllegalArgumentException("Se esperaba un objeto Sucursal con id no nulo/vacio.");
		}

		Object id = ( obj.getId() == null ) ? String.class : obj.getId();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object nombre = ( obj.getNombre() == null ) ? String.class : obj.getNombre();
		Object abreviatura = ( obj.getAbreviatura() == null ) ? String.class : obj.getAbreviatura();
		Object tipoSucursal = ( obj.getTipoSucursal() != null && obj.getTipoSucursal().getId() != null) ? obj.getTipoSucursal().getId() : String.class;
		Object cuentaClientesDesde = ( obj.getCuentaClientesDesde() == null ) ? String.class : obj.getCuentaClientesDesde();
		Object cuentaClientesHasta = ( obj.getCuentaClientesHasta() == null ) ? String.class : obj.getCuentaClientesHasta();
		Object cantidadCaracteresClientes = ( obj.getCantidadCaracteresClientes() == null ) ? Integer.class : obj.getCantidadCaracteresClientes();
		Object identificacionNumericaClientes = ( obj.getIdentificacionNumericaClientes() == null ) ? Boolean.class : obj.getIdentificacionNumericaClientes();
		Object permiteCambiarClientes = ( obj.getPermiteCambiarClientes() == null ) ? Boolean.class : obj.getPermiteCambiarClientes();
		Object cuentaProveedoresDesde = ( obj.getCuentaProveedoresDesde() == null ) ? String.class : obj.getCuentaProveedoresDesde();
		Object cuentaProveedoresHasta = ( obj.getCuentaProveedoresHasta() == null ) ? String.class : obj.getCuentaProveedoresHasta();
		Object cantidadCaracteresProveedores = ( obj.getCantidadCaracteresProveedores() == null ) ? Integer.class : obj.getCantidadCaracteresProveedores();
		Object identificacionNumericaProveedores = ( obj.getIdentificacionNumericaProveedores() == null ) ? Boolean.class : obj.getIdentificacionNumericaProveedores();
		Object permiteCambiarProveedores = ( obj.getPermiteCambiarProveedores() == null ) ? Boolean.class : obj.getPermiteCambiarProveedores();
		Object clientesOcacionalesDesde = ( obj.getClientesOcacionalesDesde() == null ) ? Integer.class : obj.getClientesOcacionalesDesde();
		Object clientesOcacionalesHasta = ( obj.getClientesOcacionalesHasta() == null ) ? Integer.class : obj.getClientesOcacionalesHasta();
		Object numeroCobranzaDesde = ( obj.getNumeroCobranzaDesde() == null ) ? Integer.class : obj.getNumeroCobranzaDesde();
		Object numeroCobranzaHasta = ( obj.getNumeroCobranzaHasta() == null ) ? Integer.class : obj.getNumeroCobranzaHasta();

		String sql = "SELECT * FROM massoftware.u_Sucursal(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, nombre, abreviatura, tipoSucursal, cuentaClientesDesde, cuentaClientesHasta, cantidadCaracteresClientes, identificacionNumericaClientes, permiteCambiarClientes, cuentaProveedoresDesde, cuentaProveedoresHasta, cantidadCaracteresProveedores, identificacionNumericaProveedores, permiteCambiarProveedores, clientesOcacionalesDesde, clientesOcacionalesHasta, numeroCobranzaDesde, numeroCobranzaHasta};

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
			throw new IllegalArgumentException("Se esperaba un id (Sucursal.id) no nulo/vacio.");
		}

		id = id.trim();

		String sql = "SELECT * FROM massoftware.d_SucursalById(?)";

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
			throw new IllegalArgumentException("Se esperaba un arg (Sucursal.numero) no nulo/vacio.");
		}

		String sql = "SELECT * FROM massoftware.f_exists_Sucursal_numero(?)";

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
			throw new IllegalArgumentException("Se esperaba un arg (Sucursal.nombre) no nulo/vacio.");
		}

		arg = arg.trim();

		String sql = "SELECT * FROM massoftware.f_exists_Sucursal_nombre(?)";

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

	public boolean isExistsAbreviatura(String arg) throws Exception {

		if(arg == null || arg.toString().trim().length() == 0){
			throw new IllegalArgumentException("Se esperaba un arg (Sucursal.abreviatura) no nulo/vacio.");
		}

		arg = arg.trim();

		String sql = "SELECT * FROM massoftware.f_exists_Sucursal_abreviatura(?)";

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

		String sql = "SELECT * FROM massoftware.f_next_Sucursal_numero()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Integer) row[0];

		} else {
			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

	}

	public Integer nextValueCantidadCaracteresClientes() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_Sucursal_cantidadCaracteresClientes()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Integer) row[0];

		} else {
			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

	}

	public Integer nextValueCantidadCaracteresProveedores() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_Sucursal_cantidadCaracteresProveedores()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Integer) row[0];

		} else {
			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

	}

	public Integer nextValueClientesOcacionalesDesde() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_Sucursal_clientesOcacionalesDesde()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Integer) row[0];

		} else {
			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

	}

	public Integer nextValueClientesOcacionalesHasta() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_Sucursal_clientesOcacionalesHasta()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Integer) row[0];

		} else {
			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

	}

	public Integer nextValueNumeroCobranzaDesde() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_Sucursal_numeroCobranzaDesde()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Integer) row[0];

		} else {
			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");
		}

	}

	public Integer nextValueNumeroCobranzaHasta() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_Sucursal_numeroCobranzaHasta()";

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

		String sql = "SELECT COUNT(*) FROM massoftware.Sucursal;";

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


	public List<Sucursal> findByNumeroOrNombre(String arg) throws Exception {


		if (arg == null || arg.trim().length() == 0) {

			throw new IllegalArgumentException("Se esperaba un arg (Sucursal.numero o Sucursal.nombre) no nulo/vacio.");

		}


		arg = arg.trim();


		//------------ buscar por Nº sucursal

		if(UtilNumeric.isInteger(arg)) {

			SucursalFiltro filtroNumero = new SucursalFiltro();

			filtroNumero.setUnlimited(true);

			filtroNumero.setNumeroFrom(new Integer(arg));

			filtroNumero.setNumeroTo(new Integer(arg));

			List<Sucursal> listadoNumero = find(filtroNumero);

			if(listadoNumero.size() > 0) {

				return listadoNumero;

			}

		}


		//------------ buscar por Nombre

		SucursalFiltro filtroNombre = new SucursalFiltro();

		filtroNombre.setUnlimited(true);

		filtroNombre.setNombre(arg);

		List<Sucursal> listadoNombre = find(filtroNombre);

		if(listadoNombre.size() > 0) {

			return listadoNombre;

		}


		return new ArrayList<Sucursal>();

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public Sucursal findById(String id) throws Exception {

		return findById(id, levelDefault);
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public Sucursal findById(String id, Integer level) throws Exception {

		if(id == null || id.trim().length() == 0){
			throw new IllegalArgumentException("Se esperaba un id (Sucursal.id) no nulo/vacio.");
		}

		id = id.trim();

		Sucursal obj = null;

		level = (level == null || level < 0 || level > 3) ? levelDefault : level;

		String levelString = (level > 0) ? "_" + level : "";

		String sql = "SELECT * FROM massoftware.f_SucursalById" + levelString + "(?)";

		Object[] args = new Object[] {id};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 19) {

				obj = mapper19Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 21) {

				obj = mapper21Fields(row);

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


	public List<Sucursal> find(SucursalFiltro filtro) throws Exception {

		List<Sucursal> listado = new ArrayList<Sucursal>();

		String levelString = (filtro.getLevel() > 0) ? "_" + filtro.getLevel() : "";

		String sql = "SELECT * FROM massoftware.f_Sucursal" + levelString + "(?, ?, ?, ?, ? , ?, ?, ?)";

		Object numeroFrom = ( filtro.getNumeroFrom() == null ) ? Integer.class : filtro.getNumeroFrom();
		Object numeroTo = ( filtro.getNumeroTo() == null ) ? Integer.class : filtro.getNumeroTo();
		Object nombre = ( filtro.getNombre() == null ) ? String.class : filtro.getNombre();

		Object[] args = null;
		if(filtro.getUnlimited()){
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), Long.class, Long.class, numeroFrom, numeroTo, nombre};
		} else {
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), filtro.getLimit(), filtro.getOffset(), numeroFrom, numeroTo, nombre};
		}

		Object[][] table = BackendContextPG.get().find(sql, args);

		for(int i = 0; i < table.length; i++){

			Object[] row = table[i];

			if(row.length == 19) {

				Sucursal obj = mapper19Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 21) {

				Sucursal obj = mapper21Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else {

				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva una fila con  " + row.length + " columnas.");

			}

		}

		return listado;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private Sucursal mapper19Fields(Object[] row) throws Exception {

		int c = -1;

		String idSucursalArg0 = (String) row[++c];
		Integer numeroSucursalArg1 = (Integer) row[++c];
		String nombreSucursalArg2 = (String) row[++c];
		String abreviaturaSucursalArg3 = (String) row[++c];
		String tipoSucursalSucursalArg4 = (String) row[++c]; // TipoSucursal.id
		String cuentaClientesDesdeSucursalArg5 = (String) row[++c];
		String cuentaClientesHastaSucursalArg6 = (String) row[++c];
		Integer cantidadCaracteresClientesSucursalArg7 = (Integer) row[++c];
		Boolean identificacionNumericaClientesSucursalArg8 = (Boolean) row[++c];
		Boolean permiteCambiarClientesSucursalArg9 = (Boolean) row[++c];
		String cuentaProveedoresDesdeSucursalArg10 = (String) row[++c];
		String cuentaProveedoresHastaSucursalArg11 = (String) row[++c];
		Integer cantidadCaracteresProveedoresSucursalArg12 = (Integer) row[++c];
		Boolean identificacionNumericaProveedoresSucursalArg13 = (Boolean) row[++c];
		Boolean permiteCambiarProveedoresSucursalArg14 = (Boolean) row[++c];
		Integer clientesOcacionalesDesdeSucursalArg15 = (Integer) row[++c];
		Integer clientesOcacionalesHastaSucursalArg16 = (Integer) row[++c];
		Integer numeroCobranzaDesdeSucursalArg17 = (Integer) row[++c];
		Integer numeroCobranzaHastaSucursalArg18 = (Integer) row[++c];

		Sucursal obj = new Sucursal(idSucursalArg0, numeroSucursalArg1, nombreSucursalArg2, abreviaturaSucursalArg3, tipoSucursalSucursalArg4, cuentaClientesDesdeSucursalArg5, cuentaClientesHastaSucursalArg6, cantidadCaracteresClientesSucursalArg7, identificacionNumericaClientesSucursalArg8, permiteCambiarClientesSucursalArg9, cuentaProveedoresDesdeSucursalArg10, cuentaProveedoresHastaSucursalArg11, cantidadCaracteresProveedoresSucursalArg12, identificacionNumericaProveedoresSucursalArg13, permiteCambiarProveedoresSucursalArg14, clientesOcacionalesDesdeSucursalArg15, clientesOcacionalesHastaSucursalArg16, numeroCobranzaDesdeSucursalArg17, numeroCobranzaHastaSucursalArg18);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private Sucursal mapper21Fields(Object[] row) throws Exception {

		int c = -1;

		String idSucursalArg0 = (String) row[++c];
		Integer numeroSucursalArg1 = (Integer) row[++c];
		String nombreSucursalArg2 = (String) row[++c];
		String abreviaturaSucursalArg3 = (String) row[++c];
		String idTipoSucursalArg4 = (String) row[++c];
		Integer numeroTipoSucursalArg5 = (Integer) row[++c];
		String nombreTipoSucursalArg6 = (String) row[++c];
		String cuentaClientesDesdeSucursalArg7 = (String) row[++c];
		String cuentaClientesHastaSucursalArg8 = (String) row[++c];
		Integer cantidadCaracteresClientesSucursalArg9 = (Integer) row[++c];
		Boolean identificacionNumericaClientesSucursalArg10 = (Boolean) row[++c];
		Boolean permiteCambiarClientesSucursalArg11 = (Boolean) row[++c];
		String cuentaProveedoresDesdeSucursalArg12 = (String) row[++c];
		String cuentaProveedoresHastaSucursalArg13 = (String) row[++c];
		Integer cantidadCaracteresProveedoresSucursalArg14 = (Integer) row[++c];
		Boolean identificacionNumericaProveedoresSucursalArg15 = (Boolean) row[++c];
		Boolean permiteCambiarProveedoresSucursalArg16 = (Boolean) row[++c];
		Integer clientesOcacionalesDesdeSucursalArg17 = (Integer) row[++c];
		Integer clientesOcacionalesHastaSucursalArg18 = (Integer) row[++c];
		Integer numeroCobranzaDesdeSucursalArg19 = (Integer) row[++c];
		Integer numeroCobranzaHastaSucursalArg20 = (Integer) row[++c];

		Sucursal obj = new Sucursal(idSucursalArg0, numeroSucursalArg1, nombreSucursalArg2, abreviaturaSucursalArg3, idTipoSucursalArg4, numeroTipoSucursalArg5, nombreTipoSucursalArg6, cuentaClientesDesdeSucursalArg7, cuentaClientesHastaSucursalArg8, cantidadCaracteresClientesSucursalArg9, identificacionNumericaClientesSucursalArg10, permiteCambiarClientesSucursalArg11, cuentaProveedoresDesdeSucursalArg12, cuentaProveedoresHastaSucursalArg13, cantidadCaracteresProveedoresSucursalArg14, identificacionNumericaProveedoresSucursalArg15, permiteCambiarProveedoresSucursalArg16, clientesOcacionalesDesdeSucursalArg17, clientesOcacionalesHastaSucursalArg18, numeroCobranzaDesdeSucursalArg19, numeroCobranzaHastaSucursalArg20);

		return obj;

	}

} // END CLASS ----------------------------------------------------------------------------------------------------------