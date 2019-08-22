package com.anthill.model.to_java;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.net.URL;

import com.anthill.model.Argument;
import com.anthill.model.Clazz;

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

					java += sc + buildEqualWhere(clazzX.getName(), arg.getName(), arg.getDataType().getName());

				} else {

					java += sc + buildFromWhere(clazzX.getName(), arg.getName(), arg.getDataType().getName());
					java += sc + buildToWhere(clazzX.getName(), arg.getName(), arg.getDataType().getName());
				}

			} else if (arg.isTimestamp()) {

				if (arg.getRange() == false) {

					java += sc + buildEqualWhere(clazzX.getName(), arg.getName(), arg.getDataType().getName());

				} else {

					java += sc + buildFromWhere(clazzX.getName(), arg.getName(), arg.getDataType().getName());
					java += sc + buildToWhere(clazzX.getName(), arg.getName(), arg.getDataType().getName());

				}

			} else if (arg.isString()) {

				java += sc + buildEqualStringWhere(clazzX.getName(), arg.getName(), arg.getDataType().getNameJava());

			} else if (arg.isBoolean()) {

				java += sc + buildEqualWhere(clazzX.getName(), arg.getName(), arg.getDataType().getNameJava());

			} else if (arg.isSimple() == false) {

				java += sc + buildEqualWhere(clazzX.getName(), arg.getName(), String.class.getSimpleName());
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

		s += "\n\t\tif (f.get" + toCamelStart(n) + "() == null || f.get" + toCamelStart(n)
				+ "().toString().trim().isEmpty()) {";
		s += "\n\t\t\tthrow new IllegalArgumentException(\"QUERY: Se esperaba un valor para el campo \" + " + m
				+ "Filtro.class.getCanonicalName() + \"." + n + " para filtrar la consulta\");";
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
					java += sc + buildRequired(clazzX.getNamePlural(), arg.getName() + "To");

				}

			} else if (arg.isDate()) {

				if (arg.getRange() == false) {

					java += sc + buildRequired(clazzX.getNamePlural(), arg.getName());

				} else {

					java += sc + buildRequired(clazzX.getNamePlural(), arg.getName() + "From");
					java += sc + buildRequired(clazzX.getNamePlural(), arg.getName() + "To");
				}

			} else if (arg.isTimestamp()) {

				if (arg.getRange() == false) {

					java += sc + buildRequired(clazzX.getNamePlural(), arg.getName());

				} else {

					java += sc + buildRequired(clazzX.getNamePlural(), arg.getName() + "From");
					java += sc + buildRequired(clazzX.getNamePlural(), arg.getName() + "To");

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

}
