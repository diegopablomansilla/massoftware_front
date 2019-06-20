package com.massoftware.service;

import com.massoftware.service.seguridad.UsuarioService;
import com.massoftware.service.seguridad.SeguridadModuloService;
import com.massoftware.service.seguridad.SeguridadPuertaService;
import com.massoftware.service.geo.ZonaService;
import com.massoftware.service.geo.PaisService;
import com.massoftware.service.geo.ProvinciaService;
import com.massoftware.service.geo.CiudadService;
import com.massoftware.service.geo.CodigoPostalService;
import com.massoftware.service.logistica.TransporteService;
import com.massoftware.service.logistica.CargaService;
import com.massoftware.service.logistica.TransporteTarifaService;
import com.massoftware.service.afip.TipoDocumentoAFIPService;
import com.massoftware.service.afip.MonedaAFIPService;
import com.massoftware.service.contabilidad.ventas.NotaCreditoMotivoService;
import com.massoftware.service.clientes.MotivoComentarioService;
import com.massoftware.service.clientes.TipoClienteService;
import com.massoftware.service.clientes.ClasificacionClienteService;
import com.massoftware.service.clientes.MotivoBloqueoClienteService;
import com.massoftware.service.empresa.TipoSucursalService;
import com.massoftware.service.empresa.SucursalService;
import com.massoftware.service.empresa.DepositoModuloService;
import com.massoftware.service.empresa.DepositoService;
import com.massoftware.service.contabilidad.EjercicioContableService;
import com.massoftware.service.contabilidad.CentroCostoContableService;
import com.massoftware.service.contabilidad.TipoPuntoEquilibrioService;
import com.massoftware.service.contabilidad.PuntoEquilibrioService;
import com.massoftware.service.contabilidad.CostoVentaService;
import com.massoftware.service.contabilidad.CuentaContableEstadoService;
import com.massoftware.service.contabilidad.CuentaContableService;
import com.massoftware.service.contabilidad.AsientoModeloService;
import com.massoftware.service.contabilidad.AsientoModeloItemService;
import com.massoftware.service.contabilidad.MinutaContableService;
import com.massoftware.service.contabilidad.AsientoContableModuloService;
import com.massoftware.service.contabilidad.AsientoContableService;
import com.massoftware.service.contabilidad.AsientoContableItemService;
import com.massoftware.service.empresa.EmpresaService;
import com.massoftware.service.monedas.MonedaService;
import com.massoftware.service.monedas.MonedaCotizacionService;
import com.massoftware.service.fondos.banco.BancoService;
import com.massoftware.service.fondos.banco.BancoFirmanteService;
import com.massoftware.service.fondos.CajaService;
import com.massoftware.service.fondos.CuentaFondoTipoService;
import com.massoftware.service.fondos.CuentaFondoRubroService;
import com.massoftware.service.fondos.CuentaFondoGrupoService;
import com.massoftware.service.fondos.CuentaFondoTipoBancoService;
import com.massoftware.service.fondos.CuentaFondoBancoCopiaService;
import com.massoftware.service.fondos.CuentaFondoService;


public abstract class AbstractFactoryService {

	public UsuarioService buildUsuarioService() throws Exception {
		return new UsuarioService();
	}

	public SeguridadModuloService buildSeguridadModuloService() throws Exception {
		return new SeguridadModuloService();
	}

	public SeguridadPuertaService buildSeguridadPuertaService() throws Exception {
		return new SeguridadPuertaService();
	}

	public ZonaService buildZonaService() throws Exception {
		return new ZonaService();
	}

	public PaisService buildPaisService() throws Exception {
		return new PaisService();
	}

	public ProvinciaService buildProvinciaService() throws Exception {
		return new ProvinciaService();
	}

	public CiudadService buildCiudadService() throws Exception {
		return new CiudadService();
	}

	public CodigoPostalService buildCodigoPostalService() throws Exception {
		return new CodigoPostalService();
	}

	public TransporteService buildTransporteService() throws Exception {
		return new TransporteService();
	}

	public CargaService buildCargaService() throws Exception {
		return new CargaService();
	}

	public TransporteTarifaService buildTransporteTarifaService() throws Exception {
		return new TransporteTarifaService();
	}

