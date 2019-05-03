package com.massoftware.anthill;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.math.BigDecimal;

public class Builder {

	public static void main(String[] args) throws IOException {

		String sql = "";

//		Clazz banco = buildBanco();
//		Clazz usuario = buildUsuario();
		Clazz monedaAFIP = buildMonedaAFIP();
//		Clazz moneda = buildMoneda(monedaAFIP);
//		Clazz monedaCotizacion = buildMonedaCotizacion(moneda, usuario);

//		sql += usuario.toSQL();
		sql += "\n\n";
		sql += monedaAFIP.toSQL();
		sql += "\n\n";
//		sql += moneda.toSQL();
		sql += "\n\n";
//		sql += monedaCotizacion.toSQL();

		// System.out.println(banco.toSQL());
//		System.out.println(usuario.toSQL());
//		System.out.println(monedaAFIP.toSQL());
//		System.out.println(moneda.toSQL());
//		System.out.println(monedaCotizacion.toSQL());

		// System.out.println(usuario.toJava());
		// System.out.println(banco.toJava());
//		 System.out.println(monedaAFIP.toJava());
		// System.out.println(moneda.toJava());
		// System.out.println(monedaCotizacion.toJava());

		write("D:\\dev\\salidas_pruebas\\sql.sql", sql);
		
//		write("D:\\dev\\salidas_pruebas\\" + usuario.getName() + ".java", usuario.toJava());
		write("D:\\dev\\salidas_pruebas\\" + monedaAFIP.getName() + ".java", monedaAFIP.toJava());
//		write("D:\\dev\\salidas_pruebas\\" + moneda.getName() + ".java", moneda.toJava());
//		write("D:\\dev\\salidas_pruebas\\" + monedaCotizacion.getName() + ".java", monedaCotizacion.toJava());
		
//		write("D:\\dev\\salidas_pruebas\\" + usuario.getName() + "Filtro.java", usuario.toJavaFilter());
		write("D:\\dev\\salidas_pruebas\\" + monedaAFIP.getName() + "Filtro.java", monedaAFIP.toJavaFilter());
//		write("D:\\dev\\salidas_pruebas\\" + moneda.getName() + "Filtro.java", moneda.toJavaFilter());
//		write("D:\\dev\\salidas_pruebas\\" + monedaCotizacion.getName() + "Filtro.java", monedaCotizacion.toJavaFilter());
		
//		write("D:\\dev\\salidas_pruebas\\" + usuario.getName() + "DAO.java", usuario.toJavaDao());
		write("D:\\dev\\salidas_pruebas\\" + monedaAFIP.getName() + "DAO.java", monedaAFIP.toJavaDao());
//		write("D:\\dev\\salidas_pruebas\\" + moneda.getName() + "DAO.java", moneda.toJavaDao());
//		write("D:\\dev\\salidas_pruebas\\" + monedaCotizacion.getName() + "DAO.java", monedaCotizacion.toJavaDao());
		
		write("D:\\dev\\salidas_pruebas\\WL" + monedaAFIP.getName() + ".java", monedaAFIP.toJavaWListado());
		
//		System.out.println(monedaAFIP.toJavaWListado());
		

	}
	
	private static void write(String fileName, String content) throws IOException {
		File file = new File(fileName);

		// Create the file
		if (file.createNewFile()) {
			System.out.println("File is created!");
		} else {
			System.out.println("File already exists.");
		}

		// Write Content
		FileWriter writer = new FileWriter(file);
		writer.write(content);
		writer.close();
	}

	public static Clazz buildUsuario() {

		Clazz usuario = new Clazz();

		usuario.setName("Usuario");

		Att numero = new Att("numero", "Nº usuario");
		numero.setDataTypeInteger(1, null);
		numero.setRequired(true);
		numero.setUnique(true);
		usuario.addAtt(numero);

		Att nombre = new Att("nombre", "Nombre");
		nombre.setRequired(true);
		nombre.setUnique(true);
		nombre.setLength(null, 50);
		usuario.addAtt(nombre);

		usuario.addArgument(numero, true);
		usuario.addArgument(nombre);

		usuario.addOrder(numero);
		usuario.addOrder(nombre);

		return usuario;
	}

