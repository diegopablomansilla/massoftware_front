package com.anthill.model.to_java;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.net.URL;

import com.anthill.model.Argument;
import com.anthill.model.Att;
import com.anthill.model.Clazz;

public class UtilJavaUIGrid {

	private static String toCamelStart(String text) {
		if (text == null || text.isEmpty()) {
			return text;
		}

		return text.substring(0, 1).toUpperCase() + text.substring(1, text.length());
	}

	public static String toJava(Clazz clazzX) throws IOException {

		String java = "";

		String linea;
		String source = "";

		ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
		URL url = classLoader.getResource("grid.txt");
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
		source = source.replaceAll("@NAME_VIEW@", clazzX.getNamePlural().toLowerCase());
		source = source.replaceAll("@NAME@", clazzX.getName());
		source = source.replaceAll("@LABEL@", clazzX.getSingular());

		String atts = "";
		for (int i = 0; i < clazzX.getAttsGrid().size(); i++) {

			Att att = clazzX.getAttsGrid().get(i);

			if (att.isBoolean()) {
				atts += "\n";
				atts += "\t";
				atts += "\t";
				atts += "addColumn(new ComponentRenderer<>(this::createRenderer" + toCamelStart(att.getName()) + "))";
				atts += "\n";
				atts += "\t";
				atts += "\t";
				atts += "\t";
				atts += ".setKey(\"" + att.getName() + "\")";
				atts += "\n";
				atts += "\t";
				atts += "\t";
				atts += "\t";
				atts += ".setResizable(true)";
				atts += "\n";
				atts += "\t";
				atts += "\t";
				atts += "\t";
				atts += ".setSortProperty(\"" + (i + 2) + "\")";
				atts += "\n";
				atts += "\t";
				atts += "\t";
				atts += "\t";
				atts += ".setHeader(\"" + att.getLabel() + "\");";
				atts += "\n";
			} else {
				atts += "\n";
				atts += "\t";
				atts += "\t";
				atts += "addColumn(" + clazzX.getNamePlural() + "::get" + toCamelStart(att.getName()) + ", \""
						+ att.getName() + "\")";
				atts += "\n";
				atts += "\t";
				atts += "\t";
				atts += "\t";
				atts += ".setKey(\"" + att.getName() + "\")";
				atts += "\n";
				atts += "\t";
				atts += "\t";
				atts += "\t";
				atts += ".setResizable(true)";
				atts += "\n";
				atts += "\t";
				atts += "\t";
				atts += "\t";
				atts += ".setSortProperty(\"" + (i + 2) + "\")";
				atts += "\n";
				atts += "\t";
				atts += "\t";
				atts += "\t";
				atts += ".setHeader(\"" + att.getLabel() + "\");";
				atts += "\n";
			}

		}

		String renders = "";
		for (int i = 0; i < clazzX.getAttsGrid().size(); i++) {

			Att att = clazzX.getAttsGrid().get(i);

			if (att.isBoolean()) {
				renders += "\n";
				renders += "\t";
				renders += "private Component createRenderer" + toCamelStart(att.getName()) + "("
						+ clazzX.getNamePlural() + " item) {";
				renders += "\n";
				renders += "\t";
				renders += "\t";
				renders += "return (item.get" + toCamelStart(att.getName())
						+ "() == true) ? UIUtils.createPrimaryIcon(VaadinIcon.CHECK) : UIUtils.createDisabledIcon(VaadinIcon.CLOSE);";
				renders += "\n";
				renders += "\t";
				renders += "}";

			}

		}

		source = source.replaceAll("@ATTS@", atts);
		source = source.replaceAll("@RENDER@", renders);
		source = source.replaceAll("@REQUIRED_A@", buildCheck(true, clazzX));
		source = source.replaceAll("@REQUIRED_B@", buildCheck(false, clazzX));

		java += source;

		return java;
	}
	
	private static String buildCheck(boolean a, Clazz clazzX) {
		String java = "";

		for (int i = 0; i < clazzX.getArgs().size(); i++) {

			Argument arg = clazzX.getArgs().get(i);

			if (arg.isRequired() == false) {
				continue;
			}

			String sc = "\n\t";

			if (arg.isNumber()) {

				if (arg.getRange() == false) {

					java += sc + buildRequired(a, clazzX.getNamePlural(), arg.getName());

				} else {

					java += sc + buildRequired(a, clazzX.getNamePlural(), arg.getName() + "From");
					java += sc + buildRequired(a, clazzX.getNamePlural(), arg.getName() + "To");

				}

			} else if (arg.isDate()) {

				if (arg.getRange() == false) {

					java += sc + buildRequired(a, clazzX.getNamePlural(), arg.getName());

				} else {

					java += sc + buildRequired(a, clazzX.getNamePlural(), arg.getName() + "From");
					java += sc + buildRequired(a, clazzX.getNamePlural(), arg.getName() + "To");
				}

			} else if (arg.isTimestamp()) {

				if (arg.getRange() == false) {

					java += sc + buildRequired(a, clazzX.getNamePlural(), arg.getName());

				} else {

					java += sc + buildRequired(a, clazzX.getNamePlural(), arg.getName() + "From");
					java += sc + buildRequired(a, clazzX.getNamePlural(), arg.getName() + "To");

				}

			} else if (arg.isString()) {

				java += sc + buildRequired(a, clazzX.getNamePlural(), arg.getName());

			} else if (arg.isBoolean()) {

				java += sc + buildRequired(a, clazzX.getNamePlural(), arg.getName());

			} else if (arg.isSimple() == false) {

				java += sc + buildRequired(a, clazzX.getNamePlural(), arg.getName());
			}
		}

		java += "\n";

		return java;
	}
	
	private static String buildRequired(boolean a, String m, String n) {
		String s = "";

		s += "\n\t\t\tif (filter.get" + toCamelStart(n) + "() == null || filter.get" + toCamelStart(n)
				+ "().toString().trim().isEmpty()) {";
		
		if(a) {
			s += "\n\t\t\t\treturn 0;";
		} else {
			s += "\n\t\t\t\treturn new ArrayList<" + m + ">();";	
		}
		
		
		s += "\n\t\t\t}";

		return s;
	}

}
