package com.massoftware.model.fondos;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.model.EntityId;
import com.massoftware.model.fondos.ComprobanteFondoModelo;
import com.massoftware.model.fondos.CuentaFondo;

@ClassLabelAnont(singular = "Modelo de comprobante de fondo", plural = "Modelos de comprobante de fondo", singularPre = "el nodelo de comprobante de fondo", pluralPre = "los modelos de comprobante de fondo")
public class ComprobanteFondoModeloItem extends EntityId {

	// ---------------------------------------------------------------------------------------------------------------------------


	@FieldConfAnont(label = "ID")
	private String id;

	// Nº modelo
	@FieldConfAnont(label = "Nº modelo", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numero;

	// Debe
	@FieldConfAnont(label = "Debe", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Boolean debe = false;

	// Modelo
	@FieldConfAnont(label = "Modelo", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private ComprobanteFondoModelo comprobanteFondoModelo;

	// Cuenta fondo
	@FieldConfAnont(label = "Cuenta fondo", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private CuentaFondo cuentaFondo;

	// ---------------------------------------------------------------------------------------------------------------------------


	public ComprobanteFondoModeloItem() throws Exception {
	}

	public ComprobanteFondoModeloItem(String idArg0, Integer numeroArg1, Boolean debeArg2, String idComprobanteFondoModeloArg3, String idCuentaFondoArg4) throws Exception {

		setter(idArg0, numeroArg1, debeArg2, idComprobanteFondoModeloArg3, idCuentaFondoArg4);

	}

	public ComprobanteFondoModeloItem(String idArg0, Integer numeroArg1, Boolean debeArg2, String idArg3, Integer numeroArg4, String nombreArg5, String idArg6, Integer numeroArg7, String nombreArg8, String idCuentaContableArg9, String idCuentaFondoGrupoArg10, String idCuentaFondoTipoArg11, Boolean obsoletoArg12, Boolean noImprimeCajaArg13, Boolean ventasArg14, Boolean fondosArg15, Boolean comprasArg16, String idMonedaArg17, String idCajaArg18, Boolean rechazadosArg19, Boolean conciliacionArg20, String idCuentaFondoTipoBancoArg21, String idBancoArg22, String cuentaBancariaArg23, String cbuArg24, java.math.BigDecimal limiteDescubiertoArg25, String cuentaFondoCaucionArg26, String cuentaFondoDiferidosArg27, String formatoArg28, String idCuentaFondoBancoCopiaArg29, java.math.BigDecimal limiteOperacionIndividualArg30, String idSeguridadPuertaArg31, String idSeguridadPuertaArg32, String idSeguridadPuertaArg33) throws Exception {

		setter(idArg0, numeroArg1, debeArg2, idArg3, numeroArg4, nombreArg5, idArg6, numeroArg7, nombreArg8, idCuentaContableArg9, idCuentaFondoGrupoArg10, idCuentaFondoTipoArg11, obsoletoArg12, noImprimeCajaArg13, ventasArg14, fondosArg15, comprasArg16, idMonedaArg17, idCajaArg18, rechazadosArg19, conciliacionArg20, idCuentaFondoTipoBancoArg21, idBancoArg22, cuentaBancariaArg23, cbuArg24, limiteDescubiertoArg25, cuentaFondoCaucionArg26, cuentaFondoDiferidosArg27, formatoArg28, idCuentaFondoBancoCopiaArg29, limiteOperacionIndividualArg30, idSeguridadPuertaArg31, idSeguridadPuertaArg32, idSeguridadPuertaArg33);

	}

	public ComprobanteFondoModeloItem(String idArg0, Integer numeroArg1, Boolean debeArg2, String idArg3, Integer numeroArg4, String nombreArg5, String idArg6, Integer numeroArg7, String nombreArg8, String idArg9, String codigoArg10, String nombreArg11, String idEjercicioContableArg12, String integraArg13, String cuentaJerarquiaArg14, Boolean imputableArg15, Boolean ajustaPorInflacionArg16, String idCuentaContableEstadoArg17, Boolean cuentaConApropiacionArg18, String idCentroCostoContableArg19, String cuentaAgrupadoraArg20, java.math.BigDecimal porcentajeArg21, String idPuntoEquilibrioArg22, String idCostoVentaArg23, String idSeguridadPuertaArg24, String idArg25, Integer numeroArg26, String nombreArg27, String idCuentaFondoRubroArg28, String idArg29, Integer numeroArg30, String nombreArg31, Boolean obsoletoArg32, Boolean noImprimeCajaArg33, Boolean ventasArg34, Boolean fondosArg35, Boolean comprasArg36, String idArg37, Integer numeroArg38, String nombreArg39, String abreviaturaArg40, java.math.BigDecimal cotizacionArg41, java.sql.Timestamp cotizacionFechaArg42, Boolean controlActualizacionArg43, String idMonedaAFIPArg44, String idArg45, Integer numeroArg46, String nombreArg47, String idSeguridadPuertaArg48, Boolean rechazadosArg49, Boolean conciliacionArg50, String idArg51, Integer numeroArg52, String nombreArg53, String idArg54, Integer numeroArg55, String nombreArg56, Long cuitArg57, Boolean bloqueadoArg58, Integer hojaArg59, Integer primeraFilaArg60, Integer ultimaFilaArg61, String fechaArg62, String descripcionArg63, String referencia1Arg64, String importeArg65, String referencia2Arg66, String saldoArg67, String cuentaBancariaArg68, String cbuArg69, java.math.BigDecimal limiteDescubiertoArg70, String cuentaFondoCaucionArg71, String cuentaFondoDiferidosArg72, String formatoArg73, String idArg74, Integer numeroArg75, String nombreArg76, java.math.BigDecimal limiteOperacionIndividualArg77, String idArg78, Integer numeroArg79, String nombreArg80, String equateArg81, String idSeguridadModuloArg82, String idArg83, Integer numeroArg84, String nombreArg85, String equateArg86, String idSeguridadModuloArg87, String idArg88, Integer numeroArg89, String nombreArg90, String equateArg91, String idSeguridadModuloArg92) throws Exception {

		setter(idArg0, numeroArg1, debeArg2, idArg3, numeroArg4, nombreArg5, idArg6, numeroArg7, nombreArg8, idArg9, codigoArg10, nombreArg11, idEjercicioContableArg12, integraArg13, cuentaJerarquiaArg14, imputableArg15, ajustaPorInflacionArg16, idCuentaContableEstadoArg17, cuentaConApropiacionArg18, idCentroCostoContableArg19, cuentaAgrupadoraArg20, porcentajeArg21, idPuntoEquilibrioArg22, idCostoVentaArg23, idSeguridadPuertaArg24, idArg25, numeroArg26, nombreArg27, idCuentaFondoRubroArg28, idArg29, numeroArg30, nombreArg31, obsoletoArg32, noImprimeCajaArg33, ventasArg34, fondosArg35, comprasArg36, idArg37, numeroArg38, nombreArg39, abreviaturaArg40, cotizacionArg41, cotizacionFechaArg42, controlActualizacionArg43, idMonedaAFIPArg44, idArg45, numeroArg46, nombreArg47, idSeguridadPuertaArg48, rechazadosArg49, conciliacionArg50, idArg51, numeroArg52, nombreArg53, idArg54, numeroArg55, nombreArg56, cuitArg57, bloqueadoArg58, hojaArg59, primeraFilaArg60, ultimaFilaArg61, fechaArg62, descripcionArg63, referencia1Arg64, importeArg65, referencia2Arg66, saldoArg67, cuentaBancariaArg68, cbuArg69, limiteDescubiertoArg70, cuentaFondoCaucionArg71, cuentaFondoDiferidosArg72, formatoArg73, idArg74, numeroArg75, nombreArg76, limiteOperacionIndividualArg77, idArg78, numeroArg79, nombreArg80, equateArg81, idSeguridadModuloArg82, idArg83, numeroArg84, nombreArg85, equateArg86, idSeguridadModuloArg87, idArg88, numeroArg89, nombreArg90, equateArg91, idSeguridadModuloArg92);

	}

	public ComprobanteFondoModeloItem(String idArg0, Integer numeroArg1, Boolean debeArg2, String idArg3, Integer numeroArg4, String nombreArg5, String idArg6, Integer numeroArg7, String nombreArg8, String idArg9, String codigoArg10, String nombreArg11, String idArg12, Integer numeroArg13, java.util.Date aperturaArg14, java.util.Date cierreArg15, Boolean cerradoArg16, Boolean cerradoModulosArg17, String comentarioArg18, String integraArg19, String cuentaJerarquiaArg20, Boolean imputableArg21, Boolean ajustaPorInflacionArg22, String idArg23, Integer numeroArg24, String nombreArg25, Boolean cuentaConApropiacionArg26, String idArg27, Integer numeroArg28, String nombreArg29, String abreviaturaArg30, String idEjercicioContableArg31, String cuentaAgrupadoraArg32, java.math.BigDecimal porcentajeArg33, String idArg34, Integer numeroArg35, String nombreArg36, String idTipoPuntoEquilibrioArg37, String idEjercicioContableArg38, String idArg39, Integer numeroArg40, String nombreArg41, String idArg42, Integer numeroArg43, String nombreArg44, String equateArg45, String idSeguridadModuloArg46, String idArg47, Integer numeroArg48, String nombreArg49, String idArg50, Integer numeroArg51, String nombreArg52, String idArg53, Integer numeroArg54, String nombreArg55, Boolean obsoletoArg56, Boolean noImprimeCajaArg57, Boolean ventasArg58, Boolean fondosArg59, Boolean comprasArg60, String idArg61, Integer numeroArg62, String nombreArg63, String abreviaturaArg64, java.math.BigDecimal cotizacionArg65, java.sql.Timestamp cotizacionFechaArg66, Boolean controlActualizacionArg67, String idArg68, String codigoArg69, String nombreArg70, String idArg71, Integer numeroArg72, String nombreArg73, String idArg74, Integer numeroArg75, String nombreArg76, String equateArg77, String idSeguridadModuloArg78, Boolean rechazadosArg79, Boolean conciliacionArg80, String idArg81, Integer numeroArg82, String nombreArg83, String idArg84, Integer numeroArg85, String nombreArg86, Long cuitArg87, Boolean bloqueadoArg88, Integer hojaArg89, Integer primeraFilaArg90, Integer ultimaFilaArg91, String fechaArg92, String descripcionArg93, String referencia1Arg94, String importeArg95, String referencia2Arg96, String saldoArg97, String cuentaBancariaArg98, String cbuArg99, java.math.BigDecimal limiteDescubiertoArg100, String cuentaFondoCaucionArg101, String cuentaFondoDiferidosArg102, String formatoArg103, String idArg104, Integer numeroArg105, String nombreArg106, java.math.BigDecimal limiteOperacionIndividualArg107, String idArg108, Integer numeroArg109, String nombreArg110, String equateArg111, String idArg112, Integer numeroArg113, String nombreArg114, String idArg115, Integer numeroArg116, String nombreArg117, String equateArg118, String idArg119, Integer numeroArg120, String nombreArg121, String idArg122, Integer numeroArg123, String nombreArg124, String equateArg125, String idArg126, Integer numeroArg127, String nombreArg128) throws Exception {

		setter(idArg0, numeroArg1, debeArg2, idArg3, numeroArg4, nombreArg5, idArg6, numeroArg7, nombreArg8, idArg9, codigoArg10, nombreArg11, idArg12, numeroArg13, aperturaArg14, cierreArg15, cerradoArg16, cerradoModulosArg17, comentarioArg18, integraArg19, cuentaJerarquiaArg20, imputableArg21, ajustaPorInflacionArg22, idArg23, numeroArg24, nombreArg25, cuentaConApropiacionArg26, idArg27, numeroArg28, nombreArg29, abreviaturaArg30, idEjercicioContableArg31, cuentaAgrupadoraArg32, porcentajeArg33, idArg34, numeroArg35, nombreArg36, idTipoPuntoEquilibrioArg37, idEjercicioContableArg38, idArg39, numeroArg40, nombreArg41, idArg42, numeroArg43, nombreArg44, equateArg45, idSeguridadModuloArg46, idArg47, numeroArg48, nombreArg49, idArg50, numeroArg51, nombreArg52, idArg53, numeroArg54, nombreArg55, obsoletoArg56, noImprimeCajaArg57, ventasArg58, fondosArg59, comprasArg60, idArg61, numeroArg62, nombreArg63, abreviaturaArg64, cotizacionArg65, cotizacionFechaArg66, controlActualizacionArg67, idArg68, codigoArg69, nombreArg70, idArg71, numeroArg72, nombreArg73, idArg74, numeroArg75, nombreArg76, equateArg77, idSeguridadModuloArg78, rechazadosArg79, conciliacionArg80, idArg81, numeroArg82, nombreArg83, idArg84, numeroArg85, nombreArg86, cuitArg87, bloqueadoArg88, hojaArg89, primeraFilaArg90, ultimaFilaArg91, fechaArg92, descripcionArg93, referencia1Arg94, importeArg95, referencia2Arg96, saldoArg97, cuentaBancariaArg98, cbuArg99, limiteDescubiertoArg100, cuentaFondoCaucionArg101, cuentaFondoDiferidosArg102, formatoArg103, idArg104, numeroArg105, nombreArg106, limiteOperacionIndividualArg107, idArg108, numeroArg109, nombreArg110, equateArg111, idArg112, numeroArg113, nombreArg114, idArg115, numeroArg116, nombreArg117, equateArg118, idArg119, numeroArg120, nombreArg121, idArg122, numeroArg123, nombreArg124, equateArg125, idArg126, numeroArg127, nombreArg128);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	// GET ID
	public String getId() {
		return this.id;
	}
	// SET ID
	public void setId(String id){
		id = (id != null) ? id.trim() : null;
		this.id = (id != null && id.length() == 0) ? null : id;
	}

	// GET Nº modelo
	public Integer getNumero() {
		return this.numero;
	}

	// SET Nº modelo
	public void setNumero(Integer numero ){
		this.numero = numero;
	}

	// GET Debe
	public Boolean getDebe() {
		return this.debe;
	}

	// SET Debe
	public void setDebe(Boolean debe ){
		this.debe = (debe == null) ? false : debe;
	}

	// BUILD IF NULL AND GET Modelo
	public ComprobanteFondoModelo buildComprobanteFondoModelo() throws Exception {
		this.comprobanteFondoModelo = (this.comprobanteFondoModelo == null) ? new ComprobanteFondoModelo() : this.comprobanteFondoModelo;
		return this.comprobanteFondoModelo;
	}

	// GET Modelo
	public ComprobanteFondoModelo getComprobanteFondoModelo() {
		this.comprobanteFondoModelo = (this.comprobanteFondoModelo != null && this.comprobanteFondoModelo.getId() == null) ? null : this.comprobanteFondoModelo ;
		return this.comprobanteFondoModelo;
	}

	// SET Modelo
	public void setComprobanteFondoModelo(ComprobanteFondoModelo comprobanteFondoModelo ){
		this.comprobanteFondoModelo = comprobanteFondoModelo;
	}

	// BUILD IF NULL AND GET Cuenta fondo
	public CuentaFondo buildCuentaFondo() throws Exception {
		this.cuentaFondo = (this.cuentaFondo == null) ? new CuentaFondo() : this.cuentaFondo;
		return this.cuentaFondo;
	}

	// GET Cuenta fondo
	public CuentaFondo getCuentaFondo() {
		this.cuentaFondo = (this.cuentaFondo != null && this.cuentaFondo.getId() == null) ? null : this.cuentaFondo ;
		return this.cuentaFondo;
	}

	// SET Cuenta fondo
	public void setCuentaFondo(CuentaFondo cuentaFondo ){
		this.cuentaFondo = cuentaFondo;
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, Boolean debeArg2, String idComprobanteFondoModeloArg3, String idCuentaFondoArg4) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setDebe(debeArg2);
		this.buildComprobanteFondoModelo().setId(idComprobanteFondoModeloArg3);
		this.buildCuentaFondo().setId(idCuentaFondoArg4);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, Boolean debeArg2, String idArg3, Integer numeroArg4, String nombreArg5, String idArg6, Integer numeroArg7, String nombreArg8, String idCuentaContableArg9, String idCuentaFondoGrupoArg10, String idCuentaFondoTipoArg11, Boolean obsoletoArg12, Boolean noImprimeCajaArg13, Boolean ventasArg14, Boolean fondosArg15, Boolean comprasArg16, String idMonedaArg17, String idCajaArg18, Boolean rechazadosArg19, Boolean conciliacionArg20, String idCuentaFondoTipoBancoArg21, String idBancoArg22, String cuentaBancariaArg23, String cbuArg24, java.math.BigDecimal limiteDescubiertoArg25, String cuentaFondoCaucionArg26, String cuentaFondoDiferidosArg27, String formatoArg28, String idCuentaFondoBancoCopiaArg29, java.math.BigDecimal limiteOperacionIndividualArg30, String idSeguridadPuertaArg31, String idSeguridadPuertaArg32, String idSeguridadPuertaArg33) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setDebe(debeArg2);
		this.buildComprobanteFondoModelo().setId(idArg3);
		this.buildComprobanteFondoModelo().setNumero(numeroArg4);
		this.buildComprobanteFondoModelo().setNombre(nombreArg5);
		this.buildCuentaFondo().setId(idArg6);
		this.buildCuentaFondo().setNumero(numeroArg7);
		this.buildCuentaFondo().setNombre(nombreArg8);
		this.buildCuentaFondo().buildCuentaContable().setId(idCuentaContableArg9);
		this.buildCuentaFondo().buildCuentaFondoGrupo().setId(idCuentaFondoGrupoArg10);
		this.buildCuentaFondo().buildCuentaFondoTipo().setId(idCuentaFondoTipoArg11);
		this.buildCuentaFondo().setObsoleto(obsoletoArg12);
		this.buildCuentaFondo().setNoImprimeCaja(noImprimeCajaArg13);
		this.buildCuentaFondo().setVentas(ventasArg14);
		this.buildCuentaFondo().setFondos(fondosArg15);
		this.buildCuentaFondo().setCompras(comprasArg16);
		this.buildCuentaFondo().buildMoneda().setId(idMonedaArg17);
		this.buildCuentaFondo().buildCaja().setId(idCajaArg18);
		this.buildCuentaFondo().setRechazados(rechazadosArg19);
		this.buildCuentaFondo().setConciliacion(conciliacionArg20);
		this.buildCuentaFondo().buildCuentaFondoTipoBanco().setId(idCuentaFondoTipoBancoArg21);
		this.buildCuentaFondo().buildBanco().setId(idBancoArg22);
		this.buildCuentaFondo().setCuentaBancaria(cuentaBancariaArg23);
		this.buildCuentaFondo().setCbu(cbuArg24);
		this.buildCuentaFondo().setLimiteDescubierto(limiteDescubiertoArg25);
		this.buildCuentaFondo().setCuentaFondoCaucion(cuentaFondoCaucionArg26);
		this.buildCuentaFondo().setCuentaFondoDiferidos(cuentaFondoDiferidosArg27);
		this.buildCuentaFondo().setFormato(formatoArg28);
		this.buildCuentaFondo().buildCuentaFondoBancoCopia().setId(idCuentaFondoBancoCopiaArg29);
		this.buildCuentaFondo().setLimiteOperacionIndividual(limiteOperacionIndividualArg30);
		this.buildCuentaFondo().buildSeguridadPuertaUso().setId(idSeguridadPuertaArg31);
		this.buildCuentaFondo().buildSeguridadPuertaConsulta().setId(idSeguridadPuertaArg32);
		this.buildCuentaFondo().buildSeguridadPuertaLimite().setId(idSeguridadPuertaArg33);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, Boolean debeArg2, String idArg3, Integer numeroArg4, String nombreArg5, String idArg6, Integer numeroArg7, String nombreArg8, String idArg9, String codigoArg10, String nombreArg11, String idEjercicioContableArg12, String integraArg13, String cuentaJerarquiaArg14, Boolean imputableArg15, Boolean ajustaPorInflacionArg16, String idCuentaContableEstadoArg17, Boolean cuentaConApropiacionArg18, String idCentroCostoContableArg19, String cuentaAgrupadoraArg20, java.math.BigDecimal porcentajeArg21, String idPuntoEquilibrioArg22, String idCostoVentaArg23, String idSeguridadPuertaArg24, String idArg25, Integer numeroArg26, String nombreArg27, String idCuentaFondoRubroArg28, String idArg29, Integer numeroArg30, String nombreArg31, Boolean obsoletoArg32, Boolean noImprimeCajaArg33, Boolean ventasArg34, Boolean fondosArg35, Boolean comprasArg36, String idArg37, Integer numeroArg38, String nombreArg39, String abreviaturaArg40, java.math.BigDecimal cotizacionArg41, java.sql.Timestamp cotizacionFechaArg42, Boolean controlActualizacionArg43, String idMonedaAFIPArg44, String idArg45, Integer numeroArg46, String nombreArg47, String idSeguridadPuertaArg48, Boolean rechazadosArg49, Boolean conciliacionArg50, String idArg51, Integer numeroArg52, String nombreArg53, String idArg54, Integer numeroArg55, String nombreArg56, Long cuitArg57, Boolean bloqueadoArg58, Integer hojaArg59, Integer primeraFilaArg60, Integer ultimaFilaArg61, String fechaArg62, String descripcionArg63, String referencia1Arg64, String importeArg65, String referencia2Arg66, String saldoArg67, String cuentaBancariaArg68, String cbuArg69, java.math.BigDecimal limiteDescubiertoArg70, String cuentaFondoCaucionArg71, String cuentaFondoDiferidosArg72, String formatoArg73, String idArg74, Integer numeroArg75, String nombreArg76, java.math.BigDecimal limiteOperacionIndividualArg77, String idArg78, Integer numeroArg79, String nombreArg80, String equateArg81, String idSeguridadModuloArg82, String idArg83, Integer numeroArg84, String nombreArg85, String equateArg86, String idSeguridadModuloArg87, String idArg88, Integer numeroArg89, String nombreArg90, String equateArg91, String idSeguridadModuloArg92) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setDebe(debeArg2);
		this.buildComprobanteFondoModelo().setId(idArg3);
		this.buildComprobanteFondoModelo().setNumero(numeroArg4);
		this.buildComprobanteFondoModelo().setNombre(nombreArg5);
		this.buildCuentaFondo().setId(idArg6);
		this.buildCuentaFondo().setNumero(numeroArg7);
		this.buildCuentaFondo().setNombre(nombreArg8);
		this.buildCuentaFondo().buildCuentaContable().setId(idArg9);
		this.buildCuentaFondo().buildCuentaContable().setCodigo(codigoArg10);
		this.buildCuentaFondo().buildCuentaContable().setNombre(nombreArg11);
		this.buildCuentaFondo().buildCuentaContable().buildEjercicioContable().setId(idEjercicioContableArg12);
		this.buildCuentaFondo().buildCuentaContable().setIntegra(integraArg13);
		this.buildCuentaFondo().buildCuentaContable().setCuentaJerarquia(cuentaJerarquiaArg14);
		this.buildCuentaFondo().buildCuentaContable().setImputable(imputableArg15);
		this.buildCuentaFondo().buildCuentaContable().setAjustaPorInflacion(ajustaPorInflacionArg16);
		this.buildCuentaFondo().buildCuentaContable().buildCuentaContableEstado().setId(idCuentaContableEstadoArg17);
		this.buildCuentaFondo().buildCuentaContable().setCuentaConApropiacion(cuentaConApropiacionArg18);
		this.buildCuentaFondo().buildCuentaContable().buildCentroCostoContable().setId(idCentroCostoContableArg19);
		this.buildCuentaFondo().buildCuentaContable().setCuentaAgrupadora(cuentaAgrupadoraArg20);
		this.buildCuentaFondo().buildCuentaContable().setPorcentaje(porcentajeArg21);
		this.buildCuentaFondo().buildCuentaContable().buildPuntoEquilibrio().setId(idPuntoEquilibrioArg22);
		this.buildCuentaFondo().buildCuentaContable().buildCostoVenta().setId(idCostoVentaArg23);
		this.buildCuentaFondo().buildCuentaContable().buildSeguridadPuerta().setId(idSeguridadPuertaArg24);
		this.buildCuentaFondo().buildCuentaFondoGrupo().setId(idArg25);
		this.buildCuentaFondo().buildCuentaFondoGrupo().setNumero(numeroArg26);
		this.buildCuentaFondo().buildCuentaFondoGrupo().setNombre(nombreArg27);
		this.buildCuentaFondo().buildCuentaFondoGrupo().buildCuentaFondoRubro().setId(idCuentaFondoRubroArg28);
		this.buildCuentaFondo().buildCuentaFondoTipo().setId(idArg29);
		this.buildCuentaFondo().buildCuentaFondoTipo().setNumero(numeroArg30);
		this.buildCuentaFondo().buildCuentaFondoTipo().setNombre(nombreArg31);
		this.buildCuentaFondo().setObsoleto(obsoletoArg32);
		this.buildCuentaFondo().setNoImprimeCaja(noImprimeCajaArg33);
		this.buildCuentaFondo().setVentas(ventasArg34);
		this.buildCuentaFondo().setFondos(fondosArg35);
		this.buildCuentaFondo().setCompras(comprasArg36);
		this.buildCuentaFondo().buildMoneda().setId(idArg37);
		this.buildCuentaFondo().buildMoneda().setNumero(numeroArg38);
		this.buildCuentaFondo().buildMoneda().setNombre(nombreArg39);
		this.buildCuentaFondo().buildMoneda().setAbreviatura(abreviaturaArg40);
		this.buildCuentaFondo().buildMoneda().setCotizacion(cotizacionArg41);
		this.buildCuentaFondo().buildMoneda().setCotizacionFecha(cotizacionFechaArg42);
		this.buildCuentaFondo().buildMoneda().setControlActualizacion(controlActualizacionArg43);
		this.buildCuentaFondo().buildMoneda().buildMonedaAFIP().setId(idMonedaAFIPArg44);
		this.buildCuentaFondo().buildCaja().setId(idArg45);
		this.buildCuentaFondo().buildCaja().setNumero(numeroArg46);
		this.buildCuentaFondo().buildCaja().setNombre(nombreArg47);
		this.buildCuentaFondo().buildCaja().buildSeguridadPuerta().setId(idSeguridadPuertaArg48);
		this.buildCuentaFondo().setRechazados(rechazadosArg49);
		this.buildCuentaFondo().setConciliacion(conciliacionArg50);
		this.buildCuentaFondo().buildCuentaFondoTipoBanco().setId(idArg51);
		this.buildCuentaFondo().buildCuentaFondoTipoBanco().setNumero(numeroArg52);
		this.buildCuentaFondo().buildCuentaFondoTipoBanco().setNombre(nombreArg53);
		this.buildCuentaFondo().buildBanco().setId(idArg54);
		this.buildCuentaFondo().buildBanco().setNumero(numeroArg55);
		this.buildCuentaFondo().buildBanco().setNombre(nombreArg56);
		this.buildCuentaFondo().buildBanco().setCuit(cuitArg57);
		this.buildCuentaFondo().buildBanco().setBloqueado(bloqueadoArg58);
		this.buildCuentaFondo().buildBanco().setHoja(hojaArg59);
		this.buildCuentaFondo().buildBanco().setPrimeraFila(primeraFilaArg60);
		this.buildCuentaFondo().buildBanco().setUltimaFila(ultimaFilaArg61);
		this.buildCuentaFondo().buildBanco().setFecha(fechaArg62);
		this.buildCuentaFondo().buildBanco().setDescripcion(descripcionArg63);
		this.buildCuentaFondo().buildBanco().setReferencia1(referencia1Arg64);
		this.buildCuentaFondo().buildBanco().setImporte(importeArg65);
		this.buildCuentaFondo().buildBanco().setReferencia2(referencia2Arg66);
		this.buildCuentaFondo().buildBanco().setSaldo(saldoArg67);
		this.buildCuentaFondo().setCuentaBancaria(cuentaBancariaArg68);
		this.buildCuentaFondo().setCbu(cbuArg69);
		this.buildCuentaFondo().setLimiteDescubierto(limiteDescubiertoArg70);
		this.buildCuentaFondo().setCuentaFondoCaucion(cuentaFondoCaucionArg71);
		this.buildCuentaFondo().setCuentaFondoDiferidos(cuentaFondoDiferidosArg72);
		this.buildCuentaFondo().setFormato(formatoArg73);
		this.buildCuentaFondo().buildCuentaFondoBancoCopia().setId(idArg74);
		this.buildCuentaFondo().buildCuentaFondoBancoCopia().setNumero(numeroArg75);
		this.buildCuentaFondo().buildCuentaFondoBancoCopia().setNombre(nombreArg76);
		this.buildCuentaFondo().setLimiteOperacionIndividual(limiteOperacionIndividualArg77);
		this.buildCuentaFondo().buildSeguridadPuertaUso().setId(idArg78);
		this.buildCuentaFondo().buildSeguridadPuertaUso().setNumero(numeroArg79);
		this.buildCuentaFondo().buildSeguridadPuertaUso().setNombre(nombreArg80);
		this.buildCuentaFondo().buildSeguridadPuertaUso().setEquate(equateArg81);
		this.buildCuentaFondo().buildSeguridadPuertaUso().buildSeguridadModulo().setId(idSeguridadModuloArg82);
		this.buildCuentaFondo().buildSeguridadPuertaConsulta().setId(idArg83);
		this.buildCuentaFondo().buildSeguridadPuertaConsulta().setNumero(numeroArg84);
		this.buildCuentaFondo().buildSeguridadPuertaConsulta().setNombre(nombreArg85);
		this.buildCuentaFondo().buildSeguridadPuertaConsulta().setEquate(equateArg86);
		this.buildCuentaFondo().buildSeguridadPuertaConsulta().buildSeguridadModulo().setId(idSeguridadModuloArg87);
		this.buildCuentaFondo().buildSeguridadPuertaLimite().setId(idArg88);
		this.buildCuentaFondo().buildSeguridadPuertaLimite().setNumero(numeroArg89);
		this.buildCuentaFondo().buildSeguridadPuertaLimite().setNombre(nombreArg90);
		this.buildCuentaFondo().buildSeguridadPuertaLimite().setEquate(equateArg91);
		this.buildCuentaFondo().buildSeguridadPuertaLimite().buildSeguridadModulo().setId(idSeguridadModuloArg92);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, Boolean debeArg2, String idArg3, Integer numeroArg4, String nombreArg5, String idArg6, Integer numeroArg7, String nombreArg8, String idArg9, String codigoArg10, String nombreArg11, String idArg12, Integer numeroArg13, java.util.Date aperturaArg14, java.util.Date cierreArg15, Boolean cerradoArg16, Boolean cerradoModulosArg17, String comentarioArg18, String integraArg19, String cuentaJerarquiaArg20, Boolean imputableArg21, Boolean ajustaPorInflacionArg22, String idArg23, Integer numeroArg24, String nombreArg25, Boolean cuentaConApropiacionArg26, String idArg27, Integer numeroArg28, String nombreArg29, String abreviaturaArg30, String idEjercicioContableArg31, String cuentaAgrupadoraArg32, java.math.BigDecimal porcentajeArg33, String idArg34, Integer numeroArg35, String nombreArg36, String idTipoPuntoEquilibrioArg37, String idEjercicioContableArg38, String idArg39, Integer numeroArg40, String nombreArg41, String idArg42, Integer numeroArg43, String nombreArg44, String equateArg45, String idSeguridadModuloArg46, String idArg47, Integer numeroArg48, String nombreArg49, String idArg50, Integer numeroArg51, String nombreArg52, String idArg53, Integer numeroArg54, String nombreArg55, Boolean obsoletoArg56, Boolean noImprimeCajaArg57, Boolean ventasArg58, Boolean fondosArg59, Boolean comprasArg60, String idArg61, Integer numeroArg62, String nombreArg63, String abreviaturaArg64, java.math.BigDecimal cotizacionArg65, java.sql.Timestamp cotizacionFechaArg66, Boolean controlActualizacionArg67, String idArg68, String codigoArg69, String nombreArg70, String idArg71, Integer numeroArg72, String nombreArg73, String idArg74, Integer numeroArg75, String nombreArg76, String equateArg77, String idSeguridadModuloArg78, Boolean rechazadosArg79, Boolean conciliacionArg80, String idArg81, Integer numeroArg82, String nombreArg83, String idArg84, Integer numeroArg85, String nombreArg86, Long cuitArg87, Boolean bloqueadoArg88, Integer hojaArg89, Integer primeraFilaArg90, Integer ultimaFilaArg91, String fechaArg92, String descripcionArg93, String referencia1Arg94, String importeArg95, String referencia2Arg96, String saldoArg97, String cuentaBancariaArg98, String cbuArg99, java.math.BigDecimal limiteDescubiertoArg100, String cuentaFondoCaucionArg101, String cuentaFondoDiferidosArg102, String formatoArg103, String idArg104, Integer numeroArg105, String nombreArg106, java.math.BigDecimal limiteOperacionIndividualArg107, String idArg108, Integer numeroArg109, String nombreArg110, String equateArg111, String idArg112, Integer numeroArg113, String nombreArg114, String idArg115, Integer numeroArg116, String nombreArg117, String equateArg118, String idArg119, Integer numeroArg120, String nombreArg121, String idArg122, Integer numeroArg123, String nombreArg124, String equateArg125, String idArg126, Integer numeroArg127, String nombreArg128) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setDebe(debeArg2);
		this.buildComprobanteFondoModelo().setId(idArg3);
		this.buildComprobanteFondoModelo().setNumero(numeroArg4);
		this.buildComprobanteFondoModelo().setNombre(nombreArg5);
		this.buildCuentaFondo().setId(idArg6);
		this.buildCuentaFondo().setNumero(numeroArg7);
		this.buildCuentaFondo().setNombre(nombreArg8);
		this.buildCuentaFondo().buildCuentaContable().setId(idArg9);
		this.buildCuentaFondo().buildCuentaContable().setCodigo(codigoArg10);
		this.buildCuentaFondo().buildCuentaContable().setNombre(nombreArg11);
		this.buildCuentaFondo().buildCuentaContable().buildEjercicioContable().setId(idArg12);
		this.buildCuentaFondo().buildCuentaContable().buildEjercicioContable().setNumero(numeroArg13);
		this.buildCuentaFondo().buildCuentaContable().buildEjercicioContable().setApertura(aperturaArg14);
		this.buildCuentaFondo().buildCuentaContable().buildEjercicioContable().setCierre(cierreArg15);
		this.buildCuentaFondo().buildCuentaContable().buildEjercicioContable().setCerrado(cerradoArg16);
		this.buildCuentaFondo().buildCuentaContable().buildEjercicioContable().setCerradoModulos(cerradoModulosArg17);
		this.buildCuentaFondo().buildCuentaContable().buildEjercicioContable().setComentario(comentarioArg18);
		this.buildCuentaFondo().buildCuentaContable().setIntegra(integraArg19);
		this.buildCuentaFondo().buildCuentaContable().setCuentaJerarquia(cuentaJerarquiaArg20);
		this.buildCuentaFondo().buildCuentaContable().setImputable(imputableArg21);
		this.buildCuentaFondo().buildCuentaContable().setAjustaPorInflacion(ajustaPorInflacionArg22);
		this.buildCuentaFondo().buildCuentaContable().buildCuentaContableEstado().setId(idArg23);
		this.buildCuentaFondo().buildCuentaContable().buildCuentaContableEstado().setNumero(numeroArg24);
		this.buildCuentaFondo().buildCuentaContable().buildCuentaContableEstado().setNombre(nombreArg25);
		this.buildCuentaFondo().buildCuentaContable().setCuentaConApropiacion(cuentaConApropiacionArg26);
		this.buildCuentaFondo().buildCuentaContable().buildCentroCostoContable().setId(idArg27);
		this.buildCuentaFondo().buildCuentaContable().buildCentroCostoContable().setNumero(numeroArg28);
		this.buildCuentaFondo().buildCuentaContable().buildCentroCostoContable().setNombre(nombreArg29);
		this.buildCuentaFondo().buildCuentaContable().buildCentroCostoContable().setAbreviatura(abreviaturaArg30);
		this.buildCuentaFondo().buildCuentaContable().buildCentroCostoContable().buildEjercicioContable().setId(idEjercicioContableArg31);
		this.buildCuentaFondo().buildCuentaContable().setCuentaAgrupadora(cuentaAgrupadoraArg32);
		this.buildCuentaFondo().buildCuentaContable().setPorcentaje(porcentajeArg33);
		this.buildCuentaFondo().buildCuentaContable().buildPuntoEquilibrio().setId(idArg34);
		this.buildCuentaFondo().buildCuentaContable().buildPuntoEquilibrio().setNumero(numeroArg35);
		this.buildCuentaFondo().buildCuentaContable().buildPuntoEquilibrio().setNombre(nombreArg36);
		this.buildCuentaFondo().buildCuentaContable().buildPuntoEquilibrio().buildTipoPuntoEquilibrio().setId(idTipoPuntoEquilibrioArg37);
		this.buildCuentaFondo().buildCuentaContable().buildPuntoEquilibrio().buildEjercicioContable().setId(idEjercicioContableArg38);
		this.buildCuentaFondo().buildCuentaContable().buildCostoVenta().setId(idArg39);
		this.buildCuentaFondo().buildCuentaContable().buildCostoVenta().setNumero(numeroArg40);
		this.buildCuentaFondo().buildCuentaContable().buildCostoVenta().setNombre(nombreArg41);
		this.buildCuentaFondo().buildCuentaContable().buildSeguridadPuerta().setId(idArg42);
		this.buildCuentaFondo().buildCuentaContable().buildSeguridadPuerta().setNumero(numeroArg43);
		this.buildCuentaFondo().buildCuentaContable().buildSeguridadPuerta().setNombre(nombreArg44);
		this.buildCuentaFondo().buildCuentaContable().buildSeguridadPuerta().setEquate(equateArg45);
		this.buildCuentaFondo().buildCuentaContable().buildSeguridadPuerta().buildSeguridadModulo().setId(idSeguridadModuloArg46);
		this.buildCuentaFondo().buildCuentaFondoGrupo().setId(idArg47);
		this.buildCuentaFondo().buildCuentaFondoGrupo().setNumero(numeroArg48);
		this.buildCuentaFondo().buildCuentaFondoGrupo().setNombre(nombreArg49);
		this.buildCuentaFondo().buildCuentaFondoGrupo().buildCuentaFondoRubro().setId(idArg50);
		this.buildCuentaFondo().buildCuentaFondoGrupo().buildCuentaFondoRubro().setNumero(numeroArg51);
		this.buildCuentaFondo().buildCuentaFondoGrupo().buildCuentaFondoRubro().setNombre(nombreArg52);
		this.buildCuentaFondo().buildCuentaFondoTipo().setId(idArg53);
		this.buildCuentaFondo().buildCuentaFondoTipo().setNumero(numeroArg54);
		this.buildCuentaFondo().buildCuentaFondoTipo().setNombre(nombreArg55);
		this.buildCuentaFondo().setObsoleto(obsoletoArg56);
		this.buildCuentaFondo().setNoImprimeCaja(noImprimeCajaArg57);
		this.buildCuentaFondo().setVentas(ventasArg58);
		this.buildCuentaFondo().setFondos(fondosArg59);
		this.buildCuentaFondo().setCompras(comprasArg60);
		this.buildCuentaFondo().buildMoneda().setId(idArg61);
		this.buildCuentaFondo().buildMoneda().setNumero(numeroArg62);
		this.buildCuentaFondo().buildMoneda().setNombre(nombreArg63);
		this.buildCuentaFondo().buildMoneda().setAbreviatura(abreviaturaArg64);
		this.buildCuentaFondo().buildMoneda().setCotizacion(cotizacionArg65);
		this.buildCuentaFondo().buildMoneda().setCotizacionFecha(cotizacionFechaArg66);
		this.buildCuentaFondo().buildMoneda().setControlActualizacion(controlActualizacionArg67);
		this.buildCuentaFondo().buildMoneda().buildMonedaAFIP().setId(idArg68);
		this.buildCuentaFondo().buildMoneda().buildMonedaAFIP().setCodigo(codigoArg69);
		this.buildCuentaFondo().buildMoneda().buildMonedaAFIP().setNombre(nombreArg70);
		this.buildCuentaFondo().buildCaja().setId(idArg71);
		this.buildCuentaFondo().buildCaja().setNumero(numeroArg72);
		this.buildCuentaFondo().buildCaja().setNombre(nombreArg73);
		this.buildCuentaFondo().buildCaja().buildSeguridadPuerta().setId(idArg74);
		this.buildCuentaFondo().buildCaja().buildSeguridadPuerta().setNumero(numeroArg75);
		this.buildCuentaFondo().buildCaja().buildSeguridadPuerta().setNombre(nombreArg76);
		this.buildCuentaFondo().buildCaja().buildSeguridadPuerta().setEquate(equateArg77);
		this.buildCuentaFondo().buildCaja().buildSeguridadPuerta().buildSeguridadModulo().setId(idSeguridadModuloArg78);
		this.buildCuentaFondo().setRechazados(rechazadosArg79);
		this.buildCuentaFondo().setConciliacion(conciliacionArg80);
		this.buildCuentaFondo().buildCuentaFondoTipoBanco().setId(idArg81);
		this.buildCuentaFondo().buildCuentaFondoTipoBanco().setNumero(numeroArg82);
		this.buildCuentaFondo().buildCuentaFondoTipoBanco().setNombre(nombreArg83);
		this.buildCuentaFondo().buildBanco().setId(idArg84);
		this.buildCuentaFondo().buildBanco().setNumero(numeroArg85);
		this.buildCuentaFondo().buildBanco().setNombre(nombreArg86);
		this.buildCuentaFondo().buildBanco().setCuit(cuitArg87);
		this.buildCuentaFondo().buildBanco().setBloqueado(bloqueadoArg88);
		this.buildCuentaFondo().buildBanco().setHoja(hojaArg89);
		this.buildCuentaFondo().buildBanco().setPrimeraFila(primeraFilaArg90);
		this.buildCuentaFondo().buildBanco().setUltimaFila(ultimaFilaArg91);
		this.buildCuentaFondo().buildBanco().setFecha(fechaArg92);
		this.buildCuentaFondo().buildBanco().setDescripcion(descripcionArg93);
		this.buildCuentaFondo().buildBanco().setReferencia1(referencia1Arg94);
		this.buildCuentaFondo().buildBanco().setImporte(importeArg95);
		this.buildCuentaFondo().buildBanco().setReferencia2(referencia2Arg96);
		this.buildCuentaFondo().buildBanco().setSaldo(saldoArg97);
		this.buildCuentaFondo().setCuentaBancaria(cuentaBancariaArg98);
		this.buildCuentaFondo().setCbu(cbuArg99);
		this.buildCuentaFondo().setLimiteDescubierto(limiteDescubiertoArg100);
		this.buildCuentaFondo().setCuentaFondoCaucion(cuentaFondoCaucionArg101);
		this.buildCuentaFondo().setCuentaFondoDiferidos(cuentaFondoDiferidosArg102);
		this.buildCuentaFondo().setFormato(formatoArg103);
		this.buildCuentaFondo().buildCuentaFondoBancoCopia().setId(idArg104);
		this.buildCuentaFondo().buildCuentaFondoBancoCopia().setNumero(numeroArg105);
		this.buildCuentaFondo().buildCuentaFondoBancoCopia().setNombre(nombreArg106);
		this.buildCuentaFondo().setLimiteOperacionIndividual(limiteOperacionIndividualArg107);
		this.buildCuentaFondo().buildSeguridadPuertaUso().setId(idArg108);
		this.buildCuentaFondo().buildSeguridadPuertaUso().setNumero(numeroArg109);
		this.buildCuentaFondo().buildSeguridadPuertaUso().setNombre(nombreArg110);
		this.buildCuentaFondo().buildSeguridadPuertaUso().setEquate(equateArg111);
		this.buildCuentaFondo().buildSeguridadPuertaUso().buildSeguridadModulo().setId(idArg112);
		this.buildCuentaFondo().buildSeguridadPuertaUso().buildSeguridadModulo().setNumero(numeroArg113);
		this.buildCuentaFondo().buildSeguridadPuertaUso().buildSeguridadModulo().setNombre(nombreArg114);
		this.buildCuentaFondo().buildSeguridadPuertaConsulta().setId(idArg115);
		this.buildCuentaFondo().buildSeguridadPuertaConsulta().setNumero(numeroArg116);
		this.buildCuentaFondo().buildSeguridadPuertaConsulta().setNombre(nombreArg117);
		this.buildCuentaFondo().buildSeguridadPuertaConsulta().setEquate(equateArg118);
		this.buildCuentaFondo().buildSeguridadPuertaConsulta().buildSeguridadModulo().setId(idArg119);
		this.buildCuentaFondo().buildSeguridadPuertaConsulta().buildSeguridadModulo().setNumero(numeroArg120);
		this.buildCuentaFondo().buildSeguridadPuertaConsulta().buildSeguridadModulo().setNombre(nombreArg121);
		this.buildCuentaFondo().buildSeguridadPuertaLimite().setId(idArg122);
		this.buildCuentaFondo().buildSeguridadPuertaLimite().setNumero(numeroArg123);
		this.buildCuentaFondo().buildSeguridadPuertaLimite().setNombre(nombreArg124);
		this.buildCuentaFondo().buildSeguridadPuertaLimite().setEquate(equateArg125);
		this.buildCuentaFondo().buildSeguridadPuertaLimite().buildSeguridadModulo().setId(idArg126);
		this.buildCuentaFondo().buildSeguridadPuertaLimite().buildSeguridadModulo().setNumero(numeroArg127);
		this.buildCuentaFondo().buildSeguridadPuertaLimite().buildSeguridadModulo().setNombre(nombreArg128);

	}

	// ---------------------------------------------------------------------------------------------------------------------------

	public String toString() {
		if(this.getNumero() != null && this.getDebe() != null){
			return this.getNumero() + " - " +  this.getDebe();
		} else if(this.getNumero() != null && this.getDebe() == null){
			return this.getNumero().toString();
		} else if(this.getNumero() == null && this.getDebe() != null){
			return this.getDebe().toString();
		} else {
			return super.toString();
		}
	}

} // END CLASS ----------------------------------------------------------------------------------------------------------