	public TipoDocumentoAFIPService buildTipoDocumentoAFIPService() throws Exception {
		return new TipoDocumentoAFIPService();
	}

	public MonedaAFIPService buildMonedaAFIPService() throws Exception {
		return new MonedaAFIPService();
	}

	public NotaCreditoMotivoService buildNotaCreditoMotivoService() throws Exception {
		return new NotaCreditoMotivoService();
	}

	public MotivoComentarioService buildMotivoComentarioService() throws Exception {
		return new MotivoComentarioService();
	}

	public TipoClienteService buildTipoClienteService() throws Exception {
		return new TipoClienteService();
	}

	public ClasificacionClienteService buildClasificacionClienteService() throws Exception {
		return new ClasificacionClienteService();
	}

	public MotivoBloqueoClienteService buildMotivoBloqueoClienteService() throws Exception {
		return new MotivoBloqueoClienteService();
	}

	public TipoSucursalService buildTipoSucursalService() throws Exception {
		return new TipoSucursalService();
	}

	public SucursalService buildSucursalService() throws Exception {
		return new SucursalService();
	}

	public DepositoModuloService buildDepositoModuloService() throws Exception {
		return new DepositoModuloService();
	}

	public DepositoService buildDepositoService() throws Exception {
		return new DepositoService();
	}

	public EjercicioContableService buildEjercicioContableService() throws Exception {
		return new EjercicioContableService();
	}

	public CentroCostoContableService buildCentroCostoContableService() throws Exception {
		return new CentroCostoContableService();
	}

	public TipoPuntoEquilibrioService buildTipoPuntoEquilibrioService() throws Exception {
		return new TipoPuntoEquilibrioService();
	}

	public PuntoEquilibrioService buildPuntoEquilibrioService() throws Exception {
		return new PuntoEquilibrioService();
	}

	public CostoVentaService buildCostoVentaService() throws Exception {
		return new CostoVentaService();
	}

	public CuentaContableEstadoService buildCuentaContableEstadoService() throws Exception {
		return new CuentaContableEstadoService();
	}

	public CuentaContableService buildCuentaContableService() throws Exception {
		return new CuentaContableService();
	}

	public AsientoModeloService buildAsientoModeloService() throws Exception {
		return new AsientoModeloService();
	}

	public AsientoModeloItemService buildAsientoModeloItemService() throws Exception {
		return new AsientoModeloItemService();
	}

	public MinutaContableService buildMinutaContableService() throws Exception {
		return new MinutaContableService();
	}

	public AsientoContableModuloService buildAsientoContableModuloService() throws Exception {
		return new AsientoContableModuloService();
	}

	public AsientoContableService buildAsientoContableService() throws Exception {
		return new AsientoContableService();
	}

	public AsientoContableItemService buildAsientoContableItemService() throws Exception {
		return new AsientoContableItemService();
	}

	public EmpresaService buildEmpresaService() throws Exception {
		return new EmpresaService();
	}

	public MonedaService buildMonedaService() throws Exception {
		return new MonedaService();
	}

	public MonedaCotizacionService buildMonedaCotizacionService() throws Exception {
		return new MonedaCotizacionService();
	}

	public BancoService buildBancoService() throws Exception {
		return new BancoService();
	}

	public BancoFirmanteService buildBancoFirmanteService() throws Exception {
		return new BancoFirmanteService();
	}

	public CajaService buildCajaService() throws Exception {
		return new CajaService();
	}

	public CuentaFondoTipoService buildCuentaFondoTipoService() throws Exception {
		return new CuentaFondoTipoService();
	}

	public CuentaFondoRubroService buildCuentaFondoRubroService() throws Exception {
		return new CuentaFondoRubroService();
	}

	public CuentaFondoGrupoService buildCuentaFondoGrupoService() throws Exception {
		return new CuentaFondoGrupoService();
	}

	public CuentaFondoTipoBancoService buildCuentaFondoTipoBancoService() throws Exception {
		return new CuentaFondoTipoBancoService();
	}

	public CuentaFondoBancoCopiaService buildCuentaFondoBancoCopiaService() throws Exception {
		return new CuentaFondoBancoCopiaService();
	}

	public CuentaFondoService buildCuentaFondoService() throws Exception {
		return new CuentaFondoService();
	}


}