package com.anthill.ant.fondos;

import java.math.BigDecimal;

import com.anthill.Anthill;
import com.anthill.ant.Ant;
import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeInteger;

public class CuentaFondoAnt extends Ant {

	private Ant cuentaContableAnt;
	private Ant cuentaFondoGrupoAnt;
	private Ant cuentaFondoTipoAnt;
	private Ant monedaAnt;
	private Ant cajaAnt;
	private Ant cuentaFondoTipoBancoAnt;
	private Ant bancoAnt;
//	private Ant cuentaFondoCaucionAnt;
//	private Ant cuentaFondoDiferidosAnt;
	private Ant cuentaFondoBancoCopiaAnt;
	private Ant seguridadPuertaUsoAnt;
	private Ant seguridadPuertaConsultaAnt;
	private Ant seguridadPuertaLimiteAnt;

	public CuentaFondoAnt(Anthill anthill, Ant cuentaContableAnt, Ant cuentaFondoGrupoAnt, Ant cuentaFondoTipoAnt,
			Ant monedaAnt, Ant cajaAnt, Ant cuentaFondoTipoBancoAnt, Ant bancoAnt, /*Ant cuentaFondoCaucionAnt,
			Ant cuentaFondoDiferidosAnt,*/ Ant cuentaFondoBancoCopiaAnt, Ant seguridadPuertaUsoAnt, Ant seguridadPuertaConsultaAnt, Ant seguridadPuertaLimiteAnt) {
		super(anthill);
		this.cuentaContableAnt = cuentaContableAnt;
		this.cuentaFondoGrupoAnt = cuentaFondoGrupoAnt;
		this.cuentaFondoTipoAnt = cuentaFondoTipoAnt;
		this.monedaAnt = monedaAnt;
		this.cajaAnt = cajaAnt;
		this.cuentaFondoTipoBancoAnt = cuentaFondoTipoBancoAnt;
		this.bancoAnt = bancoAnt;
//		this.cuentaFondoCaucionAnt = cuentaFondoCaucionAnt;
//		this.cuentaFondoDiferidosAnt = cuentaFondoDiferidosAnt;
		this.cuentaFondoBancoCopiaAnt = cuentaFondoBancoCopiaAnt;
		this.seguridadPuertaUsoAnt = seguridadPuertaUsoAnt;
		this.seguridadPuertaConsultaAnt = seguridadPuertaConsultaAnt;
		this.seguridadPuertaLimiteAnt = seguridadPuertaLimiteAnt;
	}

