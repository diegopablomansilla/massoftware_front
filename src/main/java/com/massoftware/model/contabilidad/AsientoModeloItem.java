package com.massoftware.model.contabilidad;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.model.EntityId;
import com.massoftware.model.contabilidad.AsientoModelo;
import com.massoftware.model.contabilidad.CuentaContable;

@ClassLabelAnont(singular = "Item de asiento modelo", plural = "Items de asiento modelo", singularPre = "el item de asiento modelo", pluralPre = "los items de asientos modelo")
public class AsientoModeloItem extends EntityId {

	// ---------------------------------------------------------------------------------------------------------------------------


	@FieldConfAnont(label = "ID")
	private String id;

	// Nº item
	@FieldConfAnont(label = "Nº item", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numero;

	// Asiento modelo
	@FieldConfAnont(label = "Asiento modelo", labelError = "", unique = false, readOnly = true, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private AsientoModelo asientoModelo;

	// Cuenta contable
	@FieldConfAnont(label = "Cuenta contable", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private CuentaContable cuentaContable;

	// ---------------------------------------------------------------------------------------------------------------------------


	public AsientoModeloItem() throws Exception {
	}

	public AsientoModeloItem(String idArg0, Integer numeroArg1, String idAsientoModeloArg2, String idCuentaContableArg3) throws Exception {

		setter(idArg0, numeroArg1, idAsientoModeloArg2, idCuentaContableArg3);

	}

	public AsientoModeloItem(String idArg0, Integer numeroArg1, String idArg2, Integer numeroArg3, String nombreArg4, String idEjercicioContableArg5, String idArg6, String codigoArg7, String nombreArg8, String idEjercicioContableArg9, String integraArg10, String cuentaJerarquiaArg11, Boolean imputableArg12, Boolean ajustaPorInflacionArg13, String idCuentaContableEstadoArg14, Boolean cuentaConApropiacionArg15, String idCentroCostoContableArg16, String cuentaAgrupadoraArg17, java.math.BigDecimal porcentajeArg18, String idPuntoEquilibrioArg19, String idCostoVentaArg20, String idSeguridadPuertaArg21) throws Exception {

		setter(idArg0, numeroArg1, idArg2, numeroArg3, nombreArg4, idEjercicioContableArg5, idArg6, codigoArg7, nombreArg8, idEjercicioContableArg9, integraArg10, cuentaJerarquiaArg11, imputableArg12, ajustaPorInflacionArg13, idCuentaContableEstadoArg14, cuentaConApropiacionArg15, idCentroCostoContableArg16, cuentaAgrupadoraArg17, porcentajeArg18, idPuntoEquilibrioArg19, idCostoVentaArg20, idSeguridadPuertaArg21);

	}

	public AsientoModeloItem(String idArg0, Integer numeroArg1, String idArg2, Integer numeroArg3, String nombreArg4, String idArg5, Integer numeroArg6, java.util.Date aperturaArg7, java.util.Date cierreArg8, Boolean cerradoArg9, Boolean cerradoModulosArg10, String comentarioArg11, String idArg12, String codigoArg13, String nombreArg14, String idArg15, Integer numeroArg16, java.util.Date aperturaArg17, java.util.Date cierreArg18, Boolean cerradoArg19, Boolean cerradoModulosArg20, String comentarioArg21, String integraArg22, String cuentaJerarquiaArg23, Boolean imputableArg24, Boolean ajustaPorInflacionArg25, String idArg26, Integer numeroArg27, String nombreArg28, Boolean cuentaConApropiacionArg29, String idArg30, Integer numeroArg31, String nombreArg32, String abreviaturaArg33, String idEjercicioContableArg34, String cuentaAgrupadoraArg35, java.math.BigDecimal porcentajeArg36, String idArg37, Integer numeroArg38, String nombreArg39, String idTipoPuntoEquilibrioArg40, String idEjercicioContableArg41, String idArg42, Integer numeroArg43, String nombreArg44, String idArg45, Integer numeroArg46, String nombreArg47, String equateArg48, String idSeguridadModuloArg49) throws Exception {

		setter(idArg0, numeroArg1, idArg2, numeroArg3, nombreArg4, idArg5, numeroArg6, aperturaArg7, cierreArg8, cerradoArg9, cerradoModulosArg10, comentarioArg11, idArg12, codigoArg13, nombreArg14, idArg15, numeroArg16, aperturaArg17, cierreArg18, cerradoArg19, cerradoModulosArg20, comentarioArg21, integraArg22, cuentaJerarquiaArg23, imputableArg24, ajustaPorInflacionArg25, idArg26, numeroArg27, nombreArg28, cuentaConApropiacionArg29, idArg30, numeroArg31, nombreArg32, abreviaturaArg33, idEjercicioContableArg34, cuentaAgrupadoraArg35, porcentajeArg36, idArg37, numeroArg38, nombreArg39, idTipoPuntoEquilibrioArg40, idEjercicioContableArg41, idArg42, numeroArg43, nombreArg44, idArg45, numeroArg46, nombreArg47, equateArg48, idSeguridadModuloArg49);

	}

	public AsientoModeloItem(String idArg0, Integer numeroArg1, String idArg2, Integer numeroArg3, String nombreArg4, String idArg5, Integer numeroArg6, java.util.Date aperturaArg7, java.util.Date cierreArg8, Boolean cerradoArg9, Boolean cerradoModulosArg10, String comentarioArg11, String idArg12, String codigoArg13, String nombreArg14, String idArg15, Integer numeroArg16, java.util.Date aperturaArg17, java.util.Date cierreArg18, Boolean cerradoArg19, Boolean cerradoModulosArg20, String comentarioArg21, String integraArg22, String cuentaJerarquiaArg23, Boolean imputableArg24, Boolean ajustaPorInflacionArg25, String idArg26, Integer numeroArg27, String nombreArg28, Boolean cuentaConApropiacionArg29, String idArg30, Integer numeroArg31, String nombreArg32, String abreviaturaArg33, String idArg34, Integer numeroArg35, java.util.Date aperturaArg36, java.util.Date cierreArg37, Boolean cerradoArg38, Boolean cerradoModulosArg39, String comentarioArg40, String cuentaAgrupadoraArg41, java.math.BigDecimal porcentajeArg42, String idArg43, Integer numeroArg44, String nombreArg45, String idArg46, Integer numeroArg47, String nombreArg48, String idArg49, Integer numeroArg50, java.util.Date aperturaArg51, java.util.Date cierreArg52, Boolean cerradoArg53, Boolean cerradoModulosArg54, String comentarioArg55, String idArg56, Integer numeroArg57, String nombreArg58, String idArg59, Integer numeroArg60, String nombreArg61, String equateArg62, String idArg63, Integer numeroArg64, String nombreArg65) throws Exception {

		setter(idArg0, numeroArg1, idArg2, numeroArg3, nombreArg4, idArg5, numeroArg6, aperturaArg7, cierreArg8, cerradoArg9, cerradoModulosArg10, comentarioArg11, idArg12, codigoArg13, nombreArg14, idArg15, numeroArg16, aperturaArg17, cierreArg18, cerradoArg19, cerradoModulosArg20, comentarioArg21, integraArg22, cuentaJerarquiaArg23, imputableArg24, ajustaPorInflacionArg25, idArg26, numeroArg27, nombreArg28, cuentaConApropiacionArg29, idArg30, numeroArg31, nombreArg32, abreviaturaArg33, idArg34, numeroArg35, aperturaArg36, cierreArg37, cerradoArg38, cerradoModulosArg39, comentarioArg40, cuentaAgrupadoraArg41, porcentajeArg42, idArg43, numeroArg44, nombreArg45, idArg46, numeroArg47, nombreArg48, idArg49, numeroArg50, aperturaArg51, cierreArg52, cerradoArg53, cerradoModulosArg54, comentarioArg55, idArg56, numeroArg57, nombreArg58, idArg59, numeroArg60, nombreArg61, equateArg62, idArg63, numeroArg64, nombreArg65);

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

	// GET Nº item
	public Integer getNumero() {
		return this.numero;
	}

	// SET Nº item
	public void setNumero(Integer numero ){
		this.numero = numero;
	}

	// BUILD IF NULL AND GET Asiento modelo
	public AsientoModelo buildAsientoModelo() throws Exception {
		this.asientoModelo = (this.asientoModelo == null) ? new AsientoModelo() : this.asientoModelo;
		return this.asientoModelo;
	}

	// GET Asiento modelo
	public AsientoModelo getAsientoModelo() {
		this.asientoModelo = (this.asientoModelo != null && this.asientoModelo.getId() == null) ? null : this.asientoModelo ;
		return this.asientoModelo;
	}

	// SET Asiento modelo
	public void setAsientoModelo(AsientoModelo asientoModelo ){
		this.asientoModelo = asientoModelo;
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

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String idAsientoModeloArg2, String idCuentaContableArg3) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.buildAsientoModelo().setId(idAsientoModeloArg2);
		this.buildCuentaContable().setId(idCuentaContableArg3);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String idArg2, Integer numeroArg3, String nombreArg4, String idEjercicioContableArg5, String idArg6, String codigoArg7, String nombreArg8, String idEjercicioContableArg9, String integraArg10, String cuentaJerarquiaArg11, Boolean imputableArg12, Boolean ajustaPorInflacionArg13, String idCuentaContableEstadoArg14, Boolean cuentaConApropiacionArg15, String idCentroCostoContableArg16, String cuentaAgrupadoraArg17, java.math.BigDecimal porcentajeArg18, String idPuntoEquilibrioArg19, String idCostoVentaArg20, String idSeguridadPuertaArg21) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.buildAsientoModelo().setId(idArg2);
		this.buildAsientoModelo().setNumero(numeroArg3);
		this.buildAsientoModelo().setNombre(nombreArg4);
		this.buildAsientoModelo().buildEjercicioContable().setId(idEjercicioContableArg5);
		this.buildCuentaContable().setId(idArg6);
		this.buildCuentaContable().setCodigo(codigoArg7);
		this.buildCuentaContable().setNombre(nombreArg8);
		this.buildCuentaContable().buildEjercicioContable().setId(idEjercicioContableArg9);
		this.buildCuentaContable().setIntegra(integraArg10);
		this.buildCuentaContable().setCuentaJerarquia(cuentaJerarquiaArg11);
		this.buildCuentaContable().setImputable(imputableArg12);
		this.buildCuentaContable().setAjustaPorInflacion(ajustaPorInflacionArg13);
		this.buildCuentaContable().buildCuentaContableEstado().setId(idCuentaContableEstadoArg14);
		this.buildCuentaContable().setCuentaConApropiacion(cuentaConApropiacionArg15);
		this.buildCuentaContable().buildCentroCostoContable().setId(idCentroCostoContableArg16);
		this.buildCuentaContable().setCuentaAgrupadora(cuentaAgrupadoraArg17);
		this.buildCuentaContable().setPorcentaje(porcentajeArg18);
		this.buildCuentaContable().buildPuntoEquilibrio().setId(idPuntoEquilibrioArg19);
		this.buildCuentaContable().buildCostoVenta().setId(idCostoVentaArg20);
		this.buildCuentaContable().buildSeguridadPuerta().setId(idSeguridadPuertaArg21);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String idArg2, Integer numeroArg3, String nombreArg4, String idArg5, Integer numeroArg6, java.util.Date aperturaArg7, java.util.Date cierreArg8, Boolean cerradoArg9, Boolean cerradoModulosArg10, String comentarioArg11, String idArg12, String codigoArg13, String nombreArg14, String idArg15, Integer numeroArg16, java.util.Date aperturaArg17, java.util.Date cierreArg18, Boolean cerradoArg19, Boolean cerradoModulosArg20, String comentarioArg21, String integraArg22, String cuentaJerarquiaArg23, Boolean imputableArg24, Boolean ajustaPorInflacionArg25, String idArg26, Integer numeroArg27, String nombreArg28, Boolean cuentaConApropiacionArg29, String idArg30, Integer numeroArg31, String nombreArg32, String abreviaturaArg33, String idEjercicioContableArg34, String cuentaAgrupadoraArg35, java.math.BigDecimal porcentajeArg36, String idArg37, Integer numeroArg38, String nombreArg39, String idTipoPuntoEquilibrioArg40, String idEjercicioContableArg41, String idArg42, Integer numeroArg43, String nombreArg44, String idArg45, Integer numeroArg46, String nombreArg47, String equateArg48, String idSeguridadModuloArg49) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.buildAsientoModelo().setId(idArg2);
		this.buildAsientoModelo().setNumero(numeroArg3);
		this.buildAsientoModelo().setNombre(nombreArg4);
		this.buildAsientoModelo().buildEjercicioContable().setId(idArg5);
		this.buildAsientoModelo().buildEjercicioContable().setNumero(numeroArg6);
		this.buildAsientoModelo().buildEjercicioContable().setApertura(aperturaArg7);
		this.buildAsientoModelo().buildEjercicioContable().setCierre(cierreArg8);
		this.buildAsientoModelo().buildEjercicioContable().setCerrado(cerradoArg9);
		this.buildAsientoModelo().buildEjercicioContable().setCerradoModulos(cerradoModulosArg10);
		this.buildAsientoModelo().buildEjercicioContable().setComentario(comentarioArg11);
		this.buildCuentaContable().setId(idArg12);
		this.buildCuentaContable().setCodigo(codigoArg13);
		this.buildCuentaContable().setNombre(nombreArg14);
		this.buildCuentaContable().buildEjercicioContable().setId(idArg15);
		this.buildCuentaContable().buildEjercicioContable().setNumero(numeroArg16);
		this.buildCuentaContable().buildEjercicioContable().setApertura(aperturaArg17);
		this.buildCuentaContable().buildEjercicioContable().setCierre(cierreArg18);
		this.buildCuentaContable().buildEjercicioContable().setCerrado(cerradoArg19);
		this.buildCuentaContable().buildEjercicioContable().setCerradoModulos(cerradoModulosArg20);
		this.buildCuentaContable().buildEjercicioContable().setComentario(comentarioArg21);
		this.buildCuentaContable().setIntegra(integraArg22);
		this.buildCuentaContable().setCuentaJerarquia(cuentaJerarquiaArg23);
		this.buildCuentaContable().setImputable(imputableArg24);
		this.buildCuentaContable().setAjustaPorInflacion(ajustaPorInflacionArg25);
		this.buildCuentaContable().buildCuentaContableEstado().setId(idArg26);
		this.buildCuentaContable().buildCuentaContableEstado().setNumero(numeroArg27);
		this.buildCuentaContable().buildCuentaContableEstado().setNombre(nombreArg28);
		this.buildCuentaContable().setCuentaConApropiacion(cuentaConApropiacionArg29);
		this.buildCuentaContable().buildCentroCostoContable().setId(idArg30);
		this.buildCuentaContable().buildCentroCostoContable().setNumero(numeroArg31);
		this.buildCuentaContable().buildCentroCostoContable().setNombre(nombreArg32);
		this.buildCuentaContable().buildCentroCostoContable().setAbreviatura(abreviaturaArg33);
		this.buildCuentaContable().buildCentroCostoContable().buildEjercicioContable().setId(idEjercicioContableArg34);
		this.buildCuentaContable().setCuentaAgrupadora(cuentaAgrupadoraArg35);
		this.buildCuentaContable().setPorcentaje(porcentajeArg36);
		this.buildCuentaContable().buildPuntoEquilibrio().setId(idArg37);
		this.buildCuentaContable().buildPuntoEquilibrio().setNumero(numeroArg38);
		this.buildCuentaContable().buildPuntoEquilibrio().setNombre(nombreArg39);
		this.buildCuentaContable().buildPuntoEquilibrio().buildTipoPuntoEquilibrio().setId(idTipoPuntoEquilibrioArg40);
		this.buildCuentaContable().buildPuntoEquilibrio().buildEjercicioContable().setId(idEjercicioContableArg41);
		this.buildCuentaContable().buildCostoVenta().setId(idArg42);
		this.buildCuentaContable().buildCostoVenta().setNumero(numeroArg43);
		this.buildCuentaContable().buildCostoVenta().setNombre(nombreArg44);
		this.buildCuentaContable().buildSeguridadPuerta().setId(idArg45);
		this.buildCuentaContable().buildSeguridadPuerta().setNumero(numeroArg46);
		this.buildCuentaContable().buildSeguridadPuerta().setNombre(nombreArg47);
		this.buildCuentaContable().buildSeguridadPuerta().setEquate(equateArg48);
		this.buildCuentaContable().buildSeguridadPuerta().buildSeguridadModulo().setId(idSeguridadModuloArg49);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String idArg2, Integer numeroArg3, String nombreArg4, String idArg5, Integer numeroArg6, java.util.Date aperturaArg7, java.util.Date cierreArg8, Boolean cerradoArg9, Boolean cerradoModulosArg10, String comentarioArg11, String idArg12, String codigoArg13, String nombreArg14, String idArg15, Integer numeroArg16, java.util.Date aperturaArg17, java.util.Date cierreArg18, Boolean cerradoArg19, Boolean cerradoModulosArg20, String comentarioArg21, String integraArg22, String cuentaJerarquiaArg23, Boolean imputableArg24, Boolean ajustaPorInflacionArg25, String idArg26, Integer numeroArg27, String nombreArg28, Boolean cuentaConApropiacionArg29, String idArg30, Integer numeroArg31, String nombreArg32, String abreviaturaArg33, String idArg34, Integer numeroArg35, java.util.Date aperturaArg36, java.util.Date cierreArg37, Boolean cerradoArg38, Boolean cerradoModulosArg39, String comentarioArg40, String cuentaAgrupadoraArg41, java.math.BigDecimal porcentajeArg42, String idArg43, Integer numeroArg44, String nombreArg45, String idArg46, Integer numeroArg47, String nombreArg48, String idArg49, Integer numeroArg50, java.util.Date aperturaArg51, java.util.Date cierreArg52, Boolean cerradoArg53, Boolean cerradoModulosArg54, String comentarioArg55, String idArg56, Integer numeroArg57, String nombreArg58, String idArg59, Integer numeroArg60, String nombreArg61, String equateArg62, String idArg63, Integer numeroArg64, String nombreArg65) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.buildAsientoModelo().setId(idArg2);
		this.buildAsientoModelo().setNumero(numeroArg3);
		this.buildAsientoModelo().setNombre(nombreArg4);
		this.buildAsientoModelo().buildEjercicioContable().setId(idArg5);
		this.buildAsientoModelo().buildEjercicioContable().setNumero(numeroArg6);
		this.buildAsientoModelo().buildEjercicioContable().setApertura(aperturaArg7);
		this.buildAsientoModelo().buildEjercicioContable().setCierre(cierreArg8);
		this.buildAsientoModelo().buildEjercicioContable().setCerrado(cerradoArg9);
		this.buildAsientoModelo().buildEjercicioContable().setCerradoModulos(cerradoModulosArg10);
		this.buildAsientoModelo().buildEjercicioContable().setComentario(comentarioArg11);
		this.buildCuentaContable().setId(idArg12);
		this.buildCuentaContable().setCodigo(codigoArg13);
		this.buildCuentaContable().setNombre(nombreArg14);
		this.buildCuentaContable().buildEjercicioContable().setId(idArg15);
		this.buildCuentaContable().buildEjercicioContable().setNumero(numeroArg16);
		this.buildCuentaContable().buildEjercicioContable().setApertura(aperturaArg17);
		this.buildCuentaContable().buildEjercicioContable().setCierre(cierreArg18);
		this.buildCuentaContable().buildEjercicioContable().setCerrado(cerradoArg19);
		this.buildCuentaContable().buildEjercicioContable().setCerradoModulos(cerradoModulosArg20);
		this.buildCuentaContable().buildEjercicioContable().setComentario(comentarioArg21);
		this.buildCuentaContable().setIntegra(integraArg22);
		this.buildCuentaContable().setCuentaJerarquia(cuentaJerarquiaArg23);
		this.buildCuentaContable().setImputable(imputableArg24);
		this.buildCuentaContable().setAjustaPorInflacion(ajustaPorInflacionArg25);
		this.buildCuentaContable().buildCuentaContableEstado().setId(idArg26);
		this.buildCuentaContable().buildCuentaContableEstado().setNumero(numeroArg27);
		this.buildCuentaContable().buildCuentaContableEstado().setNombre(nombreArg28);
		this.buildCuentaContable().setCuentaConApropiacion(cuentaConApropiacionArg29);
		this.buildCuentaContable().buildCentroCostoContable().setId(idArg30);
		this.buildCuentaContable().buildCentroCostoContable().setNumero(numeroArg31);
		this.buildCuentaContable().buildCentroCostoContable().setNombre(nombreArg32);
		this.buildCuentaContable().buildCentroCostoContable().setAbreviatura(abreviaturaArg33);
		this.buildCuentaContable().buildCentroCostoContable().buildEjercicioContable().setId(idArg34);
		this.buildCuentaContable().buildCentroCostoContable().buildEjercicioContable().setNumero(numeroArg35);
		this.buildCuentaContable().buildCentroCostoContable().buildEjercicioContable().setApertura(aperturaArg36);
		this.buildCuentaContable().buildCentroCostoContable().buildEjercicioContable().setCierre(cierreArg37);
		this.buildCuentaContable().buildCentroCostoContable().buildEjercicioContable().setCerrado(cerradoArg38);
		this.buildCuentaContable().buildCentroCostoContable().buildEjercicioContable().setCerradoModulos(cerradoModulosArg39);
		this.buildCuentaContable().buildCentroCostoContable().buildEjercicioContable().setComentario(comentarioArg40);
		this.buildCuentaContable().setCuentaAgrupadora(cuentaAgrupadoraArg41);
		this.buildCuentaContable().setPorcentaje(porcentajeArg42);
		this.buildCuentaContable().buildPuntoEquilibrio().setId(idArg43);
		this.buildCuentaContable().buildPuntoEquilibrio().setNumero(numeroArg44);
		this.buildCuentaContable().buildPuntoEquilibrio().setNombre(nombreArg45);
		this.buildCuentaContable().buildPuntoEquilibrio().buildTipoPuntoEquilibrio().setId(idArg46);
		this.buildCuentaContable().buildPuntoEquilibrio().buildTipoPuntoEquilibrio().setNumero(numeroArg47);
		this.buildCuentaContable().buildPuntoEquilibrio().buildTipoPuntoEquilibrio().setNombre(nombreArg48);
		this.buildCuentaContable().buildPuntoEquilibrio().buildEjercicioContable().setId(idArg49);
		this.buildCuentaContable().buildPuntoEquilibrio().buildEjercicioContable().setNumero(numeroArg50);
		this.buildCuentaContable().buildPuntoEquilibrio().buildEjercicioContable().setApertura(aperturaArg51);
		this.buildCuentaContable().buildPuntoEquilibrio().buildEjercicioContable().setCierre(cierreArg52);
		this.buildCuentaContable().buildPuntoEquilibrio().buildEjercicioContable().setCerrado(cerradoArg53);
		this.buildCuentaContable().buildPuntoEquilibrio().buildEjercicioContable().setCerradoModulos(cerradoModulosArg54);
		this.buildCuentaContable().buildPuntoEquilibrio().buildEjercicioContable().setComentario(comentarioArg55);
		this.buildCuentaContable().buildCostoVenta().setId(idArg56);
		this.buildCuentaContable().buildCostoVenta().setNumero(numeroArg57);
		this.buildCuentaContable().buildCostoVenta().setNombre(nombreArg58);
		this.buildCuentaContable().buildSeguridadPuerta().setId(idArg59);
		this.buildCuentaContable().buildSeguridadPuerta().setNumero(numeroArg60);
		this.buildCuentaContable().buildSeguridadPuerta().setNombre(nombreArg61);
		this.buildCuentaContable().buildSeguridadPuerta().setEquate(equateArg62);
		this.buildCuentaContable().buildSeguridadPuerta().buildSeguridadModulo().setId(idArg63);
		this.buildCuentaContable().buildSeguridadPuerta().buildSeguridadModulo().setNumero(numeroArg64);
		this.buildCuentaContable().buildSeguridadPuerta().buildSeguridadModulo().setNombre(nombreArg65);

	}

	// ---------------------------------------------------------------------------------------------------------------------------

	public String toString() {
		if(this.getNumero() != null && this.getAsientoModelo() != null){
			return this.getNumero() + " - " +  this.getAsientoModelo();
		} else if(this.getNumero() != null && this.getAsientoModelo() == null){
			return this.getNumero().toString();
		} else if(this.getNumero() == null && this.getAsientoModelo() != null){
			return this.getAsientoModelo().toString();
		} else {
			return super.toString();
		}
	}

} // END CLASS ----------------------------------------------------------------------------------------------------------