
package com.massoftware.x.fondos;

import com.vaadin.data.util.BeanItem;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.Component;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.VerticalLayout;

import com.massoftware.x.util.*;
import com.massoftware.x.util.controls.*;
import com.massoftware.x.util.windows.*;

import com.massoftware.AppCX;

import com.massoftware.model.EntityId;


import java.util.List;
import com.massoftware.model.contabilidad.CuentaContable;
import com.massoftware.service.contabilidad.CuentaContableFiltro;
import com.massoftware.service.contabilidad.CuentaContableService;
import com.massoftware.model.fondos.CuentaFondoGrupo;
import com.massoftware.service.fondos.CuentaFondoGrupoFiltro;
import com.massoftware.service.fondos.CuentaFondoGrupoService;
import com.massoftware.model.fondos.CuentaFondoTipo;
import com.massoftware.service.fondos.CuentaFondoTipoFiltro;
import com.massoftware.service.fondos.CuentaFondoTipoService;
import com.massoftware.model.monedas.Moneda;
import com.massoftware.service.monedas.MonedaFiltro;
import com.massoftware.service.monedas.MonedaService;
import com.massoftware.model.fondos.Caja;
import com.massoftware.service.fondos.CajaFiltro;
import com.massoftware.service.fondos.CajaService;
import com.massoftware.model.fondos.CuentaFondoTipoBanco;
import com.massoftware.service.fondos.CuentaFondoTipoBancoFiltro;
import com.massoftware.service.fondos.CuentaFondoTipoBancoService;
import com.massoftware.model.fondos.banco.Banco;
import com.massoftware.service.fondos.banco.BancoFiltro;
import com.massoftware.service.fondos.banco.BancoService;
import com.massoftware.model.fondos.CuentaFondoBancoCopia;
import com.massoftware.service.fondos.CuentaFondoBancoCopiaFiltro;
import com.massoftware.service.fondos.CuentaFondoBancoCopiaService;
import com.massoftware.model.seguridad.SeguridadPuerta;
import com.massoftware.service.seguridad.SeguridadPuertaFiltro;
import com.massoftware.service.seguridad.SeguridadPuertaService;
import com.massoftware.model.seguridad.SeguridadPuerta;
import com.massoftware.service.seguridad.SeguridadPuertaFiltro;
import com.massoftware.service.seguridad.SeguridadPuertaService;
import com.massoftware.model.seguridad.SeguridadPuerta;
import com.massoftware.service.seguridad.SeguridadPuertaFiltro;
import com.massoftware.service.seguridad.SeguridadPuertaService;

import com.massoftware.model.fondos.CuentaFondo;
import com.massoftware.service.fondos.CuentaFondoService;

@SuppressWarnings("serial")
public class WFCuentaFondo extends WindowForm {


	// -------------------------------------------------------------

	protected BeanItem<CuentaFondo> itemBI;
	
	private CuentaFondoService service;

