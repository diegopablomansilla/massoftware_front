package com.massoftware.anthill;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.net.URL;
import java.time.ZonedDateTime;

public class UtilJavaList {

	public static String toJavaWL(Clazz clazzX) throws IOException {

		String java = "";

		String linea;
		String source = "";

		ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
		URL url = classLoader.getResource("wl.txt");
		String path = url.toString().substring(6, url.toString().length());

		FileReader f = new FileReader(path);
		BufferedReader b = new BufferedReader(f);
		while ((linea = b.readLine()) != null) {
			source += "\n" + linea;
			// System.out.println(linea);
		}
		b.close();

		source = source.replaceAll("NOMBRE_PAQUETE", clazzX.getNamePackage());
		source = source.replaceAll("NOMBRE_CLASE", clazzX.getName());
		source = source.replaceAll("CONTROLES", buildWLControls(clazzX));
		source = source.replaceAll("INSTANCE", buildWLControlsInstance(clazzX));
		source = source.replaceAll("ADD", buildWLControlsInstanceAdd(clazzX));
		source = source.replaceAll("COLUMNAS", buildWColumnsAdd(clazzX));
		source = source.replaceAll("ANCHOS", buildWColumnsProperties(clazzX));
		source = source.replaceAll("LOGICO", buildWColumnsPropertiesLogico(clazzX));
		source = source.replaceAll("FECHA", buildWColumnsPropertiesDate(clazzX));
		source = source.replaceAll("TIEMPO", buildWColumnsPropertiesTiempo(clazzX));
		source = source.replaceAll("@HH:SS@", ZonedDateTime.now().toString());

		java += source;

		// java += buildWListadoPackage();
		// java += buildWListadoImports();
		// java += buildWListadoControls();
		// java += buildWListadoControlsInstance();

		return java;
	}

	private static String buildWLControls(Clazz clazzX) {
		String java = "";

		for (int i = 0; i < clazzX.getArgs().size(); i++) {

			Argument arg = clazzX.getArgs().get(i);

			String sc = "\n\t";

			if (arg.isNumber() || arg.isTimestamp() || arg.isDate()) {

				if (arg.getRange() == false) {

					java += sc + "private TextFieldBox " + arg.getName() + "TXTB;";

				} else {

					java += sc + "private TextFieldBox " + arg.getName() + "FromTXTB;";
					java += sc + "private TextFieldBox " + arg.getName() + "ToTXTB;";

				}

			} else if (arg.isString()) {

				java += sc + "private TextFieldBox " + arg.getName() + "TXTB;";

			} else if (arg.isBoolean()) {
				java += sc + "private OptionGroupEntityBoolean " + arg.getName() + "OPT;";
			} else if (arg.isSimple() == false) {
				java += sc + "private SelectorBox " + arg.getName() + "CBXB;";
			}
		}

		java += "\n";

		return java;
	}

	private static String buildWLControlsInstance(Clazz clazzX) {
		String java = "";

		for (int i = 0; i < clazzX.getArgs().size(); i++) {

			Argument arg = clazzX.getArgs().get(i);

			String sc = "\n\n\t\t// ------------------------------------------------------------------\n\n\t\t";

			if (arg.isNumber() || arg.isTimestamp() || arg.isDate()) {

				if (arg.getRange() == false) {

					java += sc + arg.getName() + "TXTB = new TextFieldBox(this, filterBI, \"" + arg.getName() + "\");";

				} else {

					java += sc + arg.getName() + "FromTXTB = new TextFieldBox(this, filterBI, \"" + arg.getName()
							+ "From\");";
					java += sc + arg.getName() + "ToTXTB = new TextFieldBox(this, filterBI, \"" + arg.getName()
							+ "To\");";

				}

			} else if (arg.isString()) {

				java += sc + arg.getName() + "TXTB = new TextFieldBox(this, filterBI, \"" + arg.getName() + "\", \""
						+ arg.getSearchOptionValue() + "\");";

			} else if (arg.isBoolean()) {

				java += sc + arg.getName() + "OPT = new OptionGroupEntityBoolean(this, filterBI, " + arg.getName()
						+ ", \"Activas\", \"Obsoletas\", \"Todas\", true, 0)";

			} else if (arg.isSimple() == false) {
				java += sc + arg.getDataType().getName().replaceAll("java.lang", "") + " " + arg.getName()
						+ "Filtro = new " + arg.getName() + "Filtro();";
				java += sc + arg.getName() + "Filtro.setUnlimited(true);";
				java += sc + arg.getDataType().getName().replaceAll("java.lang", "") + "DAO " + arg.getName()
						+ "DAO = new " + arg.getName() + "DAO();";
				java += sc + "List<" + arg.getDataType().getName().replaceAll("java.lang", "") + ">" + arg.getName()
						+ "Lista = " + arg.getName() + "DAO.find(" + arg.getName() + "Filtro);";

				java += sc + arg.getName() + "CBXB = new ComboBoxBox(this, filterBI, \"" + arg.getName() + "\", "
						+ arg.getName() + "Lista" + ");";

				java += sc + "private SelectorBox " + arg.getName() + "CBXB;";
			}
		}

		java += "\n";

		return java;
	}

