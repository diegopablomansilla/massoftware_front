package com.massoftware.service.logistica;

import java.util.List;
import java.util.ArrayList;
import java.util.UUID;
import com.massoftware.model.logistica.Transporte;
import com.massoftware.backend.BackendContextPG;
import com.massoftware.model.EntityId;
import com.massoftware.model.logistica.TransporteTarifa;

public class TransporteTarifaService {

	private int levelDefault = 3;

	// ---------------------------------------------------------------------------------------------------------------------------


	public String insert(TransporteTarifa obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto TransporteTarifa no nulo.");

		}


		Object id = UUID.randomUUID().toString();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object carga = ( obj.getCarga() != null && obj.getCarga().getId() != null) ? obj.getCarga().getId() : String.class;
		Object ciudad = ( obj.getCiudad() != null && obj.getCiudad().getId() != null) ? obj.getCiudad().getId() : String.class;
		Object precioFlete = ( obj.getPrecioFlete() == null ) ? java.math.BigDecimal.class : obj.getPrecioFlete();
		Object precioUnidadFacturacion = ( obj.getPrecioUnidadFacturacion() == null ) ? java.math.BigDecimal.class : obj.getPrecioUnidadFacturacion();
		Object precioUnidadStock = ( obj.getPrecioUnidadStock() == null ) ? java.math.BigDecimal.class : obj.getPrecioUnidadStock();
		Object precioBultos = ( obj.getPrecioBultos() == null ) ? java.math.BigDecimal.class : obj.getPrecioBultos();
		Object importeMinimoEntrega = ( obj.getImporteMinimoEntrega() == null ) ? java.math.BigDecimal.class : obj.getImporteMinimoEntrega();
		Object importeMinimoCarga = ( obj.getImporteMinimoCarga() == null ) ? java.math.BigDecimal.class : obj.getImporteMinimoCarga();

		String sql = "SELECT * FROM massoftware.i_TransporteTarifa(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, carga, ciudad, precioFlete, precioUnidadFacturacion, precioUnidadStock, precioBultos, importeMinimoEntrega, importeMinimoCarga};

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


	public String update(TransporteTarifa obj) throws Exception {

		if(obj == null){

			throw new IllegalArgumentException("Se esperaba un objeto TransporteTarifa no nulo.");

		}


		if(obj.getId() == null || obj.getId().trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un objeto TransporteTarifa con id no nulo/vacio.");

		}


		Object id = ( obj.getId() == null ) ? String.class : obj.getId();
		Object numero = ( obj.getNumero() == null ) ? Integer.class : obj.getNumero();
		Object carga = ( obj.getCarga() != null && obj.getCarga().getId() != null) ? obj.getCarga().getId() : String.class;
		Object ciudad = ( obj.getCiudad() != null && obj.getCiudad().getId() != null) ? obj.getCiudad().getId() : String.class;
		Object precioFlete = ( obj.getPrecioFlete() == null ) ? java.math.BigDecimal.class : obj.getPrecioFlete();
		Object precioUnidadFacturacion = ( obj.getPrecioUnidadFacturacion() == null ) ? java.math.BigDecimal.class : obj.getPrecioUnidadFacturacion();
		Object precioUnidadStock = ( obj.getPrecioUnidadStock() == null ) ? java.math.BigDecimal.class : obj.getPrecioUnidadStock();
		Object precioBultos = ( obj.getPrecioBultos() == null ) ? java.math.BigDecimal.class : obj.getPrecioBultos();
		Object importeMinimoEntrega = ( obj.getImporteMinimoEntrega() == null ) ? java.math.BigDecimal.class : obj.getImporteMinimoEntrega();
		Object importeMinimoCarga = ( obj.getImporteMinimoCarga() == null ) ? java.math.BigDecimal.class : obj.getImporteMinimoCarga();

		String sql = "SELECT * FROM massoftware.u_TransporteTarifa(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		Object[] args = new Object[] {id, numero, carga, ciudad, precioFlete, precioUnidadFacturacion, precioUnidadStock, precioBultos, importeMinimoEntrega, importeMinimoCarga};

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

			throw new IllegalArgumentException("Se esperaba un id (TransporteTarifa.id) no nulo/vacio.");

		}


