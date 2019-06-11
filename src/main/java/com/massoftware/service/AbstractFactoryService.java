package com.massoftware.service;

import com.massoftware.service.seguridad.UsuarioService;
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
import com.massoftware.service.monedas.MonedaService;
import com.massoftware.service.contabilidad.ventas.NotaCreditoMotivoService;
import com.massoftware.service.clientes.MotivoComentarioService;
import com.massoftware.service.clientes.TipoClienteService;
import com.massoftware.service.clientes.ClasificacionClienteService;
import com.massoftware.service.clientes.MotivoBloqueoClienteService;


public abstract class AbstractFactoryService {

	public UsuarioService buildUsuarioService() throws Exception {
		return new UsuarioService();
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

	public MonedaService buildMonedaService() throws Exception {
		return new MonedaService();
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


}