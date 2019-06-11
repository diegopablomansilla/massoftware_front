package com.massoftware.anthill;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.net.URL;
import java.time.ZonedDateTime;

public class UtilJavaForm {

	private static String toCamelStart(String text) {
		if (text == null || text.isEmpty()) {
			return text;
		}

		return text.substring(0, 1).toUpperCase() + text.substring(1, text.length());
	}

	public static String toJavaWF(Clazz clazz) throws IOException {
		String java = "";

		String linea;
		String source = "";

		ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
		URL url = classLoader.getResource("wf.txt");
		String path = url.toString().substring(6, url.toString().length());

		FileReader f = new FileReader(path);
		BufferedReader b = new BufferedReader(f);
		while ((linea = b.readLine()) != null) {
			source += "\n" + linea;
			// System.out.println(linea);
		}
		b.close();

		source = source.replaceAll("NOMBRE_PAQUETE", clazz.getNamePackage());
		source = source.replaceAll("FK", buildWFControlsImportModel(clazz));
		source = source.replaceAll("NOMBRE_CLASE", clazz.getName());
		source = source.replaceAll("CONTROLES", buildWFControls(clazz));
		source = source.replaceAll("INSTANCE", buildWFControlsInstance(clazz));
		source = source.replaceAll("ADD", buildWFControlsInstanceAdd(clazz));
		source = source.replaceAll("NEXT", buildWFNextValues(clazz));
		source = source.replaceAll("@HH:SS@", ZonedDateTime.now().toString());

		java += source;

		return java;
	}

	private static String buildWFControlsImportModel(Clazz clazzX) {

		String java = "";

		boolean b = false;

		for (int i = 0; i < clazzX.getAtts().size(); i++) {

			Att att = clazzX.getAtts().get(i);

			String sc = "\n";

			if (att.isSimple() == false) {

				b = true;

				Clazz clazz = ((DataTypeClazz) att.getDataType()).getClazz();

				java += sc + "import com.massoftware.model." + clazz.getNamePackage() + "." + clazz.getName() + ";";
				java += sc + "import com.massoftware.service." + clazz.getNamePackage() + "." + clazz.getName() + "Filtro;";
				java += sc + "import com.massoftware.service." + clazz.getNamePackage() + "." + clazz.getName() + "Service;";
				// java += sc + "import com.massoftware.x." + clazz.getNamePackage() + ".WL" +
				// clazz.getName() + ";";
			}
		}

		if (b) {
			java = "\n" + "import java.util.List;" + java;
		}

		java += "\n";

		return java;
	}

	private static String buildWFControls(Clazz clazzX) {
		String java = "";

		for (int i = 0; i < clazzX.getAtts().size(); i++) {

			Att att = clazzX.getAtts().get(i);

			String sc = "\n\t";

			if (att.isNumber()) {

				java += sc + "protected TextFieldEntity " + att.getName() + "TXT;";

			} else if (att.isString()) {

				if (att.getMaxLength() > 200) {
					java += sc + "protected TextAreaEntity " + att.getName() + "TXA;";
				} else {
					java += sc + "protected TextFieldEntity " + att.getName() + "TXT;";
				}

			} else if (att.isBoolean()) {

				java += sc + "protected CheckBoxEntity " + att.getName() + "CHK;";

			} else if (att.isDate()) {

				java += sc + "protected DateFieldEntity " + att.getName() + "DAF;";

			} else if (att.isTimestamp()) {

				java += sc + "protected DateFieldEntity " + att.getName() + "DAF;";

			} else if (att.isSimple() == false) {

				java += sc + "protected ComboBoxEntity " + att.getName() + "CBX;";
				java += sc + "protected SelectorBox " + att.getName() + "SBX;";
			}
		}

		java += "\n";

		return java;
	}