	public static Clazz buildMonedaAFIP() {

		Clazz monedaAFIP = new Clazz();
		monedaAFIP.setSingular("Moneda AFIP");
		monedaAFIP.setPlural("Monedas AFIP");
		monedaAFIP.setSingularPre("la moneda AFIP");
		monedaAFIP.setPluralPre("las monedas AFIP");

		monedaAFIP.setName("MonedaAFIP");

		Att codigo = new Att("codigo", "Código");
		codigo.setRequired(true);
		codigo.setUnique(true);
		codigo.setLength(null, 3);
		codigo.setColumns((float) 6);
		monedaAFIP.addAtt(codigo);

		Att nombre = new Att("nombre", "Nombre");
		nombre.setRequired(true);
		nombre.setUnique(true);
		nombre.setLength(null, 50);
		monedaAFIP.addAtt(nombre);

		monedaAFIP.addArgument(codigo, Argument.EQUALS_IGNORE_CASE);
		monedaAFIP.addArgument(nombre);

		monedaAFIP.addOrder(codigo);
		monedaAFIP.addOrder(nombre);

		return monedaAFIP;
	}

	public static Clazz buildMoneda(Clazz monedaAFIPClazz) {

		Clazz moneda = new Clazz();

		moneda.setName("Moneda");

		Att numero = new Att("numero", "Nº moneda");
		numero.setDataTypeInteger(1, null);
		numero.setRequired(true);
		numero.setUnique(true);
		moneda.addAtt(numero);

		Att nombre = new Att("nombre", "Nombre");
		nombre.setRequired(true);
		nombre.setUnique(true);
		nombre.setLength(null, 50);
		moneda.addAtt(nombre);

		Att abreviatura = new Att("abreviatura", "Abreviatura");
		abreviatura.setRequired(true);
		abreviatura.setUnique(true);
		abreviatura.setLength(null, 5);
		abreviatura.setColumns((float) 5);
		moneda.addAtt(abreviatura);

		Att cotizacion = new Att("cotizacion", "Cotización");
		cotizacion.setDataTypeBigDecimal(new BigDecimal("-9999.9999"), new BigDecimal("99999.9999"), 9, 4);
		cotizacion.setRequired(true);
		cotizacion.setReadOnly(true);
		moneda.addAtt(cotizacion);

		Att cotizacionFecha = new Att("cotizacionFecha", "Fecha cotización");
		cotizacionFecha.setDataTypeTimestamp();
		cotizacionFecha.setRequired(true);
		cotizacionFecha.setReadOnly(true);
		moneda.addAtt(cotizacionFecha);

		Att controlActualizacion = new Att("controlActualizacion", "Control de actualizacion");
		controlActualizacion.setDataTypeBoolean();
		moneda.addAtt(controlActualizacion);

		Att monedaAFIP = new Att("monedaAFIP", "Moneda AFIP");
		monedaAFIP.setDataTypeClazz(monedaAFIPClazz);
		monedaAFIP.setRequired(true);
		moneda.addAtt(monedaAFIP);

		moneda.addArgument(numero, true);
		moneda.addArgument(nombre);
		moneda.addArgument(abreviatura);

		moneda.addOrder(numero);
		moneda.addOrder(nombre);
		moneda.addOrder(abreviatura);

		return moneda;
	}

