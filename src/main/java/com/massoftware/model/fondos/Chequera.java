package com.massoftware.model.fondos;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.model.EntityId;
import com.massoftware.model.fondos.CuentaFondo;

@ClassLabelAnont(singular = "Chequera", plural = "Chequeras", singularPre = "la chequera", pluralPre = "las chequeras")
public class Chequera extends EntityId {

	// ---------------------------------------------------------------------------------------------------------------------------


	@FieldConfAnont(label = "ID")
	private String id;

	// Nº chequera
	@FieldConfAnont(label = "Nº chequera", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numero;

	// Nombre
	@FieldConfAnont(label = "Nombre", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String nombre;

	// Cuenta fondo
	@FieldConfAnont(label = "Cuenta fondo", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private CuentaFondo cuentaFondo;

	// Primer número
	@FieldConfAnont(label = "Primer número", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "0", maxValue = "2147483647", mask = "")
	private Integer primerNumero;

	// Último número
	@FieldConfAnont(label = "Último número", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "0", maxValue = "2147483647", mask = "")
	private Integer ultimoNumero;

	// Próximo número
	@FieldConfAnont(label = "Próximo número", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "0", maxValue = "2147483647", mask = "")
	private Integer proximoNumero;

	// Obsoleto
	@FieldConfAnont(label = "Obsoleto", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Boolean bloqueado = false;

	// Impresión diferida
	@FieldConfAnont(label = "Impresión diferida", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Boolean impresionDiferida = false;

	// Formato
	@FieldConfAnont(label = "Formato", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String formato;

	// ---------------------------------------------------------------------------------------------------------------------------


	public Chequera() throws Exception {
	}

	public Chequera(String idArg0, Integer numeroArg1, String nombreArg2, String idCuentaFondoArg3, Integer primerNumeroArg4, Integer ultimoNumeroArg5, Integer proximoNumeroArg6, Boolean bloqueadoArg7, Boolean impresionDiferidaArg8, String formatoArg9) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, idCuentaFondoArg3, primerNumeroArg4, ultimoNumeroArg5, proximoNumeroArg6, bloqueadoArg7, impresionDiferidaArg8, formatoArg9);

	}

	public Chequera(String idArg0, Integer numeroArg1, String nombreArg2, String idArg3, Integer numeroArg4, String nombreArg5, String idCuentaContableArg6, String idCuentaFondoGrupoArg7, String idCuentaFondoTipoArg8, Boolean obsoletoArg9, Boolean noImprimeCajaArg10, Boolean ventasArg11, Boolean fondosArg12, Boolean comprasArg13, String idMonedaArg14, String idCajaArg15, Boolean rechazadosArg16, Boolean conciliacionArg17, String idCuentaFondoTipoBancoArg18, String idBancoArg19, String cuentaBancariaArg20, String cbuArg21, java.math.BigDecimal limiteDescubiertoArg22, String cuentaFondoCaucionArg23, String cuentaFondoDiferidosArg24, String formatoArg25, String idCuentaFondoBancoCopiaArg26, java.math.BigDecimal limiteOperacionIndividualArg27, String idSeguridadPuertaArg28, String idSeguridadPuertaArg29, String idSeguridadPuertaArg30, Integer primerNumeroArg31, Integer ultimoNumeroArg32, Integer proximoNumeroArg33, Boolean bloqueadoArg34, Boolean impresionDiferidaArg35, String formatoArg36) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, idArg3, numeroArg4, nombreArg5, idCuentaContableArg6, idCuentaFondoGrupoArg7, idCuentaFondoTipoArg8, obsoletoArg9, noImprimeCajaArg10, ventasArg11, fondosArg12, comprasArg13, idMonedaArg14, idCajaArg15, rechazadosArg16, conciliacionArg17, idCuentaFondoTipoBancoArg18, idBancoArg19, cuentaBancariaArg20, cbuArg21, limiteDescubiertoArg22, cuentaFondoCaucionArg23, cuentaFondoDiferidosArg24, formatoArg25, idCuentaFondoBancoCopiaArg26, limiteOperacionIndividualArg27, idSeguridadPuertaArg28, idSeguridadPuertaArg29, idSeguridadPuertaArg30, primerNumeroArg31, ultimoNumeroArg32, proximoNumeroArg33, bloqueadoArg34, impresionDiferidaArg35, formatoArg36);

	}

	public Chequera(String idArg0, Integer numeroArg1, String nombreArg2, String idArg3, Integer numeroArg4, String nombreArg5, String idArg6, String codigoArg7, String nombreArg8, String idEjercicioContableArg9, String integraArg10, String cuentaJerarquiaArg11, Boolean imputableArg12, Boolean ajustaPorInflacionArg13, String idCuentaContableEstadoArg14, Boolean cuentaConApropiacionArg15, String idCentroCostoContableArg16, String cuentaAgrupadoraArg17, java.math.BigDecimal porcentajeArg18, String idPuntoEquilibrioArg19, String idCostoVentaArg20, String idSeguridadPuertaArg21, String idArg22, Integer numeroArg23, String nombreArg24, String idCuentaFondoRubroArg25, String idArg26, Integer numeroArg27, String nombreArg28, Boolean obsoletoArg29, Boolean noImprimeCajaArg30, Boolean ventasArg31, Boolean fondosArg32, Boolean comprasArg33, String idArg34, Integer numeroArg35, String nombreArg36, String abreviaturaArg37, java.math.BigDecimal cotizacionArg38, java.sql.Timestamp cotizacionFechaArg39, Boolean controlActualizacionArg40, String idMonedaAFIPArg41, String idArg42, Integer numeroArg43, String nombreArg44, String idSeguridadPuertaArg45, Boolean rechazadosArg46, Boolean conciliacionArg47, String idArg48, Integer numeroArg49, String nombreArg50, String idArg51, Integer numeroArg52, String nombreArg53, Long cuitArg54, Boolean bloqueadoArg55, Integer hojaArg56, Integer primeraFilaArg57, Integer ultimaFilaArg58, String fechaArg59, String descripcionArg60, String referencia1Arg61, String importeArg62, String referencia2Arg63, String saldoArg64, String cuentaBancariaArg65, String cbuArg66, java.math.BigDecimal limiteDescubiertoArg67, String cuentaFondoCaucionArg68, String cuentaFondoDiferidosArg69, String formatoArg70, String idArg71, Integer numeroArg72, String nombreArg73, java.math.BigDecimal limiteOperacionIndividualArg74, String idArg75, Integer numeroArg76, String nombreArg77, String equateArg78, String idSeguridadModuloArg79, String idArg80, Integer numeroArg81, String nombreArg82, String equateArg83, String idSeguridadModuloArg84, String idArg85, Integer numeroArg86, String nombreArg87, String equateArg88, String idSeguridadModuloArg89, Integer primerNumeroArg90, Integer ultimoNumeroArg91, Integer proximoNumeroArg92, Boolean bloqueadoArg93, Boolean impresionDiferidaArg94, String formatoArg95) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, idArg3, numeroArg4, nombreArg5, idArg6, codigoArg7, nombreArg8, idEjercicioContableArg9, integraArg10, cuentaJerarquiaArg11, imputableArg12, ajustaPorInflacionArg13, idCuentaContableEstadoArg14, cuentaConApropiacionArg15, idCentroCostoContableArg16, cuentaAgrupadoraArg17, porcentajeArg18, idPuntoEquilibrioArg19, idCostoVentaArg20, idSeguridadPuertaArg21, idArg22, numeroArg23, nombreArg24, idCuentaFondoRubroArg25, idArg26, numeroArg27, nombreArg28, obsoletoArg29, noImprimeCajaArg30, ventasArg31, fondosArg32, comprasArg33, idArg34, numeroArg35, nombreArg36, abreviaturaArg37, cotizacionArg38, cotizacionFechaArg39, controlActualizacionArg40, idMonedaAFIPArg41, idArg42, numeroArg43, nombreArg44, idSeguridadPuertaArg45, rechazadosArg46, conciliacionArg47, idArg48, numeroArg49, nombreArg50, idArg51, numeroArg52, nombreArg53, cuitArg54, bloqueadoArg55, hojaArg56, primeraFilaArg57, ultimaFilaArg58, fechaArg59, descripcionArg60, referencia1Arg61, importeArg62, referencia2Arg63, saldoArg64, cuentaBancariaArg65, cbuArg66, limiteDescubiertoArg67, cuentaFondoCaucionArg68, cuentaFondoDiferidosArg69, formatoArg70, idArg71, numeroArg72, nombreArg73, limiteOperacionIndividualArg74, idArg75, numeroArg76, nombreArg77, equateArg78, idSeguridadModuloArg79, idArg80, numeroArg81, nombreArg82, equateArg83, idSeguridadModuloArg84, idArg85, numeroArg86, nombreArg87, equateArg88, idSeguridadModuloArg89, primerNumeroArg90, ultimoNumeroArg91, proximoNumeroArg92, bloqueadoArg93, impresionDiferidaArg94, formatoArg95);

	}

