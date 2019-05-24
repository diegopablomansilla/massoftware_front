package com.massoftware.anthill;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class Builder {

	// modificar este metodo
	// modificar en WL
	// agregar el buscar por timestamp y date (no se por que faltan)
	// agregar un tostring por los dos primeros atributos del atts
	// paginado con cursor para abajo, probar y calibrar
	// order by default en clazz

	// limit puede ser int, pero offset tiene que ser bigint
	// addBeansToItemsBIC(boolean removeAllItems) uno solo y abstracto

	public static void main(String[] args) throws IOException, CloneNotSupportedException {

		// System.exit(0);

		List<Clazz> clazzList = new ArrayList<Clazz>();

		///////////////////////////////////////////////////////////////////

		// Clazz banco = buildBanco();
		Clazz usuario = buildUsuario();
		clazzList.add(usuario);

		Clazz pais = buildPais();
		clazzList.add(pais);
		Clazz provincia = buildProvincia(pais);
		clazzList.add(provincia);
		Clazz ciudad = buildCiudad(pais, provincia);
		clazzList.add(ciudad);

		Clazz monedaAFIP = buildMonedaAFIP();
		clazzList.add(monedaAFIP);
		Clazz moneda = buildMoneda(monedaAFIP);
		clazzList.add(moneda);
		// Clazz monedaCotizacion = buildMonedaCotizacion(moneda, usuario);
		// clazzList.add(monedaCotizacion);

		write(clazzList);

	}

	private static void write(List<Clazz> clazzList) throws IOException {

		String massoftware_front = "D:\\dev\\source\\massoftware_front";

		String src_java = massoftware_front + File.separatorChar + "src\\main\\java";

		File folderSQL = new File(massoftware_front + File.separatorChar + "postgresql" + File.separatorChar + "pp");
		folderSQL.mkdirs();

		File folderPopulate = new File(src_java + File.separatorChar + "com\\massoftware\\backend\\populate");
		folderPopulate.mkdirs();

		File folderPOJO = new File(src_java + File.separatorChar + "com\\massoftware\\model");
		folderPOJO.mkdirs();

		File folderDAO = new File(src_java + File.separatorChar + "com\\massoftware\\dao");
		folderDAO.mkdirs();

		File folderWindows = new File(src_java + File.separatorChar + "com\\massoftware\\x");
		folderWindows.mkdirs();

		String sql = "";

		String javaPopulateBody = "";
		String javaPopulateImport = "";
		String javaPopulateInsert = "";

		for (Clazz clazz : clazzList) {

			String sqlItem = clazz.toSQL();

			write(folderSQL.getAbsolutePath() + File.separatorChar + clazz.getName() + ".sql", sqlItem);

			sql += "\n\n";
			sql += sqlItem;

			javaPopulateInsert += "\n\t\ttry {";
			javaPopulateInsert += "\n\t\t\tinsert" + clazz.getName() + "();";
			javaPopulateInsert += "\n\t\t} catch (Exception e) {}";

			javaPopulateBody += "\n\n";
			javaPopulateBody += clazz.toPopulateJava();

			javaPopulateImport += "\n";
			javaPopulateImport += "import com.massoftware.model." + clazz.getNamePackage() + "." + clazz.getName()
					+ ";";
			javaPopulateImport += "\n";
			javaPopulateImport += "import com.massoftware.dao." + clazz.getNamePackage() + "." + clazz.getName()
					+ "Filtro;";
			javaPopulateImport += "\n";
			javaPopulateImport += "import com.massoftware.dao." + clazz.getNamePackage() + "." + clazz.getName()
					+ "DAO;";

			File folderPOJOPackage = new File(
					folderPOJO.getAbsolutePath() + File.separatorChar + clazz.getNamePackage());
			folderPOJOPackage.mkdirs();

			File folderDAOPackage = new File(folderDAO.getAbsolutePath() + File.separatorChar + clazz.getNamePackage());
			folderDAOPackage.mkdirs();

			File folderWindosPackage = new File(
					folderWindows.getAbsolutePath() + File.separatorChar + clazz.getNamePackage());
			folderWindosPackage.mkdirs();

			write(folderPOJOPackage.getAbsolutePath() + File.separatorChar + clazz.getName() + ".java", clazz.toJava());
			write(folderDAOPackage.getAbsolutePath() + File.separatorChar + clazz.getName() + "DAO.java",
					clazz.toJavaDao());
			write(folderDAOPackage.getAbsolutePath() + File.separatorChar + clazz.getName() + "Filtro.java",
					clazz.toJavaFilter());
			write(folderWindosPackage.getAbsolutePath() + File.separatorChar + "WL" + clazz.getName() + ".java",
					clazz.toJavaWL());
			write(folderWindosPackage.getAbsolutePath() + File.separatorChar + "WF" + clazz.getName() + ".java",
					clazz.toJavaWF());

		}

		String javaPopulate = "package com.massoftware.backend.populate;\n";

		javaPopulate += "import java.util.List;\n";
		javaPopulate += "import java.util.Random;\n";
		javaPopulate += javaPopulateImport;
		javaPopulate += "\n\npublic class Populate {";

		javaPopulate += "\n\n\tstatic int maxRows = 1000;";

		javaPopulate += "\n\n\tpublic static void main(String[] args) {";
		javaPopulate += javaPopulateInsert;
		javaPopulate += "\n\t}";

		javaPopulate += javaPopulateBody;

		javaPopulate += "\n\n}";

		write(folderPopulate.getAbsolutePath() + File.separatorChar + "Populate.java", javaPopulate);

		write(folderSQL.getAbsolutePath() + File.separatorChar + "pp.sql", sql);

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

	public static Clazz buildUsuario() throws CloneNotSupportedException {

		Clazz usuario = new Clazz();
		usuario.setNamePackage("seguridad");
		usuario.setSingular("Usuario");
		usuario.setPlural("Usuarios");
		usuario.setSingularPre("el usuario");
		usuario.setPluralPre("los usuarios");

		usuario.setName("Usuario");

		Att numero = new Att("numero", "Nº usuario");
		numero.setDataTypeInteger(1, null);
		((DataTypeInteger) numero.getDataType()).setNextValueProposed(true);
		numero.setRequired(true);
		numero.setUnique(true);
		usuario.addAtt(numero);

		Att nombre = new Att("nombre", "Nombre");
		nombre.setRequired(true);
		nombre.setUnique(true);
		nombre.setLength(null, 50);
		usuario.addAtt(nombre);

		usuario.addArgument(numero, true);
		usuario.getLastArgument().setRequired(false);
		usuario.addArgumentSBX(usuario.getLastArgument());

		usuario.addArgument(nombre);
		usuario.getLastArgument().setRequired(false);
		usuario.addArgumentSBX(usuario.getLastArgument());

		usuario.addOrderAllAtts();

		usuario.getOrderDefault().setDesc(true);

		return usuario;
	}

	public static Clazz buildPais() throws CloneNotSupportedException {

		// SELECT A.PAIS, A.NOMBRE, A.ABREVIATURA FROM Paises A ORDER BY A.NOMBRE,
		// A.PAIS

		Clazz pais = new Clazz();
		pais.setNamePackage("geo");
		pais.setSingular("País");
		pais.setPlural("Países");
		pais.setSingularPre("el país");
		pais.setPluralPre("los países");

		pais.setName("Pais");

		Att numero = new Att("numero", "Nº país");
		numero.setDataTypeInteger(1, null);
		((DataTypeInteger) numero.getDataType()).setNextValueProposed(true);
		numero.setRequired(true);
		numero.setUnique(true);
		pais.addAtt(numero);

		Att nombre = new Att("nombre", "Nombre");
		nombre.setRequired(true);
		nombre.setUnique(true);
		nombre.setLength(null, 50);
		pais.addAtt(nombre);

		Att abreviatura = new Att("abreviatura", "Abreviatura");
		abreviatura.setRequired(true);
		abreviatura.setUnique(true);
		abreviatura.setLength(null, 5);
		abreviatura.setColumns((float) 5);
		pais.addAtt(abreviatura);

		// -------------------------------------------------

		pais.addArgument(numero, true);
		pais.getLastArgument().setRequired(false);
		pais.addArgumentSBX(pais.getLastArgument());

		pais.addArgument(nombre);
		pais.getLastArgument().setRequired(false);
		pais.addArgumentSBX(pais.getLastArgument());

		pais.addArgument(abreviatura);
		pais.getLastArgument().setRequired(false);

		pais.addOrderAllAtts();

		pais.getOrderDefault().setDesc(true);

		return pais;
	}

	public static Clazz buildProvincia(Clazz paisClazz) throws CloneNotSupportedException {

		// SELECT A.PAIS, A.PROVINCIA, A.NOMBRE, A.ABREVIATURA FROM Provincias A WHERE (
		// A.PAIS = 1 AND A.NOMBRE LIKE ''%'' ) ORDER BY A.PAIS, A.NOMBRE, A.PROVINCIA

		Clazz provincia = new Clazz();
		provincia.setNamePackage("geo");
		provincia.setSingular("Provincia");
		provincia.setPlural("Provincias");
		provincia.setSingularPre("la provincia");
		provincia.setPluralPre("las provincias");

		provincia.setName("Provincia");

		Att numero = new Att("numero", "Nº provincia");
		numero.setDataTypeInteger(1, null);
		((DataTypeInteger) numero.getDataType()).setNextValueProposed(true);
		numero.setRequired(true);
		numero.setUnique(true);
		provincia.addAtt(numero);

		Att nombre = new Att("nombre", "Nombre");
		nombre.setRequired(true);
		nombre.setUnique(true);
		nombre.setLength(null, 50);
		provincia.addAtt(nombre);

		Att abreviatura = new Att("abreviatura", "Abreviatura");
		abreviatura.setRequired(true);
		abreviatura.setUnique(true);
		abreviatura.setLength(null, 5);
		abreviatura.setColumns((float) 5);
		provincia.addAtt(abreviatura);

		Att numeroAFIP = new Att("numeroAFIP", "Nº provincia AFIP");
		numeroAFIP.setDataTypeInteger(1, null);
		// ((DataTypeInteger) numero.getDataType()).setNextValueProposed(true);
		// numero.setRequired(true);
		// numero.setUnique(true);
		provincia.addAtt(numeroAFIP);

		Att numeroIngresosBrutos = new Att("numeroIngresosBrutos", "Nº provincia ingresos brutos");
		numeroIngresosBrutos.setDataTypeInteger(1, null);
		// ((DataTypeInteger) numero.getDataType()).setNextValueProposed(true);
		// numero.setRequired(true);
		// numero.setUnique(true);
		provincia.addAtt(numeroIngresosBrutos);

		Att numeroRENATEA = new Att("numeroRENATEA", "Nº provincia RENATEA");
		numeroRENATEA.setDataTypeInteger(1, null);
		// ((DataTypeInteger) numero.getDataType()).setNextValueProposed(true);
		// numero.setRequired(true);
		// numero.setUnique(true);
		provincia.addAtt(numeroRENATEA);

		Att pais = new Att("pais", "País");
		pais.setDataTypeClazz(paisClazz);
		pais.setRequired(true);
		provincia.addAtt(pais);

		// -------------------------------------------------

		provincia.addArgument(numero, true);
		provincia.getLastArgument().setRequired(false);
		provincia.addArgumentSBX(provincia.getLastArgument());

		provincia.addArgument(nombre);
		provincia.getLastArgument().setRequired(false);
		provincia.addArgumentSBX(provincia.getLastArgument());

		provincia.addArgument(abreviatura);
		provincia.getLastArgument().setRequired(false);

		provincia.addArgument(pais);
		// provincia.getLastArgument().setRequired(true);

		provincia.addOrderAllAtts();

		provincia.getOrderDefault().setDesc(true);

		return provincia;
	}

	public static Clazz buildCiudad(Clazz paisClazz, Clazz provinciaClazz) throws CloneNotSupportedException {

		// SELECT A.CIUDAD, A.PAIS, A.PROVINCIA, A.NOMBRE, B.PAIS, B.PROVINCIA,
		// B.NOMBRE, C.PAIS, C.NOMBRE, C.ABREVIATURA FROM {oj Ciudades A LEFT OUTER JOIN
		// Provincias B ON A.PAIS= B.PAIS AND A.PROVINCIA= B.PROVINCIA LEFT OUTER JOIN
		// Paises C ON B.PAIS= C.PAIS } ORDER BY A.NOMBRE, A.CIUDAD

		Clazz ciudad = new Clazz();
		ciudad.setNamePackage("geo");
		ciudad.setSingular("Ciudad");
		ciudad.setPlural("Ciudades");
		ciudad.setSingularPre("la ciudad");
		ciudad.setPluralPre("las ciudades");

		ciudad.setName("Ciudad");

		Att numero = new Att("numero", "Nº ciudad");
		numero.setDataTypeInteger(1, null);
		((DataTypeInteger) numero.getDataType()).setNextValueProposed(true);
		numero.setRequired(true);
		numero.setUnique(true);
		ciudad.addAtt(numero);

		Att nombre = new Att("nombre", "Nombre");
		nombre.setRequired(true);
		nombre.setUnique(true);
		nombre.setLength(null, 50);
		ciudad.addAtt(nombre);

		Att departamento = new Att("departamento", "Departamento");
		departamento.setRequired(false);
		departamento.setUnique(false);
		departamento.setLength(null, 50);
		// departamento.setColumns((float) 5);
		ciudad.addAtt(departamento);

		Att numeroAFIP = new Att("numeroAFIP", "Nº provincia AFIP");
		numeroAFIP.setDataTypeInteger(1, null);
		// ((DataTypeInteger) numero.getDataType()).setNextValueProposed(true);
		// numero.setRequired(true);
		// numero.setUnique(true);
		ciudad.addAtt(numeroAFIP);

		Att provincia = new Att("provincia", "Provincia");
		provincia.setDataTypeClazz(provinciaClazz);
		provincia.setRequired(true);
		ciudad.addAtt(provincia);

		// -------------------------------------------------

		Att pais = new Att("pais", "País");
		pais.setDataTypeClazz(paisClazz);
		pais.setRequired(true);
		// provincia.addAtt(pais);

		// -------------------------------------------------

		ciudad.addArgument(numero, true);
		ciudad.getLastArgument().setRequired(false);
		ciudad.addArgumentSBX(ciudad.getLastArgument());

		ciudad.addArgument(nombre);
		ciudad.getLastArgument().setRequired(false);
		ciudad.addArgumentSBX(ciudad.getLastArgument());

		ciudad.addArgument(pais);
		ciudad.getLastArgument().setRequired(true);
		ciudad.getLastArgument().setOnlyVisual(true);
		
		ciudad.addArgument(provincia);
		ciudad.getLastArgument().setRequired(true);

		ciudad.addOrderAllAtts();

		ciudad.getOrderDefault().setDesc(true);

		return ciudad;
	}

	public static Clazz buildMonedaAFIP() throws CloneNotSupportedException {

		// SELECT A.MONEDAAFIP, A.DESCRIPCION FROM AfipMonedas A ORDER BY A.MONEDAAFIP

		Clazz monedaAFIP = new Clazz();
		monedaAFIP.setNamePackage("monedas");
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
		monedaAFIP.getLastArgument().setRequired(false);
		monedaAFIP.addArgumentSBX(monedaAFIP.getLastArgument());

		monedaAFIP.addArgument(nombre);
		monedaAFIP.getLastArgument().setRequired(false);
		monedaAFIP.addArgumentSBX(monedaAFIP.getLastArgument());

		monedaAFIP.addOrder(codigo);
		monedaAFIP.addOrder(nombre);

		return monedaAFIP;
	}

	public static Clazz buildMoneda(Clazz monedaAFIPClazz) throws CloneNotSupportedException {

		// SELECT A.MONEDA, A.DESCRIPCION, A.ABREVIATURA, A.COTIZACION, A.FECHASQL FROM
		// Monedas A ORDER BY A.MONEDA

		Clazz moneda = new Clazz();
		moneda.setNamePackage("monedas");
		moneda.setSingular("Moneda");
		moneda.setPlural("Monedas");
		moneda.setSingularPre("la moneda");
		moneda.setPluralPre("las monedas");

		moneda.setName("Moneda");

		Att numero = new Att("numero", "Nº moneda");
		numero.setDataTypeInteger(1, null);
		((DataTypeInteger) numero.getDataType()).setNextValueProposed(true);
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
		cotizacion.setDataTypeBigDecimal(new BigDecimal("-9999.9999"), new BigDecimal("99999.9999"), 13, 5);
		((DataTypeBigDecimal) cotizacion.getDataType()).setDefValueInsert(new BigDecimal("1"));
		cotizacion.setRequired(true);
		cotizacion.setReadOnlyGUI(true);
		moneda.addAtt(cotizacion);

		Att cotizacionFecha = new Att("cotizacionFecha", "Fecha cotización");
		cotizacionFecha.setDataTypeTimestamp();
		((DataTypeTimestamp) cotizacionFecha.getDataType()).setDefNowInsert(true);
		cotizacionFecha.setRequired(true);
		cotizacionFecha.setReadOnlyGUI(true);
		moneda.addAtt(cotizacionFecha);

		Att controlActualizacion = new Att("controlActualizacion", "Control de actualizacion");
		controlActualizacion.setDataTypeBoolean();
		moneda.addAtt(controlActualizacion);

		Att monedaAFIP = new Att("monedaAFIP", "Moneda AFIP");
		monedaAFIP.setDataTypeClazz(monedaAFIPClazz);
		monedaAFIP.setRequired(true);
		moneda.addAtt(monedaAFIP);

		moneda.addArgument(numero, true);
		moneda.getLastArgument().setRequired(false);
		moneda.addArgumentSBX(moneda.getLastArgument());

		moneda.addArgument(nombre);
		moneda.getLastArgument().setRequired(false);
		moneda.addArgumentSBX(moneda.getLastArgument());

		moneda.addArgument(abreviatura);
		moneda.getLastArgument().setRequired(false);

		moneda.addOrderAllAtts();

		moneda.getOrderDefault().setDesc(true);

		return moneda;
	}

	public static Clazz buildMonedaCotizacion(Clazz monedaClazz, Clazz usuarioClazz) throws CloneNotSupportedException {

		// SELECT A.MONEDA, A.FECHASQL, A.COMPRA, A.VENTA, A.USUARIO, A.FECHAINGRESOSQL,
		// B.MONEDA, B.DESCRIPCION, C."NO", C.GROUPFLAG, C.LASTNAME, C.FIRSTNAME,
		// C."LEVEL" FROM {oj MonedasCotizaciones A LEFT OUTER JOIN Monedas B ON
		// A.MONEDA= B.MONEDA LEFT OUTER JOIN dbo.SSECUR_User C ON A.USUARIO= C."NO" }
		// WHERE ( A.MONEDA = 6 ) ORDER BY A.MONEDA, A.FECHASQL

		Clazz monedaCotizacion = new Clazz();

		monedaCotizacion.setName("MonedaCotizacion");

		Att fecha = new Att("fecha", "Fecha cotización");
		fecha.setDataTypeTimestamp();
		fecha.setRequired(true);
		// fecha.setUnique(true);
		monedaCotizacion.addAtt(fecha);

		Att moneda = new Att("moneda", "Moneda");
		moneda.setDataTypeClazz(monedaClazz);
		moneda.setRequired(true);
		// moneda.setUnique(true);
		monedaCotizacion.addAtt(moneda);

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
		auditoriaFecha.setReadOnlyGUI(true);
		monedaCotizacion.addAtt(auditoriaFecha);

		Att usuario = new Att("usuario", "Usuario");
		usuario.setDataTypeClazz(usuarioClazz);
		usuario.setRequired(true);
		usuario.setReadOnlyGUI(true);
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