	// -------------------------------------------------------------

	
	protected TextFieldEntity numeroTXT;
	protected TextFieldEntity nombreTXT;
	protected ComboBoxEntity cuentaContableCBX;
	protected SelectorBox cuentaContableSBX;
	protected ComboBoxEntity cuentaFondoGrupoCBX;
	protected SelectorBox cuentaFondoGrupoSBX;
	protected ComboBoxEntity cuentaFondoTipoCBX;
	protected SelectorBox cuentaFondoTipoSBX;
	protected CheckBoxEntity obsoletoCHK;
	protected CheckBoxEntity noImprimeCajaCHK;
	protected CheckBoxEntity ventasCHK;
	protected CheckBoxEntity fondosCHK;
	protected CheckBoxEntity comprasCHK;
	protected ComboBoxEntity monedaCBX;
	protected SelectorBox monedaSBX;
	protected ComboBoxEntity cajaCBX;
	protected SelectorBox cajaSBX;
	protected CheckBoxEntity rechazadosCHK;
	protected CheckBoxEntity conciliacionCHK;
	protected ComboBoxEntity cuentaFondoTipoBancoCBX;
	protected SelectorBox cuentaFondoTipoBancoSBX;
	protected ComboBoxEntity bancoCBX;
	protected SelectorBox bancoSBX;
	protected TextFieldEntity cuentaBancariaTXT;
	protected TextFieldEntity cbuTXT;
	protected TextFieldEntity limiteDescubiertoTXT;
	protected TextFieldEntity cuentaFondoCaucionTXT;
	protected TextFieldEntity cuentaFondoDiferidosTXT;
	protected TextFieldEntity formatoTXT;
	protected ComboBoxEntity cuentaFondoBancoCopiaCBX;
	protected SelectorBox cuentaFondoBancoCopiaSBX;
	protected TextFieldEntity limiteOperacionIndividualTXT;
	protected ComboBoxEntity seguridadPuertaUsoCBX;
	protected SelectorBox seguridadPuertaUsoSBX;
	protected ComboBoxEntity seguridadPuertaConsultaCBX;
	protected SelectorBox seguridadPuertaConsultaSBX;
	protected ComboBoxEntity seguridadPuertaLimiteCBX;
	protected SelectorBox seguridadPuertaLimiteSBX;


	// -------------------------------------------------------------

	public WFCuentaFondo(String mode, String id) {
		super(mode, id);					
	}

	protected CuentaFondoService getService() throws Exception {
		if(service == null){
			service = AppCX.services().buildCuentaFondoService();
		}
		
		return service;
	}

	protected void buildContent() throws Exception {

		confWinForm(this.itemBI.getBean().labelSingular());
		this.setWidth(28f, Unit.EM);

		// =======================================================
		// CUERPO

		Component cuerpo = buildCuerpo();

		// =======================================================
		// BOTONERAS

		HorizontalLayout filaBotoneraHL = buildBotonera1();

		// =======================================================
		// CONTENT

		VerticalLayout content = UtilUI.buildWinContentVertical();

		content.addComponents(cuerpo, filaBotoneraHL);

		content.setComponentAlignment(filaBotoneraHL, Alignment.MIDDLE_LEFT);

		this.setContent(content);
	}