	public Clazz build() throws Exception {

		//
		/*
		 * SELECT [RUBRO] ,[GRUPO] ,[CUENTA] ,[NOMBRE] ,[DOORNO] ,[CUENTACONTABLE]
		 * ,[TIPO] ,[CAJA] ,[UNIDADMONETARIA] ,[COTIZACION] ,[TIPOBANCO] ,[BANCO]
		 * ,[CARTERARECHAZADOS] ,[LIMITEDESCUBIERTO] ,[CUENTADIFERIDOS] ,[CUENTACAUCION]
		 * ,[CONCILIACION] ,[CBU] ,[CUENTABANCARIA] ,[DESTINOIMPRESIONTRANSF]
		 * ,[FORMATOTRANSF] ,[COPIASTRANSF] ,[VENTAS] ,[FONDOS] ,[COMPRAS] ,[OBSOLETA]
		 * ,[LIMITEOPERACIONINDIVIDUAL] ,[DOORNOLIMITE] ,[FECHACIERRESQL] ,[SALDOCIERRE]
		 * ,[FECHADEPURACIONSQL] ,[SALDODEPURADO] ,[SALDOCONCILIADO] ,[SALDOACTUAL]
		 * ,[NOMBRECOMPROBANTE] ,[DOORNOCONSULTA] ,[EJERCICIO]
		 * ,[CUENTACONCILIACIONPENDIENTE] ,[CANTIDADCONCILIACIONPENDIENTE]
		 * ,[ARRASTRASALDOSCONCILIACION] ,[NOIMPRIMECAJA] ,[MONEDA] FROM
		 * [dbo].[CuentasDeFondos]
		 */

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("CuentaFondo");
		c.setNamePlural("CuentasFondos");

		c.setNamePackage("fondos");
		c.setSingular("Cuenta fondo");
		c.setPlural("Cuentas fondo");
		c.setSingularPre("la cuenta fondo");
		c.setPluralPre("las cuentas fondo");

		// -------- Atts

		Att numero = new Att("numero", "Nº cuenta");
		numero.setDataTypeInteger(1, null);
		((DataTypeInteger) numero.getDataType()).setNextValueProposed(true);
		numero.setRequired(true);
		numero.setUnique(true);
		c.addAtt(numero);

		Att nombre = new Att("nombre", "Nombre");
		nombre.setRequired(true);
		nombre.setUnique(true);
		nombre.setLength(null, 50);
		c.addAtt(nombre);

		Att cuentaContable = new Att("cuentaContable", "Cuenta contable");
		cuentaContable.setDataTypeClazz(cuentaContableAnt.build());
		cuentaContable.setRequired(true);
		c.addAtt(cuentaContable);

		Att cuentaFondoGrupo = new Att("cuentaFondoGrupo", "Grupo");
		cuentaFondoGrupo.setDataTypeClazz(cuentaFondoGrupoAnt.build());
		cuentaFondoGrupo.setRequired(true);
		c.addAtt(cuentaFondoGrupo);

		Att cuentaFondoTipo = new Att("cuentaFondoTipo", "Tipo");
		cuentaFondoTipo.setDataTypeClazz(cuentaFondoTipoAnt.build());
		cuentaFondoTipo.setRequired(true);
		c.addAtt(cuentaFondoTipo);
		
		Att obsoleto = new Att("obsoleto", "Obsoleto");
		obsoleto.setDataTypeBoolean();
		obsoleto.setRequired(true);		
		c.addAtt(obsoleto);
		
		Att noImprimeCaja = new Att("noImprimeCaja", "No imprime caja");
		noImprimeCaja.setDataTypeBoolean();
		noImprimeCaja.setRequired(true);		
		c.addAtt(noImprimeCaja);
		
		Att ventas = new Att("ventas", "Ventas");
		ventas.setDataTypeBoolean();
		ventas.setRequired(true);		
		c.addAtt(ventas);
		
		Att fondos = new Att("fondos", "Fondos");
		fondos.setDataTypeBoolean();
		fondos.setRequired(true);		
		c.addAtt(fondos);
		
		Att compras = new Att("compras", "Compras");
		compras.setDataTypeBoolean();
		compras.setRequired(true);		
		c.addAtt(compras);

		Att moneda = new Att("moneda", "Moneda");
		moneda.setDataTypeClazz(monedaAnt.build());
		// moneda.setRequired(true);
		c.addAtt(moneda);

		Att caja = new Att("caja", "Caja");
		caja.setDataTypeClazz(cajaAnt.build());
		// caja.setRequired(true);
		c.addAtt(caja);
		
		Att rechazados = new Att("rechazados", "Rechazados");
		rechazados.setDataTypeBoolean();
		rechazados.setRequired(true);		
		c.addAtt(rechazados);
		
		Att conciliacion = new Att("conciliacion", "Conciliación");
		conciliacion.setDataTypeBoolean();
		conciliacion.setRequired(true);		
		c.addAtt(conciliacion);

		Att cuentaFondoTipoBanco = new Att("cuentaFondoTipoBanco", "Tipo de banco");
		cuentaFondoTipoBanco.setDataTypeClazz(cuentaFondoTipoBancoAnt.build());
		// cuentaFondoTipoBanco.setRequired(true);
		c.addAtt(cuentaFondoTipoBanco);

		Att banco = new Att("banco", "banco");
		banco.setDataTypeClazz(bancoAnt.build());
		// banco.setRequired(true);
		c.addAtt(banco);
		
		Att cuentaBancaria = new Att("cuentaBancaria", "Cuenta bancaria");
//		cuentaBancaria.setRequired(true);
//		cuentaBancaria.setUnique(true);
		cuentaBancaria.setLength(null, 22);
		c.addAtt(cuentaBancaria);
		
		Att cbu = new Att("cbu", "CBU");
//		cbu.setRequired(true);
//		cbu.setUnique(true);
		cbu.setLength(null, 22);
		c.addAtt(cbu);
		
		Att limiteDescubierto = new Att("limiteDescubierto", "Límite descubierto");
		limiteDescubierto.setDataTypeBigDecimal(new BigDecimal("-9999.9999"), new BigDecimal("99999.9999"), 13, 5);
		// ((DataTypeBigDecimal) limiteDescubierto.getDataType()).setDefValueInsert(new
		// BigDecimal("1"));
//		limiteDescubierto.setRequired(true);
		c.addAtt(limiteDescubierto);

		Att cuentaFondoCaucion = new Att("cuentaFondoCaucion", "Cuenta fondo caución");
		cuentaFondoCaucion.setLength(null, 50);
//		cuentaFondoCaucion.setDataTypeClazz(cuentaFondoCaucionAnt.build());
		// cuentaFondoCaucion.setRequired(true);
		c.addAtt(cuentaFondoCaucion);

		Att cuentaFondoDiferidos = new Att("cuentaFondoDiferidos", "Cuenta fondo diferidos");
		cuentaFondoDiferidos.setLength(null, 50);
//		cuentaFondoDiferidos.setDataTypeClazz(cuentaFondoDiferidosAnt.build());
		// cuentaFondoCaucion.setRequired(true);
		c.addAtt(cuentaFondoDiferidos);
		
		Att formato = new Att("formato", "Formato");
		formato.setLength(null, 50);
		c.addAtt(formato);

		Att cuentaFondoBancoCopia = new Att("cuentaFondoBancoCopia", "Tipo de copias");
		cuentaFondoBancoCopia.setDataTypeClazz(cuentaFondoBancoCopiaAnt.build());
		// cuentaFondoBancoCopia.setRequired(true);
		c.addAtt(cuentaFondoBancoCopia);
		
		Att limiteOperacionIndividual = new Att("limiteOperacionIndividual", "Límite operación individual");
		limiteOperacionIndividual.setDataTypeBigDecimal(new BigDecimal("-9999.9999"), new BigDecimal("99999.9999"), 13, 5);
		// ((DataTypeBigDecimal) limiteOperacionIndividual.getDataType()).setDefValueInsert(new
		// BigDecimal("1"));
//		limiteOperacionIndividual.setRequired(true);
		c.addAtt(limiteOperacionIndividual);
		
		Att seguridadPuertaUso = new Att("seguridadPuertaUso", "Puerta p/ uso");
		seguridadPuertaUso.setDataTypeClazz(seguridadPuertaUsoAnt.build());
//		seguridadPuertaUso.setRequired(true);
		c.addAtt(seguridadPuertaUso);
		
		Att seguridadPuertaConsulta = new Att("seguridadPuertaConsulta", "Puerta p/ consulta");
		seguridadPuertaConsulta.setDataTypeClazz(seguridadPuertaConsultaAnt.build());
//		seguridadPuertaConsulta.setRequired(true);
		c.addAtt(seguridadPuertaConsulta);
		
		Att seguridadPuertaLimite = new Att("seguridadPuertaLimite", "Puerta p/ superar límite");
		seguridadPuertaLimite.setDataTypeClazz(seguridadPuertaLimiteAnt.build());
//		seguridadPuertaLimite.setRequired(true);
		c.addAtt(seguridadPuertaLimite);

		
		// -------- SBX Args

		c.addArgument(numero, true);
		c.getLastArgument().setRequired(false);
		c.addArgumentSBX(c.getLastArgument());

		c.addArgument(nombre);
		c.getLastArgument().setRequired(false);
		c.addArgumentSBX(c.getLastArgument());

		// -------- Simple Args
		
		c.addArgument(banco);
		c.getLastArgument().setRequired(false);		

		// -------- Order

		c.addOrderAllAtts();

		c.getOrderDefault().setDesc(true);

		// ------------------------------------------------

		return c;

		// ------------------------------------------------
	}

}
