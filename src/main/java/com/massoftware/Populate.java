package com.massoftware;
import java.util.List;
import java.util.List;
import java.util.Random;
import com.massoftware.AppCX;

import com.massoftware.model.seguridad.Usuario;
import com.massoftware.service.seguridad.UsuarioFiltro;
import com.massoftware.service.seguridad.UsuarioService;
import com.massoftware.model.seguridad.SeguridadModulo;
import com.massoftware.service.seguridad.SeguridadModuloFiltro;
import com.massoftware.service.seguridad.SeguridadModuloService;
import com.massoftware.model.seguridad.SeguridadPuerta;
import com.massoftware.service.seguridad.SeguridadPuertaFiltro;
import com.massoftware.service.seguridad.SeguridadPuertaService;
import com.massoftware.model.geo.Zona;
import com.massoftware.service.geo.ZonaFiltro;
import com.massoftware.service.geo.ZonaService;
import com.massoftware.model.geo.Pais;
import com.massoftware.service.geo.PaisFiltro;
import com.massoftware.service.geo.PaisService;
import com.massoftware.model.geo.Provincia;
import com.massoftware.service.geo.ProvinciaFiltro;
import com.massoftware.service.geo.ProvinciaService;
import com.massoftware.model.geo.Ciudad;
import com.massoftware.service.geo.CiudadFiltro;
import com.massoftware.service.geo.CiudadService;
import com.massoftware.model.geo.CodigoPostal;
import com.massoftware.service.geo.CodigoPostalFiltro;
import com.massoftware.service.geo.CodigoPostalService;
import com.massoftware.model.logistica.Transporte;
import com.massoftware.service.logistica.TransporteFiltro;
import com.massoftware.service.logistica.TransporteService;
import com.massoftware.model.logistica.Carga;
import com.massoftware.service.logistica.CargaFiltro;
import com.massoftware.service.logistica.CargaService;
import com.massoftware.model.logistica.TransporteTarifa;
import com.massoftware.service.logistica.TransporteTarifaFiltro;
import com.massoftware.service.logistica.TransporteTarifaService;
import com.massoftware.model.afip.TipoDocumentoAFIP;
import com.massoftware.service.afip.TipoDocumentoAFIPFiltro;
import com.massoftware.service.afip.TipoDocumentoAFIPService;
import com.massoftware.model.afip.MonedaAFIP;
import com.massoftware.service.afip.MonedaAFIPFiltro;
import com.massoftware.service.afip.MonedaAFIPService;
import com.massoftware.model.monedas.Moneda;
import com.massoftware.service.monedas.MonedaFiltro;
import com.massoftware.service.monedas.MonedaService;
import com.massoftware.model.contabilidad.ventas.NotaCreditoMotivo;
import com.massoftware.service.contabilidad.ventas.NotaCreditoMotivoFiltro;
import com.massoftware.service.contabilidad.ventas.NotaCreditoMotivoService;
import com.massoftware.model.clientes.MotivoComentario;
import com.massoftware.service.clientes.MotivoComentarioFiltro;
import com.massoftware.service.clientes.MotivoComentarioService;
import com.massoftware.model.clientes.TipoCliente;
import com.massoftware.service.clientes.TipoClienteFiltro;
import com.massoftware.service.clientes.TipoClienteService;
import com.massoftware.model.clientes.ClasificacionCliente;
import com.massoftware.service.clientes.ClasificacionClienteFiltro;
import com.massoftware.service.clientes.ClasificacionClienteService;
import com.massoftware.model.clientes.MotivoBloqueoCliente;
import com.massoftware.service.clientes.MotivoBloqueoClienteFiltro;
import com.massoftware.service.clientes.MotivoBloqueoClienteService;
import com.massoftware.model.empresa.TipoSucursal;
import com.massoftware.service.empresa.TipoSucursalFiltro;
import com.massoftware.service.empresa.TipoSucursalService;
import com.massoftware.model.empresa.Sucursal;
import com.massoftware.service.empresa.SucursalFiltro;
import com.massoftware.service.empresa.SucursalService;
import com.massoftware.model.empresa.DepositoModulo;
import com.massoftware.service.empresa.DepositoModuloFiltro;
import com.massoftware.service.empresa.DepositoModuloService;
import com.massoftware.model.empresa.Deposito;
import com.massoftware.service.empresa.DepositoFiltro;
import com.massoftware.service.empresa.DepositoService;