	public static Clazz buildMonedaCotizacion(Clazz monedaClazz, Clazz usuarioClazz) {

		Clazz monedaCotizacion = new Clazz();

		monedaCotizacion.setName("MonedaCotizacion");

		Att moneda = new Att("moneda", "Moneda");
		moneda.setDataTypeClazz(monedaClazz);
		moneda.setRequired(true);
		monedaCotizacion.addAtt(moneda);

		Att fecha = new Att("fecha", "Fecha cotización");
		fecha.setDataTypeTimestamp();
		fecha.setRequired(true);
		monedaCotizacion.addAtt(fecha);

		Att compra = new Att("compra", "Compra");
		compra.setDataTypeBigDecimal(new BigDecimal("-9999.9999"), new BigDecimal("99999.9999"), 9, 4);
		compra.setRequired(true);
		monedaCotizacion.addAtt(compra);

		Att venta = new Att("venta", "Venta");
		venta.setDataTypeBigDecimal(new BigDecimal("-9999.9999"), new BigDecimal("99999.9999"), 9, 4);
		venta.setRequired(true);
		monedaCotizacion.addAtt(venta);

		Att auditoriaFecha = new Att("auditoriaFecha", "Fecha ingreso");
		auditoriaFecha.setDataTypeTimestamp();
		auditoriaFecha.setRequired(true);
		auditoriaFecha.setReadOnly(true);
		monedaCotizacion.addAtt(auditoriaFecha);

		Att usuario = new Att("usuario", "Usuario");
		usuario.setDataTypeClazz(usuarioClazz);
		usuario.setRequired(true);
		usuario.setReadOnly(true);
		monedaCotizacion.addAtt(usuario);

		monedaCotizacion.addArgument(moneda);
		monedaCotizacion.addArgument(fecha, true);		
		
		monedaCotizacion.addOrder(fecha);
		monedaCotizacion.addOrder(monedaClazz.getAtts().get(0));
		monedaCotizacion.addOrder(monedaClazz.getAtts().get(1));

		return monedaCotizacion;
	}

	public static Clazz buildBanco() {

		Clazz banco = new Clazz();

		banco.setName("Banco");

		Att numero = new Att("numero", "Nº banco");
		numero.setDataTypeInteger(1, null);
		numero.setRequired(true);
		numero.setUnique(true);
		banco.addAtt(numero);

		Att nombre = new Att("nombre", "Nombre");
		nombre.setLength(null, 50);
		nombre.setRequired(true);
		nombre.setUnique(true);
		banco.addAtt(nombre);

		Att cuit = new Att("cuit", "CUIT");
		cuit.setDataTypeLong(1L, 99999999999L);
		cuit.setRequired(true);
		cuit.setUnique(true);
		cuit.setColumns((float) 11);
		cuit.setLength(11, 11);
		cuit.setMask("99-99999999-9");
		banco.addAtt(cuit);

		Att bloqueado = new Att("bloqueado", "Obsoleto");
		bloqueado.setDataTypeBoolean();
		banco.addAtt(bloqueado);

		Att hoja = new Att("hoja", "Hoja");
		hoja.setDataTypeInteger(1, 100);
		banco.addAtt(hoja);

		Att primeraFila = new Att("primeraFila", "Primera fila");
		primeraFila.setDataTypeInteger(1, 1000);
		banco.addAtt(primeraFila);

		Att ultimaFila = new Att("ultimaFila", "Última fila");
		ultimaFila.setDataTypeInteger(1, 1000);
		banco.addAtt(ultimaFila);

		Att fecha = new Att("fecha", "Fecha");
		fecha.setColumns((float) 6);
		fecha.setLength(null, 3);
		banco.addAtt(fecha);

		Att descripcion = new Att("descripcion", "Descripción");
		descripcion.setColumns((float) 6);
		descripcion.setLength(null, 3);
		banco.addAtt(descripcion);

		Att referencia1 = new Att("referencia1", "Referencia 1");
		referencia1.setColumns((float) 6);
		referencia1.setLength(null, 3);
		banco.addAtt(referencia1);

		Att importe = new Att("importe", "Importe");
		importe.setColumns((float) 6);
		importe.setLength(null, 3);
		banco.addAtt(importe);

		Att referencia2 = new Att("referencia2", "Referencia 2");
		referencia2.setColumns((float) 6);
		referencia2.setLength(null, 3);
		banco.addAtt(referencia2);

		Att saldo = new Att("saldo", "Saldo");
		saldo.setColumns((float) 6);
		saldo.setLength(null, 3);
		banco.addAtt(saldo);

		return banco;
	}

}
