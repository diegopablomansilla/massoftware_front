package com.anthill.model.to_java;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.net.URL;
import java.time.ZonedDateTime;

import com.anthill.model.Argument;
import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeClazz;
import com.massoftware.AppCX;

public class UtilJavaStm {

	private static String toCamelStart(String text) {
		if (text == null || text.isEmpty()) {
			return text;
		}

		return text.substring(0, 1).toUpperCase() + text.substring(1, text.length());
	}

	public static String toJavaStm(Clazz clazzX) throws IOException {

		String java = "";

		String linea;
		String source = "";

		ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
		URL url = classLoader.getResource("stm.txt");
		String path = url.toString().substring(6, url.toString().length());

		FileReader f = new FileReader(path);
		BufferedReader b = new BufferedReader(f);
		while ((linea = b.readLine()) != null) {
			source += "\n" + linea;
			// System.out.println(linea);
		}
		b.close();

		source = source.replaceAll("@NAME_PACKAGE@", clazzX.getNamePackage());
		source = source.replaceAll("@NAME_PLURAL@", clazzX.getNamePlural());
		source = source.replaceAll("@NAME@", clazzX.getName());

		String atts = "";
		for (int i = 0; i < clazzX.getAttsGrid().size(); i++) {
			if (i == 0) {
				atts += clazzX.getName() + "." + clazzX.getAttsGrid().get(i).getName();
			} else {
				atts += ", " + clazzX.getName() + "." + clazzX.getAttsGrid().get(i).getName();
			}
		}

		source = source.replaceAll("@ATTS@", atts);
		source = source.replaceAll("@WHEEW@", buildWhere(clazzX));
		source = source.replaceAll("@REQUIRED@", buildCheck(clazzX));

		java += source;

		// java += buildWListadoPackage();
		// java += buildWListadoImports();
		// java += buildWListadoControls();
		// java += buildWListadoControlsInstance();

		return java;
	}

	private static String buildWhere(Clazz clazzX) {
		String java = "";

		for (int i = 0; i < clazzX.getArgs().size(); i++) {

			Argument arg = clazzX.getArgs().get(i);

			String sc = "\n\t";

			if (arg.isNumber()) {

				if (arg.getRange() == false) {

					java += sc + buildEqualWhere(clazzX.getName(), arg.getName(), arg.getDataType().getNameJava());

				} else {

					java += sc + buildFromWhere(clazzX.getName(), arg.getName(), arg.getDataType().getNameJava());
					java += sc + buildToWhere(clazzX.getName(), arg.getName(), arg.getDataType().getNameJava());

				}

			} else if (arg.isDate()) {

				if (arg.getRange() == false) {

					java += sc + buildEqualWhere(clazzX.getName(), arg.getName(), arg.getDataType().getNameJava());

				} else {

					java += sc + buildFromWhere(clazzX.getName(), arg.getName(), arg.getDataType().getNameJava());
					java += sc + buildToWhere(clazzX.getName(), arg.getName(), arg.getDataType().getNameJava());
				}

			} else if (arg.isTimestamp()) {

				if (arg.getRange() == false) {

					java += sc + buildEqualWhere(clazzX.getName(), arg.getName(), arg.getDataType().getNameJava());

				} else {

					java += sc + buildFromWhere(clazzX.getName(), arg.getName(), arg.getDataType().getNameJava());
					java += sc + buildToWhere(clazzX.getName(), arg.getName(), arg.getDataType().getNameJava());

				}

			} else if (arg.isString()) {

				java += sc + buildEqualStringWhere(clazzX.getName(), arg.getName(), arg.getDataType().getNameJava());

			} else if (arg.isBoolean()) {

				java += sc + buildEqualWhere(clazzX.getName(), arg.getName(), arg.getDataType().getNameJava());

			} else if (arg.isSimple() == false) {

				java += sc + buildEqualWhere(clazzX.getName(), arg.getName(), String.class.getName());
			}
		}

		java += "\n";

		return java;
	}

