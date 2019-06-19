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
import com.massoftware.model.contabilidad.EjercicioContable;
import com.massoftware.service.contabilidad.EjercicioContableFiltro;
import com.massoftware.service.contabilidad.EjercicioContableService;
import com.massoftware.model.contabilidad.CentroCostoContable;
import com.massoftware.service.contabilidad.CentroCostoContableFiltro;
import com.massoftware.service.contabilidad.CentroCostoContableService;
import com.massoftware.model.contabilidad.TipoPuntoEquilibrio;
import com.massoftware.service.contabilidad.TipoPuntoEquilibrioFiltro;
import com.massoftware.service.contabilidad.TipoPuntoEquilibrioService;
import com.massoftware.model.contabilidad.PuntoEquilibrio;
import com.massoftware.service.contabilidad.PuntoEquilibrioFiltro;
import com.massoftware.service.contabilidad.PuntoEquilibrioService;
import com.massoftware.model.contabilidad.CostoVenta;
import com.massoftware.service.contabilidad.CostoVentaFiltro;
import com.massoftware.service.contabilidad.CostoVentaService;
import com.massoftware.model.contabilidad.CuentaContableEstado;
import com.massoftware.service.contabilidad.CuentaContableEstadoFiltro;
import com.massoftware.service.contabilidad.CuentaContableEstadoService;
import com.massoftware.model.contabilidad.CuentaContable;
import com.massoftware.service.contabilidad.CuentaContableFiltro;
import com.massoftware.service.contabilidad.CuentaContableService;
import com.massoftware.model.contabilidad.AsientoModelo;
import com.massoftware.service.contabilidad.AsientoModeloFiltro;
import com.massoftware.service.contabilidad.AsientoModeloService;
import com.massoftware.model.contabilidad.AsientoModeloItem;
import com.massoftware.service.contabilidad.AsientoModeloItemFiltro;
import com.massoftware.service.contabilidad.AsientoModeloItemService;
import com.massoftware.model.contabilidad.MinutaContable;
import com.massoftware.service.contabilidad.MinutaContableFiltro;
import com.massoftware.service.contabilidad.MinutaContableService;
import com.massoftware.model.contabilidad.AsientoContableModulo;
import com.massoftware.service.contabilidad.AsientoContableModuloFiltro;
import com.massoftware.service.contabilidad.AsientoContableModuloService;
import com.massoftware.model.contabilidad.AsientoContable;
import com.massoftware.service.contabilidad.AsientoContableFiltro;
import com.massoftware.service.contabilidad.AsientoContableService;
import com.massoftware.model.contabilidad.AsientoContableItem;
import com.massoftware.service.contabilidad.AsientoContableItemFiltro;
import com.massoftware.service.contabilidad.AsientoContableItemService;
import com.massoftware.model.empresa.Empresa;
import com.massoftware.service.empresa.EmpresaFiltro;
import com.massoftware.service.empresa.EmpresaService;
import com.massoftware.model.fondos.banco.Banco;
import com.massoftware.service.fondos.banco.BancoFiltro;
import com.massoftware.service.fondos.banco.BancoService;
import com.massoftware.model.fondos.banco.BancoFirmante;
import com.massoftware.service.fondos.banco.BancoFirmanteFiltro;
import com.massoftware.service.fondos.banco.BancoFirmanteService;

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
			//insertTipoSucursal();
			//insertSucursal();
			//insertDepositoModulo();
			//insertDeposito();
			//insertEjercicioContable();
			//insertCentroCostoContable();
			//insertTipoPuntoEquilibrio();
			//insertPuntoEquilibrio();
			//insertCostoVenta();
			//insertCuentaContableEstado();
			//insertCuentaContable();
			//insertAsientoModelo();
			//insertAsientoModeloItem();
			//insertMinutaContable();
			//insertAsientoContableModulo();
			//insertAsientoContable();
			//insertAsientoContableItem();
			//insertEmpresa();
			//insertBanco();
			//insertBancoFirmante();
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



	public static void insertEjercicioContable() throws Exception {

		EjercicioContableService service = AppCX.services().buildEjercicioContableService();

		for(int i = 0; i < maxRows; i++){

			try {

				EjercicioContable obj = new EjercicioContable();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setApertura(new java.util.Date(UtilPopulate.getDateRandom(2000, 2019, true)));

				obj.setCierre(new java.util.Date(UtilPopulate.getDateRandom(2000, 2019, true)));

				obj.setCerrado(new Random().nextBoolean());

				obj.setCerradoModulos(new Random().nextBoolean());

				obj.setComentario(UtilPopulate.getStringRandom(null, 250, false));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertCentroCostoContable() throws Exception {

		CentroCostoContableService service = AppCX.services().buildCentroCostoContableService();
		EjercicioContableService serviceejercicioContable = AppCX.services().buildEjercicioContableService();
		Long ejercicioContableCount = serviceejercicioContable.count();

		for(int i = 0; i < maxRows; i++){

			try {

				CentroCostoContable obj = new CentroCostoContable();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				obj.setAbreviatura(UtilPopulate.getStringRandom(null, 5, true));

				EjercicioContableFiltro ejercicioContableFiltro = new EjercicioContableFiltro();
				long ejercicioContableIndex = UtilPopulate.getLongRandom(0L, ejercicioContableCount-1);
				ejercicioContableFiltro.setOffset(ejercicioContableIndex);
				ejercicioContableFiltro.setLimit(1L);
				List<EjercicioContable> ejercicioContableListado = serviceejercicioContable.find(ejercicioContableFiltro);
				obj.setEjercicioContable(ejercicioContableListado.get(0));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertTipoPuntoEquilibrio() throws Exception {

		TipoPuntoEquilibrioService service = AppCX.services().buildTipoPuntoEquilibrioService();

		for(int i = 0; i < maxRows; i++){

			try {

				TipoPuntoEquilibrio obj = new TipoPuntoEquilibrio();

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



	public static void insertPuntoEquilibrio() throws Exception {

		PuntoEquilibrioService service = AppCX.services().buildPuntoEquilibrioService();
		TipoPuntoEquilibrioService servicetipoPuntoEquilibrio = AppCX.services().buildTipoPuntoEquilibrioService();
		Long tipoPuntoEquilibrioCount = servicetipoPuntoEquilibrio.count();
		EjercicioContableService serviceejercicioContable = AppCX.services().buildEjercicioContableService();
		Long ejercicioContableCount = serviceejercicioContable.count();

		for(int i = 0; i < maxRows; i++){

			try {

				PuntoEquilibrio obj = new PuntoEquilibrio();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				TipoPuntoEquilibrioFiltro tipoPuntoEquilibrioFiltro = new TipoPuntoEquilibrioFiltro();
				long tipoPuntoEquilibrioIndex = UtilPopulate.getLongRandom(0L, tipoPuntoEquilibrioCount-1);
				tipoPuntoEquilibrioFiltro.setOffset(tipoPuntoEquilibrioIndex);
				tipoPuntoEquilibrioFiltro.setLimit(1L);
				List<TipoPuntoEquilibrio> tipoPuntoEquilibrioListado = servicetipoPuntoEquilibrio.find(tipoPuntoEquilibrioFiltro);
				obj.setTipoPuntoEquilibrio(tipoPuntoEquilibrioListado.get(0));

				EjercicioContableFiltro ejercicioContableFiltro = new EjercicioContableFiltro();
				long ejercicioContableIndex = UtilPopulate.getLongRandom(0L, ejercicioContableCount-1);
				ejercicioContableFiltro.setOffset(ejercicioContableIndex);
				ejercicioContableFiltro.setLimit(1L);
				List<EjercicioContable> ejercicioContableListado = serviceejercicioContable.find(ejercicioContableFiltro);
				obj.setEjercicioContable(ejercicioContableListado.get(0));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertCostoVenta() throws Exception {

		CostoVentaService service = AppCX.services().buildCostoVentaService();

		for(int i = 0; i < maxRows; i++){

			try {

				CostoVenta obj = new CostoVenta();

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



	public static void insertCuentaContableEstado() throws Exception {

		CuentaContableEstadoService service = AppCX.services().buildCuentaContableEstadoService();

		for(int i = 0; i < maxRows; i++){

			try {

				CuentaContableEstado obj = new CuentaContableEstado();

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



	public static void insertCuentaContable() throws Exception {

		CuentaContableService service = AppCX.services().buildCuentaContableService();
		EjercicioContableService serviceejercicioContable = AppCX.services().buildEjercicioContableService();
		Long ejercicioContableCount = serviceejercicioContable.count();
		CuentaContableEstadoService servicecuentaContableEstado = AppCX.services().buildCuentaContableEstadoService();
		Long cuentaContableEstadoCount = servicecuentaContableEstado.count();
		CentroCostoContableService servicecentroCostoContable = AppCX.services().buildCentroCostoContableService();
		Long centroCostoContableCount = servicecentroCostoContable.count();
		PuntoEquilibrioService servicepuntoEquilibrio = AppCX.services().buildPuntoEquilibrioService();
		Long puntoEquilibrioCount = servicepuntoEquilibrio.count();
		CostoVentaService servicecostoVenta = AppCX.services().buildCostoVentaService();
		Long costoVentaCount = servicecostoVenta.count();
		SeguridadPuertaService serviceseguridadPuerta = AppCX.services().buildSeguridadPuertaService();
		Long seguridadPuertaCount = serviceseguridadPuerta.count();

		for(int i = 0; i < maxRows; i++){

			try {

				CuentaContable obj = new CuentaContable();

				obj.setCodigo(UtilPopulate.getStringRandom(null, 11, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				EjercicioContableFiltro ejercicioContableFiltro = new EjercicioContableFiltro();
				long ejercicioContableIndex = UtilPopulate.getLongRandom(0L, ejercicioContableCount-1);
				ejercicioContableFiltro.setOffset(ejercicioContableIndex);
				ejercicioContableFiltro.setLimit(1L);
				List<EjercicioContable> ejercicioContableListado = serviceejercicioContable.find(ejercicioContableFiltro);
				obj.setEjercicioContable(ejercicioContableListado.get(0));

				obj.setIntegra(UtilPopulate.getStringRandom(16, 16, true));

				obj.setCuentaJerarquia(UtilPopulate.getStringRandom(16, 16, true));

				obj.setImputable(new Random().nextBoolean());

				obj.setAjustaPorInflacion(new Random().nextBoolean());

				CuentaContableEstadoFiltro cuentaContableEstadoFiltro = new CuentaContableEstadoFiltro();
				long cuentaContableEstadoIndex = UtilPopulate.getLongRandom(0L, cuentaContableEstadoCount-1);
				cuentaContableEstadoFiltro.setOffset(cuentaContableEstadoIndex);
				cuentaContableEstadoFiltro.setLimit(1L);
				List<CuentaContableEstado> cuentaContableEstadoListado = servicecuentaContableEstado.find(cuentaContableEstadoFiltro);
				obj.setCuentaContableEstado(cuentaContableEstadoListado.get(0));

				obj.setCuentaConApropiacion(new Random().nextBoolean());

				CentroCostoContableFiltro centroCostoContableFiltro = new CentroCostoContableFiltro();
				long centroCostoContableIndex = UtilPopulate.getLongRandom(0L, centroCostoContableCount-1);
				centroCostoContableFiltro.setOffset(centroCostoContableIndex);
				centroCostoContableFiltro.setLimit(1L);
				List<CentroCostoContable> centroCostoContableListado = servicecentroCostoContable.find(centroCostoContableFiltro);
				obj.setCentroCostoContable(centroCostoContableListado.get(0));

				obj.setCuentaAgrupadora(UtilPopulate.getStringRandom(null, 50, false));

				obj.setPorcentaje(UtilPopulate.getBigDecimalRandom(new java.math.BigDecimal("0"), new java.math.BigDecimal("999.99"), false, 6, 3));

				PuntoEquilibrioFiltro puntoEquilibrioFiltro = new PuntoEquilibrioFiltro();
				long puntoEquilibrioIndex = UtilPopulate.getLongRandom(0L, puntoEquilibrioCount-1);
				puntoEquilibrioFiltro.setOffset(puntoEquilibrioIndex);
				puntoEquilibrioFiltro.setLimit(1L);
				List<PuntoEquilibrio> puntoEquilibrioListado = servicepuntoEquilibrio.find(puntoEquilibrioFiltro);
				obj.setPuntoEquilibrio(puntoEquilibrioListado.get(0));

				CostoVentaFiltro costoVentaFiltro = new CostoVentaFiltro();
				long costoVentaIndex = UtilPopulate.getLongRandom(0L, costoVentaCount-1);
				costoVentaFiltro.setOffset(costoVentaIndex);
				costoVentaFiltro.setLimit(1L);
				List<CostoVenta> costoVentaListado = servicecostoVenta.find(costoVentaFiltro);
				obj.setCostoVenta(costoVentaListado.get(0));

				SeguridadPuertaFiltro seguridadPuertaFiltro = new SeguridadPuertaFiltro();
				long seguridadPuertaIndex = UtilPopulate.getLongRandom(0L, seguridadPuertaCount-1);
				seguridadPuertaFiltro.setOffset(seguridadPuertaIndex);
				seguridadPuertaFiltro.setLimit(1L);
				List<SeguridadPuerta> seguridadPuertaListado = serviceseguridadPuerta.find(seguridadPuertaFiltro);
				obj.setSeguridadPuerta(seguridadPuertaListado.get(0));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertAsientoModelo() throws Exception {

		AsientoModeloService service = AppCX.services().buildAsientoModeloService();
		EjercicioContableService serviceejercicioContable = AppCX.services().buildEjercicioContableService();
		Long ejercicioContableCount = serviceejercicioContable.count();

		for(int i = 0; i < maxRows; i++){

			try {

				AsientoModelo obj = new AsientoModelo();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				EjercicioContableFiltro ejercicioContableFiltro = new EjercicioContableFiltro();
				long ejercicioContableIndex = UtilPopulate.getLongRandom(0L, ejercicioContableCount-1);
				ejercicioContableFiltro.setOffset(ejercicioContableIndex);
				ejercicioContableFiltro.setLimit(1L);
				List<EjercicioContable> ejercicioContableListado = serviceejercicioContable.find(ejercicioContableFiltro);
				obj.setEjercicioContable(ejercicioContableListado.get(0));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertAsientoModeloItem() throws Exception {

		AsientoModeloItemService service = AppCX.services().buildAsientoModeloItemService();
		AsientoModeloService serviceasientoModelo = AppCX.services().buildAsientoModeloService();
		Long asientoModeloCount = serviceasientoModelo.count();
		CuentaContableService servicecuentaContable = AppCX.services().buildCuentaContableService();
		Long cuentaContableCount = servicecuentaContable.count();

		for(int i = 0; i < maxRows; i++){

			try {

				AsientoModeloItem obj = new AsientoModeloItem();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				AsientoModeloFiltro asientoModeloFiltro = new AsientoModeloFiltro();
				long asientoModeloIndex = UtilPopulate.getLongRandom(0L, asientoModeloCount-1);
				asientoModeloFiltro.setOffset(asientoModeloIndex);
				asientoModeloFiltro.setLimit(1L);
				List<AsientoModelo> asientoModeloListado = serviceasientoModelo.find(asientoModeloFiltro);
				obj.setAsientoModelo(asientoModeloListado.get(0));

				CuentaContableFiltro cuentaContableFiltro = new CuentaContableFiltro();
				long cuentaContableIndex = UtilPopulate.getLongRandom(0L, cuentaContableCount-1);
				cuentaContableFiltro.setOffset(cuentaContableIndex);
				cuentaContableFiltro.setLimit(1L);
				List<CuentaContable> cuentaContableListado = servicecuentaContable.find(cuentaContableFiltro);
				obj.setCuentaContable(cuentaContableListado.get(0));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertMinutaContable() throws Exception {

		MinutaContableService service = AppCX.services().buildMinutaContableService();

		for(int i = 0; i < maxRows; i++){

			try {

				MinutaContable obj = new MinutaContable();

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



	public static void insertAsientoContableModulo() throws Exception {

		AsientoContableModuloService service = AppCX.services().buildAsientoContableModuloService();

		for(int i = 0; i < maxRows; i++){

			try {

				AsientoContableModulo obj = new AsientoContableModulo();

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



	public static void insertAsientoContable() throws Exception {

		AsientoContableService service = AppCX.services().buildAsientoContableService();
		EjercicioContableService serviceejercicioContable = AppCX.services().buildEjercicioContableService();
		Long ejercicioContableCount = serviceejercicioContable.count();
		MinutaContableService serviceminutaContable = AppCX.services().buildMinutaContableService();
		Long minutaContableCount = serviceminutaContable.count();
		SucursalService servicesucursal = AppCX.services().buildSucursalService();
		Long sucursalCount = servicesucursal.count();
		AsientoContableModuloService serviceasientoContableModulo = AppCX.services().buildAsientoContableModuloService();
		Long asientoContableModuloCount = serviceasientoContableModulo.count();

		for(int i = 0; i < maxRows; i++){

			try {

				AsientoContable obj = new AsientoContable();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setFecha(new java.util.Date(UtilPopulate.getDateRandom(2000, 2019, true)));

				obj.setDetalle(UtilPopulate.getStringRandom(null, 100, false));

				EjercicioContableFiltro ejercicioContableFiltro = new EjercicioContableFiltro();
				long ejercicioContableIndex = UtilPopulate.getLongRandom(0L, ejercicioContableCount-1);
				ejercicioContableFiltro.setOffset(ejercicioContableIndex);
				ejercicioContableFiltro.setLimit(1L);
				List<EjercicioContable> ejercicioContableListado = serviceejercicioContable.find(ejercicioContableFiltro);
				obj.setEjercicioContable(ejercicioContableListado.get(0));

				MinutaContableFiltro minutaContableFiltro = new MinutaContableFiltro();
				long minutaContableIndex = UtilPopulate.getLongRandom(0L, minutaContableCount-1);
				minutaContableFiltro.setOffset(minutaContableIndex);
				minutaContableFiltro.setLimit(1L);
				List<MinutaContable> minutaContableListado = serviceminutaContable.find(minutaContableFiltro);
				obj.setMinutaContable(minutaContableListado.get(0));

				SucursalFiltro sucursalFiltro = new SucursalFiltro();
				long sucursalIndex = UtilPopulate.getLongRandom(0L, sucursalCount-1);
				sucursalFiltro.setOffset(sucursalIndex);
				sucursalFiltro.setLimit(1L);
				List<Sucursal> sucursalListado = servicesucursal.find(sucursalFiltro);
				obj.setSucursal(sucursalListado.get(0));

				AsientoContableModuloFiltro asientoContableModuloFiltro = new AsientoContableModuloFiltro();
				long asientoContableModuloIndex = UtilPopulate.getLongRandom(0L, asientoContableModuloCount-1);
				asientoContableModuloFiltro.setOffset(asientoContableModuloIndex);
				asientoContableModuloFiltro.setLimit(1L);
				List<AsientoContableModulo> asientoContableModuloListado = serviceasientoContableModulo.find(asientoContableModuloFiltro);
				obj.setAsientoContableModulo(asientoContableModuloListado.get(0));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertAsientoContableItem() throws Exception {

		AsientoContableItemService service = AppCX.services().buildAsientoContableItemService();
		AsientoContableService serviceasientoContable = AppCX.services().buildAsientoContableService();
		Long asientoContableCount = serviceasientoContable.count();
		CuentaContableService servicecuentaContable = AppCX.services().buildCuentaContableService();
		Long cuentaContableCount = servicecuentaContable.count();

		for(int i = 0; i < maxRows; i++){

			try {

				AsientoContableItem obj = new AsientoContableItem();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setFecha(new java.util.Date(UtilPopulate.getDateRandom(2000, 2019, true)));

				obj.setDetalle(UtilPopulate.getStringRandom(null, 100, false));

				AsientoContableFiltro asientoContableFiltro = new AsientoContableFiltro();
				long asientoContableIndex = UtilPopulate.getLongRandom(0L, asientoContableCount-1);
				asientoContableFiltro.setOffset(asientoContableIndex);
				asientoContableFiltro.setLimit(1L);
				List<AsientoContable> asientoContableListado = serviceasientoContable.find(asientoContableFiltro);
				obj.setAsientoContable(asientoContableListado.get(0));

				CuentaContableFiltro cuentaContableFiltro = new CuentaContableFiltro();
				long cuentaContableIndex = UtilPopulate.getLongRandom(0L, cuentaContableCount-1);
				cuentaContableFiltro.setOffset(cuentaContableIndex);
				cuentaContableFiltro.setLimit(1L);
				List<CuentaContable> cuentaContableListado = servicecuentaContable.find(cuentaContableFiltro);
				obj.setCuentaContable(cuentaContableListado.get(0));

				obj.setDebe(UtilPopulate.getBigDecimalRandom(null, null, true, 13, 5));

				obj.setHaber(UtilPopulate.getBigDecimalRandom(null, null, true, 13, 5));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertEmpresa() throws Exception {

		EmpresaService service = AppCX.services().buildEmpresaService();
		EjercicioContableService serviceejercicioContable = AppCX.services().buildEjercicioContableService();
		Long ejercicioContableCount = serviceejercicioContable.count();

		for(int i = 0; i < maxRows; i++){

			try {

				Empresa obj = new Empresa();

				EjercicioContableFiltro ejercicioContableFiltro = new EjercicioContableFiltro();
				long ejercicioContableIndex = UtilPopulate.getLongRandom(0L, ejercicioContableCount-1);
				ejercicioContableFiltro.setOffset(ejercicioContableIndex);
				ejercicioContableFiltro.setLimit(1L);
				List<EjercicioContable> ejercicioContableListado = serviceejercicioContable.find(ejercicioContableFiltro);
				obj.setEjercicioContable(ejercicioContableListado.get(0));

				obj.setFechaCierreVentas(new java.util.Date(UtilPopulate.getDateRandom(2000, 2019, false)));

				obj.setFechaCierreStock(new java.util.Date(UtilPopulate.getDateRandom(2000, 2019, false)));

				obj.setFechaCierreFondo(new java.util.Date(UtilPopulate.getDateRandom(2000, 2019, false)));

				obj.setFechaCierreCompras(new java.util.Date(UtilPopulate.getDateRandom(2000, 2019, false)));

				obj.setFechaCierreContabilidad(new java.util.Date(UtilPopulate.getDateRandom(2000, 2019, false)));

				obj.setFechaCierreGarantiaDevoluciones(new java.util.Date(UtilPopulate.getDateRandom(2000, 2019, false)));

				obj.setFechaCierreTambos(new java.util.Date(UtilPopulate.getDateRandom(2000, 2019, false)));

				obj.setFechaCierreRRHH(new java.util.Date(UtilPopulate.getDateRandom(2000, 2019, false)));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertBanco() throws Exception {

		BancoService service = AppCX.services().buildBancoService();

		for(int i = 0; i < maxRows; i++){

			try {

				Banco obj = new Banco();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				obj.setCuit(UtilPopulate.getLongRandom(1L, 99999999999L, true));

				obj.setBloqueado(new Random().nextBoolean());

				obj.setHoja(UtilPopulate.getIntegerRandom(1, 100, false));

				obj.setPrimeraFila(UtilPopulate.getIntegerRandom(1, 1000, false));

				obj.setUltimaFila(UtilPopulate.getIntegerRandom(1, 1000, false));

				obj.setFecha(UtilPopulate.getStringRandom(null, 3, false));

				obj.setDescripcion(UtilPopulate.getStringRandom(null, 3, false));

				obj.setReferencia1(UtilPopulate.getStringRandom(null, 3, false));

				obj.setImporte(UtilPopulate.getStringRandom(null, 3, false));

				obj.setReferencia2(UtilPopulate.getStringRandom(null, 3, false));

				obj.setSaldo(UtilPopulate.getStringRandom(null, 3, false));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertBancoFirmante() throws Exception {

		BancoFirmanteService service = AppCX.services().buildBancoFirmanteService();

		for(int i = 0; i < maxRows; i++){

			try {

				BancoFirmante obj = new BancoFirmante();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				obj.setCargo(UtilPopulate.getStringRandom(null, 50, false));

				obj.setBloqueado(new Random().nextBoolean());

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}


}