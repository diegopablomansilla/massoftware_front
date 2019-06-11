package com.massoftware.anthill;

import java.util.List;

public class UtilJavaFactoryWidget {

	public static String toJava(List<Clazz> clazzList) {

		String java = "";

		java += "package com.massoftware.x;\n";

		for (Clazz clazz : clazzList) {
			java += toJavaIport(clazz);
		}
		java += "\n";
		java += "\n\npublic abstract class AbstractFactoryWidget {";
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
		java += "import com.massoftware.service." + clazz.getNamePackage() + "." + clazz.getName() + "Filtro;";
		java += "\n";
		java += "import com.massoftware.x." + clazz.getNamePackage() + ".WL" + clazz.getName() + ";";
		java += "\n";
		java += "import com.massoftware.x." + clazz.getNamePackage() + ".WF" + clazz.getName() + ";";

		return java;
	}

	private static String toJava(Clazz clazz) {
		String java = "";

		java += "\n\n\t// -------------------------------------------------------------------------";
		
		java += "\n";
		java += "\t";

		java += "public WL" + clazz.getName() + " buildWL" + clazz.getName() + "() throws Exception {";

		java += "\n";

		java += "\t";
		java += "\t";
		java += "return new WL" + clazz.getName() + "();";

		java += "\n";
		java += "\t";
		java += "}";

		////////

		java += "\n";
		java += "\t";

		java += "public WL" + clazz.getName() + " buildWL" + clazz.getName() + "(" + clazz.getName()
				+ "Filtro filtro) throws Exception {";

		java += "\n";

		java += "\t";
		java += "\t";
		java += "return new WL" + clazz.getName() + "(filtro);";

		java += "\n";
		java += "\t";
		java += "}";

		//////////////////////

		java += "\n";
		java += "\t";

		java += "public WF" + clazz.getName() + " buildWF" + clazz.getName()
				+ "(String mode, String id) throws Exception {";

		java += "\n";

		java += "\t";
		java += "\t";
		java += "return new WF" + clazz.getName() + "(mode, id);";

		java += "\n";
		java += "\t";
		java += "}";

		// public WLClasificacionClienteCustom buildWLClasificacionCliente() throws
		// Exception {
		// return new WLClasificacionClienteCustom();
		// }

		// public WFClasificacionCliente buildWFClasificacionCliente(String mode, String
		// id) throws Exception {
		// return new WFClasificacionCliente(mode, id);
		// }

		// public WLClasificacionClienteCustom
		// buildWLClasificacionCliente(ClasificacionClienteFiltro filtro)
		// throws Exception {
		// return new WLClasificacionClienteCustom(filtro);
		// }

		return java;
	}

}