	private static String buildWLControlsInstanceAdd(Clazz clazzX) {
		String java = "";

		for (int i = 0; i < clazzX.getArgs().size(); i++) {

			Argument arg = clazzX.getArgs().get(i);

			String sc = (i == 0) ? "" : ", ";

			if (arg.isNumber() || arg.isTimestamp() || arg.isDate()) {

				if (arg.getRange() == false) {

					java += sc + arg.getName() + "TXTB";

				} else {

					java += sc + arg.getName() + "FromTXTB";
					sc = ", ";
					java += sc + arg.getName() + "ToTXTB";

				}

			} else if (arg.isString()) {

				java += sc + arg.getName() + "TXTB";

			} else if (arg.isBoolean()) {

				java += sc + arg.getName() + "OPT";

			} else if (arg.isSimple() == false) {

				java += sc + arg.getName() + "CBXB";
			}
		}

		return java;
	}

	private static String buildWColumnsAdd(Clazz clazzX) {
		String java = "\"id\", ";

		for (int i = 0; i < clazzX.getAtts().size(); i++) {

			Att att = clazzX.getAtts().get(i);

			String sc = (i == 0) ? "" : ", ";

			java += sc + "\"" + att.getName() + "\"";

		}

		return java;
	}

	private static String buildWColumnsProperties(Clazz clazzX) {
		String java = "UtilUI.confColumn(itemsGRD.getColumn(\"id\"), true, true, true, -1);";

		for (int i = 0; i < clazzX.getAtts().size(); i++) {

			Att att = clazzX.getAtts().get(i);

			String sc = "\n\n\t\t";

			String w = "-1";

			if (att.getColumns() != null) {
				w = att.getColumns().intValue() * 12 + "";
				if(att.isTimestamp()) {
					w = "120";					
				} else if(att.isBoolean()) {
					w = "70";					
				} else if(att.isInteger()) {
					w = "100";					
				} else if(att.isBigDecimal()) {
					w = "120";					
				}
				
			}

			java += sc + "UtilUI.confColumn(itemsGRD.getColumn(\"" + att.getName() + "\"), true, " + w + ");";

		}

		return java;
	}

	private static String buildWColumnsPropertiesLogico(Clazz clazzX) {
		String java = "";

		for (int i = 0; i < clazzX.getAtts().size(); i++) {

			Att att = clazzX.getAtts().get(i);

			if (att.isBoolean()) {
				String sc = "\n\n\t\t";

				java += sc + "itemsGRD.getColumn(\"" + att.getName()
						+ "\").setRenderer(new HtmlRenderer(), new StringToBooleanConverter(FontAwesome.CHECK_SQUARE_O.getHtml(),FontAwesome.SQUARE_O.getHtml()));";

			}

		}

		return java;
	}

	private static String buildWColumnsPropertiesDate(Clazz clazzX) {
		String java = "";

		for (int i = 0; i < clazzX.getAtts().size(); i++) {

			Att att = clazzX.getAtts().get(i);

			if (att.isDate()) {
				String sc = "\n\n\t\t";

				java += sc + "itemsGRD.getColumn(\"" + att.getName()
						+ "\").setRenderer(new DateRenderer(new SimpleDateFormat(\"dd/MM/yyyy\")));";

			}

		}

		return java;
	}

	private static String buildWColumnsPropertiesTiempo(Clazz clazzX) {
		String java = "";

		for (int i = 0; i < clazzX.getAtts().size(); i++) {

			Att att = clazzX.getAtts().get(i);

			if (att.isTimestamp()) {
				String sc = "\n\n\t\t";

				java += sc + "itemsGRD.getColumn(\"" + att.getName()
						+ "\").setRenderer(new DateRenderer(new SimpleDateFormat(\"dd/MM/yyyy HH:mm:ss\")));";

			}

		}

		return java;
	}

}