	private static String buildWFControlsInstance(Clazz clazzX) {

		String java = "";

		for (int i = 0; i < clazzX.getAtts().size(); i++) {

			Att att = clazzX.getAtts().get(i);

			String sc = "\n\n\t\t// ------------------------------------------------------------------\n\n\t\t";

			if (att.isNumber()) {

				if (att.isUnique()) {

					java += sc + att.getName() + "TXT = new TextFieldEntity(itemBI, \"" + att.getName()
							+ "\", this.mode) {";

					java += "\n\t\t\tprotected boolean ifExists(Object arg) throws Exception {";

					java += "\n\t\t\t\treturn getService().isExists" + toCamelStart(att.getName()) + "(("
							+ att.getDataType().getName().replace("java.lang.", "") + ")arg);";
					java += "\n\t\t\t}";
					java += "\n\t\t};";

				} else {
					java += sc + att.getName() + "TXT = new TextFieldEntity(itemBI, \"" + att.getName()
							+ "\", this.mode);";
				}

				if (i == 0) {
					java += "\n\n\t\t" + att.getName() + "TXT.focus();";
				}

			} else if (att.isString()) {
				
				if (att.getMaxLength() > 200) {
					java += sc + att.getName() + "TXA = new TextAreaEntity(itemBI, \"" + att.getName()
					+ "\", this.mode);";
					
					if (i == 0) {
						java += "\n\n\t\t" + att.getName() + "TXA.focus();";
					}
					
				} else {
					if (att.isUnique()) {
						java += sc + att.getName() + "TXT = new TextFieldEntity(itemBI, \"" + att.getName()
								+ "\", this.mode) {";

						java += "\n\t\t\tprotected boolean ifExists(Object arg) throws Exception {";

						java += "\n\t\t\t\treturn getService().isExists" + toCamelStart(att.getName()) + "(("
								+ att.getDataType().getName().replace("java.lang.", "") + ")arg);";
						java += "\n\t\t\t}";
						java += "\n\t\t};";

					} else {
						java += sc + att.getName() + "TXT = new TextFieldEntity(itemBI, \"" + att.getName()
								+ "\", this.mode);";
					}

					if (i == 0) {
						java += "\n\n\t\t" + att.getName() + "TXT.focus();";
					}
				}

				

			} else if (att.isBoolean()) {

				java += sc + att.getName() + "CHK = new CheckBoxEntity(itemBI, \"" + att.getName() + "\");";

				if (i == 0) {
					java += "\n\n\t\t" + att.getName() + "CHK.focus();";
				}

			} else if (att.isTimestamp()) {

				java += sc + att.getName() + "DAF = new DateFieldEntity(itemBI, \"" + att.getName()
						+ "\", this.mode, true);";

				if (i == 0) {
					java += "\n\n\t\t" + att.getName() + "DAF.focus();";
				}

			} else if (att.isDate()) {

				java += sc + att.getName() + "DAF = new DateFieldEntity(itemBI, \"" + att.getName()
						+ "\", this.mode, false);";

				if (i == 0) {
					java += "\n\n\t\t" + att.getName() + "DAF.focus();";
				}

			} else if (att.isSimple() == false) {

				String sc2 = "\n\n\t\t";
				String sc3 = sc2 + "\t";
				String sc4 = sc3 + "\t";
				String sc5 = sc4 + "\t";
				String sc6 = sc5 + "\t";

//				java += sc2 + att.getDataType().getName() + "DAO " + att.getName() + "DAO = new "
//						+ att.getDataType().getName() + "DAO();";
				
				java += sc2 + att.getDataType().getName() + "Service " + att.getName() + "Service = AppCX.services().build"
						+ att.getDataType().getName() + "Service();";

				java += sc2 + "long " + att.getName() + "Items = " + att.getName() + "Service.count();";

				java += sc2 + "if (" + att.getName() +"Items < MAX_ROWS_FOR_CBX) {";

				java += sc3 + att.getDataType().getName() + "Filtro " + att.getName() + "Filtro = new "
						+ att.getDataType().getName() + "Filtro();";

				java += sc3 + att.getName() + "Filtro.setUnlimited(true);";

//				java += sc3 + att.getName() + "Filtro.setOrderBy(\"" + clazzX.getAtts().get(0).getName() + "\");";
				java += sc3 + att.getName() + "Filtro.setOrderBy(1);";

				java += sc3 + "List<" + att.getDataType().getName().replaceAll("java.lang", "") + "> " + att.getName()
						+ "Lista = " + att.getName() + "Service.find(" + att.getName() + "Filtro);";

				java += sc3 + att.getName() + "CBX = new ComboBoxEntity(itemBI, \"" + att.getName() + "\", this.mode, "
						+ att.getName() + "Lista" + ");";

				if (i == 0) {
					java += "\n\n\t\t\t" + att.getName() + "CBX.focus();";
				}

				java += sc2 + "} else {";

				java += sc3 + att.getName() + "SBX = new SelectorBox(itemBI, \"" + att.getName() + "\") {";

				java += sc4 + "@SuppressWarnings(\"rawtypes\")" + "\n\t\t\t\t"
						+ "protected List findBean(String value) throws Exception {";

//				java += sc5 + att.getDataType().getName() + "DAO dao = new " + att.getDataType().getName() + "DAO();";
				java += sc5 + att.getDataType().getName() + "Service service = AppCX.services().build" + att.getDataType().getName() + "Service();";

				Clazz clazzAtt = ((DataTypeClazz) att.getDataType()).getClazz();
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

				java += sc5 + att.getDataType().getName() + "Filtro filtro = new " + att.getDataType().getName()
						+ "Filtro();";
				java += sc5 + "if (filter) {";

				if (clazzAtt.getArgsSBX().size() > 1 && clazzAtt.getArgsSBX().get(1).isString()) {
					java += sc6 + "filtro.set" + toCamelStart(clazzAtt.getArgsSBX().get(1).getName()) + "(getValue());";
				} else {
					java += sc6 + "filtro.set" + toCamelStart(clazzAtt.getArgsSBX().get(0).getName()) + "(getValue());";
				}

				java += sc5 + "}";
				java += sc5 + "return AppCX.widgets().buildWL" + att.getDataType().getName() + "(filtro);";

				java += sc4 + "}";

				java += sc3 + "};";

				if (i == 0) {
					java += "\n\n\t\t\t" + att.getName() + "SBX.focus();";
				}

				java += sc2 + "}";

			}
		}

		java += "\n";

		return java;
	}

