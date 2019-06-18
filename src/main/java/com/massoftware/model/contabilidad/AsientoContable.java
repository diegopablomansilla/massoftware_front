package com.massoftware.model.contabilidad;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.model.EntityId;
import com.massoftware.model.contabilidad.EjercicioContable;
import com.massoftware.model.contabilidad.MinutaContable;
import com.massoftware.model.empresa.Sucursal;
import com.massoftware.model.contabilidad.AsientoContableModulo;

@ClassLabelAnont(singular = "Asiento contable", plural = "Asientos contables", singularPre = "el asiento contable", pluralPre = "los asientos contables")
public class AsientoContable extends EntityId {

	// ---------------------------------------------------------------------------------------------------------------------------


	@FieldConfAnont(label = "ID")
	private String id;

	// Nº asiento
	@FieldConfAnont(label = "Nº asiento", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numero;

	// Fecha
	@FieldConfAnont(label = "Fecha", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private java.util.Date fecha;

	// Detalle
	@FieldConfAnont(label = "Detalle", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 100, minValue = "", maxValue = "", mask = "")
	private String detalle;

	// Ejercicio
	@FieldConfAnont(label = "Ejercicio", labelError = "", unique = false, readOnly = true, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private EjercicioContable ejercicioContable;

	// Minuta contable
	@FieldConfAnont(label = "Minuta contable", labelError = "", unique = false, readOnly = true, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private MinutaContable minutaContable;

	// Sucursal
	@FieldConfAnont(label = "Sucursal", labelError = "", unique = false, readOnly = true, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Sucursal sucursal;

	// Módulo
	@FieldConfAnont(label = "Módulo", labelError = "", unique = false, readOnly = true, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private AsientoContableModulo asientoContableModulo;

	// ---------------------------------------------------------------------------------------------------------------------------


	public AsientoContable() throws Exception {
	}

	public AsientoContable(String idArg0, Integer numeroArg1, java.util.Date fechaArg2, String detalleArg3, String idEjercicioContableArg4, String idMinutaContableArg5, String idSucursalArg6, String idAsientoContableModuloArg7) throws Exception {

		setter(idArg0, numeroArg1, fechaArg2, detalleArg3, idEjercicioContableArg4, idMinutaContableArg5, idSucursalArg6, idAsientoContableModuloArg7);

	}

	public AsientoContable(String idArg0, Integer numeroArg1, java.util.Date fechaArg2, String detalleArg3, String idArg4, Integer numeroArg5, java.util.Date aperturaArg6, java.util.Date cierreArg7, Boolean cerradoArg8, Boolean cerradoModulosArg9, String comentarioArg10, String idArg11, Integer numeroArg12, String nombreArg13, String idArg14, Integer numeroArg15, String nombreArg16, String abreviaturaArg17, String idTipoSucursalArg18, String cuentaClientesDesdeArg19, String cuentaClientesHastaArg20, Integer cantidadCaracteresClientesArg21, Boolean identificacionNumericaClientesArg22, Boolean permiteCambiarClientesArg23, String cuentaProveedoresDesdeArg24, String cuentaProveedoresHastaArg25, Integer cantidadCaracteresProveedoresArg26, Boolean identificacionNumericaProveedoresArg27, Boolean permiteCambiarProveedoresArg28, Integer clientesOcacionalesDesdeArg29, Integer clientesOcacionalesHastaArg30, Integer numeroCobranzaDesdeArg31, Integer numeroCobranzaHastaArg32, String idArg33, Integer numeroArg34, String nombreArg35) throws Exception {

		setter(idArg0, numeroArg1, fechaArg2, detalleArg3, idArg4, numeroArg5, aperturaArg6, cierreArg7, cerradoArg8, cerradoModulosArg9, comentarioArg10, idArg11, numeroArg12, nombreArg13, idArg14, numeroArg15, nombreArg16, abreviaturaArg17, idTipoSucursalArg18, cuentaClientesDesdeArg19, cuentaClientesHastaArg20, cantidadCaracteresClientesArg21, identificacionNumericaClientesArg22, permiteCambiarClientesArg23, cuentaProveedoresDesdeArg24, cuentaProveedoresHastaArg25, cantidadCaracteresProveedoresArg26, identificacionNumericaProveedoresArg27, permiteCambiarProveedoresArg28, clientesOcacionalesDesdeArg29, clientesOcacionalesHastaArg30, numeroCobranzaDesdeArg31, numeroCobranzaHastaArg32, idArg33, numeroArg34, nombreArg35);

	}

	public AsientoContable(String idArg0, Integer numeroArg1, java.util.Date fechaArg2, String detalleArg3, String idArg4, Integer numeroArg5, java.util.Date aperturaArg6, java.util.Date cierreArg7, Boolean cerradoArg8, Boolean cerradoModulosArg9, String comentarioArg10, String idArg11, Integer numeroArg12, String nombreArg13, String idArg14, Integer numeroArg15, String nombreArg16, String abreviaturaArg17, String idArg18, Integer numeroArg19, String nombreArg20, String cuentaClientesDesdeArg21, String cuentaClientesHastaArg22, Integer cantidadCaracteresClientesArg23, Boolean identificacionNumericaClientesArg24, Boolean permiteCambiarClientesArg25, String cuentaProveedoresDesdeArg26, String cuentaProveedoresHastaArg27, Integer cantidadCaracteresProveedoresArg28, Boolean identificacionNumericaProveedoresArg29, Boolean permiteCambiarProveedoresArg30, Integer clientesOcacionalesDesdeArg31, Integer clientesOcacionalesHastaArg32, Integer numeroCobranzaDesdeArg33, Integer numeroCobranzaHastaArg34, String idArg35, Integer numeroArg36, String nombreArg37) throws Exception {

		setter(idArg0, numeroArg1, fechaArg2, detalleArg3, idArg4, numeroArg5, aperturaArg6, cierreArg7, cerradoArg8, cerradoModulosArg9, comentarioArg10, idArg11, numeroArg12, nombreArg13, idArg14, numeroArg15, nombreArg16, abreviaturaArg17, idArg18, numeroArg19, nombreArg20, cuentaClientesDesdeArg21, cuentaClientesHastaArg22, cantidadCaracteresClientesArg23, identificacionNumericaClientesArg24, permiteCambiarClientesArg25, cuentaProveedoresDesdeArg26, cuentaProveedoresHastaArg27, cantidadCaracteresProveedoresArg28, identificacionNumericaProveedoresArg29, permiteCambiarProveedoresArg30, clientesOcacionalesDesdeArg31, clientesOcacionalesHastaArg32, numeroCobranzaDesdeArg33, numeroCobranzaHastaArg34, idArg35, numeroArg36, nombreArg37);

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

	// GET Nº asiento
	public Integer getNumero() {
		return this.numero;
	}

	// SET Nº asiento
	public void setNumero(Integer numero ){
		this.numero = numero;
	}

	// GET Fecha
	public java.util.Date getFecha() {
		return this.fecha;
	}

	// SET Fecha
	public void setFecha(java.util.Date fecha ){
		this.fecha = fecha;
	}

	// GET Detalle
	public String getDetalle() {
		return this.detalle;
	}

	// SET Detalle
	public void setDetalle(String detalle ){
		detalle = (detalle != null) ? detalle.trim() : null;
		this.detalle = (detalle != null && detalle.length() == 0) ? null : detalle;
	}

	// BUILD IF NULL AND GET Ejercicio
	public EjercicioContable buildEjercicioContable() throws Exception {
		this.ejercicioContable = (this.ejercicioContable == null) ? new EjercicioContable() : this.ejercicioContable;
		return this.ejercicioContable;
	}

	// GET Ejercicio
	public EjercicioContable getEjercicioContable() {
		this.ejercicioContable = (this.ejercicioContable != null && this.ejercicioContable.getId() == null) ? null : this.ejercicioContable ;
		return this.ejercicioContable;
	}

	// SET Ejercicio
	public void setEjercicioContable(EjercicioContable ejercicioContable ){
		this.ejercicioContable = ejercicioContable;
	}

	// BUILD IF NULL AND GET Minuta contable
	public MinutaContable buildMinutaContable() throws Exception {
		this.minutaContable = (this.minutaContable == null) ? new MinutaContable() : this.minutaContable;
		return this.minutaContable;
	}

	// GET Minuta contable
	public MinutaContable getMinutaContable() {
		this.minutaContable = (this.minutaContable != null && this.minutaContable.getId() == null) ? null : this.minutaContable ;
		return this.minutaContable;
	}

	// SET Minuta contable
	public void setMinutaContable(MinutaContable minutaContable ){
		this.minutaContable = minutaContable;
	}

	// BUILD IF NULL AND GET Sucursal
	public Sucursal buildSucursal() throws Exception {
		this.sucursal = (this.sucursal == null) ? new Sucursal() : this.sucursal;
		return this.sucursal;
	}

	// GET Sucursal
	public Sucursal getSucursal() {
		this.sucursal = (this.sucursal != null && this.sucursal.getId() == null) ? null : this.sucursal ;
		return this.sucursal;
	}

	// SET Sucursal
	public void setSucursal(Sucursal sucursal ){
		this.sucursal = sucursal;
	}

	// BUILD IF NULL AND GET Módulo
	public AsientoContableModulo buildAsientoContableModulo() throws Exception {
		this.asientoContableModulo = (this.asientoContableModulo == null) ? new AsientoContableModulo() : this.asientoContableModulo;
		return this.asientoContableModulo;
	}

	// GET Módulo
	public AsientoContableModulo getAsientoContableModulo() {
		this.asientoContableModulo = (this.asientoContableModulo != null && this.asientoContableModulo.getId() == null) ? null : this.asientoContableModulo ;
		return this.asientoContableModulo;
	}

	// SET Módulo
	public void setAsientoContableModulo(AsientoContableModulo asientoContableModulo ){
		this.asientoContableModulo = asientoContableModulo;
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, java.util.Date fechaArg2, String detalleArg3, String idEjercicioContableArg4, String idMinutaContableArg5, String idSucursalArg6, String idAsientoContableModuloArg7) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setFecha(fechaArg2);
		this.setDetalle(detalleArg3);
		this.buildEjercicioContable().setId(idEjercicioContableArg4);
		this.buildMinutaContable().setId(idMinutaContableArg5);
		this.buildSucursal().setId(idSucursalArg6);
		this.buildAsientoContableModulo().setId(idAsientoContableModuloArg7);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, java.util.Date fechaArg2, String detalleArg3, String idArg4, Integer numeroArg5, java.util.Date aperturaArg6, java.util.Date cierreArg7, Boolean cerradoArg8, Boolean cerradoModulosArg9, String comentarioArg10, String idArg11, Integer numeroArg12, String nombreArg13, String idArg14, Integer numeroArg15, String nombreArg16, String abreviaturaArg17, String idTipoSucursalArg18, String cuentaClientesDesdeArg19, String cuentaClientesHastaArg20, Integer cantidadCaracteresClientesArg21, Boolean identificacionNumericaClientesArg22, Boolean permiteCambiarClientesArg23, String cuentaProveedoresDesdeArg24, String cuentaProveedoresHastaArg25, Integer cantidadCaracteresProveedoresArg26, Boolean identificacionNumericaProveedoresArg27, Boolean permiteCambiarProveedoresArg28, Integer clientesOcacionalesDesdeArg29, Integer clientesOcacionalesHastaArg30, Integer numeroCobranzaDesdeArg31, Integer numeroCobranzaHastaArg32, String idArg33, Integer numeroArg34, String nombreArg35) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setFecha(fechaArg2);
		this.setDetalle(detalleArg3);
		this.buildEjercicioContable().setId(idArg4);
		this.buildEjercicioContable().setNumero(numeroArg5);
		this.buildEjercicioContable().setApertura(aperturaArg6);
		this.buildEjercicioContable().setCierre(cierreArg7);
		this.buildEjercicioContable().setCerrado(cerradoArg8);
		this.buildEjercicioContable().setCerradoModulos(cerradoModulosArg9);
		this.buildEjercicioContable().setComentario(comentarioArg10);
		this.buildMinutaContable().setId(idArg11);
		this.buildMinutaContable().setNumero(numeroArg12);
		this.buildMinutaContable().setNombre(nombreArg13);
		this.buildSucursal().setId(idArg14);
		this.buildSucursal().setNumero(numeroArg15);
		this.buildSucursal().setNombre(nombreArg16);
		this.buildSucursal().setAbreviatura(abreviaturaArg17);
		this.buildSucursal().buildTipoSucursal().setId(idTipoSucursalArg18);
		this.buildSucursal().setCuentaClientesDesde(cuentaClientesDesdeArg19);
		this.buildSucursal().setCuentaClientesHasta(cuentaClientesHastaArg20);
		this.buildSucursal().setCantidadCaracteresClientes(cantidadCaracteresClientesArg21);
		this.buildSucursal().setIdentificacionNumericaClientes(identificacionNumericaClientesArg22);
		this.buildSucursal().setPermiteCambiarClientes(permiteCambiarClientesArg23);
		this.buildSucursal().setCuentaProveedoresDesde(cuentaProveedoresDesdeArg24);
		this.buildSucursal().setCuentaProveedoresHasta(cuentaProveedoresHastaArg25);
		this.buildSucursal().setCantidadCaracteresProveedores(cantidadCaracteresProveedoresArg26);
		this.buildSucursal().setIdentificacionNumericaProveedores(identificacionNumericaProveedoresArg27);
		this.buildSucursal().setPermiteCambiarProveedores(permiteCambiarProveedoresArg28);
		this.buildSucursal().setClientesOcacionalesDesde(clientesOcacionalesDesdeArg29);
		this.buildSucursal().setClientesOcacionalesHasta(clientesOcacionalesHastaArg30);
		this.buildSucursal().setNumeroCobranzaDesde(numeroCobranzaDesdeArg31);
		this.buildSucursal().setNumeroCobranzaHasta(numeroCobranzaHastaArg32);
		this.buildAsientoContableModulo().setId(idArg33);
		this.buildAsientoContableModulo().setNumero(numeroArg34);
		this.buildAsientoContableModulo().setNombre(nombreArg35);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, java.util.Date fechaArg2, String detalleArg3, String idArg4, Integer numeroArg5, java.util.Date aperturaArg6, java.util.Date cierreArg7, Boolean cerradoArg8, Boolean cerradoModulosArg9, String comentarioArg10, String idArg11, Integer numeroArg12, String nombreArg13, String idArg14, Integer numeroArg15, String nombreArg16, String abreviaturaArg17, String idArg18, Integer numeroArg19, String nombreArg20, String cuentaClientesDesdeArg21, String cuentaClientesHastaArg22, Integer cantidadCaracteresClientesArg23, Boolean identificacionNumericaClientesArg24, Boolean permiteCambiarClientesArg25, String cuentaProveedoresDesdeArg26, String cuentaProveedoresHastaArg27, Integer cantidadCaracteresProveedoresArg28, Boolean identificacionNumericaProveedoresArg29, Boolean permiteCambiarProveedoresArg30, Integer clientesOcacionalesDesdeArg31, Integer clientesOcacionalesHastaArg32, Integer numeroCobranzaDesdeArg33, Integer numeroCobranzaHastaArg34, String idArg35, Integer numeroArg36, String nombreArg37) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setFecha(fechaArg2);
		this.setDetalle(detalleArg3);
		this.buildEjercicioContable().setId(idArg4);
		this.buildEjercicioContable().setNumero(numeroArg5);
		this.buildEjercicioContable().setApertura(aperturaArg6);
		this.buildEjercicioContable().setCierre(cierreArg7);
		this.buildEjercicioContable().setCerrado(cerradoArg8);
		this.buildEjercicioContable().setCerradoModulos(cerradoModulosArg9);
		this.buildEjercicioContable().setComentario(comentarioArg10);
		this.buildMinutaContable().setId(idArg11);
		this.buildMinutaContable().setNumero(numeroArg12);
		this.buildMinutaContable().setNombre(nombreArg13);
		this.buildSucursal().setId(idArg14);
		this.buildSucursal().setNumero(numeroArg15);
		this.buildSucursal().setNombre(nombreArg16);
		this.buildSucursal().setAbreviatura(abreviaturaArg17);
		this.buildSucursal().buildTipoSucursal().setId(idArg18);
		this.buildSucursal().buildTipoSucursal().setNumero(numeroArg19);
		this.buildSucursal().buildTipoSucursal().setNombre(nombreArg20);
		this.buildSucursal().setCuentaClientesDesde(cuentaClientesDesdeArg21);
		this.buildSucursal().setCuentaClientesHasta(cuentaClientesHastaArg22);
		this.buildSucursal().setCantidadCaracteresClientes(cantidadCaracteresClientesArg23);
		this.buildSucursal().setIdentificacionNumericaClientes(identificacionNumericaClientesArg24);
		this.buildSucursal().setPermiteCambiarClientes(permiteCambiarClientesArg25);
		this.buildSucursal().setCuentaProveedoresDesde(cuentaProveedoresDesdeArg26);
		this.buildSucursal().setCuentaProveedoresHasta(cuentaProveedoresHastaArg27);
		this.buildSucursal().setCantidadCaracteresProveedores(cantidadCaracteresProveedoresArg28);
		this.buildSucursal().setIdentificacionNumericaProveedores(identificacionNumericaProveedoresArg29);
		this.buildSucursal().setPermiteCambiarProveedores(permiteCambiarProveedoresArg30);
		this.buildSucursal().setClientesOcacionalesDesde(clientesOcacionalesDesdeArg31);
		this.buildSucursal().setClientesOcacionalesHasta(clientesOcacionalesHastaArg32);
		this.buildSucursal().setNumeroCobranzaDesde(numeroCobranzaDesdeArg33);
		this.buildSucursal().setNumeroCobranzaHasta(numeroCobranzaHastaArg34);
		this.buildAsientoContableModulo().setId(idArg35);
		this.buildAsientoContableModulo().setNumero(numeroArg36);
		this.buildAsientoContableModulo().setNombre(nombreArg37);

	}

	// ---------------------------------------------------------------------------------------------------------------------------

	public String toString() {
		if(this.getNumero() != null && this.getFecha() != null){
			return this.getNumero() + " - " +  this.getFecha();
		} else if(this.getNumero() != null && this.getFecha() == null){
			return this.getNumero().toString();
		} else if(this.getNumero() == null && this.getFecha() != null){
			return this.getFecha().toString();
		} else {
			return super.toString();
		}
	}

} // END CLASS ----------------------------------------------------------------------------------------------------------