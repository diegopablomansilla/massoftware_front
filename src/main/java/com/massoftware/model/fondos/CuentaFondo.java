package com.massoftware.model.fondos;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.model.EntityId;
import com.massoftware.model.contabilidad.CuentaContable;
import com.massoftware.model.fondos.CuentaFondoGrupo;
import com.massoftware.model.fondos.CuentaFondoTipo;
import com.massoftware.model.monedas.Moneda;
import com.massoftware.model.fondos.Caja;
import com.massoftware.model.fondos.CuentaFondoTipoBanco;
import com.massoftware.model.fondos.banco.Banco;
import com.massoftware.model.fondos.CuentaFondoBancoCopia;
import com.massoftware.model.seguridad.SeguridadPuerta;
import com.massoftware.model.seguridad.SeguridadPuerta;
import com.massoftware.model.seguridad.SeguridadPuerta;

@ClassLabelAnont(singular = "Cuenta fondo", plural = "Cuentas fondo", singularPre = "la cuenta fondo", pluralPre = "las cuentas fondo")
public class CuentaFondo extends EntityId {

	// ---------------------------------------------------------------------------------------------------------------------------


	@FieldConfAnont(label = "ID")
	private String id;

	// Nº cuenta
	@FieldConfAnont(label = "Nº cuenta", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numero;

	// Nombre
	@FieldConfAnont(label = "Nombre", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String nombre;

	// Cuenta contable
	@FieldConfAnont(label = "Cuenta contable", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private CuentaContable cuentaContable;

	// Grupo
	@FieldConfAnont(label = "Grupo", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private CuentaFondoGrupo cuentaFondoGrupo;

	// Tipo
	@FieldConfAnont(label = "Tipo", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private CuentaFondoTipo cuentaFondoTipo;

	// Obsoleto
	@FieldConfAnont(label = "Obsoleto", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Boolean obsoleto = false;

	// No imprime caja
	@FieldConfAnont(label = "No imprime caja", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Boolean noImprimeCaja = false;

	// Ventas
	@FieldConfAnont(label = "Ventas", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Boolean ventas = false;

	// Fondos
	@FieldConfAnont(label = "Fondos", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Boolean fondos = false;

	// Compras
	@FieldConfAnont(label = "Compras", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Boolean compras = false;

	// Moneda
	@FieldConfAnont(label = "Moneda", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Moneda moneda;

	// Caja
	@FieldConfAnont(label = "Caja", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Caja caja;

	// Rechazados
	@FieldConfAnont(label = "Rechazados", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Boolean rechazados = false;

	// Conciliación
	@FieldConfAnont(label = "Conciliación", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Boolean conciliacion = false;

	// Tipo de banco
	@FieldConfAnont(label = "Tipo de banco", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private CuentaFondoTipoBanco cuentaFondoTipoBanco;

	// banco
	@FieldConfAnont(label = "banco", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Banco banco;

	// Cuenta bancaria
	@FieldConfAnont(label = "Cuenta bancaria", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 22, minValue = "", maxValue = "", mask = "")
	private String cuentaBancaria;

	// CBU
	@FieldConfAnont(label = "CBU", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 22, minValue = "", maxValue = "", mask = "")
	private String cbu;

	// Límite descubierto
	@FieldConfAnont(label = "Límite descubierto", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "-9999.9999", maxValue = "99999.9999", mask = "")
	private java.math.BigDecimal limiteDescubierto;

	// Cuenta fondo caución
	@FieldConfAnont(label = "Cuenta fondo caución", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String cuentaFondoCaucion;

	// Cuenta fondo diferidos
	@FieldConfAnont(label = "Cuenta fondo diferidos", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String cuentaFondoDiferidos;

	// Formato
	@FieldConfAnont(label = "Formato", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String formato;

	// Tipo de copias
	@FieldConfAnont(label = "Tipo de copias", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private CuentaFondoBancoCopia cuentaFondoBancoCopia;

	// Límite operación individual
	@FieldConfAnont(label = "Límite operación individual", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "-9999.9999", maxValue = "99999.9999", mask = "")
	private java.math.BigDecimal limiteOperacionIndividual;

	// Puerta p/ uso
	@FieldConfAnont(label = "Puerta p/ uso", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private SeguridadPuerta seguridadPuertaUso;

	// Puerta p/ consulta
	@FieldConfAnont(label = "Puerta p/ consulta", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private SeguridadPuerta seguridadPuertaConsulta;

	// Puerta p/ superar límite
	@FieldConfAnont(label = "Puerta p/ superar límite", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private SeguridadPuerta seguridadPuertaLimite;

	// ---------------------------------------------------------------------------------------------------------------------------


	public CuentaFondo() throws Exception {
	}

	public CuentaFondo(String idArg0, Integer numeroArg1, String nombreArg2, String idCuentaContableArg3, String idCuentaFondoGrupoArg4, String idCuentaFondoTipoArg5, Boolean obsoletoArg6, Boolean noImprimeCajaArg7, Boolean ventasArg8, Boolean fondosArg9, Boolean comprasArg10, String idMonedaArg11, String idCajaArg12, Boolean rechazadosArg13, Boolean conciliacionArg14, String idCuentaFondoTipoBancoArg15, String idBancoArg16, String cuentaBancariaArg17, String cbuArg18, java.math.BigDecimal limiteDescubiertoArg19, String cuentaFondoCaucionArg20, String cuentaFondoDiferidosArg21, String formatoArg22, String idCuentaFondoBancoCopiaArg23, java.math.BigDecimal limiteOperacionIndividualArg24, String idSeguridadPuertaArg25, String idSeguridadPuertaArg26, String idSeguridadPuertaArg27) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, idCuentaContableArg3, idCuentaFondoGrupoArg4, idCuentaFondoTipoArg5, obsoletoArg6, noImprimeCajaArg7, ventasArg8, fondosArg9, comprasArg10, idMonedaArg11, idCajaArg12, rechazadosArg13, conciliacionArg14, idCuentaFondoTipoBancoArg15, idBancoArg16, cuentaBancariaArg17, cbuArg18, limiteDescubiertoArg19, cuentaFondoCaucionArg20, cuentaFondoDiferidosArg21, formatoArg22, idCuentaFondoBancoCopiaArg23, limiteOperacionIndividualArg24, idSeguridadPuertaArg25, idSeguridadPuertaArg26, idSeguridadPuertaArg27);

	}

	public CuentaFondo(String idArg0, Integer numeroArg1, String nombreArg2, String idArg3, String codigoArg4, String nombreArg5, String idEjercicioContableArg6, String integraArg7, String cuentaJerarquiaArg8, Boolean imputableArg9, Boolean ajustaPorInflacionArg10, String idCuentaContableEstadoArg11, Boolean cuentaConApropiacionArg12, String idCentroCostoContableArg13, String cuentaAgrupadoraArg14, java.math.BigDecimal porcentajeArg15, String idPuntoEquilibrioArg16, String idCostoVentaArg17, String idSeguridadPuertaArg18, String idArg19, Integer numeroArg20, String nombreArg21, String idCuentaFondoRubroArg22, String idArg23, Integer numeroArg24, String nombreArg25, Boolean obsoletoArg26, Boolean noImprimeCajaArg27, Boolean ventasArg28, Boolean fondosArg29, Boolean comprasArg30, String idArg31, Integer numeroArg32, String nombreArg33, String abreviaturaArg34, java.math.BigDecimal cotizacionArg35, java.sql.Timestamp cotizacionFechaArg36, Boolean controlActualizacionArg37, String idMonedaAFIPArg38, String idArg39, Integer numeroArg40, String nombreArg41, String idSeguridadPuertaArg42, Boolean rechazadosArg43, Boolean conciliacionArg44, String idArg45, Integer numeroArg46, String nombreArg47, String idArg48, Integer numeroArg49, String nombreArg50, Long cuitArg51, Boolean bloqueadoArg52, Integer hojaArg53, Integer primeraFilaArg54, Integer ultimaFilaArg55, String fechaArg56, String descripcionArg57, String referencia1Arg58, String importeArg59, String referencia2Arg60, String saldoArg61, String cuentaBancariaArg62, String cbuArg63, java.math.BigDecimal limiteDescubiertoArg64, String cuentaFondoCaucionArg65, String cuentaFondoDiferidosArg66, String formatoArg67, String idArg68, Integer numeroArg69, String nombreArg70, java.math.BigDecimal limiteOperacionIndividualArg71, String idArg72, Integer numeroArg73, String nombreArg74, String equateArg75, String idSeguridadModuloArg76, String idArg77, Integer numeroArg78, String nombreArg79, String equateArg80, String idSeguridadModuloArg81, String idArg82, Integer numeroArg83, String nombreArg84, String equateArg85, String idSeguridadModuloArg86) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, idArg3, codigoArg4, nombreArg5, idEjercicioContableArg6, integraArg7, cuentaJerarquiaArg8, imputableArg9, ajustaPorInflacionArg10, idCuentaContableEstadoArg11, cuentaConApropiacionArg12, idCentroCostoContableArg13, cuentaAgrupadoraArg14, porcentajeArg15, idPuntoEquilibrioArg16, idCostoVentaArg17, idSeguridadPuertaArg18, idArg19, numeroArg20, nombreArg21, idCuentaFondoRubroArg22, idArg23, numeroArg24, nombreArg25, obsoletoArg26, noImprimeCajaArg27, ventasArg28, fondosArg29, comprasArg30, idArg31, numeroArg32, nombreArg33, abreviaturaArg34, cotizacionArg35, cotizacionFechaArg36, controlActualizacionArg37, idMonedaAFIPArg38, idArg39, numeroArg40, nombreArg41, idSeguridadPuertaArg42, rechazadosArg43, conciliacionArg44, idArg45, numeroArg46, nombreArg47, idArg48, numeroArg49, nombreArg50, cuitArg51, bloqueadoArg52, hojaArg53, primeraFilaArg54, ultimaFilaArg55, fechaArg56, descripcionArg57, referencia1Arg58, importeArg59, referencia2Arg60, saldoArg61, cuentaBancariaArg62, cbuArg63, limiteDescubiertoArg64, cuentaFondoCaucionArg65, cuentaFondoDiferidosArg66, formatoArg67, idArg68, numeroArg69, nombreArg70, limiteOperacionIndividualArg71, idArg72, numeroArg73, nombreArg74, equateArg75, idSeguridadModuloArg76, idArg77, numeroArg78, nombreArg79, equateArg80, idSeguridadModuloArg81, idArg82, numeroArg83, nombreArg84, equateArg85, idSeguridadModuloArg86);

	}

	public CuentaFondo(String idArg0, Integer numeroArg1, String nombreArg2, String idArg3, String codigoArg4, String nombreArg5, String idArg6, Integer numeroArg7, java.util.Date aperturaArg8, java.util.Date cierreArg9, Boolean cerradoArg10, Boolean cerradoModulosArg11, String comentarioArg12, String integraArg13, String cuentaJerarquiaArg14, Boolean imputableArg15, Boolean ajustaPorInflacionArg16, String idArg17, Integer numeroArg18, String nombreArg19, Boolean cuentaConApropiacionArg20, String idArg21, Integer numeroArg22, String nombreArg23, String abreviaturaArg24, String idEjercicioContableArg25, String cuentaAgrupadoraArg26, java.math.BigDecimal porcentajeArg27, String idArg28, Integer numeroArg29, String nombreArg30, String idTipoPuntoEquilibrioArg31, String idEjercicioContableArg32, String idArg33, Integer numeroArg34, String nombreArg35, String idArg36, Integer numeroArg37, String nombreArg38, String equateArg39, String idSeguridadModuloArg40, String idArg41, Integer numeroArg42, String nombreArg43, String idArg44, Integer numeroArg45, String nombreArg46, String idArg47, Integer numeroArg48, String nombreArg49, Boolean obsoletoArg50, Boolean noImprimeCajaArg51, Boolean ventasArg52, Boolean fondosArg53, Boolean comprasArg54, String idArg55, Integer numeroArg56, String nombreArg57, String abreviaturaArg58, java.math.BigDecimal cotizacionArg59, java.sql.Timestamp cotizacionFechaArg60, Boolean controlActualizacionArg61, String idArg62, String codigoArg63, String nombreArg64, String idArg65, Integer numeroArg66, String nombreArg67, String idArg68, Integer numeroArg69, String nombreArg70, String equateArg71, String idSeguridadModuloArg72, Boolean rechazadosArg73, Boolean conciliacionArg74, String idArg75, Integer numeroArg76, String nombreArg77, String idArg78, Integer numeroArg79, String nombreArg80, Long cuitArg81, Boolean bloqueadoArg82, Integer hojaArg83, Integer primeraFilaArg84, Integer ultimaFilaArg85, String fechaArg86, String descripcionArg87, String referencia1Arg88, String importeArg89, String referencia2Arg90, String saldoArg91, String cuentaBancariaArg92, String cbuArg93, java.math.BigDecimal limiteDescubiertoArg94, String cuentaFondoCaucionArg95, String cuentaFondoDiferidosArg96, String formatoArg97, String idArg98, Integer numeroArg99, String nombreArg100, java.math.BigDecimal limiteOperacionIndividualArg101, String idArg102, Integer numeroArg103, String nombreArg104, String equateArg105, String idArg106, Integer numeroArg107, String nombreArg108, String idArg109, Integer numeroArg110, String nombreArg111, String equateArg112, String idArg113, Integer numeroArg114, String nombreArg115, String idArg116, Integer numeroArg117, String nombreArg118, String equateArg119, String idArg120, Integer numeroArg121, String nombreArg122) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, idArg3, codigoArg4, nombreArg5, idArg6, numeroArg7, aperturaArg8, cierreArg9, cerradoArg10, cerradoModulosArg11, comentarioArg12, integraArg13, cuentaJerarquiaArg14, imputableArg15, ajustaPorInflacionArg16, idArg17, numeroArg18, nombreArg19, cuentaConApropiacionArg20, idArg21, numeroArg22, nombreArg23, abreviaturaArg24, idEjercicioContableArg25, cuentaAgrupadoraArg26, porcentajeArg27, idArg28, numeroArg29, nombreArg30, idTipoPuntoEquilibrioArg31, idEjercicioContableArg32, idArg33, numeroArg34, nombreArg35, idArg36, numeroArg37, nombreArg38, equateArg39, idSeguridadModuloArg40, idArg41, numeroArg42, nombreArg43, idArg44, numeroArg45, nombreArg46, idArg47, numeroArg48, nombreArg49, obsoletoArg50, noImprimeCajaArg51, ventasArg52, fondosArg53, comprasArg54, idArg55, numeroArg56, nombreArg57, abreviaturaArg58, cotizacionArg59, cotizacionFechaArg60, controlActualizacionArg61, idArg62, codigoArg63, nombreArg64, idArg65, numeroArg66, nombreArg67, idArg68, numeroArg69, nombreArg70, equateArg71, idSeguridadModuloArg72, rechazadosArg73, conciliacionArg74, idArg75, numeroArg76, nombreArg77, idArg78, numeroArg79, nombreArg80, cuitArg81, bloqueadoArg82, hojaArg83, primeraFilaArg84, ultimaFilaArg85, fechaArg86, descripcionArg87, referencia1Arg88, importeArg89, referencia2Arg90, saldoArg91, cuentaBancariaArg92, cbuArg93, limiteDescubiertoArg94, cuentaFondoCaucionArg95, cuentaFondoDiferidosArg96, formatoArg97, idArg98, numeroArg99, nombreArg100, limiteOperacionIndividualArg101, idArg102, numeroArg103, nombreArg104, equateArg105, idArg106, numeroArg107, nombreArg108, idArg109, numeroArg110, nombreArg111, equateArg112, idArg113, numeroArg114, nombreArg115, idArg116, numeroArg117, nombreArg118, equateArg119, idArg120, numeroArg121, nombreArg122);

	}

	public CuentaFondo(String idArg0, Integer numeroArg1, String nombreArg2, String idArg3, String codigoArg4, String nombreArg5, String idArg6, Integer numeroArg7, java.util.Date aperturaArg8, java.util.Date cierreArg9, Boolean cerradoArg10, Boolean cerradoModulosArg11, String comentarioArg12, String integraArg13, String cuentaJerarquiaArg14, Boolean imputableArg15, Boolean ajustaPorInflacionArg16, String idArg17, Integer numeroArg18, String nombreArg19, Boolean cuentaConApropiacionArg20, String idArg21, Integer numeroArg22, String nombreArg23, String abreviaturaArg24, String idArg25, Integer numeroArg26, java.util.Date aperturaArg27, java.util.Date cierreArg28, Boolean cerradoArg29, Boolean cerradoModulosArg30, String comentarioArg31, String cuentaAgrupadoraArg32, java.math.BigDecimal porcentajeArg33, String idArg34, Integer numeroArg35, String nombreArg36, String idArg37, Integer numeroArg38, String nombreArg39, String idArg40, Integer numeroArg41, java.util.Date aperturaArg42, java.util.Date cierreArg43, Boolean cerradoArg44, Boolean cerradoModulosArg45, String comentarioArg46, String idArg47, Integer numeroArg48, String nombreArg49, String idArg50, Integer numeroArg51, String nombreArg52, String equateArg53, String idArg54, Integer numeroArg55, String nombreArg56, String idArg57, Integer numeroArg58, String nombreArg59, String idArg60, Integer numeroArg61, String nombreArg62, String idArg63, Integer numeroArg64, String nombreArg65, Boolean obsoletoArg66, Boolean noImprimeCajaArg67, Boolean ventasArg68, Boolean fondosArg69, Boolean comprasArg70, String idArg71, Integer numeroArg72, String nombreArg73, String abreviaturaArg74, java.math.BigDecimal cotizacionArg75, java.sql.Timestamp cotizacionFechaArg76, Boolean controlActualizacionArg77, String idArg78, String codigoArg79, String nombreArg80, String idArg81, Integer numeroArg82, String nombreArg83, String idArg84, Integer numeroArg85, String nombreArg86, String equateArg87, String idArg88, Integer numeroArg89, String nombreArg90, Boolean rechazadosArg91, Boolean conciliacionArg92, String idArg93, Integer numeroArg94, String nombreArg95, String idArg96, Integer numeroArg97, String nombreArg98, Long cuitArg99, Boolean bloqueadoArg100, Integer hojaArg101, Integer primeraFilaArg102, Integer ultimaFilaArg103, String fechaArg104, String descripcionArg105, String referencia1Arg106, String importeArg107, String referencia2Arg108, String saldoArg109, String cuentaBancariaArg110, String cbuArg111, java.math.BigDecimal limiteDescubiertoArg112, String cuentaFondoCaucionArg113, String cuentaFondoDiferidosArg114, String formatoArg115, String idArg116, Integer numeroArg117, String nombreArg118, java.math.BigDecimal limiteOperacionIndividualArg119, String idArg120, Integer numeroArg121, String nombreArg122, String equateArg123, String idArg124, Integer numeroArg125, String nombreArg126, String idArg127, Integer numeroArg128, String nombreArg129, String equateArg130, String idArg131, Integer numeroArg132, String nombreArg133, String idArg134, Integer numeroArg135, String nombreArg136, String equateArg137, String idArg138, Integer numeroArg139, String nombreArg140) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, idArg3, codigoArg4, nombreArg5, idArg6, numeroArg7, aperturaArg8, cierreArg9, cerradoArg10, cerradoModulosArg11, comentarioArg12, integraArg13, cuentaJerarquiaArg14, imputableArg15, ajustaPorInflacionArg16, idArg17, numeroArg18, nombreArg19, cuentaConApropiacionArg20, idArg21, numeroArg22, nombreArg23, abreviaturaArg24, idArg25, numeroArg26, aperturaArg27, cierreArg28, cerradoArg29, cerradoModulosArg30, comentarioArg31, cuentaAgrupadoraArg32, porcentajeArg33, idArg34, numeroArg35, nombreArg36, idArg37, numeroArg38, nombreArg39, idArg40, numeroArg41, aperturaArg42, cierreArg43, cerradoArg44, cerradoModulosArg45, comentarioArg46, idArg47, numeroArg48, nombreArg49, idArg50, numeroArg51, nombreArg52, equateArg53, idArg54, numeroArg55, nombreArg56, idArg57, numeroArg58, nombreArg59, idArg60, numeroArg61, nombreArg62, idArg63, numeroArg64, nombreArg65, obsoletoArg66, noImprimeCajaArg67, ventasArg68, fondosArg69, comprasArg70, idArg71, numeroArg72, nombreArg73, abreviaturaArg74, cotizacionArg75, cotizacionFechaArg76, controlActualizacionArg77, idArg78, codigoArg79, nombreArg80, idArg81, numeroArg82, nombreArg83, idArg84, numeroArg85, nombreArg86, equateArg87, idArg88, numeroArg89, nombreArg90, rechazadosArg91, conciliacionArg92, idArg93, numeroArg94, nombreArg95, idArg96, numeroArg97, nombreArg98, cuitArg99, bloqueadoArg100, hojaArg101, primeraFilaArg102, ultimaFilaArg103, fechaArg104, descripcionArg105, referencia1Arg106, importeArg107, referencia2Arg108, saldoArg109, cuentaBancariaArg110, cbuArg111, limiteDescubiertoArg112, cuentaFondoCaucionArg113, cuentaFondoDiferidosArg114, formatoArg115, idArg116, numeroArg117, nombreArg118, limiteOperacionIndividualArg119, idArg120, numeroArg121, nombreArg122, equateArg123, idArg124, numeroArg125, nombreArg126, idArg127, numeroArg128, nombreArg129, equateArg130, idArg131, numeroArg132, nombreArg133, idArg134, numeroArg135, nombreArg136, equateArg137, idArg138, numeroArg139, nombreArg140);

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

	// GET Nº cuenta
	public Integer getNumero() {
		return this.numero;
	}

	// SET Nº cuenta
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

	// BUILD IF NULL AND GET Cuenta contable
	public CuentaContable buildCuentaContable() throws Exception {
		this.cuentaContable = (this.cuentaContable == null) ? new CuentaContable() : this.cuentaContable;
		return this.cuentaContable;
	}

	// GET Cuenta contable
	public CuentaContable getCuentaContable() {
		this.cuentaContable = (this.cuentaContable != null && this.cuentaContable.getId() == null) ? null : this.cuentaContable ;
		return this.cuentaContable;
	}

	// SET Cuenta contable
	public void setCuentaContable(CuentaContable cuentaContable ){
		this.cuentaContable = cuentaContable;
	}

	// BUILD IF NULL AND GET Grupo
	public CuentaFondoGrupo buildCuentaFondoGrupo() throws Exception {
		this.cuentaFondoGrupo = (this.cuentaFondoGrupo == null) ? new CuentaFondoGrupo() : this.cuentaFondoGrupo;
		return this.cuentaFondoGrupo;
	}

	// GET Grupo
	public CuentaFondoGrupo getCuentaFondoGrupo() {
		this.cuentaFondoGrupo = (this.cuentaFondoGrupo != null && this.cuentaFondoGrupo.getId() == null) ? null : this.cuentaFondoGrupo ;
		return this.cuentaFondoGrupo;
	}

	// SET Grupo
	public void setCuentaFondoGrupo(CuentaFondoGrupo cuentaFondoGrupo ){
		this.cuentaFondoGrupo = cuentaFondoGrupo;
	}

	// BUILD IF NULL AND GET Tipo
	public CuentaFondoTipo buildCuentaFondoTipo() throws Exception {
		this.cuentaFondoTipo = (this.cuentaFondoTipo == null) ? new CuentaFondoTipo() : this.cuentaFondoTipo;
		return this.cuentaFondoTipo;
	}

	// GET Tipo
	public CuentaFondoTipo getCuentaFondoTipo() {
		this.cuentaFondoTipo = (this.cuentaFondoTipo != null && this.cuentaFondoTipo.getId() == null) ? null : this.cuentaFondoTipo ;
		return this.cuentaFondoTipo;
	}

	// SET Tipo
	public void setCuentaFondoTipo(CuentaFondoTipo cuentaFondoTipo ){
		this.cuentaFondoTipo = cuentaFondoTipo;
	}

	// GET Obsoleto
	public Boolean getObsoleto() {
		return this.obsoleto;
	}

	// SET Obsoleto
	public void setObsoleto(Boolean obsoleto ){
		this.obsoleto = (obsoleto == null) ? false : obsoleto;
	}

	// GET No imprime caja
	public Boolean getNoImprimeCaja() {
		return this.noImprimeCaja;
	}

	// SET No imprime caja
	public void setNoImprimeCaja(Boolean noImprimeCaja ){
		this.noImprimeCaja = (noImprimeCaja == null) ? false : noImprimeCaja;
	}

	// GET Ventas
	public Boolean getVentas() {
		return this.ventas;
	}

	// SET Ventas
	public void setVentas(Boolean ventas ){
		this.ventas = (ventas == null) ? false : ventas;
	}

	// GET Fondos
	public Boolean getFondos() {
		return this.fondos;
	}

	// SET Fondos
	public void setFondos(Boolean fondos ){
		this.fondos = (fondos == null) ? false : fondos;
	}

	// GET Compras
	public Boolean getCompras() {
		return this.compras;
	}

	// SET Compras
	public void setCompras(Boolean compras ){
		this.compras = (compras == null) ? false : compras;
	}

	// BUILD IF NULL AND GET Moneda
	public Moneda buildMoneda() throws Exception {
		this.moneda = (this.moneda == null) ? new Moneda() : this.moneda;
		return this.moneda;
	}

	// GET Moneda
	public Moneda getMoneda() {
		this.moneda = (this.moneda != null && this.moneda.getId() == null) ? null : this.moneda ;
		return this.moneda;
	}

	// SET Moneda
	public void setMoneda(Moneda moneda ){
		this.moneda = moneda;
	}

	// BUILD IF NULL AND GET Caja
	public Caja buildCaja() throws Exception {
		this.caja = (this.caja == null) ? new Caja() : this.caja;
		return this.caja;
	}

	// GET Caja
	public Caja getCaja() {
		this.caja = (this.caja != null && this.caja.getId() == null) ? null : this.caja ;
		return this.caja;
	}

	// SET Caja
	public void setCaja(Caja caja ){
		this.caja = caja;
	}

	// GET Rechazados
	public Boolean getRechazados() {
		return this.rechazados;
	}

	// SET Rechazados
	public void setRechazados(Boolean rechazados ){
		this.rechazados = (rechazados == null) ? false : rechazados;
	}

	// GET Conciliación
	public Boolean getConciliacion() {
		return this.conciliacion;
	}

	// SET Conciliación
	public void setConciliacion(Boolean conciliacion ){
		this.conciliacion = (conciliacion == null) ? false : conciliacion;
	}

	// BUILD IF NULL AND GET Tipo de banco
	public CuentaFondoTipoBanco buildCuentaFondoTipoBanco() throws Exception {
		this.cuentaFondoTipoBanco = (this.cuentaFondoTipoBanco == null) ? new CuentaFondoTipoBanco() : this.cuentaFondoTipoBanco;
		return this.cuentaFondoTipoBanco;
	}

	// GET Tipo de banco
	public CuentaFondoTipoBanco getCuentaFondoTipoBanco() {
		this.cuentaFondoTipoBanco = (this.cuentaFondoTipoBanco != null && this.cuentaFondoTipoBanco.getId() == null) ? null : this.cuentaFondoTipoBanco ;
		return this.cuentaFondoTipoBanco;
	}

	// SET Tipo de banco
	public void setCuentaFondoTipoBanco(CuentaFondoTipoBanco cuentaFondoTipoBanco ){
		this.cuentaFondoTipoBanco = cuentaFondoTipoBanco;
	}

	// BUILD IF NULL AND GET banco
	public Banco buildBanco() throws Exception {
		this.banco = (this.banco == null) ? new Banco() : this.banco;
		return this.banco;
	}

	// GET banco
	public Banco getBanco() {
		this.banco = (this.banco != null && this.banco.getId() == null) ? null : this.banco ;
		return this.banco;
	}

	// SET banco
	public void setBanco(Banco banco ){
		this.banco = banco;
	}

	// GET Cuenta bancaria
	public String getCuentaBancaria() {
		return this.cuentaBancaria;
	}

	// SET Cuenta bancaria
	public void setCuentaBancaria(String cuentaBancaria ){
		cuentaBancaria = (cuentaBancaria != null) ? cuentaBancaria.trim() : null;
		this.cuentaBancaria = (cuentaBancaria != null && cuentaBancaria.length() == 0) ? null : cuentaBancaria;
	}

	// GET CBU
	public String getCbu() {
		return this.cbu;
	}

	// SET CBU
	public void setCbu(String cbu ){
		cbu = (cbu != null) ? cbu.trim() : null;
		this.cbu = (cbu != null && cbu.length() == 0) ? null : cbu;
	}

	// GET Límite descubierto
	public java.math.BigDecimal getLimiteDescubierto() {
		return this.limiteDescubierto;
	}

	// SET Límite descubierto
	public void setLimiteDescubierto(java.math.BigDecimal limiteDescubierto ){
		this.limiteDescubierto = limiteDescubierto;
	}

	// GET Cuenta fondo caución
	public String getCuentaFondoCaucion() {
		return this.cuentaFondoCaucion;
	}

	// SET Cuenta fondo caución
	public void setCuentaFondoCaucion(String cuentaFondoCaucion ){
		cuentaFondoCaucion = (cuentaFondoCaucion != null) ? cuentaFondoCaucion.trim() : null;
		this.cuentaFondoCaucion = (cuentaFondoCaucion != null && cuentaFondoCaucion.length() == 0) ? null : cuentaFondoCaucion;
	}

	// GET Cuenta fondo diferidos
	public String getCuentaFondoDiferidos() {
		return this.cuentaFondoDiferidos;
	}

	// SET Cuenta fondo diferidos
	public void setCuentaFondoDiferidos(String cuentaFondoDiferidos ){
		cuentaFondoDiferidos = (cuentaFondoDiferidos != null) ? cuentaFondoDiferidos.trim() : null;
		this.cuentaFondoDiferidos = (cuentaFondoDiferidos != null && cuentaFondoDiferidos.length() == 0) ? null : cuentaFondoDiferidos;
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

	// BUILD IF NULL AND GET Tipo de copias
	public CuentaFondoBancoCopia buildCuentaFondoBancoCopia() throws Exception {
		this.cuentaFondoBancoCopia = (this.cuentaFondoBancoCopia == null) ? new CuentaFondoBancoCopia() : this.cuentaFondoBancoCopia;
		return this.cuentaFondoBancoCopia;
	}

	// GET Tipo de copias
	public CuentaFondoBancoCopia getCuentaFondoBancoCopia() {
		this.cuentaFondoBancoCopia = (this.cuentaFondoBancoCopia != null && this.cuentaFondoBancoCopia.getId() == null) ? null : this.cuentaFondoBancoCopia ;
		return this.cuentaFondoBancoCopia;
	}

	// SET Tipo de copias
	public void setCuentaFondoBancoCopia(CuentaFondoBancoCopia cuentaFondoBancoCopia ){
		this.cuentaFondoBancoCopia = cuentaFondoBancoCopia;
	}

	// GET Límite operación individual
	public java.math.BigDecimal getLimiteOperacionIndividual() {
		return this.limiteOperacionIndividual;
	}

	// SET Límite operación individual
	public void setLimiteOperacionIndividual(java.math.BigDecimal limiteOperacionIndividual ){
		this.limiteOperacionIndividual = limiteOperacionIndividual;
	}

	// BUILD IF NULL AND GET Puerta p/ uso
	public SeguridadPuerta buildSeguridadPuertaUso() throws Exception {
		this.seguridadPuertaUso = (this.seguridadPuertaUso == null) ? new SeguridadPuerta() : this.seguridadPuertaUso;
		return this.seguridadPuertaUso;
	}

	// GET Puerta p/ uso
	public SeguridadPuerta getSeguridadPuertaUso() {
		this.seguridadPuertaUso = (this.seguridadPuertaUso != null && this.seguridadPuertaUso.getId() == null) ? null : this.seguridadPuertaUso ;
		return this.seguridadPuertaUso;
	}

	// SET Puerta p/ uso
	public void setSeguridadPuertaUso(SeguridadPuerta seguridadPuertaUso ){
		this.seguridadPuertaUso = seguridadPuertaUso;
	}

	// BUILD IF NULL AND GET Puerta p/ consulta
	public SeguridadPuerta buildSeguridadPuertaConsulta() throws Exception {
		this.seguridadPuertaConsulta = (this.seguridadPuertaConsulta == null) ? new SeguridadPuerta() : this.seguridadPuertaConsulta;
		return this.seguridadPuertaConsulta;
	}

	// GET Puerta p/ consulta
	public SeguridadPuerta getSeguridadPuertaConsulta() {
		this.seguridadPuertaConsulta = (this.seguridadPuertaConsulta != null && this.seguridadPuertaConsulta.getId() == null) ? null : this.seguridadPuertaConsulta ;
		return this.seguridadPuertaConsulta;
	}

	// SET Puerta p/ consulta
	public void setSeguridadPuertaConsulta(SeguridadPuerta seguridadPuertaConsulta ){
		this.seguridadPuertaConsulta = seguridadPuertaConsulta;
	}

	// BUILD IF NULL AND GET Puerta p/ superar límite
	public SeguridadPuerta buildSeguridadPuertaLimite() throws Exception {
		this.seguridadPuertaLimite = (this.seguridadPuertaLimite == null) ? new SeguridadPuerta() : this.seguridadPuertaLimite;
		return this.seguridadPuertaLimite;
	}

	// GET Puerta p/ superar límite
	public SeguridadPuerta getSeguridadPuertaLimite() {
		this.seguridadPuertaLimite = (this.seguridadPuertaLimite != null && this.seguridadPuertaLimite.getId() == null) ? null : this.seguridadPuertaLimite ;
		return this.seguridadPuertaLimite;
	}

	// SET Puerta p/ superar límite
	public void setSeguridadPuertaLimite(SeguridadPuerta seguridadPuertaLimite ){
		this.seguridadPuertaLimite = seguridadPuertaLimite;
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String idCuentaContableArg3, String idCuentaFondoGrupoArg4, String idCuentaFondoTipoArg5, Boolean obsoletoArg6, Boolean noImprimeCajaArg7, Boolean ventasArg8, Boolean fondosArg9, Boolean comprasArg10, String idMonedaArg11, String idCajaArg12, Boolean rechazadosArg13, Boolean conciliacionArg14, String idCuentaFondoTipoBancoArg15, String idBancoArg16, String cuentaBancariaArg17, String cbuArg18, java.math.BigDecimal limiteDescubiertoArg19, String cuentaFondoCaucionArg20, String cuentaFondoDiferidosArg21, String formatoArg22, String idCuentaFondoBancoCopiaArg23, java.math.BigDecimal limiteOperacionIndividualArg24, String idSeguridadPuertaArg25, String idSeguridadPuertaArg26, String idSeguridadPuertaArg27) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.buildCuentaContable().setId(idCuentaContableArg3);
		this.buildCuentaFondoGrupo().setId(idCuentaFondoGrupoArg4);
		this.buildCuentaFondoTipo().setId(idCuentaFondoTipoArg5);
		this.setObsoleto(obsoletoArg6);
		this.setNoImprimeCaja(noImprimeCajaArg7);
		this.setVentas(ventasArg8);
		this.setFondos(fondosArg9);
		this.setCompras(comprasArg10);
		this.buildMoneda().setId(idMonedaArg11);
		this.buildCaja().setId(idCajaArg12);
		this.setRechazados(rechazadosArg13);
		this.setConciliacion(conciliacionArg14);
		this.buildCuentaFondoTipoBanco().setId(idCuentaFondoTipoBancoArg15);
		this.buildBanco().setId(idBancoArg16);
		this.setCuentaBancaria(cuentaBancariaArg17);
		this.setCbu(cbuArg18);
		this.setLimiteDescubierto(limiteDescubiertoArg19);
		this.setCuentaFondoCaucion(cuentaFondoCaucionArg20);
		this.setCuentaFondoDiferidos(cuentaFondoDiferidosArg21);
		this.setFormato(formatoArg22);
		this.buildCuentaFondoBancoCopia().setId(idCuentaFondoBancoCopiaArg23);
		this.setLimiteOperacionIndividual(limiteOperacionIndividualArg24);
		this.buildSeguridadPuertaUso().setId(idSeguridadPuertaArg25);
		this.buildSeguridadPuertaConsulta().setId(idSeguridadPuertaArg26);
		this.buildSeguridadPuertaLimite().setId(idSeguridadPuertaArg27);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String idArg3, String codigoArg4, String nombreArg5, String idEjercicioContableArg6, String integraArg7, String cuentaJerarquiaArg8, Boolean imputableArg9, Boolean ajustaPorInflacionArg10, String idCuentaContableEstadoArg11, Boolean cuentaConApropiacionArg12, String idCentroCostoContableArg13, String cuentaAgrupadoraArg14, java.math.BigDecimal porcentajeArg15, String idPuntoEquilibrioArg16, String idCostoVentaArg17, String idSeguridadPuertaArg18, String idArg19, Integer numeroArg20, String nombreArg21, String idCuentaFondoRubroArg22, String idArg23, Integer numeroArg24, String nombreArg25, Boolean obsoletoArg26, Boolean noImprimeCajaArg27, Boolean ventasArg28, Boolean fondosArg29, Boolean comprasArg30, String idArg31, Integer numeroArg32, String nombreArg33, String abreviaturaArg34, java.math.BigDecimal cotizacionArg35, java.sql.Timestamp cotizacionFechaArg36, Boolean controlActualizacionArg37, String idMonedaAFIPArg38, String idArg39, Integer numeroArg40, String nombreArg41, String idSeguridadPuertaArg42, Boolean rechazadosArg43, Boolean conciliacionArg44, String idArg45, Integer numeroArg46, String nombreArg47, String idArg48, Integer numeroArg49, String nombreArg50, Long cuitArg51, Boolean bloqueadoArg52, Integer hojaArg53, Integer primeraFilaArg54, Integer ultimaFilaArg55, String fechaArg56, String descripcionArg57, String referencia1Arg58, String importeArg59, String referencia2Arg60, String saldoArg61, String cuentaBancariaArg62, String cbuArg63, java.math.BigDecimal limiteDescubiertoArg64, String cuentaFondoCaucionArg65, String cuentaFondoDiferidosArg66, String formatoArg67, String idArg68, Integer numeroArg69, String nombreArg70, java.math.BigDecimal limiteOperacionIndividualArg71, String idArg72, Integer numeroArg73, String nombreArg74, String equateArg75, String idSeguridadModuloArg76, String idArg77, Integer numeroArg78, String nombreArg79, String equateArg80, String idSeguridadModuloArg81, String idArg82, Integer numeroArg83, String nombreArg84, String equateArg85, String idSeguridadModuloArg86) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.buildCuentaContable().setId(idArg3);
		this.buildCuentaContable().setCodigo(codigoArg4);
		this.buildCuentaContable().setNombre(nombreArg5);
		this.buildCuentaContable().buildEjercicioContable().setId(idEjercicioContableArg6);
		this.buildCuentaContable().setIntegra(integraArg7);
		this.buildCuentaContable().setCuentaJerarquia(cuentaJerarquiaArg8);
		this.buildCuentaContable().setImputable(imputableArg9);
		this.buildCuentaContable().setAjustaPorInflacion(ajustaPorInflacionArg10);
		this.buildCuentaContable().buildCuentaContableEstado().setId(idCuentaContableEstadoArg11);
		this.buildCuentaContable().setCuentaConApropiacion(cuentaConApropiacionArg12);
		this.buildCuentaContable().buildCentroCostoContable().setId(idCentroCostoContableArg13);
		this.buildCuentaContable().setCuentaAgrupadora(cuentaAgrupadoraArg14);
		this.buildCuentaContable().setPorcentaje(porcentajeArg15);
		this.buildCuentaContable().buildPuntoEquilibrio().setId(idPuntoEquilibrioArg16);
		this.buildCuentaContable().buildCostoVenta().setId(idCostoVentaArg17);
		this.buildCuentaContable().buildSeguridadPuerta().setId(idSeguridadPuertaArg18);
		this.buildCuentaFondoGrupo().setId(idArg19);
		this.buildCuentaFondoGrupo().setNumero(numeroArg20);
		this.buildCuentaFondoGrupo().setNombre(nombreArg21);
		this.buildCuentaFondoGrupo().buildCuentaFondoRubro().setId(idCuentaFondoRubroArg22);
		this.buildCuentaFondoTipo().setId(idArg23);
		this.buildCuentaFondoTipo().setNumero(numeroArg24);
		this.buildCuentaFondoTipo().setNombre(nombreArg25);
		this.setObsoleto(obsoletoArg26);
		this.setNoImprimeCaja(noImprimeCajaArg27);
		this.setVentas(ventasArg28);
		this.setFondos(fondosArg29);
		this.setCompras(comprasArg30);
		this.buildMoneda().setId(idArg31);
		this.buildMoneda().setNumero(numeroArg32);
		this.buildMoneda().setNombre(nombreArg33);
		this.buildMoneda().setAbreviatura(abreviaturaArg34);
		this.buildMoneda().setCotizacion(cotizacionArg35);
		this.buildMoneda().setCotizacionFecha(cotizacionFechaArg36);
		this.buildMoneda().setControlActualizacion(controlActualizacionArg37);
		this.buildMoneda().buildMonedaAFIP().setId(idMonedaAFIPArg38);
		this.buildCaja().setId(idArg39);
		this.buildCaja().setNumero(numeroArg40);
		this.buildCaja().setNombre(nombreArg41);
		this.buildCaja().buildSeguridadPuerta().setId(idSeguridadPuertaArg42);
		this.setRechazados(rechazadosArg43);
		this.setConciliacion(conciliacionArg44);
		this.buildCuentaFondoTipoBanco().setId(idArg45);
		this.buildCuentaFondoTipoBanco().setNumero(numeroArg46);
		this.buildCuentaFondoTipoBanco().setNombre(nombreArg47);
		this.buildBanco().setId(idArg48);
		this.buildBanco().setNumero(numeroArg49);
		this.buildBanco().setNombre(nombreArg50);
		this.buildBanco().setCuit(cuitArg51);
		this.buildBanco().setBloqueado(bloqueadoArg52);
		this.buildBanco().setHoja(hojaArg53);
		this.buildBanco().setPrimeraFila(primeraFilaArg54);
		this.buildBanco().setUltimaFila(ultimaFilaArg55);
		this.buildBanco().setFecha(fechaArg56);
		this.buildBanco().setDescripcion(descripcionArg57);
		this.buildBanco().setReferencia1(referencia1Arg58);
		this.buildBanco().setImporte(importeArg59);
		this.buildBanco().setReferencia2(referencia2Arg60);
		this.buildBanco().setSaldo(saldoArg61);
		this.setCuentaBancaria(cuentaBancariaArg62);
		this.setCbu(cbuArg63);
		this.setLimiteDescubierto(limiteDescubiertoArg64);
		this.setCuentaFondoCaucion(cuentaFondoCaucionArg65);
		this.setCuentaFondoDiferidos(cuentaFondoDiferidosArg66);
		this.setFormato(formatoArg67);
		this.buildCuentaFondoBancoCopia().setId(idArg68);
		this.buildCuentaFondoBancoCopia().setNumero(numeroArg69);
		this.buildCuentaFondoBancoCopia().setNombre(nombreArg70);
		this.setLimiteOperacionIndividual(limiteOperacionIndividualArg71);
		this.buildSeguridadPuertaUso().setId(idArg72);
		this.buildSeguridadPuertaUso().setNumero(numeroArg73);
		this.buildSeguridadPuertaUso().setNombre(nombreArg74);
		this.buildSeguridadPuertaUso().setEquate(equateArg75);
		this.buildSeguridadPuertaUso().buildSeguridadModulo().setId(idSeguridadModuloArg76);
		this.buildSeguridadPuertaConsulta().setId(idArg77);
		this.buildSeguridadPuertaConsulta().setNumero(numeroArg78);
		this.buildSeguridadPuertaConsulta().setNombre(nombreArg79);
		this.buildSeguridadPuertaConsulta().setEquate(equateArg80);
		this.buildSeguridadPuertaConsulta().buildSeguridadModulo().setId(idSeguridadModuloArg81);
		this.buildSeguridadPuertaLimite().setId(idArg82);
		this.buildSeguridadPuertaLimite().setNumero(numeroArg83);
		this.buildSeguridadPuertaLimite().setNombre(nombreArg84);
		this.buildSeguridadPuertaLimite().setEquate(equateArg85);
		this.buildSeguridadPuertaLimite().buildSeguridadModulo().setId(idSeguridadModuloArg86);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String idArg3, String codigoArg4, String nombreArg5, String idArg6, Integer numeroArg7, java.util.Date aperturaArg8, java.util.Date cierreArg9, Boolean cerradoArg10, Boolean cerradoModulosArg11, String comentarioArg12, String integraArg13, String cuentaJerarquiaArg14, Boolean imputableArg15, Boolean ajustaPorInflacionArg16, String idArg17, Integer numeroArg18, String nombreArg19, Boolean cuentaConApropiacionArg20, String idArg21, Integer numeroArg22, String nombreArg23, String abreviaturaArg24, String idEjercicioContableArg25, String cuentaAgrupadoraArg26, java.math.BigDecimal porcentajeArg27, String idArg28, Integer numeroArg29, String nombreArg30, String idTipoPuntoEquilibrioArg31, String idEjercicioContableArg32, String idArg33, Integer numeroArg34, String nombreArg35, String idArg36, Integer numeroArg37, String nombreArg38, String equateArg39, String idSeguridadModuloArg40, String idArg41, Integer numeroArg42, String nombreArg43, String idArg44, Integer numeroArg45, String nombreArg46, String idArg47, Integer numeroArg48, String nombreArg49, Boolean obsoletoArg50, Boolean noImprimeCajaArg51, Boolean ventasArg52, Boolean fondosArg53, Boolean comprasArg54, String idArg55, Integer numeroArg56, String nombreArg57, String abreviaturaArg58, java.math.BigDecimal cotizacionArg59, java.sql.Timestamp cotizacionFechaArg60, Boolean controlActualizacionArg61, String idArg62, String codigoArg63, String nombreArg64, String idArg65, Integer numeroArg66, String nombreArg67, String idArg68, Integer numeroArg69, String nombreArg70, String equateArg71, String idSeguridadModuloArg72, Boolean rechazadosArg73, Boolean conciliacionArg74, String idArg75, Integer numeroArg76, String nombreArg77, String idArg78, Integer numeroArg79, String nombreArg80, Long cuitArg81, Boolean bloqueadoArg82, Integer hojaArg83, Integer primeraFilaArg84, Integer ultimaFilaArg85, String fechaArg86, String descripcionArg87, String referencia1Arg88, String importeArg89, String referencia2Arg90, String saldoArg91, String cuentaBancariaArg92, String cbuArg93, java.math.BigDecimal limiteDescubiertoArg94, String cuentaFondoCaucionArg95, String cuentaFondoDiferidosArg96, String formatoArg97, String idArg98, Integer numeroArg99, String nombreArg100, java.math.BigDecimal limiteOperacionIndividualArg101, String idArg102, Integer numeroArg103, String nombreArg104, String equateArg105, String idArg106, Integer numeroArg107, String nombreArg108, String idArg109, Integer numeroArg110, String nombreArg111, String equateArg112, String idArg113, Integer numeroArg114, String nombreArg115, String idArg116, Integer numeroArg117, String nombreArg118, String equateArg119, String idArg120, Integer numeroArg121, String nombreArg122) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.buildCuentaContable().setId(idArg3);
		this.buildCuentaContable().setCodigo(codigoArg4);
		this.buildCuentaContable().setNombre(nombreArg5);
		this.buildCuentaContable().buildEjercicioContable().setId(idArg6);
		this.buildCuentaContable().buildEjercicioContable().setNumero(numeroArg7);
		this.buildCuentaContable().buildEjercicioContable().setApertura(aperturaArg8);
		this.buildCuentaContable().buildEjercicioContable().setCierre(cierreArg9);
		this.buildCuentaContable().buildEjercicioContable().setCerrado(cerradoArg10);
		this.buildCuentaContable().buildEjercicioContable().setCerradoModulos(cerradoModulosArg11);
		this.buildCuentaContable().buildEjercicioContable().setComentario(comentarioArg12);
		this.buildCuentaContable().setIntegra(integraArg13);
		this.buildCuentaContable().setCuentaJerarquia(cuentaJerarquiaArg14);
		this.buildCuentaContable().setImputable(imputableArg15);
		this.buildCuentaContable().setAjustaPorInflacion(ajustaPorInflacionArg16);
		this.buildCuentaContable().buildCuentaContableEstado().setId(idArg17);
		this.buildCuentaContable().buildCuentaContableEstado().setNumero(numeroArg18);
		this.buildCuentaContable().buildCuentaContableEstado().setNombre(nombreArg19);
		this.buildCuentaContable().setCuentaConApropiacion(cuentaConApropiacionArg20);
		this.buildCuentaContable().buildCentroCostoContable().setId(idArg21);
		this.buildCuentaContable().buildCentroCostoContable().setNumero(numeroArg22);
		this.buildCuentaContable().buildCentroCostoContable().setNombre(nombreArg23);
		this.buildCuentaContable().buildCentroCostoContable().setAbreviatura(abreviaturaArg24);
		this.buildCuentaContable().buildCentroCostoContable().buildEjercicioContable().setId(idEjercicioContableArg25);
		this.buildCuentaContable().setCuentaAgrupadora(cuentaAgrupadoraArg26);
		this.buildCuentaContable().setPorcentaje(porcentajeArg27);
		this.buildCuentaContable().buildPuntoEquilibrio().setId(idArg28);
		this.buildCuentaContable().buildPuntoEquilibrio().setNumero(numeroArg29);
		this.buildCuentaContable().buildPuntoEquilibrio().setNombre(nombreArg30);
		this.buildCuentaContable().buildPuntoEquilibrio().buildTipoPuntoEquilibrio().setId(idTipoPuntoEquilibrioArg31);
		this.buildCuentaContable().buildPuntoEquilibrio().buildEjercicioContable().setId(idEjercicioContableArg32);
		this.buildCuentaContable().buildCostoVenta().setId(idArg33);
		this.buildCuentaContable().buildCostoVenta().setNumero(numeroArg34);
		this.buildCuentaContable().buildCostoVenta().setNombre(nombreArg35);
		this.buildCuentaContable().buildSeguridadPuerta().setId(idArg36);
		this.buildCuentaContable().buildSeguridadPuerta().setNumero(numeroArg37);
		this.buildCuentaContable().buildSeguridadPuerta().setNombre(nombreArg38);
		this.buildCuentaContable().buildSeguridadPuerta().setEquate(equateArg39);
		this.buildCuentaContable().buildSeguridadPuerta().buildSeguridadModulo().setId(idSeguridadModuloArg40);
		this.buildCuentaFondoGrupo().setId(idArg41);
		this.buildCuentaFondoGrupo().setNumero(numeroArg42);
		this.buildCuentaFondoGrupo().setNombre(nombreArg43);
		this.buildCuentaFondoGrupo().buildCuentaFondoRubro().setId(idArg44);
		this.buildCuentaFondoGrupo().buildCuentaFondoRubro().setNumero(numeroArg45);
		this.buildCuentaFondoGrupo().buildCuentaFondoRubro().setNombre(nombreArg46);
		this.buildCuentaFondoTipo().setId(idArg47);
		this.buildCuentaFondoTipo().setNumero(numeroArg48);
		this.buildCuentaFondoTipo().setNombre(nombreArg49);
		this.setObsoleto(obsoletoArg50);
		this.setNoImprimeCaja(noImprimeCajaArg51);
		this.setVentas(ventasArg52);
		this.setFondos(fondosArg53);
		this.setCompras(comprasArg54);
		this.buildMoneda().setId(idArg55);
		this.buildMoneda().setNumero(numeroArg56);
		this.buildMoneda().setNombre(nombreArg57);
		this.buildMoneda().setAbreviatura(abreviaturaArg58);
		this.buildMoneda().setCotizacion(cotizacionArg59);
		this.buildMoneda().setCotizacionFecha(cotizacionFechaArg60);
		this.buildMoneda().setControlActualizacion(controlActualizacionArg61);
		this.buildMoneda().buildMonedaAFIP().setId(idArg62);
		this.buildMoneda().buildMonedaAFIP().setCodigo(codigoArg63);
		this.buildMoneda().buildMonedaAFIP().setNombre(nombreArg64);
		this.buildCaja().setId(idArg65);
		this.buildCaja().setNumero(numeroArg66);
		this.buildCaja().setNombre(nombreArg67);
		this.buildCaja().buildSeguridadPuerta().setId(idArg68);
		this.buildCaja().buildSeguridadPuerta().setNumero(numeroArg69);
		this.buildCaja().buildSeguridadPuerta().setNombre(nombreArg70);
		this.buildCaja().buildSeguridadPuerta().setEquate(equateArg71);
		this.buildCaja().buildSeguridadPuerta().buildSeguridadModulo().setId(idSeguridadModuloArg72);
		this.setRechazados(rechazadosArg73);
		this.setConciliacion(conciliacionArg74);
		this.buildCuentaFondoTipoBanco().setId(idArg75);
		this.buildCuentaFondoTipoBanco().setNumero(numeroArg76);
		this.buildCuentaFondoTipoBanco().setNombre(nombreArg77);
		this.buildBanco().setId(idArg78);
		this.buildBanco().setNumero(numeroArg79);
		this.buildBanco().setNombre(nombreArg80);
		this.buildBanco().setCuit(cuitArg81);
		this.buildBanco().setBloqueado(bloqueadoArg82);
		this.buildBanco().setHoja(hojaArg83);
		this.buildBanco().setPrimeraFila(primeraFilaArg84);
		this.buildBanco().setUltimaFila(ultimaFilaArg85);
		this.buildBanco().setFecha(fechaArg86);
		this.buildBanco().setDescripcion(descripcionArg87);
		this.buildBanco().setReferencia1(referencia1Arg88);
		this.buildBanco().setImporte(importeArg89);
		this.buildBanco().setReferencia2(referencia2Arg90);
		this.buildBanco().setSaldo(saldoArg91);
		this.setCuentaBancaria(cuentaBancariaArg92);
		this.setCbu(cbuArg93);
		this.setLimiteDescubierto(limiteDescubiertoArg94);
		this.setCuentaFondoCaucion(cuentaFondoCaucionArg95);
		this.setCuentaFondoDiferidos(cuentaFondoDiferidosArg96);
		this.setFormato(formatoArg97);
		this.buildCuentaFondoBancoCopia().setId(idArg98);
		this.buildCuentaFondoBancoCopia().setNumero(numeroArg99);
		this.buildCuentaFondoBancoCopia().setNombre(nombreArg100);
		this.setLimiteOperacionIndividual(limiteOperacionIndividualArg101);
		this.buildSeguridadPuertaUso().setId(idArg102);
		this.buildSeguridadPuertaUso().setNumero(numeroArg103);
		this.buildSeguridadPuertaUso().setNombre(nombreArg104);
		this.buildSeguridadPuertaUso().setEquate(equateArg105);
		this.buildSeguridadPuertaUso().buildSeguridadModulo().setId(idArg106);
		this.buildSeguridadPuertaUso().buildSeguridadModulo().setNumero(numeroArg107);
		this.buildSeguridadPuertaUso().buildSeguridadModulo().setNombre(nombreArg108);
		this.buildSeguridadPuertaConsulta().setId(idArg109);
		this.buildSeguridadPuertaConsulta().setNumero(numeroArg110);
		this.buildSeguridadPuertaConsulta().setNombre(nombreArg111);
		this.buildSeguridadPuertaConsulta().setEquate(equateArg112);
		this.buildSeguridadPuertaConsulta().buildSeguridadModulo().setId(idArg113);
		this.buildSeguridadPuertaConsulta().buildSeguridadModulo().setNumero(numeroArg114);
		this.buildSeguridadPuertaConsulta().buildSeguridadModulo().setNombre(nombreArg115);
		this.buildSeguridadPuertaLimite().setId(idArg116);
		this.buildSeguridadPuertaLimite().setNumero(numeroArg117);
		this.buildSeguridadPuertaLimite().setNombre(nombreArg118);
		this.buildSeguridadPuertaLimite().setEquate(equateArg119);
		this.buildSeguridadPuertaLimite().buildSeguridadModulo().setId(idArg120);
		this.buildSeguridadPuertaLimite().buildSeguridadModulo().setNumero(numeroArg121);
		this.buildSeguridadPuertaLimite().buildSeguridadModulo().setNombre(nombreArg122);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String idArg3, String codigoArg4, String nombreArg5, String idArg6, Integer numeroArg7, java.util.Date aperturaArg8, java.util.Date cierreArg9, Boolean cerradoArg10, Boolean cerradoModulosArg11, String comentarioArg12, String integraArg13, String cuentaJerarquiaArg14, Boolean imputableArg15, Boolean ajustaPorInflacionArg16, String idArg17, Integer numeroArg18, String nombreArg19, Boolean cuentaConApropiacionArg20, String idArg21, Integer numeroArg22, String nombreArg23, String abreviaturaArg24, String idArg25, Integer numeroArg26, java.util.Date aperturaArg27, java.util.Date cierreArg28, Boolean cerradoArg29, Boolean cerradoModulosArg30, String comentarioArg31, String cuentaAgrupadoraArg32, java.math.BigDecimal porcentajeArg33, String idArg34, Integer numeroArg35, String nombreArg36, String idArg37, Integer numeroArg38, String nombreArg39, String idArg40, Integer numeroArg41, java.util.Date aperturaArg42, java.util.Date cierreArg43, Boolean cerradoArg44, Boolean cerradoModulosArg45, String comentarioArg46, String idArg47, Integer numeroArg48, String nombreArg49, String idArg50, Integer numeroArg51, String nombreArg52, String equateArg53, String idArg54, Integer numeroArg55, String nombreArg56, String idArg57, Integer numeroArg58, String nombreArg59, String idArg60, Integer numeroArg61, String nombreArg62, String idArg63, Integer numeroArg64, String nombreArg65, Boolean obsoletoArg66, Boolean noImprimeCajaArg67, Boolean ventasArg68, Boolean fondosArg69, Boolean comprasArg70, String idArg71, Integer numeroArg72, String nombreArg73, String abreviaturaArg74, java.math.BigDecimal cotizacionArg75, java.sql.Timestamp cotizacionFechaArg76, Boolean controlActualizacionArg77, String idArg78, String codigoArg79, String nombreArg80, String idArg81, Integer numeroArg82, String nombreArg83, String idArg84, Integer numeroArg85, String nombreArg86, String equateArg87, String idArg88, Integer numeroArg89, String nombreArg90, Boolean rechazadosArg91, Boolean conciliacionArg92, String idArg93, Integer numeroArg94, String nombreArg95, String idArg96, Integer numeroArg97, String nombreArg98, Long cuitArg99, Boolean bloqueadoArg100, Integer hojaArg101, Integer primeraFilaArg102, Integer ultimaFilaArg103, String fechaArg104, String descripcionArg105, String referencia1Arg106, String importeArg107, String referencia2Arg108, String saldoArg109, String cuentaBancariaArg110, String cbuArg111, java.math.BigDecimal limiteDescubiertoArg112, String cuentaFondoCaucionArg113, String cuentaFondoDiferidosArg114, String formatoArg115, String idArg116, Integer numeroArg117, String nombreArg118, java.math.BigDecimal limiteOperacionIndividualArg119, String idArg120, Integer numeroArg121, String nombreArg122, String equateArg123, String idArg124, Integer numeroArg125, String nombreArg126, String idArg127, Integer numeroArg128, String nombreArg129, String equateArg130, String idArg131, Integer numeroArg132, String nombreArg133, String idArg134, Integer numeroArg135, String nombreArg136, String equateArg137, String idArg138, Integer numeroArg139, String nombreArg140) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.buildCuentaContable().setId(idArg3);
		this.buildCuentaContable().setCodigo(codigoArg4);
		this.buildCuentaContable().setNombre(nombreArg5);
		this.buildCuentaContable().buildEjercicioContable().setId(idArg6);
		this.buildCuentaContable().buildEjercicioContable().setNumero(numeroArg7);
		this.buildCuentaContable().buildEjercicioContable().setApertura(aperturaArg8);
		this.buildCuentaContable().buildEjercicioContable().setCierre(cierreArg9);
		this.buildCuentaContable().buildEjercicioContable().setCerrado(cerradoArg10);
		this.buildCuentaContable().buildEjercicioContable().setCerradoModulos(cerradoModulosArg11);
		this.buildCuentaContable().buildEjercicioContable().setComentario(comentarioArg12);
		this.buildCuentaContable().setIntegra(integraArg13);
		this.buildCuentaContable().setCuentaJerarquia(cuentaJerarquiaArg14);
		this.buildCuentaContable().setImputable(imputableArg15);
		this.buildCuentaContable().setAjustaPorInflacion(ajustaPorInflacionArg16);
		this.buildCuentaContable().buildCuentaContableEstado().setId(idArg17);
		this.buildCuentaContable().buildCuentaContableEstado().setNumero(numeroArg18);
		this.buildCuentaContable().buildCuentaContableEstado().setNombre(nombreArg19);
		this.buildCuentaContable().setCuentaConApropiacion(cuentaConApropiacionArg20);
		this.buildCuentaContable().buildCentroCostoContable().setId(idArg21);
		this.buildCuentaContable().buildCentroCostoContable().setNumero(numeroArg22);
		this.buildCuentaContable().buildCentroCostoContable().setNombre(nombreArg23);
		this.buildCuentaContable().buildCentroCostoContable().setAbreviatura(abreviaturaArg24);
		this.buildCuentaContable().buildCentroCostoContable().buildEjercicioContable().setId(idArg25);
		this.buildCuentaContable().buildCentroCostoContable().buildEjercicioContable().setNumero(numeroArg26);
		this.buildCuentaContable().buildCentroCostoContable().buildEjercicioContable().setApertura(aperturaArg27);
		this.buildCuentaContable().buildCentroCostoContable().buildEjercicioContable().setCierre(cierreArg28);
		this.buildCuentaContable().buildCentroCostoContable().buildEjercicioContable().setCerrado(cerradoArg29);
		this.buildCuentaContable().buildCentroCostoContable().buildEjercicioContable().setCerradoModulos(cerradoModulosArg30);
		this.buildCuentaContable().buildCentroCostoContable().buildEjercicioContable().setComentario(comentarioArg31);
		this.buildCuentaContable().setCuentaAgrupadora(cuentaAgrupadoraArg32);
		this.buildCuentaContable().setPorcentaje(porcentajeArg33);
		this.buildCuentaContable().buildPuntoEquilibrio().setId(idArg34);
		this.buildCuentaContable().buildPuntoEquilibrio().setNumero(numeroArg35);
		this.buildCuentaContable().buildPuntoEquilibrio().setNombre(nombreArg36);
		this.buildCuentaContable().buildPuntoEquilibrio().buildTipoPuntoEquilibrio().setId(idArg37);
		this.buildCuentaContable().buildPuntoEquilibrio().buildTipoPuntoEquilibrio().setNumero(numeroArg38);
		this.buildCuentaContable().buildPuntoEquilibrio().buildTipoPuntoEquilibrio().setNombre(nombreArg39);
		this.buildCuentaContable().buildPuntoEquilibrio().buildEjercicioContable().setId(idArg40);
		this.buildCuentaContable().buildPuntoEquilibrio().buildEjercicioContable().setNumero(numeroArg41);
		this.buildCuentaContable().buildPuntoEquilibrio().buildEjercicioContable().setApertura(aperturaArg42);
		this.buildCuentaContable().buildPuntoEquilibrio().buildEjercicioContable().setCierre(cierreArg43);
		this.buildCuentaContable().buildPuntoEquilibrio().buildEjercicioContable().setCerrado(cerradoArg44);
		this.buildCuentaContable().buildPuntoEquilibrio().buildEjercicioContable().setCerradoModulos(cerradoModulosArg45);
		this.buildCuentaContable().buildPuntoEquilibrio().buildEjercicioContable().setComentario(comentarioArg46);
		this.buildCuentaContable().buildCostoVenta().setId(idArg47);
		this.buildCuentaContable().buildCostoVenta().setNumero(numeroArg48);
		this.buildCuentaContable().buildCostoVenta().setNombre(nombreArg49);
		this.buildCuentaContable().buildSeguridadPuerta().setId(idArg50);
		this.buildCuentaContable().buildSeguridadPuerta().setNumero(numeroArg51);
		this.buildCuentaContable().buildSeguridadPuerta().setNombre(nombreArg52);
		this.buildCuentaContable().buildSeguridadPuerta().setEquate(equateArg53);
		this.buildCuentaContable().buildSeguridadPuerta().buildSeguridadModulo().setId(idArg54);
		this.buildCuentaContable().buildSeguridadPuerta().buildSeguridadModulo().setNumero(numeroArg55);
		this.buildCuentaContable().buildSeguridadPuerta().buildSeguridadModulo().setNombre(nombreArg56);
		this.buildCuentaFondoGrupo().setId(idArg57);
		this.buildCuentaFondoGrupo().setNumero(numeroArg58);
		this.buildCuentaFondoGrupo().setNombre(nombreArg59);
		this.buildCuentaFondoGrupo().buildCuentaFondoRubro().setId(idArg60);
		this.buildCuentaFondoGrupo().buildCuentaFondoRubro().setNumero(numeroArg61);
		this.buildCuentaFondoGrupo().buildCuentaFondoRubro().setNombre(nombreArg62);
		this.buildCuentaFondoTipo().setId(idArg63);
		this.buildCuentaFondoTipo().setNumero(numeroArg64);
		this.buildCuentaFondoTipo().setNombre(nombreArg65);
		this.setObsoleto(obsoletoArg66);
		this.setNoImprimeCaja(noImprimeCajaArg67);
		this.setVentas(ventasArg68);
		this.setFondos(fondosArg69);
		this.setCompras(comprasArg70);
		this.buildMoneda().setId(idArg71);
		this.buildMoneda().setNumero(numeroArg72);
		this.buildMoneda().setNombre(nombreArg73);
		this.buildMoneda().setAbreviatura(abreviaturaArg74);
		this.buildMoneda().setCotizacion(cotizacionArg75);
		this.buildMoneda().setCotizacionFecha(cotizacionFechaArg76);
		this.buildMoneda().setControlActualizacion(controlActualizacionArg77);
		this.buildMoneda().buildMonedaAFIP().setId(idArg78);
		this.buildMoneda().buildMonedaAFIP().setCodigo(codigoArg79);
		this.buildMoneda().buildMonedaAFIP().setNombre(nombreArg80);
		this.buildCaja().setId(idArg81);
		this.buildCaja().setNumero(numeroArg82);
		this.buildCaja().setNombre(nombreArg83);
		this.buildCaja().buildSeguridadPuerta().setId(idArg84);
		this.buildCaja().buildSeguridadPuerta().setNumero(numeroArg85);
		this.buildCaja().buildSeguridadPuerta().setNombre(nombreArg86);
		this.buildCaja().buildSeguridadPuerta().setEquate(equateArg87);
		this.buildCaja().buildSeguridadPuerta().buildSeguridadModulo().setId(idArg88);
		this.buildCaja().buildSeguridadPuerta().buildSeguridadModulo().setNumero(numeroArg89);
		this.buildCaja().buildSeguridadPuerta().buildSeguridadModulo().setNombre(nombreArg90);
		this.setRechazados(rechazadosArg91);
		this.setConciliacion(conciliacionArg92);
		this.buildCuentaFondoTipoBanco().setId(idArg93);
		this.buildCuentaFondoTipoBanco().setNumero(numeroArg94);
		this.buildCuentaFondoTipoBanco().setNombre(nombreArg95);
		this.buildBanco().setId(idArg96);
		this.buildBanco().setNumero(numeroArg97);
		this.buildBanco().setNombre(nombreArg98);
		this.buildBanco().setCuit(cuitArg99);
		this.buildBanco().setBloqueado(bloqueadoArg100);
		this.buildBanco().setHoja(hojaArg101);
		this.buildBanco().setPrimeraFila(primeraFilaArg102);
		this.buildBanco().setUltimaFila(ultimaFilaArg103);
		this.buildBanco().setFecha(fechaArg104);
		this.buildBanco().setDescripcion(descripcionArg105);
		this.buildBanco().setReferencia1(referencia1Arg106);
		this.buildBanco().setImporte(importeArg107);
		this.buildBanco().setReferencia2(referencia2Arg108);
		this.buildBanco().setSaldo(saldoArg109);
		this.setCuentaBancaria(cuentaBancariaArg110);
		this.setCbu(cbuArg111);
		this.setLimiteDescubierto(limiteDescubiertoArg112);
		this.setCuentaFondoCaucion(cuentaFondoCaucionArg113);
		this.setCuentaFondoDiferidos(cuentaFondoDiferidosArg114);
		this.setFormato(formatoArg115);
		this.buildCuentaFondoBancoCopia().setId(idArg116);
		this.buildCuentaFondoBancoCopia().setNumero(numeroArg117);
		this.buildCuentaFondoBancoCopia().setNombre(nombreArg118);
		this.setLimiteOperacionIndividual(limiteOperacionIndividualArg119);
		this.buildSeguridadPuertaUso().setId(idArg120);
		this.buildSeguridadPuertaUso().setNumero(numeroArg121);
		this.buildSeguridadPuertaUso().setNombre(nombreArg122);
		this.buildSeguridadPuertaUso().setEquate(equateArg123);
		this.buildSeguridadPuertaUso().buildSeguridadModulo().setId(idArg124);
		this.buildSeguridadPuertaUso().buildSeguridadModulo().setNumero(numeroArg125);
		this.buildSeguridadPuertaUso().buildSeguridadModulo().setNombre(nombreArg126);
		this.buildSeguridadPuertaConsulta().setId(idArg127);
		this.buildSeguridadPuertaConsulta().setNumero(numeroArg128);
		this.buildSeguridadPuertaConsulta().setNombre(nombreArg129);
		this.buildSeguridadPuertaConsulta().setEquate(equateArg130);
		this.buildSeguridadPuertaConsulta().buildSeguridadModulo().setId(idArg131);
		this.buildSeguridadPuertaConsulta().buildSeguridadModulo().setNumero(numeroArg132);
		this.buildSeguridadPuertaConsulta().buildSeguridadModulo().setNombre(nombreArg133);
		this.buildSeguridadPuertaLimite().setId(idArg134);
		this.buildSeguridadPuertaLimite().setNumero(numeroArg135);
		this.buildSeguridadPuertaLimite().setNombre(nombreArg136);
		this.buildSeguridadPuertaLimite().setEquate(equateArg137);
		this.buildSeguridadPuertaLimite().buildSeguridadModulo().setId(idArg138);
		this.buildSeguridadPuertaLimite().buildSeguridadModulo().setNumero(numeroArg139);
		this.buildSeguridadPuertaLimite().buildSeguridadModulo().setNombre(nombreArg140);

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