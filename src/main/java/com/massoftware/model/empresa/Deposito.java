package com.massoftware.model.empresa;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.model.EntityId;
import com.massoftware.model.empresa.Sucursal;
import com.massoftware.model.empresa.DepositoModulo;
import com.massoftware.model.seguridad.SeguridadPuerta;
import com.massoftware.model.seguridad.SeguridadPuerta;

@ClassLabelAnont(singular = "Depósito", plural = "Depósitos", singularPre = "el fepósito", pluralPre = "los depósitos")
public class Deposito extends EntityId {

	// ---------------------------------------------------------------------------------------------------------------------------


	@FieldConfAnont(label = "ID")
	private String id;

	// Nº depósito
	@FieldConfAnont(label = "Nº depósito", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numero;

	// Nombre
	@FieldConfAnont(label = "Nombre", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String nombre;

	// Abreviatura
	@FieldConfAnont(label = "Abreviatura", labelError = "", unique = true, readOnly = false, required = true, columns = 5.0f, maxLength = 5, minValue = "", maxValue = "", mask = "")
	private String abreviatura;

	// Sucursal
	@FieldConfAnont(label = "Sucursal", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Sucursal sucursal;

	// Módulo
	@FieldConfAnont(label = "Módulo", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private DepositoModulo depositoModulo;

	// Puerta operativo
	@FieldConfAnont(label = "Puerta operativo", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private SeguridadPuerta puertaOperativo;

	// Puerta consulta
	@FieldConfAnont(label = "Puerta consulta", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private SeguridadPuerta puertaConsulta;

	// ---------------------------------------------------------------------------------------------------------------------------


	public Deposito() throws Exception {
	}

	public Deposito(String idArg0, Integer numeroArg1, String nombreArg2, String abreviaturaArg3, String idSucursalArg4, String idDepositoModuloArg5, String idSeguridadPuertaArg6, String idSeguridadPuertaArg7) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, abreviaturaArg3, idSucursalArg4, idDepositoModuloArg5, idSeguridadPuertaArg6, idSeguridadPuertaArg7);

	}

	public Deposito(String idArg0, Integer numeroArg1, String nombreArg2, String abreviaturaArg3, String idArg4, Integer numeroArg5, String nombreArg6, String abreviaturaArg7, String idTipoSucursalArg8, String cuentaClientesDesdeArg9, String cuentaClientesHastaArg10, Integer cantidadCaracteresClientesArg11, Boolean identificacionNumericaClientesArg12, Boolean permiteCambiarClientesArg13, String cuentaProveedoresDesdeArg14, String cuentaProveedoresHastaArg15, Integer cantidadCaracteresProveedoresArg16, Boolean identificacionNumericaProveedoresArg17, Boolean permiteCambiarProveedoresArg18, Integer clientesOcacionalesDesdeArg19, Integer clientesOcacionalesHastaArg20, Integer numeroCobranzaDesdeArg21, Integer numeroCobranzaHastaArg22, String idArg23, Integer numeroArg24, String nombreArg25, String idArg26, Integer numeroArg27, String nombreArg28, String equateArg29, String idSeguridadModuloArg30, String idArg31, Integer numeroArg32, String nombreArg33, String equateArg34, String idSeguridadModuloArg35) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, abreviaturaArg3, idArg4, numeroArg5, nombreArg6, abreviaturaArg7, idTipoSucursalArg8, cuentaClientesDesdeArg9, cuentaClientesHastaArg10, cantidadCaracteresClientesArg11, identificacionNumericaClientesArg12, permiteCambiarClientesArg13, cuentaProveedoresDesdeArg14, cuentaProveedoresHastaArg15, cantidadCaracteresProveedoresArg16, identificacionNumericaProveedoresArg17, permiteCambiarProveedoresArg18, clientesOcacionalesDesdeArg19, clientesOcacionalesHastaArg20, numeroCobranzaDesdeArg21, numeroCobranzaHastaArg22, idArg23, numeroArg24, nombreArg25, idArg26, numeroArg27, nombreArg28, equateArg29, idSeguridadModuloArg30, idArg31, numeroArg32, nombreArg33, equateArg34, idSeguridadModuloArg35);

	}

	public Deposito(String idArg0, Integer numeroArg1, String nombreArg2, String abreviaturaArg3, String idArg4, Integer numeroArg5, String nombreArg6, String abreviaturaArg7, String idArg8, Integer numeroArg9, String nombreArg10, String cuentaClientesDesdeArg11, String cuentaClientesHastaArg12, Integer cantidadCaracteresClientesArg13, Boolean identificacionNumericaClientesArg14, Boolean permiteCambiarClientesArg15, String cuentaProveedoresDesdeArg16, String cuentaProveedoresHastaArg17, Integer cantidadCaracteresProveedoresArg18, Boolean identificacionNumericaProveedoresArg19, Boolean permiteCambiarProveedoresArg20, Integer clientesOcacionalesDesdeArg21, Integer clientesOcacionalesHastaArg22, Integer numeroCobranzaDesdeArg23, Integer numeroCobranzaHastaArg24, String idArg25, Integer numeroArg26, String nombreArg27, String idArg28, Integer numeroArg29, String nombreArg30, String equateArg31, String idArg32, Integer numeroArg33, String nombreArg34, String idArg35, Integer numeroArg36, String nombreArg37, String equateArg38, String idArg39, Integer numeroArg40, String nombreArg41) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, abreviaturaArg3, idArg4, numeroArg5, nombreArg6, abreviaturaArg7, idArg8, numeroArg9, nombreArg10, cuentaClientesDesdeArg11, cuentaClientesHastaArg12, cantidadCaracteresClientesArg13, identificacionNumericaClientesArg14, permiteCambiarClientesArg15, cuentaProveedoresDesdeArg16, cuentaProveedoresHastaArg17, cantidadCaracteresProveedoresArg18, identificacionNumericaProveedoresArg19, permiteCambiarProveedoresArg20, clientesOcacionalesDesdeArg21, clientesOcacionalesHastaArg22, numeroCobranzaDesdeArg23, numeroCobranzaHastaArg24, idArg25, numeroArg26, nombreArg27, idArg28, numeroArg29, nombreArg30, equateArg31, idArg32, numeroArg33, nombreArg34, idArg35, numeroArg36, nombreArg37, equateArg38, idArg39, numeroArg40, nombreArg41);

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

	// GET Nº depósito
	public Integer getNumero() {
		return this.numero;
	}

	// SET Nº depósito
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

	// GET Abreviatura
	public String getAbreviatura() {
		return this.abreviatura;
	}

	// SET Abreviatura
	public void setAbreviatura(String abreviatura ){
		abreviatura = (abreviatura != null) ? abreviatura.trim() : null;
		this.abreviatura = (abreviatura != null && abreviatura.length() == 0) ? null : abreviatura;
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
	public DepositoModulo buildDepositoModulo() throws Exception {
		this.depositoModulo = (this.depositoModulo == null) ? new DepositoModulo() : this.depositoModulo;
		return this.depositoModulo;
	}

	// GET Módulo
	public DepositoModulo getDepositoModulo() {
		this.depositoModulo = (this.depositoModulo != null && this.depositoModulo.getId() == null) ? null : this.depositoModulo ;
		return this.depositoModulo;
	}

	// SET Módulo
	public void setDepositoModulo(DepositoModulo depositoModulo ){
		this.depositoModulo = depositoModulo;
	}

	// BUILD IF NULL AND GET Puerta operativo
	public SeguridadPuerta buildPuertaOperativo() throws Exception {
		this.puertaOperativo = (this.puertaOperativo == null) ? new SeguridadPuerta() : this.puertaOperativo;
		return this.puertaOperativo;
	}

	// GET Puerta operativo
	public SeguridadPuerta getPuertaOperativo() {
		this.puertaOperativo = (this.puertaOperativo != null && this.puertaOperativo.getId() == null) ? null : this.puertaOperativo ;
		return this.puertaOperativo;
	}

	// SET Puerta operativo
	public void setPuertaOperativo(SeguridadPuerta puertaOperativo ){
		this.puertaOperativo = puertaOperativo;
	}

	// BUILD IF NULL AND GET Puerta consulta
	public SeguridadPuerta buildPuertaConsulta() throws Exception {
		this.puertaConsulta = (this.puertaConsulta == null) ? new SeguridadPuerta() : this.puertaConsulta;
		return this.puertaConsulta;
	}

	// GET Puerta consulta
	public SeguridadPuerta getPuertaConsulta() {
		this.puertaConsulta = (this.puertaConsulta != null && this.puertaConsulta.getId() == null) ? null : this.puertaConsulta ;
		return this.puertaConsulta;
	}

	// SET Puerta consulta
	public void setPuertaConsulta(SeguridadPuerta puertaConsulta ){
		this.puertaConsulta = puertaConsulta;
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String abreviaturaArg3, String idSucursalArg4, String idDepositoModuloArg5, String idSeguridadPuertaArg6, String idSeguridadPuertaArg7) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.setAbreviatura(abreviaturaArg3);
		this.buildSucursal().setId(idSucursalArg4);
		this.buildDepositoModulo().setId(idDepositoModuloArg5);
		this.buildPuertaOperativo().setId(idSeguridadPuertaArg6);
		this.buildPuertaConsulta().setId(idSeguridadPuertaArg7);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String abreviaturaArg3, String idArg4, Integer numeroArg5, String nombreArg6, String abreviaturaArg7, String idTipoSucursalArg8, String cuentaClientesDesdeArg9, String cuentaClientesHastaArg10, Integer cantidadCaracteresClientesArg11, Boolean identificacionNumericaClientesArg12, Boolean permiteCambiarClientesArg13, String cuentaProveedoresDesdeArg14, String cuentaProveedoresHastaArg15, Integer cantidadCaracteresProveedoresArg16, Boolean identificacionNumericaProveedoresArg17, Boolean permiteCambiarProveedoresArg18, Integer clientesOcacionalesDesdeArg19, Integer clientesOcacionalesHastaArg20, Integer numeroCobranzaDesdeArg21, Integer numeroCobranzaHastaArg22, String idArg23, Integer numeroArg24, String nombreArg25, String idArg26, Integer numeroArg27, String nombreArg28, String equateArg29, String idSeguridadModuloArg30, String idArg31, Integer numeroArg32, String nombreArg33, String equateArg34, String idSeguridadModuloArg35) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.setAbreviatura(abreviaturaArg3);
		this.buildSucursal().setId(idArg4);
		this.buildSucursal().setNumero(numeroArg5);
		this.buildSucursal().setNombre(nombreArg6);
		this.buildSucursal().setAbreviatura(abreviaturaArg7);
		this.buildSucursal().buildTipoSucursal().setId(idTipoSucursalArg8);
		this.buildSucursal().setCuentaClientesDesde(cuentaClientesDesdeArg9);
		this.buildSucursal().setCuentaClientesHasta(cuentaClientesHastaArg10);
		this.buildSucursal().setCantidadCaracteresClientes(cantidadCaracteresClientesArg11);
		this.buildSucursal().setIdentificacionNumericaClientes(identificacionNumericaClientesArg12);
		this.buildSucursal().setPermiteCambiarClientes(permiteCambiarClientesArg13);
		this.buildSucursal().setCuentaProveedoresDesde(cuentaProveedoresDesdeArg14);
		this.buildSucursal().setCuentaProveedoresHasta(cuentaProveedoresHastaArg15);
		this.buildSucursal().setCantidadCaracteresProveedores(cantidadCaracteresProveedoresArg16);
		this.buildSucursal().setIdentificacionNumericaProveedores(identificacionNumericaProveedoresArg17);
		this.buildSucursal().setPermiteCambiarProveedores(permiteCambiarProveedoresArg18);
		this.buildSucursal().setClientesOcacionalesDesde(clientesOcacionalesDesdeArg19);
		this.buildSucursal().setClientesOcacionalesHasta(clientesOcacionalesHastaArg20);
		this.buildSucursal().setNumeroCobranzaDesde(numeroCobranzaDesdeArg21);
		this.buildSucursal().setNumeroCobranzaHasta(numeroCobranzaHastaArg22);
		this.buildDepositoModulo().setId(idArg23);
		this.buildDepositoModulo().setNumero(numeroArg24);
		this.buildDepositoModulo().setNombre(nombreArg25);
		this.buildPuertaOperativo().setId(idArg26);
		this.buildPuertaOperativo().setNumero(numeroArg27);
		this.buildPuertaOperativo().setNombre(nombreArg28);
		this.buildPuertaOperativo().setEquate(equateArg29);
		this.buildPuertaOperativo().buildSeguridadModulo().setId(idSeguridadModuloArg30);
		this.buildPuertaConsulta().setId(idArg31);
		this.buildPuertaConsulta().setNumero(numeroArg32);
		this.buildPuertaConsulta().setNombre(nombreArg33);
		this.buildPuertaConsulta().setEquate(equateArg34);
		this.buildPuertaConsulta().buildSeguridadModulo().setId(idSeguridadModuloArg35);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String abreviaturaArg3, String idArg4, Integer numeroArg5, String nombreArg6, String abreviaturaArg7, String idArg8, Integer numeroArg9, String nombreArg10, String cuentaClientesDesdeArg11, String cuentaClientesHastaArg12, Integer cantidadCaracteresClientesArg13, Boolean identificacionNumericaClientesArg14, Boolean permiteCambiarClientesArg15, String cuentaProveedoresDesdeArg16, String cuentaProveedoresHastaArg17, Integer cantidadCaracteresProveedoresArg18, Boolean identificacionNumericaProveedoresArg19, Boolean permiteCambiarProveedoresArg20, Integer clientesOcacionalesDesdeArg21, Integer clientesOcacionalesHastaArg22, Integer numeroCobranzaDesdeArg23, Integer numeroCobranzaHastaArg24, String idArg25, Integer numeroArg26, String nombreArg27, String idArg28, Integer numeroArg29, String nombreArg30, String equateArg31, String idArg32, Integer numeroArg33, String nombreArg34, String idArg35, Integer numeroArg36, String nombreArg37, String equateArg38, String idArg39, Integer numeroArg40, String nombreArg41) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.setAbreviatura(abreviaturaArg3);
		this.buildSucursal().setId(idArg4);
		this.buildSucursal().setNumero(numeroArg5);
		this.buildSucursal().setNombre(nombreArg6);
		this.buildSucursal().setAbreviatura(abreviaturaArg7);
		this.buildSucursal().buildTipoSucursal().setId(idArg8);
		this.buildSucursal().buildTipoSucursal().setNumero(numeroArg9);
		this.buildSucursal().buildTipoSucursal().setNombre(nombreArg10);
		this.buildSucursal().setCuentaClientesDesde(cuentaClientesDesdeArg11);
		this.buildSucursal().setCuentaClientesHasta(cuentaClientesHastaArg12);
		this.buildSucursal().setCantidadCaracteresClientes(cantidadCaracteresClientesArg13);
		this.buildSucursal().setIdentificacionNumericaClientes(identificacionNumericaClientesArg14);
		this.buildSucursal().setPermiteCambiarClientes(permiteCambiarClientesArg15);
		this.buildSucursal().setCuentaProveedoresDesde(cuentaProveedoresDesdeArg16);
		this.buildSucursal().setCuentaProveedoresHasta(cuentaProveedoresHastaArg17);
		this.buildSucursal().setCantidadCaracteresProveedores(cantidadCaracteresProveedoresArg18);
		this.buildSucursal().setIdentificacionNumericaProveedores(identificacionNumericaProveedoresArg19);
		this.buildSucursal().setPermiteCambiarProveedores(permiteCambiarProveedoresArg20);
		this.buildSucursal().setClientesOcacionalesDesde(clientesOcacionalesDesdeArg21);
		this.buildSucursal().setClientesOcacionalesHasta(clientesOcacionalesHastaArg22);
		this.buildSucursal().setNumeroCobranzaDesde(numeroCobranzaDesdeArg23);
		this.buildSucursal().setNumeroCobranzaHasta(numeroCobranzaHastaArg24);
		this.buildDepositoModulo().setId(idArg25);
		this.buildDepositoModulo().setNumero(numeroArg26);
		this.buildDepositoModulo().setNombre(nombreArg27);
		this.buildPuertaOperativo().setId(idArg28);
		this.buildPuertaOperativo().setNumero(numeroArg29);
		this.buildPuertaOperativo().setNombre(nombreArg30);
		this.buildPuertaOperativo().setEquate(equateArg31);
		this.buildPuertaOperativo().buildSeguridadModulo().setId(idArg32);
		this.buildPuertaOperativo().buildSeguridadModulo().setNumero(numeroArg33);
		this.buildPuertaOperativo().buildSeguridadModulo().setNombre(nombreArg34);
		this.buildPuertaConsulta().setId(idArg35);
		this.buildPuertaConsulta().setNumero(numeroArg36);
		this.buildPuertaConsulta().setNombre(nombreArg37);
		this.buildPuertaConsulta().setEquate(equateArg38);
		this.buildPuertaConsulta().buildSeguridadModulo().setId(idArg39);
		this.buildPuertaConsulta().buildSeguridadModulo().setNumero(numeroArg40);
		this.buildPuertaConsulta().buildSeguridadModulo().setNombre(nombreArg41);

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