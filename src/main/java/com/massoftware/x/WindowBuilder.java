package com.massoftware.x;

import com.massoftware.dao.afip.MonedaAFIPFiltro;
import com.massoftware.dao.clientes.ClasificacionClienteFiltro;
import com.massoftware.dao.clientes.MotivoBloqueoClienteFiltro;
import com.massoftware.dao.geo.CiudadFiltro;
import com.massoftware.dao.geo.CodigoPostalFiltro;
import com.massoftware.dao.geo.PaisFiltro;
import com.massoftware.dao.geo.ProvinciaFiltro;
import com.massoftware.dao.logistica.TransporteFiltro;
import com.massoftware.model.geo.Pais;
import com.massoftware.x.afip.WFMonedaAFIP;
import com.massoftware.x.afip.WFTipoDocumentoAFIP;
import com.massoftware.x.afip.WLMonedaAFIPCustom;
import com.massoftware.x.afip.WLTipoDocumentoAFIPCustom;
import com.massoftware.x.clientes.WFClasificacionCliente;
import com.massoftware.x.clientes.WFMotivoBloqueoCliente;
import com.massoftware.x.clientes.WFMotivoComentario;
import com.massoftware.x.clientes.WFTipoCliente;
import com.massoftware.x.clientes.WLClasificacionClienteCustom;
import com.massoftware.x.clientes.WLMotivoBloqueoClienteCustom;
import com.massoftware.x.clientes.WLMotivoComentarioCustom;
import com.massoftware.x.clientes.WLTipoClienteCustom;
import com.massoftware.x.contabilidad.ventas.WFNotaCreditoMotivo;
import com.massoftware.x.contabilidad.ventas.WLNotaCreditoMotivoCustom;
import com.massoftware.x.geo.WFCiudad;
import com.massoftware.x.geo.WFCiudadCustom;
import com.massoftware.x.geo.WFCodigoPostal;
import com.massoftware.x.geo.WFPais;
import com.massoftware.x.geo.WFProvinciaCustom;
import com.massoftware.x.geo.WFZona;
import com.massoftware.x.geo.WLCiudadCustom;
import com.massoftware.x.geo.WLCodigoPostalCustom;
import com.massoftware.x.geo.WLPaisCustom;
import com.massoftware.x.geo.WLProvinciaCustom;
import com.massoftware.x.geo.WLZonaCustom;
import com.massoftware.x.logistica.WFTransporte;
import com.massoftware.x.logistica.WLTransporte;
import com.massoftware.x.monedas.WFMoneda;
import com.massoftware.x.seguridad.WFUsuario;

public class WindowBuilder {

	// ------------------------------------------

	public WFTransporte buildWFTransporte(String mode, String id) throws Exception {
		return new WFTransporte(mode, id);
	}

	public WLTransporte buildWLTransporte() throws Exception {
		return new WLTransporte();
	}

	public WLTransporte buildWLTransporte(TransporteFiltro filtro) throws Exception {
		return new WLTransporte(filtro);
	}

	// ------------------------------------------

	public WFMotivoBloqueoCliente buildWFMotivoBloqueoCliente(String mode, String id) throws Exception {
		return new WFMotivoBloqueoCliente(mode, id);
	}

	public WLMotivoBloqueoClienteCustom buildWLMotivoBloqueoCliente() throws Exception {
		return new WLMotivoBloqueoClienteCustom();
	}

	public WLMotivoBloqueoClienteCustom buildWLMotivoBloqueoCliente(MotivoBloqueoClienteFiltro filtro)
			throws Exception {
		return new WLMotivoBloqueoClienteCustom(filtro);
	}

	// ------------------------------------------

	public WFClasificacionCliente buildWFClasificacionCliente(String mode, String id) throws Exception {
		return new WFClasificacionCliente(mode, id);
	}

	public WLClasificacionClienteCustom buildWLClasificacionCliente() throws Exception {
		return new WLClasificacionClienteCustom();
	}

	public WLClasificacionClienteCustom buildWLClasificacionCliente(ClasificacionClienteFiltro filtro)
			throws Exception {
		return new WLClasificacionClienteCustom(filtro);
	}

	// ------------------------------------------

	public WFUsuario buildWFUsuario(String mode, String id) throws Exception {
		return new WFUsuario(mode, id);
	}