public class Populate {

	static int maxRows = 300;

	public static void main(String[] args) throws Exception {
			//insertUsuario();
			//insertSeguridadModulo();
			//insertSeguridadPuerta();
			//insertZona();
			//insertPais();
			//insertProvincia();
			//insertCiudad();
			//insertCodigoPostal();
			//insertTransporte();
			//insertCarga();
			//insertTransporteTarifa();
			//insertTipoDocumentoAFIP();
			//insertMonedaAFIP();
			//insertMoneda();
			//insertNotaCreditoMotivo();
			//insertMotivoComentario();
			//insertTipoCliente();
			//insertClasificacionCliente();
			//insertMotivoBloqueoCliente();
			insertTipoSucursal();
			insertSucursal();
			insertDepositoModulo();
			insertDeposito();
	}


	public static void insertUsuario() throws Exception {

		UsuarioService service = AppCX.services().buildUsuarioService();

		for(int i = 0; i < maxRows; i++){

			try {

				Usuario obj = new Usuario();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertSeguridadModulo() throws Exception {

		SeguridadModuloService service = AppCX.services().buildSeguridadModuloService();

		for(int i = 0; i < maxRows; i++){

			try {

				SeguridadModulo obj = new SeguridadModulo();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertSeguridadPuerta() throws Exception {

		SeguridadPuertaService service = AppCX.services().buildSeguridadPuertaService();
		SeguridadModuloService serviceseguridadModulo = AppCX.services().buildSeguridadModuloService();
		Long seguridadModuloCount = serviceseguridadModulo.count();

		for(int i = 0; i < maxRows; i++){

			try {

				SeguridadPuerta obj = new SeguridadPuerta();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				obj.setEquate(UtilPopulate.getStringRandom(null, 30, true));

				SeguridadModuloFiltro seguridadModuloFiltro = new SeguridadModuloFiltro();
				long seguridadModuloIndex = UtilPopulate.getLongRandom(0L, seguridadModuloCount-1);
				seguridadModuloFiltro.setOffset(seguridadModuloIndex);
				seguridadModuloFiltro.setLimit(1L);
				List<SeguridadModulo> seguridadModuloListado = serviceseguridadModulo.find(seguridadModuloFiltro);
				obj.setSeguridadModulo(seguridadModuloListado.get(0));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertZona() throws Exception {

		ZonaService service = AppCX.services().buildZonaService();

		for(int i = 0; i < maxRows; i++){

			try {

				Zona obj = new Zona();

				obj.setCodigo(UtilPopulate.getStringRandom(null, 3, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				obj.setBonificacion(UtilPopulate.getBigDecimalRandom(new java.math.BigDecimal("0"), new java.math.BigDecimal("99999.9999"), false, 13, 5));

				obj.setRecargo(UtilPopulate.getBigDecimalRandom(new java.math.BigDecimal("0"), new java.math.BigDecimal("99999.9999"), false, 13, 5));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertPais() throws Exception {

		PaisService service = AppCX.services().buildPaisService();

		for(int i = 0; i < maxRows; i++){

			try {

				Pais obj = new Pais();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				obj.setAbreviatura(UtilPopulate.getStringRandom(null, 5, true));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertProvincia() throws Exception {

		ProvinciaService service = AppCX.services().buildProvinciaService();
		PaisService servicepais = AppCX.services().buildPaisService();
		Long paisCount = servicepais.count();

		for(int i = 0; i < maxRows; i++){

			try {

				Provincia obj = new Provincia();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				obj.setAbreviatura(UtilPopulate.getStringRandom(null, 5, true));

				obj.setNumeroAFIP(UtilPopulate.getIntegerRandom(1, null, false));

				obj.setNumeroIngresosBrutos(UtilPopulate.getIntegerRandom(1, null, false));

				obj.setNumeroRENATEA(UtilPopulate.getIntegerRandom(1, null, false));

				PaisFiltro paisFiltro = new PaisFiltro();
				long paisIndex = UtilPopulate.getLongRandom(0L, paisCount-1);
				paisFiltro.setOffset(paisIndex);
				paisFiltro.setLimit(1L);
				List<Pais> paisListado = servicepais.find(paisFiltro);
				obj.setPais(paisListado.get(0));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertCiudad() throws Exception {

		CiudadService service = AppCX.services().buildCiudadService();
		ProvinciaService serviceprovincia = AppCX.services().buildProvinciaService();
		Long provinciaCount = serviceprovincia.count();

		for(int i = 0; i < maxRows; i++){

			try {

				Ciudad obj = new Ciudad();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				obj.setDepartamento(UtilPopulate.getStringRandom(null, 50, false));

				obj.setNumeroAFIP(UtilPopulate.getIntegerRandom(1, null, false));

				ProvinciaFiltro provinciaFiltro = new ProvinciaFiltro();
				long provinciaIndex = UtilPopulate.getLongRandom(0L, provinciaCount-1);
				provinciaFiltro.setOffset(provinciaIndex);
				provinciaFiltro.setLimit(1L);
				List<Provincia> provinciaListado = serviceprovincia.find(provinciaFiltro);
				obj.setProvincia(provinciaListado.get(0));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertCodigoPostal() throws Exception {

		CodigoPostalService service = AppCX.services().buildCodigoPostalService();
		CiudadService serviceciudad = AppCX.services().buildCiudadService();
		Long ciudadCount = serviceciudad.count();

		for(int i = 0; i < maxRows; i++){

			try {

				CodigoPostal obj = new CodigoPostal();

				obj.setCodigo(UtilPopulate.getStringRandom(null, 12, true));

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombreCalle(UtilPopulate.getStringRandom(null, 200, true));

				obj.setNumeroCalle(UtilPopulate.getStringRandom(null, 20, true));

				CiudadFiltro ciudadFiltro = new CiudadFiltro();
				long ciudadIndex = UtilPopulate.getLongRandom(0L, ciudadCount-1);
				ciudadFiltro.setOffset(ciudadIndex);
				ciudadFiltro.setLimit(1L);
				List<Ciudad> ciudadListado = serviceciudad.find(ciudadFiltro);
				obj.setCiudad(ciudadListado.get(0));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertTransporte() throws Exception {

		TransporteService service = AppCX.services().buildTransporteService();
		CodigoPostalService servicecodigoPostal = AppCX.services().buildCodigoPostalService();
		Long codigoPostalCount = servicecodigoPostal.count();

		for(int i = 0; i < maxRows; i++){

			try {

				Transporte obj = new Transporte();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				obj.setCuit(UtilPopulate.getLongRandom(1L, 99999999999L, true));

				obj.setIngresosBrutos(UtilPopulate.getStringRandom(null, 13, false));

				obj.setTelefono(UtilPopulate.getStringRandom(null, 50, false));

				obj.setFax(UtilPopulate.getStringRandom(null, 50, false));

				CodigoPostalFiltro codigoPostalFiltro = new CodigoPostalFiltro();
				long codigoPostalIndex = UtilPopulate.getLongRandom(0L, codigoPostalCount-1);
				codigoPostalFiltro.setOffset(codigoPostalIndex);
				codigoPostalFiltro.setLimit(1L);
				List<CodigoPostal> codigoPostalListado = servicecodigoPostal.find(codigoPostalFiltro);
				obj.setCodigoPostal(codigoPostalListado.get(0));

				obj.setDomicilio(UtilPopulate.getStringRandom(null, 150, false));

				obj.setComentario(UtilPopulate.getStringRandom(null, 300, false));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertCarga() throws Exception {

		CargaService service = AppCX.services().buildCargaService();
		TransporteService servicetransporte = AppCX.services().buildTransporteService();
		Long transporteCount = servicetransporte.count();

		for(int i = 0; i < maxRows; i++){

			try {

				Carga obj = new Carga();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				TransporteFiltro transporteFiltro = new TransporteFiltro();
				long transporteIndex = UtilPopulate.getLongRandom(0L, transporteCount-1);
				transporteFiltro.setOffset(transporteIndex);
				transporteFiltro.setLimit(1L);
				List<Transporte> transporteListado = servicetransporte.find(transporteFiltro);
				obj.setTransporte(transporteListado.get(0));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertTransporteTarifa() throws Exception {

		TransporteTarifaService service = AppCX.services().buildTransporteTarifaService();
		CargaService servicecarga = AppCX.services().buildCargaService();
		Long cargaCount = servicecarga.count();
		CiudadService serviceciudad = AppCX.services().buildCiudadService();
		Long ciudadCount = serviceciudad.count();

		for(int i = 0; i < maxRows; i++){

			try {

				TransporteTarifa obj = new TransporteTarifa();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				CargaFiltro cargaFiltro = new CargaFiltro();
				long cargaIndex = UtilPopulate.getLongRandom(0L, cargaCount-1);
				cargaFiltro.setOffset(cargaIndex);
				cargaFiltro.setLimit(1L);
				List<Carga> cargaListado = servicecarga.find(cargaFiltro);
				obj.setCarga(cargaListado.get(0));

				CiudadFiltro ciudadFiltro = new CiudadFiltro();
				long ciudadIndex = UtilPopulate.getLongRandom(0L, ciudadCount-1);
				ciudadFiltro.setOffset(ciudadIndex);
				ciudadFiltro.setLimit(1L);
				List<Ciudad> ciudadListado = serviceciudad.find(ciudadFiltro);
				obj.setCiudad(ciudadListado.get(0));

				obj.setPrecioFlete(UtilPopulate.getBigDecimalRandom(new java.math.BigDecimal("-9999.9999"), new java.math.BigDecimal("99999.9999"), true, 13, 5));

				obj.setPrecioUnidadFacturacion(UtilPopulate.getBigDecimalRandom(new java.math.BigDecimal("-9999.9999"), new java.math.BigDecimal("99999.9999"), false, 13, 5));

				obj.setPrecioUnidadStock(UtilPopulate.getBigDecimalRandom(new java.math.BigDecimal("-9999.9999"), new java.math.BigDecimal("99999.9999"), false, 13, 5));

				obj.setPrecioBultos(UtilPopulate.getBigDecimalRandom(new java.math.BigDecimal("-9999.9999"), new java.math.BigDecimal("99999.9999"), false, 13, 5));

				obj.setImporteMinimoEntrega(UtilPopulate.getBigDecimalRandom(new java.math.BigDecimal("-9999.9999"), new java.math.BigDecimal("99999.9999"), false, 13, 5));

				obj.setImporteMinimoCarga(UtilPopulate.getBigDecimalRandom(new java.math.BigDecimal("-9999.9999"), new java.math.BigDecimal("99999.9999"), false, 13, 5));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertTipoDocumentoAFIP() throws Exception {

		TipoDocumentoAFIPService service = AppCX.services().buildTipoDocumentoAFIPService();

		for(int i = 0; i < maxRows; i++){

			try {

				TipoDocumentoAFIP obj = new TipoDocumentoAFIP();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertMonedaAFIP() throws Exception {

		MonedaAFIPService service = AppCX.services().buildMonedaAFIPService();

		for(int i = 0; i < maxRows; i++){

			try {

				MonedaAFIP obj = new MonedaAFIP();

				obj.setCodigo(UtilPopulate.getStringRandom(null, 3, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertMoneda() throws Exception {

		MonedaService service = AppCX.services().buildMonedaService();
		MonedaAFIPService servicemonedaAFIP = AppCX.services().buildMonedaAFIPService();
		Long monedaAFIPCount = servicemonedaAFIP.count();

		for(int i = 0; i < maxRows; i++){

			try {

				Moneda obj = new Moneda();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				obj.setAbreviatura(UtilPopulate.getStringRandom(null, 5, true));

				obj.setCotizacion(UtilPopulate.getBigDecimalRandom(new java.math.BigDecimal("-9999.9999"), new java.math.BigDecimal("99999.9999"), true, 13, 5));

				obj.setCotizacionFecha(new java.sql.Timestamp(UtilPopulate.getDateRandom(2000, 2019, true)));

				obj.setControlActualizacion(new Random().nextBoolean());

				MonedaAFIPFiltro monedaAFIPFiltro = new MonedaAFIPFiltro();
				long monedaAFIPIndex = UtilPopulate.getLongRandom(0L, monedaAFIPCount-1);
				monedaAFIPFiltro.setOffset(monedaAFIPIndex);
				monedaAFIPFiltro.setLimit(1L);
				List<MonedaAFIP> monedaAFIPListado = servicemonedaAFIP.find(monedaAFIPFiltro);
				obj.setMonedaAFIP(monedaAFIPListado.get(0));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertNotaCreditoMotivo() throws Exception {

		NotaCreditoMotivoService service = AppCX.services().buildNotaCreditoMotivoService();

		for(int i = 0; i < maxRows; i++){

			try {

				NotaCreditoMotivo obj = new NotaCreditoMotivo();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertMotivoComentario() throws Exception {

		MotivoComentarioService service = AppCX.services().buildMotivoComentarioService();

		for(int i = 0; i < maxRows; i++){

			try {

				MotivoComentario obj = new MotivoComentario();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertTipoCliente() throws Exception {

		TipoClienteService service = AppCX.services().buildTipoClienteService();

		for(int i = 0; i < maxRows; i++){

			try {

				TipoCliente obj = new TipoCliente();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertClasificacionCliente() throws Exception {

		ClasificacionClienteService service = AppCX.services().buildClasificacionClienteService();

		for(int i = 0; i < maxRows; i++){

			try {

				ClasificacionCliente obj = new ClasificacionCliente();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				obj.setColor(UtilPopulate.getIntegerRandom(1, null, true));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertMotivoBloqueoCliente() throws Exception {

		MotivoBloqueoClienteService service = AppCX.services().buildMotivoBloqueoClienteService();
		ClasificacionClienteService serviceclasificacionCliente = AppCX.services().buildClasificacionClienteService();
		Long clasificacionClienteCount = serviceclasificacionCliente.count();

		for(int i = 0; i < maxRows; i++){

			try {

				MotivoBloqueoCliente obj = new MotivoBloqueoCliente();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				ClasificacionClienteFiltro clasificacionClienteFiltro = new ClasificacionClienteFiltro();
				long clasificacionClienteIndex = UtilPopulate.getLongRandom(0L, clasificacionClienteCount-1);
				clasificacionClienteFiltro.setOffset(clasificacionClienteIndex);
				clasificacionClienteFiltro.setLimit(1L);
				List<ClasificacionCliente> clasificacionClienteListado = serviceclasificacionCliente.find(clasificacionClienteFiltro);
				obj.setClasificacionCliente(clasificacionClienteListado.get(0));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertTipoSucursal() throws Exception {

		TipoSucursalService service = AppCX.services().buildTipoSucursalService();

		for(int i = 0; i < maxRows; i++){

			try {

				TipoSucursal obj = new TipoSucursal();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertSucursal() throws Exception {

		SucursalService service = AppCX.services().buildSucursalService();
		TipoSucursalService servicetipoSucursal = AppCX.services().buildTipoSucursalService();
		Long tipoSucursalCount = servicetipoSucursal.count();

		for(int i = 0; i < maxRows; i++){

			try {

				Sucursal obj = new Sucursal();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				obj.setAbreviatura(UtilPopulate.getStringRandom(null, 5, true));

				TipoSucursalFiltro tipoSucursalFiltro = new TipoSucursalFiltro();
				long tipoSucursalIndex = UtilPopulate.getLongRandom(0L, tipoSucursalCount-1);
				tipoSucursalFiltro.setOffset(tipoSucursalIndex);
				tipoSucursalFiltro.setLimit(1L);
				List<TipoSucursal> tipoSucursalListado = servicetipoSucursal.find(tipoSucursalFiltro);
				obj.setTipoSucursal(tipoSucursalListado.get(0));

				obj.setCuentaClientesDesde(UtilPopulate.getStringRandom(null, 7, false));

				obj.setCuentaClientesHasta(UtilPopulate.getStringRandom(null, 7, false));

				obj.setCantidadCaracteresClientes(UtilPopulate.getIntegerRandom(3, 6, true));

				obj.setIdentificacionNumericaClientes(new Random().nextBoolean());

				obj.setPermiteCambiarClientes(new Random().nextBoolean());

				obj.setCuentaProveedoresDesde(UtilPopulate.getStringRandom(null, 6, false));

				obj.setCuentaProveedoresHasta(UtilPopulate.getStringRandom(null, 6, false));

				obj.setCantidadCaracteresProveedores(UtilPopulate.getIntegerRandom(3, 6, true));

				obj.setIdentificacionNumericaProveedores(new Random().nextBoolean());

				obj.setPermiteCambiarProveedores(new Random().nextBoolean());

				obj.setClientesOcacionalesDesde(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setClientesOcacionalesHasta(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNumeroCobranzaDesde(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNumeroCobranzaHasta(UtilPopulate.getIntegerRandom(1, null, true));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertDepositoModulo() throws Exception {

		DepositoModuloService service = AppCX.services().buildDepositoModuloService();

		for(int i = 0; i < maxRows; i++){

			try {

				DepositoModulo obj = new DepositoModulo();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertDeposito() throws Exception {

		DepositoService service = AppCX.services().buildDepositoService();
		SucursalService servicesucursal = AppCX.services().buildSucursalService();
		Long sucursalCount = servicesucursal.count();
		DepositoModuloService servicedepositoModulo = AppCX.services().buildDepositoModuloService();
		Long depositoModuloCount = servicedepositoModulo.count();
		SeguridadPuertaService servicepuertaOperativo = AppCX.services().buildSeguridadPuertaService();
		Long puertaOperativoCount = servicepuertaOperativo.count();
		SeguridadPuertaService servicepuertaConsulta = AppCX.services().buildSeguridadPuertaService();
		Long puertaConsultaCount = servicepuertaConsulta.count();

		for(int i = 0; i < maxRows; i++){

			try {

				Deposito obj = new Deposito();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				obj.setAbreviatura(UtilPopulate.getStringRandom(null, 5, true));

				SucursalFiltro sucursalFiltro = new SucursalFiltro();
				long sucursalIndex = UtilPopulate.getLongRandom(0L, sucursalCount-1);
				sucursalFiltro.setOffset(sucursalIndex);
				sucursalFiltro.setLimit(1L);
				List<Sucursal> sucursalListado = servicesucursal.find(sucursalFiltro);
				obj.setSucursal(sucursalListado.get(0));

				DepositoModuloFiltro depositoModuloFiltro = new DepositoModuloFiltro();
				long depositoModuloIndex = UtilPopulate.getLongRandom(0L, depositoModuloCount-1);
				depositoModuloFiltro.setOffset(depositoModuloIndex);
				depositoModuloFiltro.setLimit(1L);
				List<DepositoModulo> depositoModuloListado = servicedepositoModulo.find(depositoModuloFiltro);
				obj.setDepositoModulo(depositoModuloListado.get(0));

				SeguridadPuertaFiltro puertaOperativoFiltro = new SeguridadPuertaFiltro();
				long puertaOperativoIndex = UtilPopulate.getLongRandom(0L, puertaOperativoCount-1);
				puertaOperativoFiltro.setOffset(puertaOperativoIndex);
				puertaOperativoFiltro.setLimit(1L);
				List<SeguridadPuerta> puertaOperativoListado = servicepuertaOperativo.find(puertaOperativoFiltro);
				obj.setPuertaOperativo(puertaOperativoListado.get(0));

				SeguridadPuertaFiltro puertaConsultaFiltro = new SeguridadPuertaFiltro();
				long puertaConsultaIndex = UtilPopulate.getLongRandom(0L, puertaConsultaCount-1);
				puertaConsultaFiltro.setOffset(puertaConsultaIndex);
				puertaConsultaFiltro.setLimit(1L);
				List<SeguridadPuerta> puertaConsultaListado = servicepuertaConsulta.find(puertaConsultaFiltro);
				obj.setPuertaConsulta(puertaConsultaListado.get(0));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}


}