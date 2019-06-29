package com.anthill;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import com.anthill.ant.Ant;
import com.anthill.ant.afip.MonedaAFIPAnt;
import com.anthill.ant.afip.TipoDocumentoAFIPAnt;
import com.anthill.ant.clientes.ClasificacionClienteAnt;
import com.anthill.ant.clientes.MotivoBloqueoClienteAnt;
import com.anthill.ant.clientes.MotivoComentarioAnt;
import com.anthill.ant.clientes.TipoClienteAnt;
import com.anthill.ant.contabilidad.AsientoContableAnt;
import com.anthill.ant.contabilidad.AsientoContableItemAnt;
import com.anthill.ant.contabilidad.AsientoContableModuloAnt;
import com.anthill.ant.contabilidad.AsientoModeloAnt;
import com.anthill.ant.contabilidad.AsientoModeloItemAnt;
import com.anthill.ant.contabilidad.CentroCostoContableAnt;
import com.anthill.ant.contabilidad.CostoVentaAnt;
import com.anthill.ant.contabilidad.CuentaContableAnt;
import com.anthill.ant.contabilidad.CuentaContableEstadoAnt;
import com.anthill.ant.contabilidad.EjercicioContableAnt;
import com.anthill.ant.contabilidad.MinutaContableAnt;
import com.anthill.ant.contabilidad.PuntoEquilibrioAnt;
import com.anthill.ant.contabilidad.TipoPuntoEquilibrioAnt;
import com.anthill.ant.contabilidad.ventas.NotaCreditoMotivoAnt;
import com.anthill.ant.empresa.DepositoAnt;
import com.anthill.ant.empresa.DepositoModuloAnt;
import com.anthill.ant.empresa.EmpresaAnt;
import com.anthill.ant.empresa.SucursalAnt;
import com.anthill.ant.empresa.TipoSucursalAnt;
import com.anthill.ant.fondos.CajaAnt;
import com.anthill.ant.fondos.ChequeraAnt;
import com.anthill.ant.fondos.ClaseComprobanteAnt;
import com.anthill.ant.fondos.ComportamientoComprobanteAnt;
import com.anthill.ant.fondos.ComprobanteFondoModeloAnt;
import com.anthill.ant.fondos.ComprobanteFondoModeloItemAnt;
import com.anthill.ant.fondos.CuentaFondoAnt;
import com.anthill.ant.fondos.CuentaFondoBancoCopiaAnt;
import com.anthill.ant.fondos.CuentaFondoGrupoAnt;
import com.anthill.ant.fondos.CuentaFondoRubroAnt;
import com.anthill.ant.fondos.CuentaFondoTipoAnt;
import com.anthill.ant.fondos.CuentaFondoTipoBancoAnt;
import com.anthill.ant.fondos.JuridiccionConvnioMultilateralAnt;
import com.anthill.ant.fondos.TalonarioAnt;
import com.anthill.ant.fondos.TalonarioControladorFizcalAnt;
import com.anthill.ant.fondos.TalonarioLetraAnt;
import com.anthill.ant.fondos.TicketAnt;
import com.anthill.ant.fondos.TicketControlDenunciadosAnt;
import com.anthill.ant.fondos.TicketModeloAnt;
import com.anthill.ant.fondos.TipoComprobanteConceptoAnt;
import com.anthill.ant.fondos.TipoComprobanteCopiaAlternativoAnt;
import com.anthill.ant.fondos.TipoComprobanteCopiaAnt;
import com.anthill.ant.fondos.banco.BancoAnt;
import com.anthill.ant.fondos.banco.BancoFirmanteAnt;
import com.anthill.ant.geo.CiudadAnt;
import com.anthill.ant.geo.CodigoPostalAnt;
import com.anthill.ant.geo.PaisAnt;
import com.anthill.ant.geo.ProvinciaAnt;
import com.anthill.ant.geo.ZonaAnt;
import com.anthill.ant.logistica.CargaAnt;
import com.anthill.ant.logistica.TransporteAnt;
import com.anthill.ant.logistica.TransporteTarifaAnt;
import com.anthill.ant.monedas.MonedaAnt;
import com.anthill.ant.monedas.MonedaCotizacionAnt;
import com.anthill.ant.seguridad.SeguridadModuloAnt;
import com.anthill.ant.seguridad.SeguridadPuertaAnt;
import com.anthill.ant.seguridad.UsuarioAnt;
import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.to_java.UtilJavaFactoryService;
import com.anthill.model.to_java.UtilJavaFactoryWidget;

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

	@SuppressWarnings("unused")
	public static void main(String[] args) throws Exception {

		Anthill anthill = new Anthill();

		///////////////////////////////////////////////////////////////////

		UsuarioAnt usuarioAnt = new UsuarioAnt(anthill);

		SeguridadModuloAnt seguridadModuloAnt = new SeguridadModuloAnt(anthill);

		SeguridadPuertaAnt seguridadPuertaAnt = new SeguridadPuertaAnt(anthill, seguridadModuloAnt);

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

		// ---------------------------------------------

		new NotaCreditoMotivoAnt(anthill);

		// ---------------------------------------------

		new MotivoComentarioAnt(anthill);
		new TipoClienteAnt(anthill);
		ClasificacionClienteAnt clasificacionCliente = new ClasificacionClienteAnt(anthill);
		new MotivoBloqueoClienteAnt(anthill, clasificacionCliente);

		// ---------------------------------------------

		TipoSucursalAnt tipoSucursalAnt = new TipoSucursalAnt(anthill);
		SucursalAnt sucursalAnt = new SucursalAnt(anthill, tipoSucursalAnt);

		DepositoModuloAnt depositoModuloAnt = new DepositoModuloAnt(anthill);
		new DepositoAnt(anthill, sucursalAnt, depositoModuloAnt, seguridadPuertaAnt);

		// ---------------------------------------------

		EjercicioContableAnt ejercicioContableAnt = new EjercicioContableAnt(anthill);
		CentroCostoContableAnt centroCostoContableAnt = new CentroCostoContableAnt(anthill, ejercicioContableAnt);
		TipoPuntoEquilibrioAnt tipoPuntoEquilibrioAnt = new TipoPuntoEquilibrioAnt(anthill);
		PuntoEquilibrioAnt puntoEquilibrioAnt = new PuntoEquilibrioAnt(anthill, ejercicioContableAnt,
				tipoPuntoEquilibrioAnt);
		CostoVentaAnt costoVentaAnt = new CostoVentaAnt(anthill);
		CuentaContableEstadoAnt cuentaContableEstadoAnt = new CuentaContableEstadoAnt(anthill);

		CuentaContableAnt cuentaContableAnt = new CuentaContableAnt(anthill, ejercicioContableAnt,
				cuentaContableEstadoAnt, centroCostoContableAnt, puntoEquilibrioAnt, costoVentaAnt, seguridadPuertaAnt);

		AsientoModeloAnt asientoModeloAnt = new AsientoModeloAnt(anthill, ejercicioContableAnt);
		AsientoModeloItemAnt asientoModeloItemAnt = new AsientoModeloItemAnt(anthill, asientoModeloAnt,
				cuentaContableAnt);

		MinutaContableAnt minutaContableAnt = new MinutaContableAnt(anthill);
		AsientoContableModuloAnt asientoContableModuloAnt = new AsientoContableModuloAnt(anthill);

		AsientoContableAnt asientoContableAnt = new AsientoContableAnt(anthill, ejercicioContableAnt, minutaContableAnt,
				sucursalAnt, asientoContableModuloAnt);

		AsientoContableItemAnt asientoContableItemAnt = new AsientoContableItemAnt(anthill, asientoContableAnt,
				cuentaContableAnt);

		// ---------------------------------------------

		EmpresaAnt empresaAnt = new EmpresaAnt(anthill, ejercicioContableAnt);

		// ---------------------------------------------

		MonedaAnt monedaAnt = new MonedaAnt(anthill, monedaAFIP);

		MonedaCotizacionAnt monedaCotizacionAnt = new MonedaCotizacionAnt(anthill, monedaAnt, usuarioAnt);

		// ---------------------------------------------

		BancoAnt bancoAnt = new BancoAnt(anthill);

		BancoFirmanteAnt bancoFirmanteAnt = new BancoFirmanteAnt(anthill);

		CajaAnt cajaAnt = new CajaAnt(anthill, seguridadPuertaAnt);

		CuentaFondoTipoAnt cuentaFondoTipoAnt = new CuentaFondoTipoAnt(anthill);

		CuentaFondoRubroAnt cuentaFondoRubroAnt = new CuentaFondoRubroAnt(anthill);

		CuentaFondoGrupoAnt cuentaFondoGrupoAnt = new CuentaFondoGrupoAnt(anthill, cuentaFondoRubroAnt);

		CuentaFondoTipoBancoAnt cuentaFondoTipoBancoAnt = new CuentaFondoTipoBancoAnt(anthill);

		CuentaFondoBancoCopiaAnt cuentaFondoBancoCopiaAnt = new CuentaFondoBancoCopiaAnt(anthill);

		CuentaFondoAnt cuentaFondoAnt = new CuentaFondoAnt(anthill, cuentaContableAnt, cuentaFondoGrupoAnt,
				cuentaFondoTipoAnt, monedaAnt, cajaAnt, cuentaFondoTipoBancoAnt, bancoAnt,
				/*
				 * cuentaFondoAnt, cuentaFondoAnt,
				 */ cuentaFondoBancoCopiaAnt, seguridadPuertaAnt, seguridadPuertaAnt, seguridadPuertaAnt);

		ComprobanteFondoModeloAnt comprobanteFondoModeloAnt = new ComprobanteFondoModeloAnt(anthill);

		ComprobanteFondoModeloItemAnt comprobanteFondoModeloItemAnt = new ComprobanteFondoModeloItemAnt(anthill,
				comprobanteFondoModeloAnt, cuentaFondoAnt);

		TalonarioLetraAnt talonarioLetraAnt = new TalonarioLetraAnt(anthill);
		TalonarioControladorFizcalAnt talonarioControladorFizcalAnt = new TalonarioControladorFizcalAnt(anthill);
		TalonarioAnt talonarioAnt = new TalonarioAnt(anthill, talonarioLetraAnt, talonarioControladorFizcalAnt);

		TicketControlDenunciadosAnt ticketControlDenunciadosAnt = new TicketControlDenunciadosAnt(anthill);
		TicketAnt ticketAnt = new TicketAnt(anthill, ticketControlDenunciadosAnt);
		TicketModeloAnt ticketModeloAnt = new TicketModeloAnt(anthill, ticketAnt);

		JuridiccionConvnioMultilateralAnt juridiccionConvnioMultilateralAnt = new JuridiccionConvnioMultilateralAnt(
				anthill, cuentaFondoAnt);

		ChequeraAnt chequeraAnt = new ChequeraAnt(anthill, cuentaFondoAnt);

		TipoComprobanteConceptoAnt tipoComprobanteConceptoAnt = new TipoComprobanteConceptoAnt(anthill);
		ClaseComprobanteAnt claseComprobanteAnt = new ClaseComprobanteAnt(anthill);
		ComportamientoComprobanteAnt comportamientoComprobanteAnt = new ComportamientoComprobanteAnt(anthill);
		TipoComprobanteCopiaAnt tipoComprobanteCopiaAnt = new TipoComprobanteCopiaAnt(anthill);
		TipoComprobanteCopiaAlternativoAnt tipoComprobanteCopiaAlternativoAnt = new TipoComprobanteCopiaAlternativoAnt(anthill);

		///////////////////////////////////////////////////////////////////

		anthill.build();

	}

	public void build() throws Exception {

		String massoftware_front = "D:\\dev\\source\\massoftware_front";

		String src_java = massoftware_front + File.separatorChar + "src\\main\\java";

		File folderSQL = new File(massoftware_front + File.separatorChar + "postgresql" + File.separatorChar + "pp");
		folderSQL.mkdirs();

		File folderPopulate = new File(src_java + File.separatorChar + "com\\massoftware");
		folderPopulate.mkdirs();

		File folderPOJO = new File(src_java + File.separatorChar + "com\\massoftware\\model");
		folderPOJO.mkdirs();

		File folderService = new File(src_java + File.separatorChar + "com\\massoftware\\service");
		folderService.mkdirs();

		File folderWindows = new File(src_java + File.separatorChar + "com\\massoftware\\x");
		folderWindows.mkdirs();

		// String sql = "";
		String sqlTable = "";
		String sqlType = "";
		String sqlFind = "";
		String sqlFindNextValue = "";
		String sqlFindExists = "";
		String sqlFindInsert = "";
		String sqlFindUpdate = "";
		String sqlFindDelete = "";

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
			String sqlFindInsertItem = clazz.toSQLInsert();
			String sqlFindUpdateItem = clazz.toSQLUpdate();
			String sqlFindDeleteItem = clazz.toSQLDeleteById();

			String sqlItem = clazz.toSQL();

			///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

			// sql += "\n\n";
			// sql += sqlItem;

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

			sqlFindInsert += "\n\n";
			sqlFindInsert += sqlFindInsertItem;

			sqlFindDelete += "\n\n";
			sqlFindDelete += sqlFindDeleteItem;

			sqlFindUpdate += "\n\n";
			sqlFindUpdate += sqlFindUpdateItem;

			File folderSQLItem = new File(folderSQL.getAbsolutePath() + File.separatorChar
					+ clazz.getNamePackage().replace(".", File.separatorChar + ""));
			folderSQLItem.mkdirs();

			writeFile(folderSQLItem.getAbsolutePath() + File.separatorChar + clazz.getName() + ".sql", sqlItem);

			///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

			// javaPopulateInsert += "\n\t\ttry {";
			javaPopulateInsert += "\n\t\t\t//insert" + clazz.getName() + "();";
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

		String javaPopulate = "package com.massoftware;\n";

		javaPopulate += "import java.util.List;\n";
		javaPopulate += "import java.util.List;\n";
		javaPopulate += "import java.util.Random;\n";
		javaPopulate += "import com.massoftware.AppCX;\n";
		javaPopulate += javaPopulateImport;
		javaPopulate += "\n\npublic class Populate {";

		javaPopulate += "\n\n\tstatic int maxRows = 300;";

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
		writeFile(folderService.getAbsolutePath() + File.separatorChar + "AbstractFactoryService.java",
				UtilJavaFactoryService.toJava(clazzList));
		writeFile(folderWindows.getAbsolutePath() + File.separatorChar + "AbstractFactoryWidget.java",
				UtilJavaFactoryWidget.toJava(clazzList));

		writeFile(folderSQL.getAbsolutePath() + File.separatorChar + "pp_create_tables.sql", sqlTable);
		writeFile(folderSQL.getAbsolutePath() + File.separatorChar + "pp_create_types.sql", sqlType);
		writeFile(folderSQL.getAbsolutePath() + File.separatorChar + "pp_create_functions_find.sql", sqlFind);
		writeFile(folderSQL.getAbsolutePath() + File.separatorChar + "pp_create_functions_next_value.sql",
				sqlFindNextValue);
		writeFile(folderSQL.getAbsolutePath() + File.separatorChar + "pp_create_functions_exists.sql", sqlFindExists);

		writeFile(folderSQL.getAbsolutePath() + File.separatorChar + "pp_create_functions_insert.sql", sqlFindInsert);
		writeFile(folderSQL.getAbsolutePath() + File.separatorChar + "pp_create_functions_update.sql", sqlFindUpdate);
		writeFile(folderSQL.getAbsolutePath() + File.separatorChar + "pp_create_functions_delete.sql", sqlFindDelete);

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

}