		id = id.trim();

		String sql = "SELECT * FROM massoftware.d_TransporteTarifaById(?)";

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


	public Integer nextValueNumero() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_TransporteTarifa_numero()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (Integer) row[0];

		} else {

			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	public java.math.BigDecimal nextValuePrecioFlete() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_TransporteTarifa_precioFlete()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (java.math.BigDecimal) row[0];

		} else {

			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	public java.math.BigDecimal nextValuePrecioUnidadFacturacion() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_TransporteTarifa_precioUnidadFacturacion()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (java.math.BigDecimal) row[0];

		} else {

			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	public java.math.BigDecimal nextValuePrecioUnidadStock() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_TransporteTarifa_precioUnidadStock()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (java.math.BigDecimal) row[0];

		} else {

			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	public java.math.BigDecimal nextValuePrecioBultos() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_TransporteTarifa_precioBultos()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (java.math.BigDecimal) row[0];

		} else {

			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	public java.math.BigDecimal nextValueImporteMinimoEntrega() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_TransporteTarifa_importeMinimoEntrega()";

		Object[] args = new Object[] {};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			return (java.math.BigDecimal) row[0];

		} else {

			throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

	public java.math.BigDecimal nextValueImporteMinimoCarga() throws Exception {

		String sql = "SELECT * FROM massoftware.f_next_TransporteTarifa_importeMinimoCarga()";

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

		String sql = "SELECT COUNT(*) FROM massoftware.TransporteTarifa;";

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


	public List<TransporteTarifa> findByTransporte(String arg) throws Exception {


		if (arg == null || arg.trim().length() == 0) {

			throw new IllegalArgumentException("Se esperaba un arg (TransporteTarifa.transporte) no nulo/vacio.");

		}


		arg = arg.trim();


		//------------ buscar por Transporte

		TransporteTarifaFiltro filtroTransporte = new TransporteTarifaFiltro();

		filtroTransporte.setUnlimited(true);

		Transporte obj = new Transporte();

		obj.setId(arg);

		filtroTransporte.setTransporte(obj);

		List<TransporteTarifa> listadoTransporte = find(filtroTransporte);

		if(listadoTransporte.size() > 0) {

			return listadoTransporte;

		}


		return new ArrayList<TransporteTarifa>();

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public TransporteTarifa findById(String id) throws Exception {

		return findById(id, levelDefault);
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public TransporteTarifa findById(String id, Integer level) throws Exception {


		if(id == null || id.trim().length() == 0){

			throw new IllegalArgumentException("Se esperaba un id (TransporteTarifa.id) no nulo/vacio.");

		}


		id = id.trim();


		TransporteTarifa obj = null;

		level = (level == null || level < 0 || level > 3) ? levelDefault : level;

		String levelString = (level > 0) ? "_" + level : "";

		String sql = "SELECT * FROM massoftware.f_TransporteTarifaById" + levelString + "(?)";

		Object[] args = new Object[] {id};

		Object[][] table = BackendContextPG.get().find(sql, args);

		if(table.length == 1){

			Object[] row = table[0];

			if(row.length == 10) {

				obj = mapper10Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 18) {

				obj = mapper18Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 34) {

				obj = mapper34Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				return obj;

			} else if(row.length == 42) {

				obj = mapper42Fields(row);

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


	public List<TransporteTarifa> find(TransporteTarifaFiltro filtro) throws Exception {

		List<TransporteTarifa> listado = new ArrayList<TransporteTarifa>();

		String levelString = (filtro.getLevel() > 0) ? "_" + filtro.getLevel() : "";

		String sql = "SELECT * FROM massoftware.f_TransporteTarifa" + levelString + "(?, ?, ?, ?, ? )";


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

				TransporteTarifa obj = mapper10Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 18) {

				TransporteTarifa obj = mapper18Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 34) {

				TransporteTarifa obj = mapper34Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else if(row.length == 42) {

				TransporteTarifa obj = mapper42Fields(row);

				obj._originalDTO = (EntityId) obj.clone();

				listado.add(obj);

			} else {

				throw new IllegalStateException("No se esperaba que la consulta a la base de datos devuelva una fila con  " + row.length + " columnas.");

			}

		}

		return listado;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private TransporteTarifa mapper10Fields(Object[] row) throws Exception {

		int c = -1;

		String idTransporteTarifaArg0 = (String) row[++c];
		Integer numeroTransporteTarifaArg1 = (Integer) row[++c];
		String cargaTransporteTarifaArg2 = (String) row[++c]; // Carga.id
		String ciudadTransporteTarifaArg3 = (String) row[++c]; // Ciudad.id
		java.math.BigDecimal precioFleteTransporteTarifaArg4 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal precioUnidadFacturacionTransporteTarifaArg5 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal precioUnidadStockTransporteTarifaArg6 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal precioBultosTransporteTarifaArg7 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal importeMinimoEntregaTransporteTarifaArg8 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal importeMinimoCargaTransporteTarifaArg9 = (java.math.BigDecimal) row[++c];

		TransporteTarifa obj = new TransporteTarifa(idTransporteTarifaArg0, numeroTransporteTarifaArg1, cargaTransporteTarifaArg2, ciudadTransporteTarifaArg3, precioFleteTransporteTarifaArg4, precioUnidadFacturacionTransporteTarifaArg5, precioUnidadStockTransporteTarifaArg6, precioBultosTransporteTarifaArg7, importeMinimoEntregaTransporteTarifaArg8, importeMinimoCargaTransporteTarifaArg9);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private TransporteTarifa mapper18Fields(Object[] row) throws Exception {

		int c = -1;

		String idTransporteTarifaArg0 = (String) row[++c];
		Integer numeroTransporteTarifaArg1 = (Integer) row[++c];
		String idCargaArg2 = (String) row[++c];
		Integer numeroCargaArg3 = (Integer) row[++c];
		String nombreCargaArg4 = (String) row[++c];
		String transporteCargaArg5 = (String) row[++c]; // Transporte.id
		String idCiudadArg6 = (String) row[++c];
		Integer numeroCiudadArg7 = (Integer) row[++c];
		String nombreCiudadArg8 = (String) row[++c];
		String departamentoCiudadArg9 = (String) row[++c];
		Integer numeroAFIPCiudadArg10 = (Integer) row[++c];
		String provinciaCiudadArg11 = (String) row[++c]; // Provincia.id
		java.math.BigDecimal precioFleteTransporteTarifaArg12 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal precioUnidadFacturacionTransporteTarifaArg13 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal precioUnidadStockTransporteTarifaArg14 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal precioBultosTransporteTarifaArg15 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal importeMinimoEntregaTransporteTarifaArg16 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal importeMinimoCargaTransporteTarifaArg17 = (java.math.BigDecimal) row[++c];

		TransporteTarifa obj = new TransporteTarifa(idTransporteTarifaArg0, numeroTransporteTarifaArg1, idCargaArg2, numeroCargaArg3, nombreCargaArg4, transporteCargaArg5, idCiudadArg6, numeroCiudadArg7, nombreCiudadArg8, departamentoCiudadArg9, numeroAFIPCiudadArg10, provinciaCiudadArg11, precioFleteTransporteTarifaArg12, precioUnidadFacturacionTransporteTarifaArg13, precioUnidadStockTransporteTarifaArg14, precioBultosTransporteTarifaArg15, importeMinimoEntregaTransporteTarifaArg16, importeMinimoCargaTransporteTarifaArg17);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private TransporteTarifa mapper34Fields(Object[] row) throws Exception {

		int c = -1;

		String idTransporteTarifaArg0 = (String) row[++c];
		Integer numeroTransporteTarifaArg1 = (Integer) row[++c];
		String idCargaArg2 = (String) row[++c];
		Integer numeroCargaArg3 = (Integer) row[++c];
		String nombreCargaArg4 = (String) row[++c];
		String idTransporteArg5 = (String) row[++c];
		Integer numeroTransporteArg6 = (Integer) row[++c];
		String nombreTransporteArg7 = (String) row[++c];
		Long cuitTransporteArg8 = (Long) row[++c];
		String ingresosBrutosTransporteArg9 = (String) row[++c];
		String telefonoTransporteArg10 = (String) row[++c];
		String faxTransporteArg11 = (String) row[++c];
		String codigoPostalTransporteArg12 = (String) row[++c]; // CodigoPostal.id
		String domicilioTransporteArg13 = (String) row[++c];
		String comentarioTransporteArg14 = (String) row[++c];
		String idCiudadArg15 = (String) row[++c];
		Integer numeroCiudadArg16 = (Integer) row[++c];
		String nombreCiudadArg17 = (String) row[++c];
		String departamentoCiudadArg18 = (String) row[++c];
		Integer numeroAFIPCiudadArg19 = (Integer) row[++c];
		String idProvinciaArg20 = (String) row[++c];
		Integer numeroProvinciaArg21 = (Integer) row[++c];
		String nombreProvinciaArg22 = (String) row[++c];
		String abreviaturaProvinciaArg23 = (String) row[++c];
		Integer numeroAFIPProvinciaArg24 = (Integer) row[++c];
		Integer numeroIngresosBrutosProvinciaArg25 = (Integer) row[++c];
		Integer numeroRENATEAProvinciaArg26 = (Integer) row[++c];
		String paisProvinciaArg27 = (String) row[++c]; // Pais.id
		java.math.BigDecimal precioFleteTransporteTarifaArg28 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal precioUnidadFacturacionTransporteTarifaArg29 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal precioUnidadStockTransporteTarifaArg30 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal precioBultosTransporteTarifaArg31 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal importeMinimoEntregaTransporteTarifaArg32 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal importeMinimoCargaTransporteTarifaArg33 = (java.math.BigDecimal) row[++c];

		TransporteTarifa obj = new TransporteTarifa(idTransporteTarifaArg0, numeroTransporteTarifaArg1, idCargaArg2, numeroCargaArg3, nombreCargaArg4, idTransporteArg5, numeroTransporteArg6, nombreTransporteArg7, cuitTransporteArg8, ingresosBrutosTransporteArg9, telefonoTransporteArg10, faxTransporteArg11, codigoPostalTransporteArg12, domicilioTransporteArg13, comentarioTransporteArg14, idCiudadArg15, numeroCiudadArg16, nombreCiudadArg17, departamentoCiudadArg18, numeroAFIPCiudadArg19, idProvinciaArg20, numeroProvinciaArg21, nombreProvinciaArg22, abreviaturaProvinciaArg23, numeroAFIPProvinciaArg24, numeroIngresosBrutosProvinciaArg25, numeroRENATEAProvinciaArg26, paisProvinciaArg27, precioFleteTransporteTarifaArg28, precioUnidadFacturacionTransporteTarifaArg29, precioUnidadStockTransporteTarifaArg30, precioBultosTransporteTarifaArg31, importeMinimoEntregaTransporteTarifaArg32, importeMinimoCargaTransporteTarifaArg33);

		return obj;

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	private TransporteTarifa mapper42Fields(Object[] row) throws Exception {

		int c = -1;

		String idTransporteTarifaArg0 = (String) row[++c];
		Integer numeroTransporteTarifaArg1 = (Integer) row[++c];
		String idCargaArg2 = (String) row[++c];
		Integer numeroCargaArg3 = (Integer) row[++c];
		String nombreCargaArg4 = (String) row[++c];
		String idTransporteArg5 = (String) row[++c];
		Integer numeroTransporteArg6 = (Integer) row[++c];
		String nombreTransporteArg7 = (String) row[++c];
		Long cuitTransporteArg8 = (Long) row[++c];
		String ingresosBrutosTransporteArg9 = (String) row[++c];
		String telefonoTransporteArg10 = (String) row[++c];
		String faxTransporteArg11 = (String) row[++c];
		String idCodigoPostalArg12 = (String) row[++c];
		String codigoCodigoPostalArg13 = (String) row[++c];
		Integer numeroCodigoPostalArg14 = (Integer) row[++c];
		String nombreCalleCodigoPostalArg15 = (String) row[++c];
		String numeroCalleCodigoPostalArg16 = (String) row[++c];
		String ciudadCodigoPostalArg17 = (String) row[++c]; // Ciudad.id
		String domicilioTransporteArg18 = (String) row[++c];
		String comentarioTransporteArg19 = (String) row[++c];
		String idCiudadArg20 = (String) row[++c];
		Integer numeroCiudadArg21 = (Integer) row[++c];
		String nombreCiudadArg22 = (String) row[++c];
		String departamentoCiudadArg23 = (String) row[++c];
		Integer numeroAFIPCiudadArg24 = (Integer) row[++c];
		String idProvinciaArg25 = (String) row[++c];
		Integer numeroProvinciaArg26 = (Integer) row[++c];
		String nombreProvinciaArg27 = (String) row[++c];
		String abreviaturaProvinciaArg28 = (String) row[++c];
		Integer numeroAFIPProvinciaArg29 = (Integer) row[++c];
		Integer numeroIngresosBrutosProvinciaArg30 = (Integer) row[++c];
		Integer numeroRENATEAProvinciaArg31 = (Integer) row[++c];
		String idPaisArg32 = (String) row[++c];
		Integer numeroPaisArg33 = (Integer) row[++c];
		String nombrePaisArg34 = (String) row[++c];
		String abreviaturaPaisArg35 = (String) row[++c];
		java.math.BigDecimal precioFleteTransporteTarifaArg36 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal precioUnidadFacturacionTransporteTarifaArg37 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal precioUnidadStockTransporteTarifaArg38 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal precioBultosTransporteTarifaArg39 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal importeMinimoEntregaTransporteTarifaArg40 = (java.math.BigDecimal) row[++c];
		java.math.BigDecimal importeMinimoCargaTransporteTarifaArg41 = (java.math.BigDecimal) row[++c];

		TransporteTarifa obj = new TransporteTarifa(idTransporteTarifaArg0, numeroTransporteTarifaArg1, idCargaArg2, numeroCargaArg3, nombreCargaArg4, idTransporteArg5, numeroTransporteArg6, nombreTransporteArg7, cuitTransporteArg8, ingresosBrutosTransporteArg9, telefonoTransporteArg10, faxTransporteArg11, idCodigoPostalArg12, codigoCodigoPostalArg13, numeroCodigoPostalArg14, nombreCalleCodigoPostalArg15, numeroCalleCodigoPostalArg16, ciudadCodigoPostalArg17, domicilioTransporteArg18, comentarioTransporteArg19, idCiudadArg20, numeroCiudadArg21, nombreCiudadArg22, departamentoCiudadArg23, numeroAFIPCiudadArg24, idProvinciaArg25, numeroProvinciaArg26, nombreProvinciaArg27, abreviaturaProvinciaArg28, numeroAFIPProvinciaArg29, numeroIngresosBrutosProvinciaArg30, numeroRENATEAProvinciaArg31, idPaisArg32, numeroPaisArg33, nombrePaisArg34, abreviaturaPaisArg35, precioFleteTransporteTarifaArg36, precioUnidadFacturacionTransporteTarifaArg37, precioUnidadStockTransporteTarifaArg38, precioBultosTransporteTarifaArg39, importeMinimoEntregaTransporteTarifaArg40, importeMinimoCargaTransporteTarifaArg41);

		return obj;

	}

} // END CLASS ----------------------------------------------------------------------------------------------------------