	private static String buildFromWhere(String m, String n, String c) {
		String s = "";
		s += "\n\t\tif (f.get" + toCamelStart(n) + "From() != null) {";
		s += "\n\t\t\twhere += (where.trim().length() > 0 ) ? \" AND \" : \"\";";
		s += "\n\t\t\twhere += \" " + m + "." + toCamelStart(n) + " >= ?\";";
		s += "\n\t\t\tthis.addArg(buildArgTrimLower(f.get" + toCamelStart(n) + "From(), " + c + ".class));";
		s += "\n\t\t}";

		return s;
	}

	private static String buildToWhere(String m, String n, String c) {
		String s = "";
		s += "\n\t\tif (f.get" + toCamelStart(n) + "To() != null) {";
		s += "\n\t\t\twhere += (where.trim().length() > 0 ) ? \" AND \" : \"\";";
		s += "\n\t\t\twhere += \" " + m + "." + toCamelStart(n) + " <= ?\";";
		s += "\n\t\t\tthis.addArg(buildArgTrimLower(f.get" + toCamelStart(n) + "To(), " + c + ".class));";
		s += "\n\t\t}";

		return s;
	}

	private static String buildEqualWhere(String m, String n, String c) {
		String s = "";
		s += "\n\t\tif (f.get" + toCamelStart(n) + "() != null) {";
		s += "\n\t\t\twhere += (where.trim().length() > 0 ) ? \" AND \" : \"\";";
		s += "\n\t\t\twhere += \" " + m + "." + toCamelStart(n) + " = ?\";";
		s += "\n\t\t\tthis.addArg(buildArgTrimLower(f.get" + toCamelStart(n) + "(), " + c + ".class));";
		s += "\n\t\t}";

		return s;
	}

	private static String buildEqualStringWhere(String m, String n, String c) {
		String s = "";

		s += "\n\t\tif (f.get" + toCamelStart(n) + "() != null && f.get" + toCamelStart(n)
				+ "().trim().isEmpty() == false) {";
		s += "\n\t\t\tString[] words =  f.get" + toCamelStart(n) + "().trim().split(\" \");";
		s += "\n\t\t\tfor(String word : words) {";
		s += "\n\t\t\t\twhere += (where.trim().length() > 0 ) ? \" AND \" : \"\";";
		s += "\n\t\t\t\twhere += \" TRANSLATE(LOWER(TRIM(" + m + "." + toCamelStart(n)
				+ "))\" + translate + \") LIKE ?\";";
		s += "\n\t\t\t\tthis.addArg(buildArgTrimLower(word.trim(), String.class));";
		s += "\n\t\t\t}";
		s += "\n\t}";

		return s;
	}

	private static String buildRequired(String m, String n) {
		String s = "";
		
		s += "\n\t\tif (f.get" + toCamelStart(n) + "() == null || f.get" + toCamelStart(n) + "().toString().trim().isEmpty()) {";
		s += "\n\t\t\tthrow new IllegalArgumentException(\"QUERY: Se esperaba un valor para el campo \" + " + m + "Filtro.class.getCanonicalName() + \".name para filtrar la consulta\");";
		s += "\n\t\t}";

		return s;
	}

