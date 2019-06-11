package com.massoftware.anthill;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import com.massoftware.anthill.ant.CargaAnt;
import com.massoftware.anthill.ant.CiudadAnt;
import com.massoftware.anthill.ant.ClasificacionClienteAnt;
import com.massoftware.anthill.ant.CodigoPostalAnt;
import com.massoftware.anthill.ant.MonedaAFIPAnt;
import com.massoftware.anthill.ant.MonedaAnt;
import com.massoftware.anthill.ant.MotivoBloqueoClienteAnt;
import com.massoftware.anthill.ant.MotivoComentarioAnt;
import com.massoftware.anthill.ant.NotaCreditoMotivoAnt;
import com.massoftware.anthill.ant.PaisAnt;
import com.massoftware.anthill.ant.ProvinciaAnt;
import com.massoftware.anthill.ant.TipoClienteAnt;
import com.massoftware.anthill.ant.TipoDocumentoAFIPAnt;
import com.massoftware.anthill.ant.TransporteAnt;
import com.massoftware.anthill.ant.TransporteTarifaAnt;
import com.massoftware.anthill.ant.UsuarioAnt;
import com.massoftware.anthill.ant.ZonaAnt;

//https://github.com/javierarce/palabras/blob/master/listado-general.txt
// http://www.listapalabras.com/
// https://www.clarin.com/sociedad/palabras-mas-usadas-espanol-comunes-frecuentes-diccionario-real_academia_espanola_0_ByLqjSFvmg.html
// https://es.wiktionary.org/wiki/Ap%C3%A9ndice:1000_palabras_b%C3%A1sicas_en_espa%C3%B1ol
//

// modificar este metodo
// modificar en WL
// agregar el buscar por timestamp y date (no se por que faltan)
// agregar un tostring por los dos primeros atributos del atts
// paginado con cursor para abajo, probar y calibrar
// order by default en clazz

// limit puede ser int, pero offset tiene que ser bigint
// addBeansToItemsBIC(boolean removeAllItems) uno solo y abstracto

public class Anthill {

	private List<Ant> ants = new ArrayList<Ant>();

	public List<Ant> getAnts() {
		return ants;
	}

	public void setAnts(List<Ant> ants) {
		this.ants = ants;
	}

	public boolean add(Ant e) {
		return ants.add(e);
	}

	public static void main(String[] args) throws Exception {

		Anthill anthill = new Anthill();

		///////////////////////////////////////////////////////////////////

		new UsuarioAnt(anthill);

		// ---------------------------------------------

		new ZonaAnt(anthill);
		PaisAnt pais = new PaisAnt(anthill);
		ProvinciaAnt provincia = new ProvinciaAnt(anthill, pais);
		CiudadAnt ciudad = new CiudadAnt(anthill, pais, provincia);
		CodigoPostalAnt codigoPostal = new CodigoPostalAnt(anthill, pais, provincia, ciudad);

		// ---------------------------------------------

		TransporteAnt transporte = new TransporteAnt(anthill, codigoPostal);
		CargaAnt carga = new CargaAnt(anthill, transporte);
		new TransporteTarifaAnt(anthill, transporte, carga, ciudad);

		// ---------------------------------------------

		new TipoDocumentoAFIPAnt(anthill);
		MonedaAFIPAnt monedaAFIP = new MonedaAFIPAnt(anthill);

		// ---------------------------------------------

		MonedaAnt moneda = new MonedaAnt(anthill, monedaAFIP);

		// ---------------------------------------------

		new NotaCreditoMotivoAnt(anthill);

		// ---------------------------------------------

		new MotivoComentarioAnt(anthill);
		new TipoClienteAnt(anthill);
		ClasificacionClienteAnt clasificacionCliente = new ClasificacionClienteAnt(anthill);
		new MotivoBloqueoClienteAnt(anthill, clasificacionCliente);

		// ---------------------------------------------

		///////////////////////////////////////////////////////////////////

		anthill.build();

	}

