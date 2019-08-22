package com.anthill.model.to_java;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.net.URL;

import com.anthill.model.Argument;
import com.anthill.model.Att;
import com.anthill.model.Clazz;

public class UtilJavaDao {

	private static String toCamelStart(String text) {
		if (text == null || text.isEmpty()) {
			return text;
		}

		return text.substring(0, 1).toUpperCase() + text.substring(1, text.length());
	}

	public static String toJavaDao(Clazz clazzX) throws IOException {

		String java = "";

		String linea;
		String source = "";

		ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
		URL url = classLoader.getResource("dao.txt");
		String path = url.toString().substring(6, url.toString().length());

		FileReader f = new FileReader(path);
		BufferedReader b = new BufferedReader(f);
		while ((linea = b.readLine()) != null) {
			source += "\n" + linea;

		}
		b.close();

		source = source.replaceAll("@NAME_PACKAGE@", clazzX.getNamePackage());
		source = source.replaceAll("@NAME_PLURAL@", clazzX.getNamePlural());

		String atts = "";
		for (Att att : clazzX.getAttsGrid()) {

			atts += "\n\t\t\t\t";

			if (att.isDate()) {

				atts += "objRow.set" + toCamelStart(att.getName()) + "((" + att.getDataType().getName()
						+ ") row[++c]);";

			} else if (att.isTimestamp()) {

				atts += "objRow.set" + toCamelStart(att.getName()) + "((" + att.getDataType().getName()
						+ ") row[++c]);";

			} else {
				atts += "objRow.set" + toCamelStart(att.getName()) + "((" + att.getDataType().getNameJava()
						+ ") row[++c]);";
			}

		}

		source = source.replaceAll("@ATTS@", atts);

		java += source;

		return java;
	}

}
