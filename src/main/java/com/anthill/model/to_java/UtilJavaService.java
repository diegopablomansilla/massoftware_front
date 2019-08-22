package com.anthill.model.to_java;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.net.URL;

import com.anthill.model.Clazz;

public class UtilJavaService {

//	private static String toCamelStart(String text) {
//		if (text == null || text.isEmpty()) {
//			return text;
//		}
//
//		return text.substring(0, 1).toUpperCase() + text.substring(1, text.length());
//	}

	public static String toJava(Clazz clazzX) throws IOException {

		String java = "";

		String linea;
		String source = "";

		ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
		URL url = classLoader.getResource("service.txt");
		String path = url.toString().substring(6, url.toString().length());

		FileReader f = new FileReader(path);
		BufferedReader b = new BufferedReader(f);
		while ((linea = b.readLine()) != null) {
			source += "\n" + linea;
		}
		b.close();

		source = source.replaceAll("@NAME_PACKAGE@", clazzX.getNamePackage());
		source = source.replaceAll("@NAME_PLURAL@", clazzX.getNamePlural());
		source = source.replaceAll("@NAME@", clazzX.getName());

		java += source;

		return java;
	}

}