	// ------------------------------------------

	public WFTipoCliente buildWFTipoCliente(String mode, String id) throws Exception {
		return new WFTipoCliente(mode, id);
	}

	public WLTipoClienteCustom buildWLTipoCliente() throws Exception {
		return new WLTipoClienteCustom();
	}

	// ------------------------------------------

	public WFMotivoComentario buildWFMotivoComentario(String mode, String id) throws Exception {
		return new WFMotivoComentario(mode, id);
	}

	public WLNotaCreditoMotivoCustom buildWLNotaCreditoMotivo() throws Exception {
		return new WLNotaCreditoMotivoCustom();
	}

	// ------------------------------------------

	public WFNotaCreditoMotivo buildWFNotaCreditoMotivo(String mode, String id) throws Exception {
		return new WFNotaCreditoMotivo(mode, id);
	}

	public WLMotivoComentarioCustom buildWLMotivoComentario() throws Exception {
		return new WLMotivoComentarioCustom();
	}

	// ------------------------------------------

	public WFZona buildWFZona(String mode, String id) throws Exception {
		return new WFZona(mode, id);
	}

	public WLZonaCustom buildWLZona() throws Exception {
		return new WLZonaCustom();
	}

	// ------------------------------------------

	public WFMoneda buildWFMoneda(String mode, String id) throws Exception {
		return new WFMoneda(mode, id);
	}

	// ------------------------------------------

	public WLMonedaAFIPCustom buildWLMonedaAFIP() throws Exception {
		return new WLMonedaAFIPCustom();
	}

	public WLMonedaAFIPCustom buildWLMonedaAFIP(MonedaAFIPFiltro filtro) throws Exception {
		return new WLMonedaAFIPCustom(filtro);
	}

	public WFMonedaAFIP buildWFMonedaAFIP(String mode, String id) throws Exception {
		return new WFMonedaAFIP(mode, id);
	}

	// ------------------------------------------

	public WLPaisCustom buildWLPais() throws Exception {
		return new WLPaisCustom();
	}

	public WLPaisCustom buildWLPais(PaisFiltro filtro) throws Exception {
		return new WLPaisCustom(filtro);
	}

	public WFPais buildWFPais(String mode, String id) throws Exception {
		return new WFPais(mode, id);
	}

	// ------------------------------------------

	public WLProvinciaCustom buildWLProvincia() throws Exception {
		return new WLProvinciaCustom();
	}

	public WLProvinciaCustom buildWLProvincia(ProvinciaFiltro filtro) throws Exception {
		return new WLProvinciaCustom(filtro);
	}

	public WFProvinciaCustom buildWFProvincia(String mode, String id) throws Exception {
		return new WFProvinciaCustom(mode, id);
	}

	// ------------------------------------------

	public WLCiudadCustom buildWLCiudad() throws Exception {
		return new WLCiudadCustom();
	}

	public WLCiudadCustom buildWLCiudad(CiudadFiltro filtro) throws Exception {
		return new WLCiudadCustom(filtro);
	}

	public WFCiudad buildWFCiudad(String mode, String id) throws Exception {
		return new WFCiudad(mode, id);
	}

	public WFCiudadCustom buildWFCiudad(String mode, String id, Pais pais) throws Exception {
		return new WFCiudadCustom(mode, id, pais);
	}

	// ------------------------------------------

	public WLTipoDocumentoAFIPCustom buildWLTipoDocumentoAFIP() throws Exception {
		return new WLTipoDocumentoAFIPCustom();
	}

	public WFTipoDocumentoAFIP buildWFTipoDocumentoAFIP(String mode, String id) {
		return new WFTipoDocumentoAFIP(mode, id);
	}

	// ------------------------------------------

	public WLCodigoPostalCustom buildWLCodigoPostal() throws Exception {
		return new WLCodigoPostalCustom();
	}

	public WLCodigoPostalCustom buildWLCodigoPostal(CodigoPostalFiltro filtro) throws Exception {
		return new WLCodigoPostalCustom(filtro);
	}

	public WFCodigoPostal buildWFCodigoPostal(String mode, String id) {
		return new WFCodigoPostal(mode, id);
	}

	// ------------------------------------------

}