	public void build() throws Exception {

		String massoftware_front = "D:\\dev\\source\\massoftware_front";

		String src_java = massoftware_front + File.separatorChar + "src\\main\\java";

		File folderSQL = new File(massoftware_front + File.separatorChar + "postgresql" + File.separatorChar + "pp");
		folderSQL.mkdirs();

		File folderPopulate = new File(src_java + File.separatorChar + "com\\massoftware\\backend\\populate");
		folderPopulate.mkdirs();

		File folderPOJO = new File(src_java + File.separatorChar + "com\\massoftware\\model");
		folderPOJO.mkdirs();

		File folderService = new File(src_java + File.separatorChar + "com\\massoftware\\service");
		folderService.mkdirs();

		File folderWindows = new File(src_java + File.separatorChar + "com\\massoftware\\x");
		folderWindows.mkdirs();

		String sql = "";
		String sqlTable = "";
		String sqlType = "";
		String sqlFind = "";
		String sqlFindNextValue = "";
		String sqlFindExists = "";

		// String sqlView = "";

		// String sqlFindByIdFull = "";
		// String sqlFindByIdView = "";

		String javaPopulateBody = "";
		String javaPopulateImport = "";
		String javaPopulateInsert = "";
		
		List<Clazz> clazzList = new ArrayList<Clazz>();

		for (Ant ant : ants) {

			Clazz clazz = ant.build();
			clazzList.add(clazz);

			System.out.println();
			System.out.println(
					"---------------------------------------------------------------------------------------------------------------------------------------------");
			System.out.println("                       " + clazz.getName());
			System.out.println(
					"---------------------------------------------------------------------------------------------------------------------------------------------");

			String sqlTypeItem = clazz.toSQLType();
			String sqlTableItem = clazz.toSQLTable();
			String sqlFindItem = clazz.toSQLFind();
			String sqlFindNextValueItem = clazz.toSQLFindNextValue();
			String sqlFindExistsItem = clazz.toSQLFindExists();

			String sqlItem = clazz.toSQL();

			///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

			sql += "\n\n";
			sql += sqlItem;

			sqlTable += "\n\n";
			sqlTable += sqlTableItem;

			if (sqlTypeItem != null && sqlTypeItem.trim().length() > 0) {
				sqlType += "\n\n";
				sqlType += sqlTypeItem;
			}

			sqlFind += "\n\n";
			sqlFind += sqlFindItem;

			if (sqlFindNextValueItem != null && sqlFindNextValueItem.trim().length() > 0) {
				sqlFindNextValue += "\n\n";
				sqlFindNextValue += sqlFindNextValueItem;
			}

			if (sqlFindExistsItem != null && sqlFindExistsItem.trim().length() > 0) {
				sqlFindExists += "\n\n";
				sqlFindExists += sqlFindExistsItem;
			}

			///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

			// javaPopulateInsert += "\n\t\ttry {";
			javaPopulateInsert += "\n\t\t\tinsert" + clazz.getName() + "();";
			// javaPopulateInsert += "\n\t\t} catch (Exception e) {}";

			javaPopulateBody += "\n\n";
			javaPopulateBody += clazz.toPopulateJava();

			javaPopulateImport += "\n";
			javaPopulateImport += "import com.massoftware.model." + clazz.getNamePackage() + "." + clazz.getName()
					+ ";";
			javaPopulateImport += "\n";
			javaPopulateImport += "import com.massoftware.service." + clazz.getNamePackage() + "." + clazz.getName()
					+ "Filtro;";
			javaPopulateImport += "\n";
			javaPopulateImport += "import com.massoftware.service." + clazz.getNamePackage() + "." + clazz.getName()
					+ "Service;";

			File folderPOJOPackage = new File(folderPOJO.getAbsolutePath() + File.separatorChar
					+ clazz.getNamePackage().replace(".", File.separatorChar + ""));
			folderPOJOPackage.mkdirs();

			File folderDAOPackage = new File(folderService.getAbsolutePath() + File.separatorChar
					+ clazz.getNamePackage().replace(".", File.separatorChar + ""));
			folderDAOPackage.mkdirs();

			File folderWindosPackage = new File(folderWindows.getAbsolutePath() + File.separatorChar
					+ clazz.getNamePackage().replace(".", File.separatorChar + ""));
			folderWindosPackage.mkdirs();

			writeFile(folderPOJOPackage.getAbsolutePath() + File.separatorChar + clazz.getName() + ".java",
					clazz.toJava());
			writeFile(folderDAOPackage.getAbsolutePath() + File.separatorChar + clazz.getName() + "Service.java",
					clazz.toJavaDao());
			writeFile(folderDAOPackage.getAbsolutePath() + File.separatorChar + clazz.getName() + "Filtro.java",
					clazz.toJavaFilter());
			writeFile(folderWindosPackage.getAbsolutePath() + File.separatorChar + "WL" + clazz.getName() + ".java",
					clazz.toJavaWL());
			writeFile(folderWindosPackage.getAbsolutePath() + File.separatorChar + "WF" + clazz.getName() + ".java",
					clazz.toJavaWF());

		}
		
		
		

		String javaPopulate = "package com.massoftware.backend.populate;\n";

		javaPopulate += "import java.util.List;\n";
		javaPopulate += "import java.util.List;\n";
		javaPopulate += "import java.util.Random;\n";
		javaPopulate += "import com.massoftware.AppCX;\n";				
		javaPopulate += javaPopulateImport;
		javaPopulate += "\n\npublic class Populate {";

		javaPopulate += "\n\n\tstatic int maxRows = 1000;";

		javaPopulate += "\n\n\tpublic static void main(String[] args) throws Exception {";
		javaPopulate += javaPopulateInsert;
		javaPopulate += "\n\t}";

		javaPopulate += javaPopulateBody;

		javaPopulate += "\n\n}";

		System.out.println();
		System.out.println(
				"---------------------------------------------------------------------------------------------------------------------------------------------");
		System.out.println("                        General Files");
		System.out.println(
				"---------------------------------------------------------------------------------------------------------------------------------------------");

		writeFile(folderPopulate.getAbsolutePath() + File.separatorChar + "Populate.java", javaPopulate);
		writeFile(folderService.getAbsolutePath() + File.separatorChar + "AbstractFactoryService.java", UtilJavaFactoryService.toJava(clazzList));
		writeFile(folderWindows.getAbsolutePath() + File.separatorChar + "AbstractFactoryWidget.java", UtilJavaFactoryWidget.toJava(clazzList));

		writeFile(folderSQL.getAbsolutePath() + File.separatorChar + "pp_create_tables.sql", sqlTable);
		writeFile(folderSQL.getAbsolutePath() + File.separatorChar + "pp_create_types.sql", sqlType);
		writeFile(folderSQL.getAbsolutePath() + File.separatorChar + "pp_create_functions_find.sql", sqlFind);
		writeFile(folderSQL.getAbsolutePath() + File.separatorChar + "pp_create_functions_next_value.sql",
				sqlFindNextValue);
		writeFile(folderSQL.getAbsolutePath() + File.separatorChar + "pp_create_functions_exists.sql", sqlFindExists);

	}

	private void writeFile(String fileName, String content) throws IOException {
		File file = new File(fileName);

		// Create the file
		if (file.createNewFile()) {
			System.out.println("File is created: " + file.getAbsolutePath());
		} else {
			System.out.println("File already exists: " + file.getAbsolutePath());
		}

		// Write Content
		FileWriter writer = new FileWriter(file);
		writer.write(content);
		writer.close();
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	private static Clazz buildMonedaCotizacion(Clazz monedaClazz, Clazz usuarioClazz)
			throws CloneNotSupportedException {

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

	private static Clazz buildBanco() {

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
