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
import com.massoftware.model.monedas.Moneda;
import com.massoftware.service.monedas.MonedaFiltro;
import com.massoftware.service.monedas.MonedaService;
import com.massoftware.model.monedas.MonedaCotizacion;
import com.massoftware.service.monedas.MonedaCotizacionFiltro;
import com.massoftware.service.monedas.MonedaCotizacionService;
import com.massoftware.model.fondos.banco.Banco;
import com.massoftware.service.fondos.banco.BancoFiltro;
import com.massoftware.service.fondos.banco.BancoService;
import com.massoftware.model.fondos.banco.BancoFirmante;
import com.massoftware.service.fondos.banco.BancoFirmanteFiltro;
import com.massoftware.service.fondos.banco.BancoFirmanteService;
import com.massoftware.model.fondos.Caja;
import com.massoftware.service.fondos.CajaFiltro;
import com.massoftware.service.fondos.CajaService;
import com.massoftware.model.fondos.CuentaFondoTipo;
import com.massoftware.service.fondos.CuentaFondoTipoFiltro;
import com.massoftware.service.fondos.CuentaFondoTipoService;
import com.massoftware.model.fondos.CuentaFondoRubro;
import com.massoftware.service.fondos.CuentaFondoRubroFiltro;
import com.massoftware.service.fondos.CuentaFondoRubroService;
import com.massoftware.model.fondos.CuentaFondoGrupo;
import com.massoftware.service.fondos.CuentaFondoGrupoFiltro;
import com.massoftware.service.fondos.CuentaFondoGrupoService;
import com.massoftware.model.fondos.CuentaFondoTipoBanco;
import com.massoftware.service.fondos.CuentaFondoTipoBancoFiltro;
import com.massoftware.service.fondos.CuentaFondoTipoBancoService;
import com.massoftware.model.fondos.CuentaFondoBancoCopia;
import com.massoftware.service.fondos.CuentaFondoBancoCopiaFiltro;
import com.massoftware.service.fondos.CuentaFondoBancoCopiaService;
import com.massoftware.model.fondos.CuentaFondo;
import com.massoftware.service.fondos.CuentaFondoFiltro;
import com.massoftware.service.fondos.CuentaFondoService;
import com.massoftware.model.fondos.ComprobanteFondoModelo;
import com.massoftware.service.fondos.ComprobanteFondoModeloFiltro;
import com.massoftware.service.fondos.ComprobanteFondoModeloService;
import com.massoftware.model.fondos.ComprobanteFondoModeloItem;
import com.massoftware.service.fondos.ComprobanteFondoModeloItemFiltro;
import com.massoftware.service.fondos.ComprobanteFondoModeloItemService;
import com.massoftware.model.fondos.TalonarioLetra;
import com.massoftware.service.fondos.TalonarioLetraFiltro;
import com.massoftware.service.fondos.TalonarioLetraService;
import com.massoftware.model.fondos.TalonarioControladorFizcal;
import com.massoftware.service.fondos.TalonarioControladorFizcalFiltro;
import com.massoftware.service.fondos.TalonarioControladorFizcalService;
import com.massoftware.model.fondos.Talonario;
import com.massoftware.service.fondos.TalonarioFiltro;
import com.massoftware.service.fondos.TalonarioService;
import com.massoftware.model.fondos.TicketControlDenunciados;
import com.massoftware.service.fondos.TicketControlDenunciadosFiltro;
import com.massoftware.service.fondos.TicketControlDenunciadosService;
import com.massoftware.model.fondos.Ticket;
import com.massoftware.service.fondos.TicketFiltro;
import com.massoftware.service.fondos.TicketService;
import com.massoftware.model.fondos.TicketModelo;
import com.massoftware.service.fondos.TicketModeloFiltro;
import com.massoftware.service.fondos.TicketModeloService;
import com.massoftware.model.fondos.JuridiccionConvnioMultilateral;
import com.massoftware.service.fondos.JuridiccionConvnioMultilateralFiltro;
import com.massoftware.service.fondos.JuridiccionConvnioMultilateralService;
import com.massoftware.model.fondos.Chequera;
import com.massoftware.service.fondos.ChequeraFiltro;
import com.massoftware.service.fondos.ChequeraService;
import com.massoftware.model.fondos.TipoComprobanteConcepto;
import com.massoftware.service.fondos.TipoComprobanteConceptoFiltro;
import com.massoftware.service.fondos.TipoComprobanteConceptoService;
import com.massoftware.model.fondos.ClaseComprobante;
import com.massoftware.service.fondos.ClaseComprobanteFiltro;
import com.massoftware.service.fondos.ClaseComprobanteService;
import com.massoftware.model.fondos.ComportamientoComprobante;
import com.massoftware.service.fondos.ComportamientoComprobanteFiltro;
import com.massoftware.service.fondos.ComportamientoComprobanteService;
import com.massoftware.model.fondos.TipoComprobanteCopia;
import com.massoftware.service.fondos.TipoComprobanteCopiaFiltro;
import com.massoftware.service.fondos.TipoComprobanteCopiaService;
import com.massoftware.model.fondos.TipoComprobanteCopiaAlternativo;
import com.massoftware.service.fondos.TipoComprobanteCopiaAlternativoFiltro;
import com.massoftware.service.fondos.TipoComprobanteCopiaAlternativoService;

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
			//insertMoneda();
			//insertMonedaCotizacion();
			//insertBanco();
			//insertBancoFirmante();
			//insertCaja();
			//insertCuentaFondoTipo();
			//insertCuentaFondoRubro();
			//insertCuentaFondoGrupo();
			//insertCuentaFondoTipoBanco();
			//insertCuentaFondoBancoCopia();
			//insertCuentaFondo();
			//insertComprobanteFondoModelo();
			//insertComprobanteFondoModeloItem();
			//insertTalonarioLetra();
			//insertTalonarioControladorFizcal();
			//insertTalonario();
			//insertTicketControlDenunciados();
			//insertTicket();
			//insertTicketModelo();
			//insertJuridiccionConvnioMultilateral();
			//insertChequera();
			//insertTipoComprobanteConcepto();
			//insertClaseComprobante();
			//insertComportamientoComprobante();
			insertTipoComprobanteCopia();
			insertTipoComprobanteCopiaAlternativo();
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



	public static void insertMonedaCotizacion() throws Exception {

		MonedaCotizacionService service = AppCX.services().buildMonedaCotizacionService();
		MonedaService servicemoneda = AppCX.services().buildMonedaService();
		Long monedaCount = servicemoneda.count();
		UsuarioService serviceusuario = AppCX.services().buildUsuarioService();
		Long usuarioCount = serviceusuario.count();

		for(int i = 0; i < maxRows; i++){

			try {

				MonedaCotizacion obj = new MonedaCotizacion();

				obj.setCotizacionFecha(new java.sql.Timestamp(UtilPopulate.getDateRandom(2000, 2019, true)));

				obj.setCompra(UtilPopulate.getBigDecimalRandom(new java.math.BigDecimal("-9999.9999"), new java.math.BigDecimal("99999.9999"), true, 13, 5));

				obj.setVenta(UtilPopulate.getBigDecimalRandom(new java.math.BigDecimal("-9999.9999"), new java.math.BigDecimal("99999.9999"), true, 13, 5));

				obj.setCotizacionFechaAuditoria(new java.sql.Timestamp(UtilPopulate.getDateRandom(2000, 2019, true)));

				MonedaFiltro monedaFiltro = new MonedaFiltro();
				long monedaIndex = UtilPopulate.getLongRandom(0L, monedaCount-1);
				monedaFiltro.setOffset(monedaIndex);
				monedaFiltro.setLimit(1L);
				List<Moneda> monedaListado = servicemoneda.find(monedaFiltro);
				obj.setMoneda(monedaListado.get(0));

				UsuarioFiltro usuarioFiltro = new UsuarioFiltro();
				long usuarioIndex = UtilPopulate.getLongRandom(0L, usuarioCount-1);
				usuarioFiltro.setOffset(usuarioIndex);
				usuarioFiltro.setLimit(1L);
				List<Usuario> usuarioListado = serviceusuario.find(usuarioFiltro);
				obj.setUsuario(usuarioListado.get(0));

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



	public static void insertCaja() throws Exception {

		CajaService service = AppCX.services().buildCajaService();
		SeguridadPuertaService serviceseguridadPuerta = AppCX.services().buildSeguridadPuertaService();
		Long seguridadPuertaCount = serviceseguridadPuerta.count();

		for(int i = 0; i < maxRows; i++){

			try {

				Caja obj = new Caja();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

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



	public static void insertCuentaFondoTipo() throws Exception {

		CuentaFondoTipoService service = AppCX.services().buildCuentaFondoTipoService();

		for(int i = 0; i < maxRows; i++){

			try {

				CuentaFondoTipo obj = new CuentaFondoTipo();

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



	public static void insertCuentaFondoRubro() throws Exception {

		CuentaFondoRubroService service = AppCX.services().buildCuentaFondoRubroService();

		for(int i = 0; i < maxRows; i++){

			try {

				CuentaFondoRubro obj = new CuentaFondoRubro();

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



	public static void insertCuentaFondoGrupo() throws Exception {

		CuentaFondoGrupoService service = AppCX.services().buildCuentaFondoGrupoService();
		CuentaFondoRubroService servicecuentaFondoRubro = AppCX.services().buildCuentaFondoRubroService();
		Long cuentaFondoRubroCount = servicecuentaFondoRubro.count();

		for(int i = 0; i < maxRows; i++){

			try {

				CuentaFondoGrupo obj = new CuentaFondoGrupo();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				CuentaFondoRubroFiltro cuentaFondoRubroFiltro = new CuentaFondoRubroFiltro();
				long cuentaFondoRubroIndex = UtilPopulate.getLongRandom(0L, cuentaFondoRubroCount-1);
				cuentaFondoRubroFiltro.setOffset(cuentaFondoRubroIndex);
				cuentaFondoRubroFiltro.setLimit(1L);
				List<CuentaFondoRubro> cuentaFondoRubroListado = servicecuentaFondoRubro.find(cuentaFondoRubroFiltro);
				obj.setCuentaFondoRubro(cuentaFondoRubroListado.get(0));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertCuentaFondoTipoBanco() throws Exception {

		CuentaFondoTipoBancoService service = AppCX.services().buildCuentaFondoTipoBancoService();

		for(int i = 0; i < maxRows; i++){

			try {

				CuentaFondoTipoBanco obj = new CuentaFondoTipoBanco();

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



	public static void insertCuentaFondoBancoCopia() throws Exception {

		CuentaFondoBancoCopiaService service = AppCX.services().buildCuentaFondoBancoCopiaService();

		for(int i = 0; i < maxRows; i++){

			try {

				CuentaFondoBancoCopia obj = new CuentaFondoBancoCopia();

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



	public static void insertCuentaFondo() throws Exception {

		CuentaFondoService service = AppCX.services().buildCuentaFondoService();
		CuentaContableService servicecuentaContable = AppCX.services().buildCuentaContableService();
		Long cuentaContableCount = servicecuentaContable.count();
		CuentaFondoGrupoService servicecuentaFondoGrupo = AppCX.services().buildCuentaFondoGrupoService();
		Long cuentaFondoGrupoCount = servicecuentaFondoGrupo.count();
		CuentaFondoTipoService servicecuentaFondoTipo = AppCX.services().buildCuentaFondoTipoService();
		Long cuentaFondoTipoCount = servicecuentaFondoTipo.count();
		MonedaService servicemoneda = AppCX.services().buildMonedaService();
		Long monedaCount = servicemoneda.count();
		CajaService servicecaja = AppCX.services().buildCajaService();
		Long cajaCount = servicecaja.count();
		CuentaFondoTipoBancoService servicecuentaFondoTipoBanco = AppCX.services().buildCuentaFondoTipoBancoService();
		Long cuentaFondoTipoBancoCount = servicecuentaFondoTipoBanco.count();
		BancoService servicebanco = AppCX.services().buildBancoService();
		Long bancoCount = servicebanco.count();
		CuentaFondoBancoCopiaService servicecuentaFondoBancoCopia = AppCX.services().buildCuentaFondoBancoCopiaService();
		Long cuentaFondoBancoCopiaCount = servicecuentaFondoBancoCopia.count();
		SeguridadPuertaService serviceseguridadPuertaUso = AppCX.services().buildSeguridadPuertaService();
		Long seguridadPuertaUsoCount = serviceseguridadPuertaUso.count();
		SeguridadPuertaService serviceseguridadPuertaConsulta = AppCX.services().buildSeguridadPuertaService();
		Long seguridadPuertaConsultaCount = serviceseguridadPuertaConsulta.count();
		SeguridadPuertaService serviceseguridadPuertaLimite = AppCX.services().buildSeguridadPuertaService();
		Long seguridadPuertaLimiteCount = serviceseguridadPuertaLimite.count();

		for(int i = 0; i < maxRows; i++){

			try {

				CuentaFondo obj = new CuentaFondo();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				CuentaContableFiltro cuentaContableFiltro = new CuentaContableFiltro();
				long cuentaContableIndex = UtilPopulate.getLongRandom(0L, cuentaContableCount-1);
				cuentaContableFiltro.setOffset(cuentaContableIndex);
				cuentaContableFiltro.setLimit(1L);
				List<CuentaContable> cuentaContableListado = servicecuentaContable.find(cuentaContableFiltro);
				obj.setCuentaContable(cuentaContableListado.get(0));

				CuentaFondoGrupoFiltro cuentaFondoGrupoFiltro = new CuentaFondoGrupoFiltro();
				long cuentaFondoGrupoIndex = UtilPopulate.getLongRandom(0L, cuentaFondoGrupoCount-1);
				cuentaFondoGrupoFiltro.setOffset(cuentaFondoGrupoIndex);
				cuentaFondoGrupoFiltro.setLimit(1L);
				List<CuentaFondoGrupo> cuentaFondoGrupoListado = servicecuentaFondoGrupo.find(cuentaFondoGrupoFiltro);
				obj.setCuentaFondoGrupo(cuentaFondoGrupoListado.get(0));

				CuentaFondoTipoFiltro cuentaFondoTipoFiltro = new CuentaFondoTipoFiltro();
				long cuentaFondoTipoIndex = UtilPopulate.getLongRandom(0L, cuentaFondoTipoCount-1);
				cuentaFondoTipoFiltro.setOffset(cuentaFondoTipoIndex);
				cuentaFondoTipoFiltro.setLimit(1L);
				List<CuentaFondoTipo> cuentaFondoTipoListado = servicecuentaFondoTipo.find(cuentaFondoTipoFiltro);
				obj.setCuentaFondoTipo(cuentaFondoTipoListado.get(0));

				obj.setObsoleto(new Random().nextBoolean());

				obj.setNoImprimeCaja(new Random().nextBoolean());

				obj.setVentas(new Random().nextBoolean());

				obj.setFondos(new Random().nextBoolean());

				obj.setCompras(new Random().nextBoolean());

				MonedaFiltro monedaFiltro = new MonedaFiltro();
				long monedaIndex = UtilPopulate.getLongRandom(0L, monedaCount-1);
				monedaFiltro.setOffset(monedaIndex);
				monedaFiltro.setLimit(1L);
				List<Moneda> monedaListado = servicemoneda.find(monedaFiltro);
				obj.setMoneda(monedaListado.get(0));

				CajaFiltro cajaFiltro = new CajaFiltro();
				long cajaIndex = UtilPopulate.getLongRandom(0L, cajaCount-1);
				cajaFiltro.setOffset(cajaIndex);
				cajaFiltro.setLimit(1L);
				List<Caja> cajaListado = servicecaja.find(cajaFiltro);
				obj.setCaja(cajaListado.get(0));

				obj.setRechazados(new Random().nextBoolean());

				obj.setConciliacion(new Random().nextBoolean());

				CuentaFondoTipoBancoFiltro cuentaFondoTipoBancoFiltro = new CuentaFondoTipoBancoFiltro();
				long cuentaFondoTipoBancoIndex = UtilPopulate.getLongRandom(0L, cuentaFondoTipoBancoCount-1);
				cuentaFondoTipoBancoFiltro.setOffset(cuentaFondoTipoBancoIndex);
				cuentaFondoTipoBancoFiltro.setLimit(1L);
				List<CuentaFondoTipoBanco> cuentaFondoTipoBancoListado = servicecuentaFondoTipoBanco.find(cuentaFondoTipoBancoFiltro);
				obj.setCuentaFondoTipoBanco(cuentaFondoTipoBancoListado.get(0));

				BancoFiltro bancoFiltro = new BancoFiltro();
				long bancoIndex = UtilPopulate.getLongRandom(0L, bancoCount-1);
				bancoFiltro.setOffset(bancoIndex);
				bancoFiltro.setLimit(1L);
				List<Banco> bancoListado = servicebanco.find(bancoFiltro);
				obj.setBanco(bancoListado.get(0));

				obj.setCuentaBancaria(UtilPopulate.getStringRandom(null, 22, false));

				obj.setCbu(UtilPopulate.getStringRandom(null, 22, false));

				obj.setLimiteDescubierto(UtilPopulate.getBigDecimalRandom(new java.math.BigDecimal("-9999.9999"), new java.math.BigDecimal("99999.9999"), false, 13, 5));

				obj.setCuentaFondoCaucion(UtilPopulate.getStringRandom(null, 50, false));

				obj.setCuentaFondoDiferidos(UtilPopulate.getStringRandom(null, 50, false));

				obj.setFormato(UtilPopulate.getStringRandom(null, 50, false));

				CuentaFondoBancoCopiaFiltro cuentaFondoBancoCopiaFiltro = new CuentaFondoBancoCopiaFiltro();
				long cuentaFondoBancoCopiaIndex = UtilPopulate.getLongRandom(0L, cuentaFondoBancoCopiaCount-1);
				cuentaFondoBancoCopiaFiltro.setOffset(cuentaFondoBancoCopiaIndex);
				cuentaFondoBancoCopiaFiltro.setLimit(1L);
				List<CuentaFondoBancoCopia> cuentaFondoBancoCopiaListado = servicecuentaFondoBancoCopia.find(cuentaFondoBancoCopiaFiltro);
				obj.setCuentaFondoBancoCopia(cuentaFondoBancoCopiaListado.get(0));

				obj.setLimiteOperacionIndividual(UtilPopulate.getBigDecimalRandom(new java.math.BigDecimal("-9999.9999"), new java.math.BigDecimal("99999.9999"), false, 13, 5));

				SeguridadPuertaFiltro seguridadPuertaUsoFiltro = new SeguridadPuertaFiltro();
				long seguridadPuertaUsoIndex = UtilPopulate.getLongRandom(0L, seguridadPuertaUsoCount-1);
				seguridadPuertaUsoFiltro.setOffset(seguridadPuertaUsoIndex);
				seguridadPuertaUsoFiltro.setLimit(1L);
				List<SeguridadPuerta> seguridadPuertaUsoListado = serviceseguridadPuertaUso.find(seguridadPuertaUsoFiltro);
				obj.setSeguridadPuertaUso(seguridadPuertaUsoListado.get(0));

				SeguridadPuertaFiltro seguridadPuertaConsultaFiltro = new SeguridadPuertaFiltro();
				long seguridadPuertaConsultaIndex = UtilPopulate.getLongRandom(0L, seguridadPuertaConsultaCount-1);
				seguridadPuertaConsultaFiltro.setOffset(seguridadPuertaConsultaIndex);
				seguridadPuertaConsultaFiltro.setLimit(1L);
				List<SeguridadPuerta> seguridadPuertaConsultaListado = serviceseguridadPuertaConsulta.find(seguridadPuertaConsultaFiltro);
				obj.setSeguridadPuertaConsulta(seguridadPuertaConsultaListado.get(0));

				SeguridadPuertaFiltro seguridadPuertaLimiteFiltro = new SeguridadPuertaFiltro();
				long seguridadPuertaLimiteIndex = UtilPopulate.getLongRandom(0L, seguridadPuertaLimiteCount-1);
				seguridadPuertaLimiteFiltro.setOffset(seguridadPuertaLimiteIndex);
				seguridadPuertaLimiteFiltro.setLimit(1L);
				List<SeguridadPuerta> seguridadPuertaLimiteListado = serviceseguridadPuertaLimite.find(seguridadPuertaLimiteFiltro);
				obj.setSeguridadPuertaLimite(seguridadPuertaLimiteListado.get(0));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertComprobanteFondoModelo() throws Exception {

		ComprobanteFondoModeloService service = AppCX.services().buildComprobanteFondoModeloService();

		for(int i = 0; i < maxRows; i++){

			try {

				ComprobanteFondoModelo obj = new ComprobanteFondoModelo();

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



	public static void insertComprobanteFondoModeloItem() throws Exception {

		ComprobanteFondoModeloItemService service = AppCX.services().buildComprobanteFondoModeloItemService();
		ComprobanteFondoModeloService servicecomprobanteFondoModelo = AppCX.services().buildComprobanteFondoModeloService();
		Long comprobanteFondoModeloCount = servicecomprobanteFondoModelo.count();
		CuentaFondoService servicecuentaFondo = AppCX.services().buildCuentaFondoService();
		Long cuentaFondoCount = servicecuentaFondo.count();

		for(int i = 0; i < maxRows; i++){

			try {

				ComprobanteFondoModeloItem obj = new ComprobanteFondoModeloItem();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setDebe(new Random().nextBoolean());

				ComprobanteFondoModeloFiltro comprobanteFondoModeloFiltro = new ComprobanteFondoModeloFiltro();
				long comprobanteFondoModeloIndex = UtilPopulate.getLongRandom(0L, comprobanteFondoModeloCount-1);
				comprobanteFondoModeloFiltro.setOffset(comprobanteFondoModeloIndex);
				comprobanteFondoModeloFiltro.setLimit(1L);
				List<ComprobanteFondoModelo> comprobanteFondoModeloListado = servicecomprobanteFondoModelo.find(comprobanteFondoModeloFiltro);
				obj.setComprobanteFondoModelo(comprobanteFondoModeloListado.get(0));

				CuentaFondoFiltro cuentaFondoFiltro = new CuentaFondoFiltro();
				long cuentaFondoIndex = UtilPopulate.getLongRandom(0L, cuentaFondoCount-1);
				cuentaFondoFiltro.setOffset(cuentaFondoIndex);
				cuentaFondoFiltro.setLimit(1L);
				List<CuentaFondo> cuentaFondoListado = servicecuentaFondo.find(cuentaFondoFiltro);
				obj.setCuentaFondo(cuentaFondoListado.get(0));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertTalonarioLetra() throws Exception {

		TalonarioLetraService service = AppCX.services().buildTalonarioLetraService();

		for(int i = 0; i < maxRows; i++){

			try {

				TalonarioLetra obj = new TalonarioLetra();

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertTalonarioControladorFizcal() throws Exception {

		TalonarioControladorFizcalService service = AppCX.services().buildTalonarioControladorFizcalService();

		for(int i = 0; i < maxRows; i++){

			try {

				TalonarioControladorFizcal obj = new TalonarioControladorFizcal();

				obj.setCodigo(UtilPopulate.getStringRandom(null, 10, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertTalonario() throws Exception {

		TalonarioService service = AppCX.services().buildTalonarioService();
		TalonarioLetraService servicetalonarioLetra = AppCX.services().buildTalonarioLetraService();
		Long talonarioLetraCount = servicetalonarioLetra.count();
		TalonarioControladorFizcalService servicetalonarioControladorFizcal = AppCX.services().buildTalonarioControladorFizcalService();
		Long talonarioControladorFizcalCount = servicetalonarioControladorFizcal.count();

		for(int i = 0; i < maxRows; i++){

			try {

				Talonario obj = new Talonario();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				TalonarioLetraFiltro talonarioLetraFiltro = new TalonarioLetraFiltro();
				long talonarioLetraIndex = UtilPopulate.getLongRandom(0L, talonarioLetraCount-1);
				talonarioLetraFiltro.setOffset(talonarioLetraIndex);
				talonarioLetraFiltro.setLimit(1L);
				List<TalonarioLetra> talonarioLetraListado = servicetalonarioLetra.find(talonarioLetraFiltro);
				obj.setTalonarioLetra(talonarioLetraListado.get(0));

				obj.setPuntoVenta(UtilPopulate.getIntegerRandom(1, 9999, true));

				obj.setAutonumeracion(new Random().nextBoolean());

				obj.setNumeracionPreImpresa(new Random().nextBoolean());

				obj.setAsociadoRG10098(new Random().nextBoolean());

				TalonarioControladorFizcalFiltro talonarioControladorFizcalFiltro = new TalonarioControladorFizcalFiltro();
				long talonarioControladorFizcalIndex = UtilPopulate.getLongRandom(0L, talonarioControladorFizcalCount-1);
				talonarioControladorFizcalFiltro.setOffset(talonarioControladorFizcalIndex);
				talonarioControladorFizcalFiltro.setLimit(1L);
				List<TalonarioControladorFizcal> talonarioControladorFizcalListado = servicetalonarioControladorFizcal.find(talonarioControladorFizcalFiltro);
				obj.setTalonarioControladorFizcal(talonarioControladorFizcalListado.get(0));

				obj.setPrimerNumero(UtilPopulate.getIntegerRandom(1, null, false));

				obj.setProximoNumero(UtilPopulate.getIntegerRandom(1, null, false));

				obj.setUltimoNumero(UtilPopulate.getIntegerRandom(1, null, false));

				obj.setCantidadMinimaComprobantes(UtilPopulate.getIntegerRandom(1, null, false));

				obj.setFecha(new java.util.Date(UtilPopulate.getDateRandom(2000, 2019, false)));

				obj.setNumeroCAI(UtilPopulate.getLongRandom(1L, 99999999999999L, false));

				obj.setVencimiento(new java.util.Date(UtilPopulate.getDateRandom(2000, 2019, false)));

				obj.setDiasAvisoVencimiento(UtilPopulate.getIntegerRandom(1, null, false));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertTicketControlDenunciados() throws Exception {

		TicketControlDenunciadosService service = AppCX.services().buildTicketControlDenunciadosService();

		for(int i = 0; i < maxRows; i++){

			try {

				TicketControlDenunciados obj = new TicketControlDenunciados();

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



	public static void insertTicket() throws Exception {

		TicketService service = AppCX.services().buildTicketService();
		TicketControlDenunciadosService serviceticketControlDenunciados = AppCX.services().buildTicketControlDenunciadosService();
		Long ticketControlDenunciadosCount = serviceticketControlDenunciados.count();

		for(int i = 0; i < maxRows; i++){

			try {

				Ticket obj = new Ticket();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				obj.setFechaActualizacion(new java.util.Date(UtilPopulate.getDateRandom(2000, 2019, false)));

				obj.setCantidadPorLotes(UtilPopulate.getIntegerRandom(1, null, false));

				TicketControlDenunciadosFiltro ticketControlDenunciadosFiltro = new TicketControlDenunciadosFiltro();
				long ticketControlDenunciadosIndex = UtilPopulate.getLongRandom(0L, ticketControlDenunciadosCount-1);
				ticketControlDenunciadosFiltro.setOffset(ticketControlDenunciadosIndex);
				ticketControlDenunciadosFiltro.setLimit(1L);
				List<TicketControlDenunciados> ticketControlDenunciadosListado = serviceticketControlDenunciados.find(ticketControlDenunciadosFiltro);
				obj.setTicketControlDenunciados(ticketControlDenunciadosListado.get(0));

				obj.setValorMaximo(UtilPopulate.getBigDecimalRandom(new java.math.BigDecimal("0"), new java.math.BigDecimal("99999.9999"), false, 13, 5));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertTicketModelo() throws Exception {

		TicketModeloService service = AppCX.services().buildTicketModeloService();
		TicketService serviceticket = AppCX.services().buildTicketService();
		Long ticketCount = serviceticket.count();

		for(int i = 0; i < maxRows; i++){

			try {

				TicketModelo obj = new TicketModelo();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				TicketFiltro ticketFiltro = new TicketFiltro();
				long ticketIndex = UtilPopulate.getLongRandom(0L, ticketCount-1);
				ticketFiltro.setOffset(ticketIndex);
				ticketFiltro.setLimit(1L);
				List<Ticket> ticketListado = serviceticket.find(ticketFiltro);
				obj.setTicket(ticketListado.get(0));

				obj.setPruebaLectura(UtilPopulate.getStringRandom(null, 50, false));

				obj.setActivo(new Random().nextBoolean());

				obj.setLongitudLectura(UtilPopulate.getIntegerRandom(0, null, false));

				obj.setIdentificacionPosicion(UtilPopulate.getIntegerRandom(0, null, false));

				obj.setIdentificacion(UtilPopulate.getIntegerRandom(0, null, false));

				obj.setImportePosicion(UtilPopulate.getIntegerRandom(0, null, false));

				obj.setLongitud(UtilPopulate.getIntegerRandom(0, null, false));

				obj.setCantidadDecimales(UtilPopulate.getIntegerRandom(0, null, false));

				obj.setNumeroPosicion(UtilPopulate.getIntegerRandom(0, null, false));

				obj.setNumeroLongitud(UtilPopulate.getIntegerRandom(0, null, false));

				obj.setPrefijoIdentificacion(UtilPopulate.getStringRandom(null, 10, false));

				obj.setPosicionPrefijo(UtilPopulate.getIntegerRandom(0, null, false));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertJuridiccionConvnioMultilateral() throws Exception {

		JuridiccionConvnioMultilateralService service = AppCX.services().buildJuridiccionConvnioMultilateralService();
		CuentaFondoService servicecuentaFondo = AppCX.services().buildCuentaFondoService();
		Long cuentaFondoCount = servicecuentaFondo.count();

		for(int i = 0; i < maxRows; i++){

			try {

				JuridiccionConvnioMultilateral obj = new JuridiccionConvnioMultilateral();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				CuentaFondoFiltro cuentaFondoFiltro = new CuentaFondoFiltro();
				long cuentaFondoIndex = UtilPopulate.getLongRandom(0L, cuentaFondoCount-1);
				cuentaFondoFiltro.setOffset(cuentaFondoIndex);
				cuentaFondoFiltro.setLimit(1L);
				List<CuentaFondo> cuentaFondoListado = servicecuentaFondo.find(cuentaFondoFiltro);
				obj.setCuentaFondo(cuentaFondoListado.get(0));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertChequera() throws Exception {

		ChequeraService service = AppCX.services().buildChequeraService();
		CuentaFondoService servicecuentaFondo = AppCX.services().buildCuentaFondoService();
		Long cuentaFondoCount = servicecuentaFondo.count();

		for(int i = 0; i < maxRows; i++){

			try {

				Chequera obj = new Chequera();

				obj.setNumero(UtilPopulate.getIntegerRandom(1, null, true));

				obj.setNombre(UtilPopulate.getStringRandom(null, 50, true));

				CuentaFondoFiltro cuentaFondoFiltro = new CuentaFondoFiltro();
				long cuentaFondoIndex = UtilPopulate.getLongRandom(0L, cuentaFondoCount-1);
				cuentaFondoFiltro.setOffset(cuentaFondoIndex);
				cuentaFondoFiltro.setLimit(1L);
				List<CuentaFondo> cuentaFondoListado = servicecuentaFondo.find(cuentaFondoFiltro);
				obj.setCuentaFondo(cuentaFondoListado.get(0));

				obj.setPrimerNumero(UtilPopulate.getIntegerRandom(0, null, false));

				obj.setUltimoNumero(UtilPopulate.getIntegerRandom(0, null, false));

				obj.setProximoNumero(UtilPopulate.getIntegerRandom(0, null, false));

				obj.setBloqueado(new Random().nextBoolean());

				obj.setImpresionDiferida(new Random().nextBoolean());

				obj.setFormato(UtilPopulate.getStringRandom(null, 50, false));

				service.insert(obj);

			} catch (org.cendra.jdbc.SQLExceptionWrapper e) {

				if(("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) || "23514".equals(e.getSQLState()) ) == false ) {	

					throw e;

				}

			}

		}

	}



	public static void insertTipoComprobanteConcepto() throws Exception {

		TipoComprobanteConceptoService service = AppCX.services().buildTipoComprobanteConceptoService();

		for(int i = 0; i < maxRows; i++){

			try {

				TipoComprobanteConcepto obj = new TipoComprobanteConcepto();

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



	public static void insertClaseComprobante() throws Exception {

		ClaseComprobanteService service = AppCX.services().buildClaseComprobanteService();

		for(int i = 0; i < maxRows; i++){

			try {

				ClaseComprobante obj = new ClaseComprobante();

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



	public static void insertComportamientoComprobante() throws Exception {

		ComportamientoComprobanteService service = AppCX.services().buildComportamientoComprobanteService();

		for(int i = 0; i < maxRows; i++){

			try {

				ComportamientoComprobante obj = new ComportamientoComprobante();

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



	public static void insertTipoComprobanteCopia() throws Exception {

		TipoComprobanteCopiaService service = AppCX.services().buildTipoComprobanteCopiaService();

		for(int i = 0; i < maxRows; i++){

			try {

				TipoComprobanteCopia obj = new TipoComprobanteCopia();

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



	public static void insertTipoComprobanteCopiaAlternativo() throws Exception {

		TipoComprobanteCopiaAlternativoService service = AppCX.services().buildTipoComprobanteCopiaAlternativoService();

		for(int i = 0; i < maxRows; i++){

			try {

				TipoComprobanteCopiaAlternativo obj = new TipoComprobanteCopiaAlternativo();

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


}