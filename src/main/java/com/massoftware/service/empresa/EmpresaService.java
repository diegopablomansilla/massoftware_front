package com.massoftware.service.empresa;

import java.util.List;
import java.util.ArrayList;
import java.util.UUID;
import com.massoftware.backend.BackendContextPG;
import com.massoftware.model.EntityId;
import com.massoftware.model.empresa.Empresa;

public class EmpresaService {

	private int levelDefault = 1;

	// ---------------------------------------------------------------------------------------------------------------------------


	public String insert(Empresa obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto Empresa no nulo.");

		}


		Object id = UUID.randomUUID().toString();
		Object ejercicioContable = ( obj.getEjercicioContable() != null && obj.getEjercicioContable().getId() != null) ? obj.getEjercicioContable().getId() : String.class;
		Object fechaCierreVentas = ( obj.getFechaCierreVentas() == null ) ? java.util.Date.class : obj.getFechaCierreVentas();
		Object fechaCierreStock = ( obj.getFechaCierreStock() == null ) ? java.util.Date.class : obj.getFechaCierreStock();
		Object fechaCierreFondo = ( obj.getFechaCierreFondo() == null ) ? java.util.Date.class : obj.getFechaCierreFondo();
		Object fechaCierreCompras = ( obj.getFechaCierreCompras() == null ) ? java.util.Date.class : obj.getFechaCierreCompras();
		Object fechaCierreContabilidad = ( obj.getFechaCierreContabilidad() == null ) ? java.util.Date.class : obj.getFechaCierreContabilidad();
		Object fechaCierreGarantiaDevoluciones = ( obj.getFechaCierreGarantiaDevoluciones() == null ) ? java.util.Date.class : obj.getFechaCierreGarantiaDevoluciones();
		Object fechaCierreTambos = ( obj.getFechaCierreTambos() == null ) ? java.util.Date.class : obj.getFechaCierreTambos();
		Object fechaCierreRRHH = ( obj.getFechaCierreRRHH() == null ) ? java.util.Date.class : obj.getFechaCierreRRHH();

		String sql = "SELECT * FROM massoftware.i_Empresa(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, ejercicioContable, fechaCierreVentas, fechaCierreStock, fechaCierreFondo, fechaCierreCompras, fechaCierreContabilidad, fechaCierreGarantiaDevoluciones, fechaCierreTambos, fechaCierreRRHH};

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


	public String update(Empresa obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto Empresa no nulo.");

		}


		if(obj.getId() == null || obj.getId().trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un objeto Empresa con id no nulo/vacio.");

		}


		Object id = ( obj.getId() == null ) ? String.class : obj.getId();
		Object ejercicioContable = ( obj.getEjercicioContable() != null && obj.getEjercicioContable().getId() != null) ? obj.getEjercicioContable().getId() : String.class;
		Object fechaCierreVentas = ( obj.getFechaCierreVentas() == null ) ? java.util.Date.class : obj.getFechaCierreVentas();
		Object fechaCierreStock = ( obj.getFechaCierreStock() == null ) ? java.util.Date.class : obj.getFechaCierreStock();
		Object fechaCierreFondo = ( obj.getFechaCierreFondo() == null ) ? java.util.Date.class : obj.getFechaCierreFondo();
		Object fechaCierreCompras = ( obj.getFechaCierreCompras() == null ) ? java.util.Date.class : obj.getFechaCierreCompras();
		Object fechaCierreContabilidad = ( obj.getFechaCierreContabilidad() == null ) ? java.util.Date.class : obj.getFechaCierreContabilidad();
		Object fechaCierreGarantiaDevoluciones = ( obj.getFechaCierreGarantiaDevoluciones() == null ) ? java.util.Date.class : obj.getFechaCierreGarantiaDevoluciones();
		Object fechaCierreTambos = ( obj.getFechaCierreTambos() == null ) ? java.util.Date.class : obj.getFechaCierreTambos();
		Object fechaCierreRRHH = ( obj.getFechaCierreRRHH() == null ) ? java.util.Date.class : obj.getFechaCierreRRHH();

		String sql = "SELECT * FROM massoftware.u_Empresa(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, ejercicioContable, fechaCierreVentas, fechaCierreStock, fechaCierreFondo, fechaCierreCompras, fechaCierreContabilidad, fechaCierreGarantiaDevoluciones, fechaCierreTambos, fechaCierreRRHH};

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