	// private static String buildWFControlsInstanceAdd(Clazz clazzX) {
	//
	// String java = "";
	//
	// for (int i = 0; i < clazzX.getAtts().size(); i++) {
	//
	// Att att = clazzX.getAtts().get(i);
	//
	// String sc = (i == 0) ? "" : ", ";
	//
	// if (att.isNumber()) {
	//
	// java += sc + att.getName() + "TXT";
	//
	// } else if (att.isString()) {
	//
	// java += sc + att.getName() + "TXT";
	//
	// } else if (att.isBoolean()) {
	//
	// java += sc + att.getName() + "CHK";
	//
	// } else if (att.isTimestamp()) {
	//
	// java += sc + att.getName() + "DAF";
	//
	// } else if (att.isDate()) {
	//
	// java += sc + att.getName() + "DAF";
	//
	// } else if (att.isSimple() == false) {
	//
	// java += sc + att.getName() + "CBX";
	// }
	// }
	//
	// return java;
	// }

	private static String buildWFControlsInstanceAdd(Clazz clazzX) {

		String java = "";

		for (int i = 0; i < clazzX.getAtts().size(); i++) {

			Att att = clazzX.getAtts().get(i);

			// String sc = (i == 0) ? "" : ", ";

			if (att.isNumber()) {

//				java += "\n\t\tif (" + att.getName() + "TXT != null) {";
//				java += "\n\t\t\tgeneralVL.addComponent(" + att.getName() + "TXT);";
//				java += "\n\t\t}";
				
				java += "\n\t\tgeneralVL.addComponent(" + att.getName() + "TXT);";

			} else if (att.isString()) {
				
				if (att.getMaxLength() > 200) {
//					java += "\n\t\tif (" + att.getName() + "TXA != null) {";
//					java += "\n\t\t\tgeneralVL.addComponent(" + att.getName() + "TXA);";
//					java += "\n\t\t}";
					
					java += "\n\t\tgeneralVL.addComponent(" + att.getName() + "TXA);";
					
				} else {
//					java += "\n\t\tif (" + att.getName() + "TXT != null) {";
//					java += "\n\t\t\tgeneralVL.addComponent(" + att.getName() + "TXT);";
//					java += "\n\t\t}";
					
					java += "\n\t\tgeneralVL.addComponent(" + att.getName() + "TXT);";
				}

				

			} else if (att.isBoolean()) {

//				java += "\n\t\tif (" + att.getName() + "CHK != null) {";
//				java += "\n\t\t\tgeneralVL.addComponent(" + att.getName() + "CHK);";
//				java += "\n\t\t}";
				
				java += "\n\t\tgeneralVL.addComponent(" + att.getName() + "CHK);";

			} else if (att.isTimestamp()) {

//				java += "\n\t\tif (" + att.getName() + "DAF != null) {";
//				java += "\n\t\t\tgeneralVL.addComponent(" + att.getName() + "DAF);";
//				java += "\n\t\t}";
				
				java += "\n\t\tgeneralVL.addComponent(" + att.getName() + "DAF);";

			} else if (att.isDate()) {

//				java += "\n\t\tif (" + att.getName() + "DAF != null) {";
//				java += "\n\t\t\tgeneralVL.addComponent(" + att.getName() + "DAF);";
//				java += "\n\t\t}";
				
				java += "\n\t\tgeneralVL.addComponent(" + att.getName() + "DAF);";

			} else if (att.isSimple() == false) {

				java += "\n\t\tif (" + att.getName() + "CBX != null) {";
				java += "\n\t\t\tgeneralVL.addComponent(" + att.getName() + "CBX);";
				java += "\n\t\t}";

				java += "\n\t\tif (" + att.getName() + "SBX != null) {";
				java += "\n\t\t\tgeneralVL.addComponent(" + att.getName() + "SBX);";
				java += "\n\t\t}";
			}
		}

		return java;

	}

	private static String buildWFNextValues(Clazz clazzX) {
		String java = "";

		for (int i = 0; i < clazzX.getAtts().size(); i++) {

			Att att = clazzX.getAtts().get(i);

			String sc = "\n\t\t";

			if (att.isNumber()) {

				if (att.isBigDecimal() && ((DataTypeBigDecimal) att.getDataType()).getNextValueProposed() == true) {
					java += sc + "((" + clazzX.getName() + ") item).set" + toCamelStart(att.getName())
							+ "(getService().nextValue" + toCamelStart(att.getName()) + "());";
				} else if (att.isLong() && ((DataTypeLong) att.getDataType()).getNextValueProposed() == true) {
					java += sc + "((" + clazzX.getName() + ") item).set" + toCamelStart(att.getName())
							+ "(getService().nextValue" + toCamelStart(att.getName()) + "());";
				} else if (att.isInteger() && ((DataTypeInteger) att.getDataType()).getNextValueProposed() == true) {
					java += sc + "((" + clazzX.getName() + ") item).set" + toCamelStart(att.getName())
							+ "(getService().nextValue" + toCamelStart(att.getName()) + "());";
				}

			}
		}

		java += "\n";

		return java;
	}

}
