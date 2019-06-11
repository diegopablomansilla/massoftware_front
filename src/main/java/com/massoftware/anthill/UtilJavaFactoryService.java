package com.massoftware.anthill;

import java.util.List;

public class UtilJavaFactoryService {

	public static String toJava(List<Clazz> clazzList) {

		String java = "";

		java += "package com.massoftware.service;\n";

		for (Clazz clazz : clazzList) {
			java += toJavaIport(clazz);
		}
		java += "\n";
		java += "\n\npublic abstract class AbstractFactoryService {";
		java += "\n";
		for (Clazz clazz : clazzList) {
			java += toJava(clazz);
		}

		java += "\n\n}";

		return java;
	}

	private static String toJavaIport(Clazz clazz) {
		String java = "";

		java += "\n";

		java += "import com.massoftware.service." + clazz.getNamePackage() + "." + clazz.getName() + "Service;";

		return java;
	}

	private static String toJava(Clazz clazz) {
		String java = "";

		java += "\n";
		java += "\t";

		java += "public " + clazz.getName() + "Service build" + clazz.getName() + "Service() throws Exception {";

		java += "\n";

		java += "\t";
		java += "\t";
		java += "return new " + clazz.getName() + "Service();";

		java += "\n";
		java += "\t";
		java += "}";

		java += "\n";

		return java;
	}

}