			throw new IllegalArgumentException("Se esperaba un id (Empresa.id) no nulo/vacio.");

		}


		id = id.trim();

		String sql = "SELECT * FROM massoftware.d_EmpresaById(?)";

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


	// ---------------------------------------------------------------------------------------------------------------------------


	public Long count() throws Exception {

		String sql = "SELECT COUNT(*) FROM massoftware.Empresa;";

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


	public Empresa findById(String id) throws Exception {

		return findById(id, levelDefault);
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public Empresa findById(String id, Integer level) throws Exception {


		if(id == null || id.trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un id (Empresa.id) no nulo/vacio.");

		}


		id = id.trim();


		Empresa obj = null;

		level = (level == null || level < 0 || level > 3) ? levelDefault : level;

		String levelString = (level > 0) ? "_" + level : "";

		String sql = "SELECT * FROM massoftware.f_EmpresaById" + levelString + "(?)";

		Object[] args = new Object[] {id};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 10) {

				obj = mapper10Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 16) {

				obj = mapper16Fields(row);

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


	public List<Empresa> find(EmpresaFiltro filtro) throws Exception {

		List<Empresa> listado = new ArrayList<Empresa>();

		String levelString = (filtro.getLevel() > 0) ? "_" + filtro.getLevel() : "";

		String sql = "SELECT * FROM massoftware.f_Empresa" + levelString + "(?, ?, ?, ?, ?, )";


		Object[] args = null;
		if(filtro.getUnlimited()){
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), Long.class, Long.class};
		} else {
			args = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), filtro.getLimit(), filtro.getOffset()};
		}

		Object[][] table = BackendContextPG.get().find(sql, args);

		for(int i = 0; i < table.length; i++){

			Object[] row = table[i];

			if(row.length == 10) {

				Empresa obj = mapper10Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 16) {

				Empresa obj = mapper16Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else {

				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva una fila con  " + row.length + " columnas.");

			}

		}

		return listado;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private Empresa mapper10Fields(Object[] row) throws Exception {

		int c = -1;

		String idEmpresaArg0 = (String) row[++c];
		String ejercicioContableEmpresaArg1 = (String) row[++c]; // EjercicioContable.id
		java.util.Date fechaCierreVentasEmpresaArg2 = (java.util.Date) row[++c];
		java.util.Date fechaCierreStockEmpresaArg3 = (java.util.Date) row[++c];
		java.util.Date fechaCierreFondoEmpresaArg4 = (java.util.Date) row[++c];
		java.util.Date fechaCierreComprasEmpresaArg5 = (java.util.Date) row[++c];
		java.util.Date fechaCierreContabilidadEmpresaArg6 = (java.util.Date) row[++c];
		java.util.Date fechaCierreGarantiaDevolucionesEmpresaArg7 = (java.util.Date) row[++c];
		java.util.Date fechaCierreTambosEmpresaArg8 = (java.util.Date) row[++c];
		java.util.Date fechaCierreRRHHEmpresaArg9 = (java.util.Date) row[++c];

		Empresa obj = new Empresa(idEmpresaArg0, ejercicioContableEmpresaArg1, fechaCierreVentasEmpresaArg2, fechaCierreStockEmpresaArg3, fechaCierreFondoEmpresaArg4, fechaCierreComprasEmpresaArg5, fechaCierreContabilidadEmpresaArg6, fechaCierreGarantiaDevolucionesEmpresaArg7, fechaCierreTambosEmpresaArg8, fechaCierreRRHHEmpresaArg9);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private Empresa mapper16Fields(Object[] row) throws Exception {

		int c = -1;

		String idEmpresaArg0 = (String) row[++c];
		String idEjercicioContableArg1 = (String) row[++c];
		Integer numeroEjercicioContableArg2 = (Integer) row[++c];
		java.util.Date aperturaEjercicioContableArg3 = (java.util.Date) row[++c];
		java.util.Date cierreEjercicioContableArg4 = (java.util.Date) row[++c];
		Boolean cerradoEjercicioContableArg5 = (Boolean) row[++c];
		Boolean cerradoModulosEjercicioContableArg6 = (Boolean) row[++c];
		String comentarioEjercicioContableArg7 = (String) row[++c];
		java.util.Date fechaCierreVentasEmpresaArg8 = (java.util.Date) row[++c];
		java.util.Date fechaCierreStockEmpresaArg9 = (java.util.Date) row[++c];
		java.util.Date fechaCierreFondoEmpresaArg10 = (java.util.Date) row[++c];
		java.util.Date fechaCierreComprasEmpresaArg11 = (java.util.Date) row[++c];
		java.util.Date fechaCierreContabilidadEmpresaArg12 = (java.util.Date) row[++c];
		java.util.Date fechaCierreGarantiaDevolucionesEmpresaArg13 = (java.util.Date) row[++c];
		java.util.Date fechaCierreTambosEmpresaArg14 = (java.util.Date) row[++c];
		java.util.Date fechaCierreRRHHEmpresaArg15 = (java.util.Date) row[++c];

		Empresa obj = new Empresa(idEmpresaArg0, idEjercicioContableArg1, numeroEjercicioContableArg2, aperturaEjercicioContableArg3, cierreEjercicioContableArg4, cerradoEjercicioContableArg5, cerradoModulosEjercicioContableArg6, comentarioEjercicioContableArg7, fechaCierreVentasEmpresaArg8, fechaCierreStockEmpresaArg9, fechaCierreFondoEmpresaArg10, fechaCierreComprasEmpresaArg11, fechaCierreContabilidadEmpresaArg12, fechaCierreGarantiaDevolucionesEmpresaArg13, fechaCierreTambosEmpresaArg14, fechaCierreRRHHEmpresaArg15);

		return obj;

	}

} // END CLASS ----------------------------------------------------------------------------------------------------------