	protected Component buildCuerpo() throws Exception {

		

		// ------------------------------------------------------------------

		numeroTXT = new TextFieldEntity(itemBI, "numero", this.mode) {
			protected boolean ifExists(Object arg) throws Exception {
				return getService().isExistsNumero((Integer)arg);
			}
		};

		numeroTXT.focus();

		// ------------------------------------------------------------------

		nombreTXT = new TextFieldEntity(itemBI, "nombre", this.mode) {
			protected boolean ifExists(Object arg) throws Exception {
				return getService().isExistsNombre((String)arg);
			}
		};

		CuentaContableService cuentaContableService = AppCX.services().buildCuentaContableService();

		long cuentaContableItems = cuentaContableService.count();

		if (cuentaContableItems < MAX_ROWS_FOR_CBX) {

			CuentaContableFiltro cuentaContableFiltro = new CuentaContableFiltro();

			cuentaContableFiltro.setUnlimited(true);

			cuentaContableFiltro.setOrderBy(1);

			List<CuentaContable> cuentaContableLista = cuentaContableService.find(cuentaContableFiltro);

			cuentaContableCBX = new ComboBoxEntity(itemBI, "cuentaContable", this.mode, cuentaContableLista);

		} else {

			cuentaContableSBX = new SelectorBox(itemBI, "cuentaContable") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					CuentaContableService service = AppCX.services().buildCuentaContableService();

					return service.findByCodigoOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					CuentaContableFiltro filtro = new CuentaContableFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return AppCX.widgets().buildWLCuentaContable(filtro);

				}

			};

		}

		CuentaFondoGrupoService cuentaFondoGrupoService = AppCX.services().buildCuentaFondoGrupoService();

		long cuentaFondoGrupoItems = cuentaFondoGrupoService.count();

		if (cuentaFondoGrupoItems < MAX_ROWS_FOR_CBX) {

			CuentaFondoGrupoFiltro cuentaFondoGrupoFiltro = new CuentaFondoGrupoFiltro();

			cuentaFondoGrupoFiltro.setUnlimited(true);

			cuentaFondoGrupoFiltro.setOrderBy(1);

			List<CuentaFondoGrupo> cuentaFondoGrupoLista = cuentaFondoGrupoService.find(cuentaFondoGrupoFiltro);

			cuentaFondoGrupoCBX = new ComboBoxEntity(itemBI, "cuentaFondoGrupo", this.mode, cuentaFondoGrupoLista);

		} else {

			cuentaFondoGrupoSBX = new SelectorBox(itemBI, "cuentaFondoGrupo") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					CuentaFondoGrupoService service = AppCX.services().buildCuentaFondoGrupoService();

					return service.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					CuentaFondoGrupoFiltro filtro = new CuentaFondoGrupoFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return AppCX.widgets().buildWLCuentaFondoGrupo(filtro);

				}

			};

		}

		CuentaFondoTipoService cuentaFondoTipoService = AppCX.services().buildCuentaFondoTipoService();

		long cuentaFondoTipoItems = cuentaFondoTipoService.count();

		if (cuentaFondoTipoItems < MAX_ROWS_FOR_CBX) {

			CuentaFondoTipoFiltro cuentaFondoTipoFiltro = new CuentaFondoTipoFiltro();

			cuentaFondoTipoFiltro.setUnlimited(true);

			cuentaFondoTipoFiltro.setOrderBy(1);

			List<CuentaFondoTipo> cuentaFondoTipoLista = cuentaFondoTipoService.find(cuentaFondoTipoFiltro);

			cuentaFondoTipoCBX = new ComboBoxEntity(itemBI, "cuentaFondoTipo", this.mode, cuentaFondoTipoLista);

		} else {

			cuentaFondoTipoSBX = new SelectorBox(itemBI, "cuentaFondoTipo") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					CuentaFondoTipoService service = AppCX.services().buildCuentaFondoTipoService();

					return service.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					CuentaFondoTipoFiltro filtro = new CuentaFondoTipoFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return AppCX.widgets().buildWLCuentaFondoTipo(filtro);

				}

			};

		}

		// ------------------------------------------------------------------

		obsoletoCHK = new CheckBoxEntity(itemBI, "obsoleto");

		// ------------------------------------------------------------------

		noImprimeCajaCHK = new CheckBoxEntity(itemBI, "noImprimeCaja");

		// ------------------------------------------------------------------

		ventasCHK = new CheckBoxEntity(itemBI, "ventas");

		// ------------------------------------------------------------------

		fondosCHK = new CheckBoxEntity(itemBI, "fondos");

		// ------------------------------------------------------------------

		comprasCHK = new CheckBoxEntity(itemBI, "compras");

		MonedaService monedaService = AppCX.services().buildMonedaService();

		long monedaItems = monedaService.count();

		if (monedaItems < MAX_ROWS_FOR_CBX) {

			MonedaFiltro monedaFiltro = new MonedaFiltro();

			monedaFiltro.setUnlimited(true);

			monedaFiltro.setOrderBy(1);

			List<Moneda> monedaLista = monedaService.find(monedaFiltro);

			monedaCBX = new ComboBoxEntity(itemBI, "moneda", this.mode, monedaLista);

		} else {

			monedaSBX = new SelectorBox(itemBI, "moneda") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					MonedaService service = AppCX.services().buildMonedaService();

					return service.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					MonedaFiltro filtro = new MonedaFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return AppCX.widgets().buildWLMoneda(filtro);

				}

			};

		}

		CajaService cajaService = AppCX.services().buildCajaService();

		long cajaItems = cajaService.count();

		if (cajaItems < MAX_ROWS_FOR_CBX) {

			CajaFiltro cajaFiltro = new CajaFiltro();

			cajaFiltro.setUnlimited(true);

			cajaFiltro.setOrderBy(1);

			List<Caja> cajaLista = cajaService.find(cajaFiltro);

			cajaCBX = new ComboBoxEntity(itemBI, "caja", this.mode, cajaLista);

		} else {

			cajaSBX = new SelectorBox(itemBI, "caja") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					CajaService service = AppCX.services().buildCajaService();

					return service.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					CajaFiltro filtro = new CajaFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return AppCX.widgets().buildWLCaja(filtro);

				}

			};

		}

		// ------------------------------------------------------------------

		rechazadosCHK = new CheckBoxEntity(itemBI, "rechazados");

		// ------------------------------------------------------------------

		conciliacionCHK = new CheckBoxEntity(itemBI, "conciliacion");

		CuentaFondoTipoBancoService cuentaFondoTipoBancoService = AppCX.services().buildCuentaFondoTipoBancoService();

		long cuentaFondoTipoBancoItems = cuentaFondoTipoBancoService.count();

		if (cuentaFondoTipoBancoItems < MAX_ROWS_FOR_CBX) {

			CuentaFondoTipoBancoFiltro cuentaFondoTipoBancoFiltro = new CuentaFondoTipoBancoFiltro();

			cuentaFondoTipoBancoFiltro.setUnlimited(true);

			cuentaFondoTipoBancoFiltro.setOrderBy(1);

			List<CuentaFondoTipoBanco> cuentaFondoTipoBancoLista = cuentaFondoTipoBancoService.find(cuentaFondoTipoBancoFiltro);

			cuentaFondoTipoBancoCBX = new ComboBoxEntity(itemBI, "cuentaFondoTipoBanco", this.mode, cuentaFondoTipoBancoLista);

		} else {

			cuentaFondoTipoBancoSBX = new SelectorBox(itemBI, "cuentaFondoTipoBanco") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					CuentaFondoTipoBancoService service = AppCX.services().buildCuentaFondoTipoBancoService();

					return service.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					CuentaFondoTipoBancoFiltro filtro = new CuentaFondoTipoBancoFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return AppCX.widgets().buildWLCuentaFondoTipoBanco(filtro);

				}

			};

		}

		BancoService bancoService = AppCX.services().buildBancoService();

		long bancoItems = bancoService.count();

		if (bancoItems < MAX_ROWS_FOR_CBX) {

			BancoFiltro bancoFiltro = new BancoFiltro();

			bancoFiltro.setUnlimited(true);

			bancoFiltro.setOrderBy(1);

			List<Banco> bancoLista = bancoService.find(bancoFiltro);

			bancoCBX = new ComboBoxEntity(itemBI, "banco", this.mode, bancoLista);

		} else {

			bancoSBX = new SelectorBox(itemBI, "banco") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					BancoService service = AppCX.services().buildBancoService();

					return service.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					BancoFiltro filtro = new BancoFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return AppCX.widgets().buildWLBanco(filtro);

				}

			};

		}

		// ------------------------------------------------------------------

		cuentaBancariaTXT = new TextFieldEntity(itemBI, "cuentaBancaria", this.mode);

		// ------------------------------------------------------------------

		cbuTXT = new TextFieldEntity(itemBI, "cbu", this.mode);

		// ------------------------------------------------------------------

		limiteDescubiertoTXT = new TextFieldEntity(itemBI, "limiteDescubierto", this.mode);

		// ------------------------------------------------------------------

		cuentaFondoCaucionTXT = new TextFieldEntity(itemBI, "cuentaFondoCaucion", this.mode);

		// ------------------------------------------------------------------

		cuentaFondoDiferidosTXT = new TextFieldEntity(itemBI, "cuentaFondoDiferidos", this.mode);

		// ------------------------------------------------------------------

		formatoTXT = new TextFieldEntity(itemBI, "formato", this.mode);

		CuentaFondoBancoCopiaService cuentaFondoBancoCopiaService = AppCX.services().buildCuentaFondoBancoCopiaService();

		long cuentaFondoBancoCopiaItems = cuentaFondoBancoCopiaService.count();

		if (cuentaFondoBancoCopiaItems < MAX_ROWS_FOR_CBX) {

			CuentaFondoBancoCopiaFiltro cuentaFondoBancoCopiaFiltro = new CuentaFondoBancoCopiaFiltro();

			cuentaFondoBancoCopiaFiltro.setUnlimited(true);

			cuentaFondoBancoCopiaFiltro.setOrderBy(1);

			List<CuentaFondoBancoCopia> cuentaFondoBancoCopiaLista = cuentaFondoBancoCopiaService.find(cuentaFondoBancoCopiaFiltro);

			cuentaFondoBancoCopiaCBX = new ComboBoxEntity(itemBI, "cuentaFondoBancoCopia", this.mode, cuentaFondoBancoCopiaLista);

		} else {

			cuentaFondoBancoCopiaSBX = new SelectorBox(itemBI, "cuentaFondoBancoCopia") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					CuentaFondoBancoCopiaService service = AppCX.services().buildCuentaFondoBancoCopiaService();

					return service.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					CuentaFondoBancoCopiaFiltro filtro = new CuentaFondoBancoCopiaFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return AppCX.widgets().buildWLCuentaFondoBancoCopia(filtro);

				}

			};

		}

		// ------------------------------------------------------------------

		limiteOperacionIndividualTXT = new TextFieldEntity(itemBI, "limiteOperacionIndividual", this.mode);

		SeguridadPuertaService seguridadPuertaUsoService = AppCX.services().buildSeguridadPuertaService();

		long seguridadPuertaUsoItems = seguridadPuertaUsoService.count();

		if (seguridadPuertaUsoItems < MAX_ROWS_FOR_CBX) {

			SeguridadPuertaFiltro seguridadPuertaUsoFiltro = new SeguridadPuertaFiltro();

			seguridadPuertaUsoFiltro.setUnlimited(true);

			seguridadPuertaUsoFiltro.setOrderBy(1);

			List<SeguridadPuerta> seguridadPuertaUsoLista = seguridadPuertaUsoService.find(seguridadPuertaUsoFiltro);

			seguridadPuertaUsoCBX = new ComboBoxEntity(itemBI, "seguridadPuertaUso", this.mode, seguridadPuertaUsoLista);

		} else {

			seguridadPuertaUsoSBX = new SelectorBox(itemBI, "seguridadPuertaUso") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					SeguridadPuertaService service = AppCX.services().buildSeguridadPuertaService();

					return service.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					SeguridadPuertaFiltro filtro = new SeguridadPuertaFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return AppCX.widgets().buildWLSeguridadPuerta(filtro);

				}

			};

		}

		SeguridadPuertaService seguridadPuertaConsultaService = AppCX.services().buildSeguridadPuertaService();

		long seguridadPuertaConsultaItems = seguridadPuertaConsultaService.count();

		if (seguridadPuertaConsultaItems < MAX_ROWS_FOR_CBX) {

			SeguridadPuertaFiltro seguridadPuertaConsultaFiltro = new SeguridadPuertaFiltro();

			seguridadPuertaConsultaFiltro.setUnlimited(true);

			seguridadPuertaConsultaFiltro.setOrderBy(1);

			List<SeguridadPuerta> seguridadPuertaConsultaLista = seguridadPuertaConsultaService.find(seguridadPuertaConsultaFiltro);

			seguridadPuertaConsultaCBX = new ComboBoxEntity(itemBI, "seguridadPuertaConsulta", this.mode, seguridadPuertaConsultaLista);

		} else {

			seguridadPuertaConsultaSBX = new SelectorBox(itemBI, "seguridadPuertaConsulta") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					SeguridadPuertaService service = AppCX.services().buildSeguridadPuertaService();

					return service.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					SeguridadPuertaFiltro filtro = new SeguridadPuertaFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return AppCX.widgets().buildWLSeguridadPuerta(filtro);

				}

			};

		}

		SeguridadPuertaService seguridadPuertaLimiteService = AppCX.services().buildSeguridadPuertaService();

		long seguridadPuertaLimiteItems = seguridadPuertaLimiteService.count();

		if (seguridadPuertaLimiteItems < MAX_ROWS_FOR_CBX) {

			SeguridadPuertaFiltro seguridadPuertaLimiteFiltro = new SeguridadPuertaFiltro();

			seguridadPuertaLimiteFiltro.setUnlimited(true);

			seguridadPuertaLimiteFiltro.setOrderBy(1);

			List<SeguridadPuerta> seguridadPuertaLimiteLista = seguridadPuertaLimiteService.find(seguridadPuertaLimiteFiltro);

			seguridadPuertaLimiteCBX = new ComboBoxEntity(itemBI, "seguridadPuertaLimite", this.mode, seguridadPuertaLimiteLista);

		} else {

			seguridadPuertaLimiteSBX = new SelectorBox(itemBI, "seguridadPuertaLimite") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					SeguridadPuertaService service = AppCX.services().buildSeguridadPuertaService();

					return service.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					SeguridadPuertaFiltro filtro = new SeguridadPuertaFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return AppCX.widgets().buildWLSeguridadPuerta(filtro);

				}

			};

		}

		
		// ---------------------------------------------------------------------------------------------------------

		return buildCuerpoLayout();

		// ---------------------------------------------------------------------------------------------------------
	}
	
	protected Component buildCuerpoLayout() throws Exception {		

		VerticalLayout generalVL = UtilUI.buildVL();

		// ------------------------------------------------------------------		
		
		
		generalVL.addComponent(numeroTXT);
		generalVL.addComponent(nombreTXT);
		if (cuentaContableCBX != null) {
			generalVL.addComponent(cuentaContableCBX);
		}
		if (cuentaContableSBX != null) {
			generalVL.addComponent(cuentaContableSBX);
		}
		if (cuentaFondoGrupoCBX != null) {
			generalVL.addComponent(cuentaFondoGrupoCBX);
		}
		if (cuentaFondoGrupoSBX != null) {
			generalVL.addComponent(cuentaFondoGrupoSBX);
		}
		if (cuentaFondoTipoCBX != null) {
			generalVL.addComponent(cuentaFondoTipoCBX);
		}
		if (cuentaFondoTipoSBX != null) {
			generalVL.addComponent(cuentaFondoTipoSBX);
		}
		generalVL.addComponent(obsoletoCHK);
		generalVL.addComponent(noImprimeCajaCHK);
		generalVL.addComponent(ventasCHK);
		generalVL.addComponent(fondosCHK);
		generalVL.addComponent(comprasCHK);
		if (monedaCBX != null) {
			generalVL.addComponent(monedaCBX);
		}
		if (monedaSBX != null) {
			generalVL.addComponent(monedaSBX);
		}
		if (cajaCBX != null) {
			generalVL.addComponent(cajaCBX);
		}
		if (cajaSBX != null) {
			generalVL.addComponent(cajaSBX);
		}
		generalVL.addComponent(rechazadosCHK);
		generalVL.addComponent(conciliacionCHK);
		if (cuentaFondoTipoBancoCBX != null) {
			generalVL.addComponent(cuentaFondoTipoBancoCBX);
		}
		if (cuentaFondoTipoBancoSBX != null) {
			generalVL.addComponent(cuentaFondoTipoBancoSBX);
		}
		if (bancoCBX != null) {
			generalVL.addComponent(bancoCBX);
		}
		if (bancoSBX != null) {
			generalVL.addComponent(bancoSBX);
		}
		generalVL.addComponent(cuentaBancariaTXT);
		generalVL.addComponent(cbuTXT);
		generalVL.addComponent(limiteDescubiertoTXT);
		generalVL.addComponent(cuentaFondoCaucionTXT);
		generalVL.addComponent(cuentaFondoDiferidosTXT);
		generalVL.addComponent(formatoTXT);
		if (cuentaFondoBancoCopiaCBX != null) {
			generalVL.addComponent(cuentaFondoBancoCopiaCBX);
		}
		if (cuentaFondoBancoCopiaSBX != null) {
			generalVL.addComponent(cuentaFondoBancoCopiaSBX);
		}
		generalVL.addComponent(limiteOperacionIndividualTXT);
		if (seguridadPuertaUsoCBX != null) {
			generalVL.addComponent(seguridadPuertaUsoCBX);
		}
		if (seguridadPuertaUsoSBX != null) {
			generalVL.addComponent(seguridadPuertaUsoSBX);
		}
		if (seguridadPuertaConsultaCBX != null) {
			generalVL.addComponent(seguridadPuertaConsultaCBX);
		}
		if (seguridadPuertaConsultaSBX != null) {
			generalVL.addComponent(seguridadPuertaConsultaSBX);
		}
		if (seguridadPuertaLimiteCBX != null) {
			generalVL.addComponent(seguridadPuertaLimiteCBX);
		}
		if (seguridadPuertaLimiteSBX != null) {
			generalVL.addComponent(seguridadPuertaLimiteSBX);
		}

		// ---------------------------------------------------------------------------------------------------------

		return generalVL;

		// ---------------------------------------------------------------------------------------------------------
	}

	// =================================================================================

	protected void setMaxValues(EntityId item) throws Exception {
		// Al momento de insertar o copiar a veces se necesita el maximo valor de ese
		// atributo, + 1, esto es asi para hacer una especie de numero incremental de
		// ese atributo
		// Este metodo se ejecuta despues de consultar a la base de datos el bean en
		// base a su id

		// item.setNumero(this.itemBI.getBean().maxValueInteger("numero"));		
		
		
		((CuentaFondo) item).setNumero(getService().nextValueNumero());

	}

	protected void setBean(EntityId obj) throws Exception {

		// se utiliza para asignarle o cambiar el bean al contenedor del formulario

		itemBI.setBean((CuentaFondo) obj);
	}

	protected BeanItem<CuentaFondo> getItemBIC() throws Exception {

		// -----------------------------------------------------------------
		// Crea el Container del form, en base a al bean que queremos usar, y ademas
		// carga el form con un bean vacio
		// como este metodo se llama muchas veces, inicializar el contenedor una sola
		// vez

		if (itemBI == null) {
			itemBI = new BeanItem<CuentaFondo>(new CuentaFondo());
		}
		return itemBI;
	}

	protected Object insert() throws Exception {

		try {
			
			getService().insert(getItemBIC().getBean());
			// ((EntityId) getItemBIC().getBean()).insert();
			if (windowListado != null) {
				windowListado.loadDataResetPagedFull();
			}

			return getItemBIC().getBean();

		} catch (Exception e) {
			LogAndNotification.print(e);
			return null;
		}
	}
	
	protected Object update() throws Exception {

		try {


			getService().update(getItemBIC().getBean());
//			((EntityId) getItemBIC().getBean()).update();
			if (windowListado != null) {
				windowListado.loadDataResetPagedFull();
			}

			return getItemBIC().getBean();

		} catch (Exception e) {
			LogAndNotification.print(e);
			return null;
		}
	}
	
	// metodo que realiza la consulta a la base de datos
	protected EntityId queryData() throws Exception {
		try {

			//EntityId item = (EntityId) getItemBIC().getBean();
			//item.loadById(id); // consulta a DB						
			CuentaFondo item = getService().findById(id);
			getItemBIC().setBean(item);

			return item;

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

		return (EntityId) getItemBIC().getBean();
	}

	// =================================================================================

}