	private static String buildCheck(Clazz clazzX) {
		String java = "";

		for (int i = 0; i < clazzX.getArgs().size(); i++) {

			Argument arg = clazzX.getArgs().get(i);

			if (arg.isRequired() == false) {
				continue;
			}

			String sc = "\n\t";

			if (arg.isNumber()) {

				if (arg.getRange() == false) {

					java += sc + buildRequired(clazzX.getNamePlural(), arg.getName());

				} else {

					java += sc + buildRequired(clazzX.getNamePlural(), arg.getName() + "From");
					java += sc + buildRequired(clazzX.getNamePlural(), arg.getName() + "to");

				}

			} else if (arg.isDate()) {

				if (arg.getRange() == false) {

					java += sc + buildRequired(clazzX.getNamePlural(), arg.getName());

				} else {

					java += sc + buildRequired(clazzX.getNamePlural(), arg.getName() + "From");
					java += sc + buildRequired(clazzX.getNamePlural(), arg.getName() + "to");
				}

			} else if (arg.isTimestamp()) {

				if (arg.getRange() == false) {

					java += sc + buildRequired(clazzX.getNamePlural(), arg.getName());

				} else {

					java += sc + buildRequired(clazzX.getNamePlural(), arg.getName() + "From");
					java += sc + buildRequired(clazzX.getNamePlural(), arg.getName() + "to");

				}

			} else if (arg.isString()) {

				java += sc + buildRequired(clazzX.getNamePlural(), arg.getName());

			} else if (arg.isBoolean()) {

				java += sc + buildRequired(clazzX.getNamePlural(), arg.getName());

			} else if (arg.isSimple() == false) {

				java += sc + buildRequired(clazzX.getNamePlural(), arg.getName());
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

			if (arg.isNumber()) {

				if (arg.getRange() == false) {

					java += sc + arg.getName() + "TXTB = new TextFieldBox(this, filterBI, \"" + arg.getName() + "\");";

				} else {

					java += sc + arg.getName() + "FromTXTB = new TextFieldBox(this, filterBI, \"" + arg.getName()
							+ "From\");";
					java += sc + arg.getName() + "ToTXTB = new TextFieldBox(this, filterBI, \"" + arg.getName()
							+ "To\");";

				}

			} else if (arg.isDate()) {

				if (arg.getRange() == false) {

					java += sc + arg.getName() + "TXTB = new DateFieldBox(this, filterBI, \"" + arg.getName()
							+ "\", false);";

				} else {

					java += sc + arg.getName() + "FromTXTB = new DateFieldBox(this, filterBI, \"" + arg.getName()
							+ "From\", false);";
					java += sc + arg.getName() + "ToTXTB = new DateFieldBox(this, filterBI, \"" + arg.getName()
							+ "To\", false);";

				}

			} else if (arg.isTimestamp()) {

				if (arg.getRange() == false) {

					java += sc + arg.getName() + "TXTB = new DateFieldBox(this, filterBI, \"" + arg.getName()
							+ "\", false);";

				} else {

					java += sc + arg.getName() + "FromTXTB = new DateFieldBox(this, filterBI, \"" + arg.getName()
							+ "From\", false);";
					java += sc + arg.getName() + "ToTXTB = new DateFieldBox(this, filterBI, \"" + arg.getName()
							+ "To\", false);";

				}

			} else if (arg.isString()) {

				java += sc + arg.getName() + "TXTB = new TextFieldBox(this, filterBI, \"" + arg.getName() + "\", \""
						+ arg.getSearchOptionValue() + "\");";

			} else if (arg.isBoolean()) {

				java += sc + arg.getName() + "OPT = new OptionGroupEntityBoolean(this, filterBI, \"" + arg.getName()
						+ "Int\", \"Activas\", \"Obsoletas\", \"Todas\", true, 0);";

			} else if (arg.isSimple() == false) {
				// java += sc + arg.getDataType().getName().replaceAll("java.lang", "") + " " +
				// arg.getName()
				// + "Filtro = new " + arg.getName() + "Filtro();";
				// java += sc + arg.getName() + "Filtro.setUnlimited(true);";
				// java += sc + arg.getDataType().getName().replaceAll("java.lang", "") + "DAO "
				// + arg.getName()
				// + "DAO = new " + arg.getName() + "DAO();";
				// java += sc + "List<" + arg.getDataType().getName().replaceAll("java.lang",
				// "") + ">" + arg.getName()
				// + "Lista = " + arg.getName() + "DAO.find(" + arg.getName() + "Filtro);";
				//
				// java += sc + arg.getName() + "CBXB = new ComboBoxBox(this, filterBI, \"" +
				// arg.getName() + "\", "
				// + arg.getName() + "Lista" + ");";
				//
				// java += sc + "private SelectorBox " + arg.getName() + "CBXB;";

				String sc2 = "\n\n\t\t";
				String sc3 = sc2 + "\t";
				String sc4 = sc3 + "\t";
				String sc5 = sc4 + "\t";
				String sc6 = sc5 + "\t";
				String sc7 = sc6 + "\t";

				// java += sc + arg.getDataType().getName() + "DAO " + arg.getName() + "DAO =
				// new "
				// + arg.getDataType().getName() + "DAO();";

				java += sc + arg.getDataType().getName() + "Service " + arg.getName()
						+ "Service = AppCX.services().build" + arg.getDataType().getName() + "Service();";

				java += sc2 + "long " + arg.getName() + "Items = " + arg.getName() + "Service.count();";

				java += sc2 + "if (" + arg.getName() + "Items < MAX_ROWS_FOR_CBX) {";

				java += sc3 + arg.getDataType().getName() + "Filtro " + arg.getName() + "Filtro = new "
						+ arg.getDataType().getName() + "Filtro();";

				java += sc3 + arg.getName() + "Filtro.setUnlimited(true);";

				DataTypeClazz dtArg = (DataTypeClazz) arg.getDataType();

				// java += sc3 + arg.getName() + "Filtro.setOrderBy(\"" +
				// dtArg.getClazz().getAtts().get(0).getName() + "\");";
				java += sc3 + arg.getName() + "Filtro.setOrderBy(1);";

				java += sc3 + "List<" + arg.getDataType().getName().replaceAll("java.lang", "") + "> " + arg.getName()
						+ "Lista = " + arg.getName() + "Service.find(" + arg.getName() + "Filtro);";

				java += sc3 + arg.getName() + "CBXB = new ComboBoxBox(this, filterBI, \"" + arg.getName() + "\", "
						+ arg.getName() + "Lista" + ", filterBI.getBean().get" + toCamelStart(arg.getName()) + "());";

				if (i == 0) {
					java += "\n\n\t\t\t" + arg.getName() + "CBXB.focus();";
				}

				java += sc2 + "} else {";

				java += sc3 + arg.getName() + "SBX = new SelectorBox(filterBI, \"" + arg.getName() + "\") {";

				java += sc4 + "protected void sourceLoadDataResetPaged() {";

				java += sc5 + "loadDataResetPaged();";

				java += sc4 + "}";

				java += sc4 + "@SuppressWarnings(\"rawtypes\")" + "\n\t\t\t\t"
						+ "protected List findBean(String value) throws Exception {";

				// java += sc5 + arg.getDataType().getName() + "DAO dao = new " +
				// arg.getDataType().getName() + "DAO();";
				java += sc5 + arg.getDataType().getName() + "Service service = AppCX.services().build"
						+ arg.getDataType().getName() + "Service();";

				Clazz clazzAtt = ((DataTypeClazz) arg.getDataType()).getClazz();
				String arg1 = toCamelStart(clazzAtt.getArgsSBX().get(0).getName());
				String arg2 = "";
				if (clazzAtt.getArgsSBX().size() > 1) {
					arg2 = "Or" + toCamelStart(clazzAtt.getArgsSBX().get(1).getName());
				}

				if (clazzAtt.getArgsSBX().size() > 1) {
					java += sc5 + "return service.findBy" + arg1 + arg2 + "(value);";
				} else {
					java += sc5 + "return service.findBy" + arg1 + "(value);";
				}

				java += sc4 + "}";

				java += sc4 + "protected WindowListado getPopup(boolean filter) throws Exception {";

				java += sc5 + arg.getDataType().getName() + "Filtro filtro = new " + arg.getDataType().getName()
						+ "Filtro();";
				java += sc5 + "if (filter) {";

				if (clazzAtt.getArgsSBX().size() > 1) {
					java += sc6 + "filtro.set" + toCamelStart(clazzAtt.getArgsSBX().get(1).getName()) + "(getValue());";
				} else {
					// java += sc6 + "filtro.set" +
					// toCamelStart(clazzAtt.getArgsSBX().get(0).getName()) + "(getValue());";
				}

				java += sc5 + "}";

				java += sc5 + "//WL" + arg.getDataType().getName() + " windowPoPup = new WL"
						+ arg.getDataType().getName() + "(filtro) {";
				java += sc6 + "//protected void setSelectedItem() throws Exception {";

				java += sc7 + "//" + arg.getName() + "SBX.setSelectedItem(itemsGRD.getSelectedRow());";

				java += sc6 + "//}";
				java += sc5 + "//};";

				java += sc5 + "WL" + arg.getDataType().getName() + " windowPoPup = AppCX.widgets().buildWL"
						+ arg.getDataType().getName() + "(filtro);";
				java += sc5 + "windowPoPup.selectorSBX = " + arg.getName() + "SBX;";

				java += sc5 + "return windowPoPup;";

				java += sc4 + "}";

				java += sc3 + "};";

				if (i == 0) {
					java += "\n\n\t\t\t" + arg.getName() + "SBX.focus();";
				}

				java += sc2 + "}";

				// WLPais windowPoPup = new WLPais(filtro) {
				//
				// protected void setSelectedItem() {
				// paisSBX.setSelectedItem(itemsGRD.getSelectedRow());
				// }
				//
				// };

			}
		}

		java += "\n";

		return java;
	}

	// private static String buildWLControlsInstanceAddx(Clazz clazzX) {
	// String java = "";
	//
	// for (int i = 0; i < clazzX.getArgs().size(); i++) {
	//
	// Argument arg = clazzX.getArgs().get(i);
	//
	// String sc = (i == 0) ? "" : ", ";
	//
	// if (arg.isNumber() || arg.isTimestamp() || arg.isDate()) {
	//
	// if (arg.getRange() == false) {
	//
	// java += sc + arg.getName() + "TXTB";
	//
	// } else {
	//
	// java += sc + arg.getName() + "FromTXTB";
	// sc = ", ";
	// java += sc + arg.getName() + "ToTXTB";
	//
	// }
	//
	// } else if (arg.isString()) {
	//
	// java += sc + arg.getName() + "TXTB";
	//
	// } else if (arg.isBoolean()) {
	//
	// java += sc + arg.getName() + "OPT";
	//
	// } else if (arg.isSimple() == false) {
	//
	// java += sc + arg.getName() + "CBXB";
	// }
	// }
	//
	// return java;
	// }

	private static String buildWLControlsInstanceAdd(Clazz clazzX) {

		String java = "";

		for (int i = 0; i < clazzX.getArgs().size(); i++) {

			Argument att = clazzX.getArgs().get(i);

			// String sc = (i == 0) ? "" : ", ";

			if (att.isNumber()) {

				if (att.getRange() == false) {

					java += "\n\t\tif (" + att.getName() + "TXTB != null) {";
					java += "\n\t\t\tfilaFiltroHL.addComponent(" + att.getName() + "TXTB);";
					java += "\n\t\t}";

				} else {

					java += "\n\t\tif (" + att.getName() + "FromTXTB != null) {";
					java += "\n\t\t\tfilaFiltroHL.addComponent(" + att.getName() + "FromTXTB);";
					java += "\n\t\t}";

					java += "\n\t\tif (" + att.getName() + "ToTXTB != null) {";
					java += "\n\t\t\tfilaFiltroHL.addComponent(" + att.getName() + "ToTXTB);";
					java += "\n\t\t}";

				}

			} else if (att.isString()) {

				java += "\n\t\tif (" + att.getName() + "TXTB != null) {";
				java += "\n\t\t\tfilaFiltroHL.addComponent(" + att.getName() + "TXTB);";
				java += "\n\t\t}";

			} else if (att.isBoolean()) {

				java += "\n\t\tif (" + att.getName() + "OPT != null) {";
				java += "\n\t\t\tfilaFiltroHL.addComponent(" + att.getName() + "OPT);";
				java += "\n\t\t}";

			} else if (att.isTimestamp()) {

				if (att.getRange() == false) {

					java += "\n\t\tif (" + att.getName() + "TXTB != null) {";
					java += "\n\t\t\tfilaFiltroHL.addComponent(" + att.getName() + "TXTB);";
					java += "\n\t\t}";

				} else {

					java += "\n\t\tif (" + att.getName() + "FromTXTB != null) {";
					java += "\n\t\t\tfilaFiltroHL.addComponent(" + att.getName() + "FromTXTB);";
					java += "\n\t\t}";

					java += "\n\t\tif (" + att.getName() + "ToTXTB != null) {";
					java += "\n\t\t\tfilaFiltroHL.addComponent(" + att.getName() + "ToTXTB);";
					java += "\n\t\t}";

				}

				// java += "\n\t\tif (" + att.getName() + "TXTB != null) {";
				// java += "\n\t\t\tfilaFiltroHL.addComponent(" + att.getName() + "TXTB);";
				// java += "\n\t\t}";

			} else if (att.isDate()) {

				if (att.getRange() == false) {

					java += "\n\t\tif (" + att.getName() + "TXTB != null) {";
					java += "\n\t\t\tfilaFiltroHL.addComponent(" + att.getName() + "TXTB);";
					java += "\n\t\t}";

				} else {

					java += "\n\t\tif (" + att.getName() + "FromTXTB != null) {";
					java += "\n\t\t\tfilaFiltroHL.addComponent(" + att.getName() + "FromTXTB);";
					java += "\n\t\t}";

					java += "\n\t\tif (" + att.getName() + "ToTXTB != null) {";
					java += "\n\t\t\tfilaFiltroHL.addComponent(" + att.getName() + "ToTXTB);";
					java += "\n\t\t}";

				}

				// java += "\n\t\tif (" + att.getName() + "DAFB != null) {";
				// java += "\n\t\t\tfilaFiltroHL.addComponent(" + att.getName() + "DAFB);";
				// java += "\n\t\t}";

			} else if (att.isSimple() == false) {

				java += "\n\t\tif (" + att.getName() + "CBXB != null) {";
				java += "\n\t\t\tfilaFiltroHL.addComponent(" + att.getName() + "CBXB);";
				java += "\n\t\t}";

				java += "\n\t\tif (" + att.getName() + "SBX != null) {";
				java += "\n\t\t\tfilaFiltroHL.addComponent(" + att.getName() + "SBX);";
				java += "\n\t\t}";
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

				if (att.isTimestamp()) {
					w = "120";
				} else if (att.isBoolean()) {
					w = "70";
				} else if (att.isInteger()) {
					w = "100";
				} else if (att.isBigDecimal()) {
					w = "120";
				}

				if (i == clazzX.getAtts().size() - 1) {
					w = "-1";
				}

			}

			java += sc + "UtilUI.confColumn(itemsGRD.getColumn(\"" + att.getName() + "\"), true, " + w + ");";

		}

		return java;
	}

	private static String buildWColumnsPropertiesLogicoImport(Clazz clazzX) {

		for (int i = 0; i < clazzX.getAtts().size(); i++) {

			Att att = clazzX.getAtts().get(i);

			if (att.isBoolean()) {

				return "\nimport com.vaadin.data.util.converter.StringToBooleanConverter;\nimport com.vaadin.server.FontAwesome;\nimport com.vaadin.ui.renderers.HtmlRenderer;";

			}

		}

		return "";
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

	private static String buildWColumnsPropertiesDateImport(Clazz clazzX) {

		for (int i = 0; i < clazzX.getAtts().size(); i++) {

			Att att = clazzX.getAtts().get(i);

			if (att.isDate() || att.isTimestamp()) {

				return "\nimport com.vaadin.ui.renderers.DateRenderer;\nimport java.text.SimpleDateFormat;";

			}

		}

		return "";
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