	public Chequera(String idArg0, Integer numeroArg1, String nombreArg2, String idArg3, Integer numeroArg4, String nombreArg5, String idArg6, String codigoArg7, String nombreArg8, String idArg9, Integer numeroArg10, java.util.Date aperturaArg11, java.util.Date cierreArg12, Boolean cerradoArg13, Boolean cerradoModulosArg14, String comentarioArg15, String integraArg16, String cuentaJerarquiaArg17, Boolean imputableArg18, Boolean ajustaPorInflacionArg19, String idArg20, Integer numeroArg21, String nombreArg22, Boolean cuentaConApropiacionArg23, String idArg24, Integer numeroArg25, String nombreArg26, String abreviaturaArg27, String idEjercicioContableArg28, String cuentaAgrupadoraArg29, java.math.BigDecimal porcentajeArg30, String idArg31, Integer numeroArg32, String nombreArg33, String idTipoPuntoEquilibrioArg34, String idEjercicioContableArg35, String idArg36, Integer numeroArg37, String nombreArg38, String idArg39, Integer numeroArg40, String nombreArg41, String equateArg42, String idSeguridadModuloArg43, String idArg44, Integer numeroArg45, String nombreArg46, String idArg47, Integer numeroArg48, String nombreArg49, String idArg50, Integer numeroArg51, String nombreArg52, Boolean obsoletoArg53, Boolean noImprimeCajaArg54, Boolean ventasArg55, Boolean fondosArg56, Boolean comprasArg57, String idArg58, Integer numeroArg59, String nombreArg60, String abreviaturaArg61, java.math.BigDecimal cotizacionArg62, java.sql.Timestamp cotizacionFechaArg63, Boolean controlActualizacionArg64, String idArg65, String codigoArg66, String nombreArg67, String idArg68, Integer numeroArg69, String nombreArg70, String idArg71, Integer numeroArg72, String nombreArg73, String equateArg74, String idSeguridadModuloArg75, Boolean rechazadosArg76, Boolean conciliacionArg77, String idArg78, Integer numeroArg79, String nombreArg80, String idArg81, Integer numeroArg82, String nombreArg83, Long cuitArg84, Boolean bloqueadoArg85, Integer hojaArg86, Integer primeraFilaArg87, Integer ultimaFilaArg88, String fechaArg89, String descripcionArg90, String referencia1Arg91, String importeArg92, String referencia2Arg93, String saldoArg94, String cuentaBancariaArg95, String cbuArg96, java.math.BigDecimal limiteDescubiertoArg97, String cuentaFondoCaucionArg98, String cuentaFondoDiferidosArg99, String formatoArg100, String idArg101, Integer numeroArg102, String nombreArg103, java.math.BigDecimal limiteOperacionIndividualArg104, String idArg105, Integer numeroArg106, String nombreArg107, String equateArg108, String idArg109, Integer numeroArg110, String nombreArg111, String idArg112, Integer numeroArg113, String nombreArg114, String equateArg115, String idArg116, Integer numeroArg117, String nombreArg118, String idArg119, Integer numeroArg120, String nombreArg121, String equateArg122, String idArg123, Integer numeroArg124, String nombreArg125, Integer primerNumeroArg126, Integer ultimoNumeroArg127, Integer proximoNumeroArg128, Boolean bloqueadoArg129, Boolean impresionDiferidaArg130, String formatoArg131) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, idArg3, numeroArg4, nombreArg5, idArg6, codigoArg7, nombreArg8, idArg9, numeroArg10, aperturaArg11, cierreArg12, cerradoArg13, cerradoModulosArg14, comentarioArg15, integraArg16, cuentaJerarquiaArg17, imputableArg18, ajustaPorInflacionArg19, idArg20, numeroArg21, nombreArg22, cuentaConApropiacionArg23, idArg24, numeroArg25, nombreArg26, abreviaturaArg27, idEjercicioContableArg28, cuentaAgrupadoraArg29, porcentajeArg30, idArg31, numeroArg32, nombreArg33, idTipoPuntoEquilibrioArg34, idEjercicioContableArg35, idArg36, numeroArg37, nombreArg38, idArg39, numeroArg40, nombreArg41, equateArg42, idSeguridadModuloArg43, idArg44, numeroArg45, nombreArg46, idArg47, numeroArg48, nombreArg49, idArg50, numeroArg51, nombreArg52, obsoletoArg53, noImprimeCajaArg54, ventasArg55, fondosArg56, comprasArg57, idArg58, numeroArg59, nombreArg60, abreviaturaArg61, cotizacionArg62, cotizacionFechaArg63, controlActualizacionArg64, idArg65, codigoArg66, nombreArg67, idArg68, numeroArg69, nombreArg70, idArg71, numeroArg72, nombreArg73, equateArg74, idSeguridadModuloArg75, rechazadosArg76, conciliacionArg77, idArg78, numeroArg79, nombreArg80, idArg81, numeroArg82, nombreArg83, cuitArg84, bloqueadoArg85, hojaArg86, primeraFilaArg87, ultimaFilaArg88, fechaArg89, descripcionArg90, referencia1Arg91, importeArg92, referencia2Arg93, saldoArg94, cuentaBancariaArg95, cbuArg96, limiteDescubiertoArg97, cuentaFondoCaucionArg98, cuentaFondoDiferidosArg99, formatoArg100, idArg101, numeroArg102, nombreArg103, limiteOperacionIndividualArg104, idArg105, numeroArg106, nombreArg107, equateArg108, idArg109, numeroArg110, nombreArg111, idArg112, numeroArg113, nombreArg114, equateArg115, idArg116, numeroArg117, nombreArg118, idArg119, numeroArg120, nombreArg121, equateArg122, idArg123, numeroArg124, nombreArg125, primerNumeroArg126, ultimoNumeroArg127, proximoNumeroArg128, bloqueadoArg129, impresionDiferidaArg130, formatoArg131);

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

	// GET Nº chequera
	public Integer getNumero() {
		return this.numero;
	}

	// SET Nº chequera
	public void setNumero(Integer numero ){
		this.numero = numero;
	}

	// GET Nombre
	public String getNombre() {
		return this.nombre;
	}

	// SET Nombre
	public void setNombre(String nombre ){
		nombre = (nombre != null) ? nombre.trim() : null;
		this.nombre = (nombre != null && nombre.length() == 0) ? null : nombre;
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

	// GET Primer número
	public Integer getPrimerNumero() {
		return this.primerNumero;
	}

	// SET Primer número
	public void setPrimerNumero(Integer primerNumero ){
		this.primerNumero = primerNumero;
	}

	// GET Último número
	public Integer getUltimoNumero() {
		return this.ultimoNumero;
	}

	// SET Último número
	public void setUltimoNumero(Integer ultimoNumero ){
		this.ultimoNumero = ultimoNumero;
	}

	// GET Próximo número
	public Integer getProximoNumero() {
		return this.proximoNumero;
	}

	// SET Próximo número
	public void setProximoNumero(Integer proximoNumero ){
		this.proximoNumero = proximoNumero;
	}

	// GET Obsoleto
	public Boolean getBloqueado() {
		return this.bloqueado;
	}

	// SET Obsoleto
	public void setBloqueado(Boolean bloqueado ){
		this.bloqueado = (bloqueado == null) ? false : bloqueado;
	}

	// GET Impresión diferida
	public Boolean getImpresionDiferida() {
		return this.impresionDiferida;
	}

	// SET Impresión diferida
	public void setImpresionDiferida(Boolean impresionDiferida ){
		this.impresionDiferida = (impresionDiferida == null) ? false : impresionDiferida;
	}

	// GET Formato
	public String getFormato() {
		return this.formato;
	}

	// SET Formato
	public void setFormato(String formato ){
		formato = (formato != null) ? formato.trim() : null;
		this.formato = (formato != null && formato.length() == 0) ? null : formato;
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String idCuentaFondoArg3, Integer primerNumeroArg4, Integer ultimoNumeroArg5, Integer proximoNumeroArg6, Boolean bloqueadoArg7, Boolean impresionDiferidaArg8, String formatoArg9) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.buildCuentaFondo().setId(idCuentaFondoArg3);
		this.setPrimerNumero(primerNumeroArg4);
		this.setUltimoNumero(ultimoNumeroArg5);
		this.setProximoNumero(proximoNumeroArg6);
		this.setBloqueado(bloqueadoArg7);
		this.setImpresionDiferida(impresionDiferidaArg8);
		this.setFormato(formatoArg9);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String idArg3, Integer numeroArg4, String nombreArg5, String idCuentaContableArg6, String idCuentaFondoGrupoArg7, String idCuentaFondoTipoArg8, Boolean obsoletoArg9, Boolean noImprimeCajaArg10, Boolean ventasArg11, Boolean fondosArg12, Boolean comprasArg13, String idMonedaArg14, String idCajaArg15, Boolean rechazadosArg16, Boolean conciliacionArg17, String idCuentaFondoTipoBancoArg18, String idBancoArg19, String cuentaBancariaArg20, String cbuArg21, java.math.BigDecimal limiteDescubiertoArg22, String cuentaFondoCaucionArg23, String cuentaFondoDiferidosArg24, String formatoArg25, String idCuentaFondoBancoCopiaArg26, java.math.BigDecimal limiteOperacionIndividualArg27, String idSeguridadPuertaArg28, String idSeguridadPuertaArg29, String idSeguridadPuertaArg30, Integer primerNumeroArg31, Integer ultimoNumeroArg32, Integer proximoNumeroArg33, Boolean bloqueadoArg34, Boolean impresionDiferidaArg35, String formatoArg36) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.buildCuentaFondo().setId(idArg3);
		this.buildCuentaFondo().setNumero(numeroArg4);
		this.buildCuentaFondo().setNombre(nombreArg5);
		this.buildCuentaFondo().buildCuentaContable().setId(idCuentaContableArg6);
		this.buildCuentaFondo().buildCuentaFondoGrupo().setId(idCuentaFondoGrupoArg7);
		this.buildCuentaFondo().buildCuentaFondoTipo().setId(idCuentaFondoTipoArg8);
		this.buildCuentaFondo().setObsoleto(obsoletoArg9);
		this.buildCuentaFondo().setNoImprimeCaja(noImprimeCajaArg10);
		this.buildCuentaFondo().setVentas(ventasArg11);
		this.buildCuentaFondo().setFondos(fondosArg12);
		this.buildCuentaFondo().setCompras(comprasArg13);
		this.buildCuentaFondo().buildMoneda().setId(idMonedaArg14);
		this.buildCuentaFondo().buildCaja().setId(idCajaArg15);
		this.buildCuentaFondo().setRechazados(rechazadosArg16);
		this.buildCuentaFondo().setConciliacion(conciliacionArg17);
		this.buildCuentaFondo().buildCuentaFondoTipoBanco().setId(idCuentaFondoTipoBancoArg18);
		this.buildCuentaFondo().buildBanco().setId(idBancoArg19);
		this.buildCuentaFondo().setCuentaBancaria(cuentaBancariaArg20);
		this.buildCuentaFondo().setCbu(cbuArg21);
		this.buildCuentaFondo().setLimiteDescubierto(limiteDescubiertoArg22);
		this.buildCuentaFondo().setCuentaFondoCaucion(cuentaFondoCaucionArg23);
		this.buildCuentaFondo().setCuentaFondoDiferidos(cuentaFondoDiferidosArg24);
		this.buildCuentaFondo().setFormato(formatoArg25);
		this.buildCuentaFondo().buildCuentaFondoBancoCopia().setId(idCuentaFondoBancoCopiaArg26);
		this.buildCuentaFondo().setLimiteOperacionIndividual(limiteOperacionIndividualArg27);
		this.buildCuentaFondo().buildSeguridadPuertaUso().setId(idSeguridadPuertaArg28);
		this.buildCuentaFondo().buildSeguridadPuertaConsulta().setId(idSeguridadPuertaArg29);
		this.buildCuentaFondo().buildSeguridadPuertaLimite().setId(idSeguridadPuertaArg30);
		this.setPrimerNumero(primerNumeroArg31);
		this.setUltimoNumero(ultimoNumeroArg32);
		this.setProximoNumero(proximoNumeroArg33);
		this.setBloqueado(bloqueadoArg34);
		this.setImpresionDiferida(impresionDiferidaArg35);
		this.setFormato(formatoArg36);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String idArg3, Integer numeroArg4, String nombreArg5, String idArg6, String codigoArg7, String nombreArg8, String idEjercicioContableArg9, String integraArg10, String cuentaJerarquiaArg11, Boolean imputableArg12, Boolean ajustaPorInflacionArg13, String idCuentaContableEstadoArg14, Boolean cuentaConApropiacionArg15, String idCentroCostoContableArg16, String cuentaAgrupadoraArg17, java.math.BigDecimal porcentajeArg18, String idPuntoEquilibrioArg19, String idCostoVentaArg20, String idSeguridadPuertaArg21, String idArg22, Integer numeroArg23, String nombreArg24, String idCuentaFondoRubroArg25, String idArg26, Integer numeroArg27, String nombreArg28, Boolean obsoletoArg29, Boolean noImprimeCajaArg30, Boolean ventasArg31, Boolean fondosArg32, Boolean comprasArg33, String idArg34, Integer numeroArg35, String nombreArg36, String abreviaturaArg37, java.math.BigDecimal cotizacionArg38, java.sql.Timestamp cotizacionFechaArg39, Boolean controlActualizacionArg40, String idMonedaAFIPArg41, String idArg42, Integer numeroArg43, String nombreArg44, String idSeguridadPuertaArg45, Boolean rechazadosArg46, Boolean conciliacionArg47, String idArg48, Integer numeroArg49, String nombreArg50, String idArg51, Integer numeroArg52, String nombreArg53, Long cuitArg54, Boolean bloqueadoArg55, Integer hojaArg56, Integer primeraFilaArg57, Integer ultimaFilaArg58, String fechaArg59, String descripcionArg60, String referencia1Arg61, String importeArg62, String referencia2Arg63, String saldoArg64, String cuentaBancariaArg65, String cbuArg66, java.math.BigDecimal limiteDescubiertoArg67, String cuentaFondoCaucionArg68, String cuentaFondoDiferidosArg69, String formatoArg70, String idArg71, Integer numeroArg72, String nombreArg73, java.math.BigDecimal limiteOperacionIndividualArg74, String idArg75, Integer numeroArg76, String nombreArg77, String equateArg78, String idSeguridadModuloArg79, String idArg80, Integer numeroArg81, String nombreArg82, String equateArg83, String idSeguridadModuloArg84, String idArg85, Integer numeroArg86, String nombreArg87, String equateArg88, String idSeguridadModuloArg89, Integer primerNumeroArg90, Integer ultimoNumeroArg91, Integer proximoNumeroArg92, Boolean bloqueadoArg93, Boolean impresionDiferidaArg94, String formatoArg95) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.buildCuentaFondo().setId(idArg3);
		this.buildCuentaFondo().setNumero(numeroArg4);
		this.buildCuentaFondo().setNombre(nombreArg5);
		this.buildCuentaFondo().buildCuentaContable().setId(idArg6);
		this.buildCuentaFondo().buildCuentaContable().setCodigo(codigoArg7);
		this.buildCuentaFondo().buildCuentaContable().setNombre(nombreArg8);
		this.buildCuentaFondo().buildCuentaContable().buildEjercicioContable().setId(idEjercicioContableArg9);
		this.buildCuentaFondo().buildCuentaContable().setIntegra(integraArg10);
		this.buildCuentaFondo().buildCuentaContable().setCuentaJerarquia(cuentaJerarquiaArg11);
		this.buildCuentaFondo().buildCuentaContable().setImputable(imputableArg12);
		this.buildCuentaFondo().buildCuentaContable().setAjustaPorInflacion(ajustaPorInflacionArg13);
		this.buildCuentaFondo().buildCuentaContable().buildCuentaContableEstado().setId(idCuentaContableEstadoArg14);
		this.buildCuentaFondo().buildCuentaContable().setCuentaConApropiacion(cuentaConApropiacionArg15);
		this.buildCuentaFondo().buildCuentaContable().buildCentroCostoContable().setId(idCentroCostoContableArg16);
		this.buildCuentaFondo().buildCuentaContable().setCuentaAgrupadora(cuentaAgrupadoraArg17);
		this.buildCuentaFondo().buildCuentaContable().setPorcentaje(porcentajeArg18);
		this.buildCuentaFondo().buildCuentaContable().buildPuntoEquilibrio().setId(idPuntoEquilibrioArg19);
		this.buildCuentaFondo().buildCuentaContable().buildCostoVenta().setId(idCostoVentaArg20);
		this.buildCuentaFondo().buildCuentaContable().buildSeguridadPuerta().setId(idSeguridadPuertaArg21);
		this.buildCuentaFondo().buildCuentaFondoGrupo().setId(idArg22);
		this.buildCuentaFondo().buildCuentaFondoGrupo().setNumero(numeroArg23);
		this.buildCuentaFondo().buildCuentaFondoGrupo().setNombre(nombreArg24);
		this.buildCuentaFondo().buildCuentaFondoGrupo().buildCuentaFondoRubro().setId(idCuentaFondoRubroArg25);
		this.buildCuentaFondo().buildCuentaFondoTipo().setId(idArg26);
		this.buildCuentaFondo().buildCuentaFondoTipo().setNumero(numeroArg27);
		this.buildCuentaFondo().buildCuentaFondoTipo().setNombre(nombreArg28);
		this.buildCuentaFondo().setObsoleto(obsoletoArg29);
		this.buildCuentaFondo().setNoImprimeCaja(noImprimeCajaArg30);
		this.buildCuentaFondo().setVentas(ventasArg31);
		this.buildCuentaFondo().setFondos(fondosArg32);
		this.buildCuentaFondo().setCompras(comprasArg33);
		this.buildCuentaFondo().buildMoneda().setId(idArg34);
		this.buildCuentaFondo().buildMoneda().setNumero(numeroArg35);
		this.buildCuentaFondo().buildMoneda().setNombre(nombreArg36);
		this.buildCuentaFondo().buildMoneda().setAbreviatura(abreviaturaArg37);
		this.buildCuentaFondo().buildMoneda().setCotizacion(cotizacionArg38);
		this.buildCuentaFondo().buildMoneda().setCotizacionFecha(cotizacionFechaArg39);
		this.buildCuentaFondo().buildMoneda().setControlActualizacion(controlActualizacionArg40);
		this.buildCuentaFondo().buildMoneda().buildMonedaAFIP().setId(idMonedaAFIPArg41);
		this.buildCuentaFondo().buildCaja().setId(idArg42);
		this.buildCuentaFondo().buildCaja().setNumero(numeroArg43);
		this.buildCuentaFondo().buildCaja().setNombre(nombreArg44);
		this.buildCuentaFondo().buildCaja().buildSeguridadPuerta().setId(idSeguridadPuertaArg45);
		this.buildCuentaFondo().setRechazados(rechazadosArg46);
		this.buildCuentaFondo().setConciliacion(conciliacionArg47);
		this.buildCuentaFondo().buildCuentaFondoTipoBanco().setId(idArg48);
		this.buildCuentaFondo().buildCuentaFondoTipoBanco().setNumero(numeroArg49);
		this.buildCuentaFondo().buildCuentaFondoTipoBanco().setNombre(nombreArg50);
		this.buildCuentaFondo().buildBanco().setId(idArg51);
		this.buildCuentaFondo().buildBanco().setNumero(numeroArg52);
		this.buildCuentaFondo().buildBanco().setNombre(nombreArg53);
		this.buildCuentaFondo().buildBanco().setCuit(cuitArg54);
		this.buildCuentaFondo().buildBanco().setBloqueado(bloqueadoArg55);
		this.buildCuentaFondo().buildBanco().setHoja(hojaArg56);
		this.buildCuentaFondo().buildBanco().setPrimeraFila(primeraFilaArg57);
		this.buildCuentaFondo().buildBanco().setUltimaFila(ultimaFilaArg58);
		this.buildCuentaFondo().buildBanco().setFecha(fechaArg59);
		this.buildCuentaFondo().buildBanco().setDescripcion(descripcionArg60);
		this.buildCuentaFondo().buildBanco().setReferencia1(referencia1Arg61);
		this.buildCuentaFondo().buildBanco().setImporte(importeArg62);
		this.buildCuentaFondo().buildBanco().setReferencia2(referencia2Arg63);
		this.buildCuentaFondo().buildBanco().setSaldo(saldoArg64);
		this.buildCuentaFondo().setCuentaBancaria(cuentaBancariaArg65);
		this.buildCuentaFondo().setCbu(cbuArg66);
		this.buildCuentaFondo().setLimiteDescubierto(limiteDescubiertoArg67);
		this.buildCuentaFondo().setCuentaFondoCaucion(cuentaFondoCaucionArg68);
		this.buildCuentaFondo().setCuentaFondoDiferidos(cuentaFondoDiferidosArg69);
		this.buildCuentaFondo().setFormato(formatoArg70);
		this.buildCuentaFondo().buildCuentaFondoBancoCopia().setId(idArg71);
		this.buildCuentaFondo().buildCuentaFondoBancoCopia().setNumero(numeroArg72);
		this.buildCuentaFondo().buildCuentaFondoBancoCopia().setNombre(nombreArg73);
		this.buildCuentaFondo().setLimiteOperacionIndividual(limiteOperacionIndividualArg74);
		this.buildCuentaFondo().buildSeguridadPuertaUso().setId(idArg75);
		this.buildCuentaFondo().buildSeguridadPuertaUso().setNumero(numeroArg76);
		this.buildCuentaFondo().buildSeguridadPuertaUso().setNombre(nombreArg77);
		this.buildCuentaFondo().buildSeguridadPuertaUso().setEquate(equateArg78);
		this.buildCuentaFondo().buildSeguridadPuertaUso().buildSeguridadModulo().setId(idSeguridadModuloArg79);
		this.buildCuentaFondo().buildSeguridadPuertaConsulta().setId(idArg80);
		this.buildCuentaFondo().buildSeguridadPuertaConsulta().setNumero(numeroArg81);
		this.buildCuentaFondo().buildSeguridadPuertaConsulta().setNombre(nombreArg82);
		this.buildCuentaFondo().buildSeguridadPuertaConsulta().setEquate(equateArg83);
		this.buildCuentaFondo().buildSeguridadPuertaConsulta().buildSeguridadModulo().setId(idSeguridadModuloArg84);
		this.buildCuentaFondo().buildSeguridadPuertaLimite().setId(idArg85);
		this.buildCuentaFondo().buildSeguridadPuertaLimite().setNumero(numeroArg86);
		this.buildCuentaFondo().buildSeguridadPuertaLimite().setNombre(nombreArg87);
		this.buildCuentaFondo().buildSeguridadPuertaLimite().setEquate(equateArg88);
		this.buildCuentaFondo().buildSeguridadPuertaLimite().buildSeguridadModulo().setId(idSeguridadModuloArg89);
		this.setPrimerNumero(primerNumeroArg90);
		this.setUltimoNumero(ultimoNumeroArg91);
		this.setProximoNumero(proximoNumeroArg92);
		this.setBloqueado(bloqueadoArg93);
		this.setImpresionDiferida(impresionDiferidaArg94);
		this.setFormato(formatoArg95);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String idArg3, Integer numeroArg4, String nombreArg5, String idArg6, String codigoArg7, String nombreArg8, String idArg9, Integer numeroArg10, java.util.Date aperturaArg11, java.util.Date cierreArg12, Boolean cerradoArg13, Boolean cerradoModulosArg14, String comentarioArg15, String integraArg16, String cuentaJerarquiaArg17, Boolean imputableArg18, Boolean ajustaPorInflacionArg19, String idArg20, Integer numeroArg21, String nombreArg22, Boolean cuentaConApropiacionArg23, String idArg24, Integer numeroArg25, String nombreArg26, String abreviaturaArg27, String idEjercicioContableArg28, String cuentaAgrupadoraArg29, java.math.BigDecimal porcentajeArg30, String idArg31, Integer numeroArg32, String nombreArg33, String idTipoPuntoEquilibrioArg34, String idEjercicioContableArg35, String idArg36, Integer numeroArg37, String nombreArg38, String idArg39, Integer numeroArg40, String nombreArg41, String equateArg42, String idSeguridadModuloArg43, String idArg44, Integer numeroArg45, String nombreArg46, String idArg47, Integer numeroArg48, String nombreArg49, String idArg50, Integer numeroArg51, String nombreArg52, Boolean obsoletoArg53, Boolean noImprimeCajaArg54, Boolean ventasArg55, Boolean fondosArg56, Boolean comprasArg57, String idArg58, Integer numeroArg59, String nombreArg60, String abreviaturaArg61, java.math.BigDecimal cotizacionArg62, java.sql.Timestamp cotizacionFechaArg63, Boolean controlActualizacionArg64, String idArg65, String codigoArg66, String nombreArg67, String idArg68, Integer numeroArg69, String nombreArg70, String idArg71, Integer numeroArg72, String nombreArg73, String equateArg74, String idSeguridadModuloArg75, Boolean rechazadosArg76, Boolean conciliacionArg77, String idArg78, Integer numeroArg79, String nombreArg80, String idArg81, Integer numeroArg82, String nombreArg83, Long cuitArg84, Boolean bloqueadoArg85, Integer hojaArg86, Integer primeraFilaArg87, Integer ultimaFilaArg88, String fechaArg89, String descripcionArg90, String referencia1Arg91, String importeArg92, String referencia2Arg93, String saldoArg94, String cuentaBancariaArg95, String cbuArg96, java.math.BigDecimal limiteDescubiertoArg97, String cuentaFondoCaucionArg98, String cuentaFondoDiferidosArg99, String formatoArg100, String idArg101, Integer numeroArg102, String nombreArg103, java.math.BigDecimal limiteOperacionIndividualArg104, String idArg105, Integer numeroArg106, String nombreArg107, String equateArg108, String idArg109, Integer numeroArg110, String nombreArg111, String idArg112, Integer numeroArg113, String nombreArg114, String equateArg115, String idArg116, Integer numeroArg117, String nombreArg118, String idArg119, Integer numeroArg120, String nombreArg121, String equateArg122, String idArg123, Integer numeroArg124, String nombreArg125, Integer primerNumeroArg126, Integer ultimoNumeroArg127, Integer proximoNumeroArg128, Boolean bloqueadoArg129, Boolean impresionDiferidaArg130, String formatoArg131) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.buildCuentaFondo().setId(idArg3);
		this.buildCuentaFondo().setNumero(numeroArg4);
		this.buildCuentaFondo().setNombre(nombreArg5);
		this.buildCuentaFondo().buildCuentaContable().setId(idArg6);
		this.buildCuentaFondo().buildCuentaContable().setCodigo(codigoArg7);
		this.buildCuentaFondo().buildCuentaContable().setNombre(nombreArg8);
		this.buildCuentaFondo().buildCuentaContable().buildEjercicioContable().setId(idArg9);
		this.buildCuentaFondo().buildCuentaContable().buildEjercicioContable().setNumero(numeroArg10);
		this.buildCuentaFondo().buildCuentaContable().buildEjercicioContable().setApertura(aperturaArg11);
		this.buildCuentaFondo().buildCuentaContable().buildEjercicioContable().setCierre(cierreArg12);
		this.buildCuentaFondo().buildCuentaContable().buildEjercicioContable().setCerrado(cerradoArg13);
		this.buildCuentaFondo().buildCuentaContable().buildEjercicioContable().setCerradoModulos(cerradoModulosArg14);
		this.buildCuentaFondo().buildCuentaContable().buildEjercicioContable().setComentario(comentarioArg15);
		this.buildCuentaFondo().buildCuentaContable().setIntegra(integraArg16);
		this.buildCuentaFondo().buildCuentaContable().setCuentaJerarquia(cuentaJerarquiaArg17);
		this.buildCuentaFondo().buildCuentaContable().setImputable(imputableArg18);
		this.buildCuentaFondo().buildCuentaContable().setAjustaPorInflacion(ajustaPorInflacionArg19);
		this.buildCuentaFondo().buildCuentaContable().buildCuentaContableEstado().setId(idArg20);
		this.buildCuentaFondo().buildCuentaContable().buildCuentaContableEstado().setNumero(numeroArg21);
		this.buildCuentaFondo().buildCuentaContable().buildCuentaContableEstado().setNombre(nombreArg22);
		this.buildCuentaFondo().buildCuentaContable().setCuentaConApropiacion(cuentaConApropiacionArg23);
		this.buildCuentaFondo().buildCuentaContable().buildCentroCostoContable().setId(idArg24);
		this.buildCuentaFondo().buildCuentaContable().buildCentroCostoContable().setNumero(numeroArg25);
		this.buildCuentaFondo().buildCuentaContable().buildCentroCostoContable().setNombre(nombreArg26);
		this.buildCuentaFondo().buildCuentaContable().buildCentroCostoContable().setAbreviatura(abreviaturaArg27);
		this.buildCuentaFondo().buildCuentaContable().buildCentroCostoContable().buildEjercicioContable().setId(idEjercicioContableArg28);
		this.buildCuentaFondo().buildCuentaContable().setCuentaAgrupadora(cuentaAgrupadoraArg29);
		this.buildCuentaFondo().buildCuentaContable().setPorcentaje(porcentajeArg30);
		this.buildCuentaFondo().buildCuentaContable().buildPuntoEquilibrio().setId(idArg31);
		this.buildCuentaFondo().buildCuentaContable().buildPuntoEquilibrio().setNumero(numeroArg32);
		this.buildCuentaFondo().buildCuentaContable().buildPuntoEquilibrio().setNombre(nombreArg33);
		this.buildCuentaFondo().buildCuentaContable().buildPuntoEquilibrio().buildTipoPuntoEquilibrio().setId(idTipoPuntoEquilibrioArg34);
		this.buildCuentaFondo().buildCuentaContable().buildPuntoEquilibrio().buildEjercicioContable().setId(idEjercicioContableArg35);
		this.buildCuentaFondo().buildCuentaContable().buildCostoVenta().setId(idArg36);
		this.buildCuentaFondo().buildCuentaContable().buildCostoVenta().setNumero(numeroArg37);
		this.buildCuentaFondo().buildCuentaContable().buildCostoVenta().setNombre(nombreArg38);
		this.buildCuentaFondo().buildCuentaContable().buildSeguridadPuerta().setId(idArg39);
		this.buildCuentaFondo().buildCuentaContable().buildSeguridadPuerta().setNumero(numeroArg40);
		this.buildCuentaFondo().buildCuentaContable().buildSeguridadPuerta().setNombre(nombreArg41);
		this.buildCuentaFondo().buildCuentaContable().buildSeguridadPuerta().setEquate(equateArg42);
		this.buildCuentaFondo().buildCuentaContable().buildSeguridadPuerta().buildSeguridadModulo().setId(idSeguridadModuloArg43);
		this.buildCuentaFondo().buildCuentaFondoGrupo().setId(idArg44);
		this.buildCuentaFondo().buildCuentaFondoGrupo().setNumero(numeroArg45);
		this.buildCuentaFondo().buildCuentaFondoGrupo().setNombre(nombreArg46);
		this.buildCuentaFondo().buildCuentaFondoGrupo().buildCuentaFondoRubro().setId(idArg47);
		this.buildCuentaFondo().buildCuentaFondoGrupo().buildCuentaFondoRubro().setNumero(numeroArg48);
		this.buildCuentaFondo().buildCuentaFondoGrupo().buildCuentaFondoRubro().setNombre(nombreArg49);
		this.buildCuentaFondo().buildCuentaFondoTipo().setId(idArg50);
		this.buildCuentaFondo().buildCuentaFondoTipo().setNumero(numeroArg51);
		this.buildCuentaFondo().buildCuentaFondoTipo().setNombre(nombreArg52);
		this.buildCuentaFondo().setObsoleto(obsoletoArg53);
		this.buildCuentaFondo().setNoImprimeCaja(noImprimeCajaArg54);
		this.buildCuentaFondo().setVentas(ventasArg55);
		this.buildCuentaFondo().setFondos(fondosArg56);
		this.buildCuentaFondo().setCompras(comprasArg57);
		this.buildCuentaFondo().buildMoneda().setId(idArg58);
		this.buildCuentaFondo().buildMoneda().setNumero(numeroArg59);
		this.buildCuentaFondo().buildMoneda().setNombre(nombreArg60);
		this.buildCuentaFondo().buildMoneda().setAbreviatura(abreviaturaArg61);
		this.buildCuentaFondo().buildMoneda().setCotizacion(cotizacionArg62);
		this.buildCuentaFondo().buildMoneda().setCotizacionFecha(cotizacionFechaArg63);
		this.buildCuentaFondo().buildMoneda().setControlActualizacion(controlActualizacionArg64);
		this.buildCuentaFondo().buildMoneda().buildMonedaAFIP().setId(idArg65);
		this.buildCuentaFondo().buildMoneda().buildMonedaAFIP().setCodigo(codigoArg66);
		this.buildCuentaFondo().buildMoneda().buildMonedaAFIP().setNombre(nombreArg67);
		this.buildCuentaFondo().buildCaja().setId(idArg68);
		this.buildCuentaFondo().buildCaja().setNumero(numeroArg69);
		this.buildCuentaFondo().buildCaja().setNombre(nombreArg70);
		this.buildCuentaFondo().buildCaja().buildSeguridadPuerta().setId(idArg71);
		this.buildCuentaFondo().buildCaja().buildSeguridadPuerta().setNumero(numeroArg72);
		this.buildCuentaFondo().buildCaja().buildSeguridadPuerta().setNombre(nombreArg73);
		this.buildCuentaFondo().buildCaja().buildSeguridadPuerta().setEquate(equateArg74);
		this.buildCuentaFondo().buildCaja().buildSeguridadPuerta().buildSeguridadModulo().setId(idSeguridadModuloArg75);
		this.buildCuentaFondo().setRechazados(rechazadosArg76);
		this.buildCuentaFondo().setConciliacion(conciliacionArg77);
		this.buildCuentaFondo().buildCuentaFondoTipoBanco().setId(idArg78);
		this.buildCuentaFondo().buildCuentaFondoTipoBanco().setNumero(numeroArg79);
		this.buildCuentaFondo().buildCuentaFondoTipoBanco().setNombre(nombreArg80);
		this.buildCuentaFondo().buildBanco().setId(idArg81);
		this.buildCuentaFondo().buildBanco().setNumero(numeroArg82);
		this.buildCuentaFondo().buildBanco().setNombre(nombreArg83);
		this.buildCuentaFondo().buildBanco().setCuit(cuitArg84);
		this.buildCuentaFondo().buildBanco().setBloqueado(bloqueadoArg85);
		this.buildCuentaFondo().buildBanco().setHoja(hojaArg86);
		this.buildCuentaFondo().buildBanco().setPrimeraFila(primeraFilaArg87);
		this.buildCuentaFondo().buildBanco().setUltimaFila(ultimaFilaArg88);
		this.buildCuentaFondo().buildBanco().setFecha(fechaArg89);
		this.buildCuentaFondo().buildBanco().setDescripcion(descripcionArg90);
		this.buildCuentaFondo().buildBanco().setReferencia1(referencia1Arg91);
		this.buildCuentaFondo().buildBanco().setImporte(importeArg92);
		this.buildCuentaFondo().buildBanco().setReferencia2(referencia2Arg93);
		this.buildCuentaFondo().buildBanco().setSaldo(saldoArg94);
		this.buildCuentaFondo().setCuentaBancaria(cuentaBancariaArg95);
		this.buildCuentaFondo().setCbu(cbuArg96);
		this.buildCuentaFondo().setLimiteDescubierto(limiteDescubiertoArg97);
		this.buildCuentaFondo().setCuentaFondoCaucion(cuentaFondoCaucionArg98);
		this.buildCuentaFondo().setCuentaFondoDiferidos(cuentaFondoDiferidosArg99);
		this.buildCuentaFondo().setFormato(formatoArg100);
		this.buildCuentaFondo().buildCuentaFondoBancoCopia().setId(idArg101);
		this.buildCuentaFondo().buildCuentaFondoBancoCopia().setNumero(numeroArg102);
		this.buildCuentaFondo().buildCuentaFondoBancoCopia().setNombre(nombreArg103);
		this.buildCuentaFondo().setLimiteOperacionIndividual(limiteOperacionIndividualArg104);
		this.buildCuentaFondo().buildSeguridadPuertaUso().setId(idArg105);
		this.buildCuentaFondo().buildSeguridadPuertaUso().setNumero(numeroArg106);
		this.buildCuentaFondo().buildSeguridadPuertaUso().setNombre(nombreArg107);
		this.buildCuentaFondo().buildSeguridadPuertaUso().setEquate(equateArg108);
		this.buildCuentaFondo().buildSeguridadPuertaUso().buildSeguridadModulo().setId(idArg109);
		this.buildCuentaFondo().buildSeguridadPuertaUso().buildSeguridadModulo().setNumero(numeroArg110);
		this.buildCuentaFondo().buildSeguridadPuertaUso().buildSeguridadModulo().setNombre(nombreArg111);
		this.buildCuentaFondo().buildSeguridadPuertaConsulta().setId(idArg112);
		this.buildCuentaFondo().buildSeguridadPuertaConsulta().setNumero(numeroArg113);
		this.buildCuentaFondo().buildSeguridadPuertaConsulta().setNombre(nombreArg114);
		this.buildCuentaFondo().buildSeguridadPuertaConsulta().setEquate(equateArg115);
		this.buildCuentaFondo().buildSeguridadPuertaConsulta().buildSeguridadModulo().setId(idArg116);
		this.buildCuentaFondo().buildSeguridadPuertaConsulta().buildSeguridadModulo().setNumero(numeroArg117);
		this.buildCuentaFondo().buildSeguridadPuertaConsulta().buildSeguridadModulo().setNombre(nombreArg118);
		this.buildCuentaFondo().buildSeguridadPuertaLimite().setId(idArg119);
		this.buildCuentaFondo().buildSeguridadPuertaLimite().setNumero(numeroArg120);
		this.buildCuentaFondo().buildSeguridadPuertaLimite().setNombre(nombreArg121);
		this.buildCuentaFondo().buildSeguridadPuertaLimite().setEquate(equateArg122);
		this.buildCuentaFondo().buildSeguridadPuertaLimite().buildSeguridadModulo().setId(idArg123);
		this.buildCuentaFondo().buildSeguridadPuertaLimite().buildSeguridadModulo().setNumero(numeroArg124);
		this.buildCuentaFondo().buildSeguridadPuertaLimite().buildSeguridadModulo().setNombre(nombreArg125);
		this.setPrimerNumero(primerNumeroArg126);
		this.setUltimoNumero(ultimoNumeroArg127);
		this.setProximoNumero(proximoNumeroArg128);
		this.setBloqueado(bloqueadoArg129);
		this.setImpresionDiferida(impresionDiferidaArg130);
		this.setFormato(formatoArg131);

	}

	// ---------------------------------------------------------------------------------------------------------------------------

	public String toString() {
		if(this.getNumero() != null && this.getNombre() != null){
			return this.getNumero() + " - " +  this.getNombre();
		} else if(this.getNumero() != null && this.getNombre() == null){
			return this.getNumero().toString();
		} else if(this.getNumero() == null && this.getNombre() != null){
			return this.getNombre();
		} else {
			return super.toString();
		}
	}

} // END CLASS ----------------------------------------------------------------------------------------------------------