package com.massoftware.anthill;

import java.util.ArrayList;
import java.util.List;

public class UtilJavaService {

	private static String toCamelStart(String text) {
		if (text == null || text.isEmpty()) {
			return text;
		}

		return text.substring(0, 1).toUpperCase() + text.substring(1, text.length());
	}

	public static String toJava(Clazz clazzX) {

		String java = "package com.massoftware.service." + clazzX.getNamePackage() + ";";

		java += "\n\nimport java.util.List;";
		java += "\nimport java.util.ArrayList;";
		java += "\nimport java.util.UUID;";
		String tmp = toFindCodeOrDecsriptionImport(clazzX);
		if (tmp != null) {
			java += tmp;
		}
		java += "\nimport com.massoftware.backend.BackendContextPG;";
		java += "\nimport com.massoftware.model.EntityId;";
		java += "\nimport com.massoftware.model." + clazzX.getNamePackage() + "." + clazzX.getName() + ";";

		java += "\n\npublic class " + clazzX.getName() + "Service {";

		java += "\n\n\tprivate int levelDefault = " + UtilJavaPOJO.buildMapperDefaultLevel(clazzX) + ";";

		java += toInsert(clazzX);
		java += toUpdate(clazzX);
		java += toDelete(clazzX);
		java += toIfExits(clazzX);
		java += toNextValue(clazzX);
		java += toCount(clazzX);
		java += toFindCodeOrDecsription(clazzX);
		java += toFindById(clazzX);
		java += toFind(clazzX);
		java += buildMapper(clazzX);

		java += "\n\n} // END CLASS ----------------------------------------------------------------------------------------------------------";

		return java;
	}

	private static String toFindCodeOrDecsriptionImport(Clazz clazz) {

		if (clazz.getArgsSBX().size() > 0) {
			Argument argument = clazz.getArgsSBX().get(0);

			if (argument.isInteger()) {
				return "\nimport com.massoftware.UtilNumeric;";
			} else if (argument.isLong()) {
				return "\nimport com.massoftware.UtilNumeric;";
			} else if (argument.isDouble()) {
				return "\nimport com.massoftware.UtilNumeric;";
			} else if (argument.isBigDecimal()) {
				return "\nimport com.massoftware.UtilNumeric;";
			} else if (argument.isSimple() == false) {
				DataTypeClazz dt = (DataTypeClazz) argument.getDataType();
				return "\nimport com.massoftware.model." + dt.getClazz().getNamePackage() + "."
						+ dt.getClazz().getName() + ";";
			}

			if (clazz.getArgsSBX().size() > 1) {

				argument = clazz.getArgsSBX().get(1);

				if (argument.isInteger()) {
					return "\nimport com.massoftware.UtilNumeric;";
				} else if (argument.isLong()) {
					return "\nimport com.massoftware.UtilNumeric;";
				} else if (argument.isDouble()) {
					return "\nimport com.massoftware.UtilNumeric;";
				} else if (argument.isBigDecimal()) {
					return "\nimport com.massoftware.UtilNumeric;";
				} else if (argument.isSimple() == false) {
					DataTypeClazz dt = (DataTypeClazz) argument.getDataType();
					return "\nimport com.massoftware.model." + dt.getClazz().getNamePackage() + "."
							+ dt.getClazz().getName() + ";";
				}

			}

		}

		return null;
	}

	private static String toFindCodeOrDecsription(Clazz clazz) {
		String java = "";

		// if (clazz.getArgsSBX().size() > 0) {

		java += "\n\n\t// ---------------------------------------------------------------------------------------------------------------------------\n";

		String arg1 = toCamelStart(clazz.getArgsSBX().get(0).getName());
		String arg2 = "";
		if (clazz.getArgsSBX().size() > 1) {
			arg2 = "Or" + toCamelStart(clazz.getArgsSBX().get(1).getName());
		}

		String l1 = "\n\n\t\t";
		String l2 = "\n\n\t\t\t";

		java += "\n\n\t" + "public List<" + clazz.getName() + "> findBy" + arg1 + arg2
				+ "(String arg) throws Exception {";

		arg2 = arg2.replaceFirst("Or", "");

		java += "\n";
		java += l1 + "if (arg == null || arg.trim().length() == 0) {";

		if (clazz.getArgsSBX().size() > 1) {
			java += l2 + "throw new IllegalArgumentException(\"Se esperaba un arg (" + clazz.getName() + "."
					+ clazz.getArgsSBX().get(0).getName() + " o " + clazz.getName() + "."
					+ clazz.getArgsSBX().get(1).getName() + ") no nulo/vacio.\");";
		} else {
			java += l2 + "throw new IllegalArgumentException(\"Se esperaba un arg (" + clazz.getName() + "."
					+ clazz.getArgsSBX().get(0).getName() + ") no nulo/vacio.\");";
		}

		java += l1 + "}";

		java += "\n";
		java += l1 + "arg = arg.trim();";

		Argument argument = clazz.getArgsSBX().get(0);
		String argName = arg1;

		java += "\n";
		java += l1 + "//------------ buscar por " + argument.getLabel();

		String l = l1;

		if (argument.isInteger()) {
			java += l1 + "if(UtilNumeric.isInteger(arg)) {";
			l = l2;
		} else if (argument.isLong()) {
			java += l1 + "if(UtilNumeric.isLong(arg)) {";
			l = l2;
		} else if (argument.isDouble()) {
			java += l1 + "if(UtilNumeric.isDouble(arg)) {";
			l = l2;
		} else if (argument.isBigDecimal()) {
			java += l1 + "if(UtilNumeric.isBigDecimal(arg)) {";
			l = l2;
		}

		java += l + clazz.getName() + "Filtro filtro" + argName + " = new " + clazz.getName() + "Filtro();";
		java += l + "filtro" + argName + ".setUnlimited(true);";

		if (argument.isSimple() == false) {

			java += l + argument.getDataType().getName() + " obj = new " + argument.getDataType().getName() + "();";
			java += l + "obj.setId(arg);";
			java += l + "filtro" + argName + ".set" + argName + "(obj);";

		} else if (argument.isString()) {

			java += l + "filtro" + argName + ".set" + argName + "(arg);";

		} else if (argument.isBoolean()) {

			java += l + "filtro" + argName + ".set" + argName + "(new Boolean(arg));";

		} else if (argument.isInteger()) {

			if (argument.getRange() == false) {
				java += l + "filtro" + argName + ".set" + argName + "(new Integer(arg));";
			} else {
				java += l + "filtro" + argName + ".set" + argName + "From(new Integer(arg));";
				java += l + "filtro" + argName + ".set" + argName + "To(new Integer(arg));";
			}

		} else if (argument.isLong()) {

			if (argument.getRange() == false) {
				java += l + "filtro" + argName + ".set" + argName + "(new Long(arg));";
			} else {
				java += l + "filtro" + argName + ".set" + argName + "From(new Long(arg));";
				java += l + "filtro" + argName + ".set" + argName + "To(new Long(arg));";
			}

		} else if (argument.isDouble()) {

			if (argument.getRange() == false) {
				java += l + "filtro" + argName + ".set" + argName + "(new Double(arg));";
			} else {
				java += l + "filtro" + argName + ".set" + argName + "From(new Double(arg));";
				java += l + "filtro" + argName + ".set" + argName + "To(new Double(arg));";
			}

		} else if (argument.isBigDecimal()) {

			if (argument.getRange() == false) {
				java += l + "filtro" + argName + ".set" + argName + "(new java.math.BigDecimal(arg));";
			} else {
				java += l + "filtro" + argName + ".set" + argName + "From(new java.math.BigDecimal(arg));";
				java += l + "filtro" + argName + ".set" + argName + "To(new java.math.BigDecimal(arg));";
			}

		} else if (argument.isDate()) {

			if (argument.getRange() == false) {
				java += l + "filtro" + argName + ".set" + argName + "(new java.util.Date(arg));";
			} else {
				java += l + "filtro" + argName + ".set" + argName + "From(new java.util.Date(arg));";
				java += l + "filtro" + argName + ".set" + argName + "To(new java.util.Date(arg));";
			}

		} else if (argument.isTimestamp()) {

			if (argument.getRange() == false) {
				java += l + "filtro" + argName + ".set" + argName + "(new java.sql.Timestamp(arg));";
			} else {
				java += l + "filtro" + argName + ".set" + argName + "From(new java.sql.Timestamp(arg));";
				java += l + "filtro" + argName + ".set" + argName + "To(new java.sql.Timestamp(arg));";
			}
		}

		java += l + "List<" + clazz.getName() + "> listado" + argName + " = find(filtro" + argName + ");";
		java += l + "if(listado" + argName + ".size() > 0) {";
		java += l + "\t" + "return listado" + argName + ";";
		java += l + "}";

		if (argument.isInteger()) {
			java += l1 + "}";
		} else if (argument.isLong()) {
			java += l1 + "}";
		} else if (argument.isDouble()) {
			java += l1 + "}";
		} else if (argument.isBigDecimal()) {
			java += l1 + "}";
		}

		if (clazz.getArgsSBX().size() > 1) {

			argument = clazz.getArgsSBX().get(1);
			argName = arg2;

			java += "\n";
			java += l1 + "//------------ buscar por " + argument.getLabel();

			l = l1;

			if (argument.isInteger()) {
				java += l1 + "if(UtilNumeric.isInteger(arg)) {";
				l = l2;
			} else if (argument.isLong()) {
				java += l1 + "if(UtilNumeric.isLong(arg)) {";
				l = l2;
			} else if (argument.isDouble()) {
				java += l1 + "if(UtilNumeric.isDouble(arg)) {";
				l = l2;
			} else if (argument.isBigDecimal()) {
				java += l1 + "if(UtilNumeric.isBigDecimal(arg)) {";
				l = l2;
			}

			java += l + clazz.getName() + "Filtro filtro" + argName + " = new " + clazz.getName() + "Filtro();";
			java += l + "filtro" + argName + ".setUnlimited(true);";

			if (argument.isSimple() == false) {
				java += l + argument.getDataType().getName() + "obj = new " + argument.getDataType().getName() + "();";
				java += l + "obj.setId(arg);";
				java += l + "filtro" + argName + ".set" + argName + "(obj);";
			} else if (argument.isString()) {
				java += l + "filtro" + argName + ".set" + argName + "(arg);";
			} else if (argument.isBoolean()) {
				java += l + "filtro" + argName + ".set" + argName + "(new Boolean(arg));";
			} else if (argument.isInteger()) {

				if (argument.getRange() == false) {
					java += l + "filtro" + argName + ".set" + argName + "(new Integer(arg));";
				} else {
					java += l + "filtro" + argName + ".set" + argName + "From(new Integer(arg));";
					java += l + "filtro" + argName + ".set" + argName + "To(new Integer(arg));";
				}

			} else if (argument.isLong()) {

				if (argument.getRange() == false) {
					java += l + "filtro" + argName + ".set" + argName + "(new Long(arg));";
				} else {
					java += l + "filtro" + argName + ".set" + argName + "From(new Long(arg));";
					java += l + "filtro" + argName + ".set" + argName + "To(new Long(arg));";
				}

			} else if (argument.isDouble()) {

				if (argument.getRange() == false) {
					java += l + "filtro" + argName + ".set" + argName + "(new Double(arg));";
				} else {
					java += l + "filtro" + argName + ".set" + argName + "From(new Double(arg));";
					java += l + "filtro" + argName + ".set" + argName + "To(new Double(arg));";
				}

			} else if (argument.isBigDecimal()) {

				if (argument.getRange() == false) {
					java += l + "filtro" + argName + ".set" + argName + "(new java.math.BigDecimal(arg));";
				} else {
					java += l + "filtro" + argName + ".set" + argName + "From(new java.math.BigDecimal(arg));";
					java += l + "filtro" + argName + ".set" + argName + "To(new java.math.BigDecimal(arg));";
				}

			} else if (argument.isDate()) {

				if (argument.getRange() == false) {
					java += l + "filtro" + argName + ".set" + argName + "(new java.util.Date(arg));";
				} else {
					java += l + "filtro" + argName + ".set" + argName + "From(new java.util.Date(arg));";
					java += l + "filtro" + argName + ".set" + argName + "To(new java.util.Date(arg));";
				}

			} else if (argument.isTimestamp()) {

				if (argument.getRange() == false) {
					java += l + "filtro" + argName + ".set" + argName + "(new java.sql.Timestamp(arg));";
				} else {
					java += l + "filtro" + argName + ".set" + argName + "From(new java.sql.Timestamp(arg));";
					java += l + "filtro" + argName + ".set" + argName + "To(new java.sql.Timestamp(arg));";
				}
			}

			java += l + "List<" + clazz.getName() + "> listado" + argName + " = find(filtro" + argName + ");";
			java += l + "if(listado" + argName + ".size() > 0) {";
			java += l + "\t" + "return listado" + argName + ";";
			java += l + "}";

			if (argument.isInteger()) {
				java += l1 + "}";
			} else if (argument.isLong()) {
				java += l1 + "}";
			} else if (argument.isDouble()) {
				java += l1 + "}";
			} else if (argument.isBigDecimal()) {
				java += l1 + "}";
			}

		}

		java += "\n";
		java += l1 + "return new ArrayList<" + clazz.getName() + ">();";
		java += "\n\n\t" + "}";

		// }

		return java;
	}

	private static String toInsert(Clazz clazzX) {
		String java = "";

		java += "\n\n\t// ---------------------------------------------------------------------------------------------------------------------------\n";

		java += "\n\n\tpublic String insert(" + clazzX.getName() + " obj) throws Exception {";

		java += "\n\n\t\tif(obj == null){";

		java += "\n\n\t\t\tthrow new IllegalArgumentException(\"Se esperaba un objeto " + clazzX.getName()
				+ " no nulo.\");";

		java += "\n\n\t\t}";

		java += "\n";

		String args = "\n\t\tObject id = UUID.randomUUID().toString();";

		for (int i = 0; i < clazzX.getAtts().size(); i++) {

			Att att = clazzX.getAtts().get(i);

			String sc = "\n\t\t";

			String n = "obj.get" + toCamelStart(att.getName()) + "()";

			if (att.isSimple()) {

				args += sc + "Object " + att.getName() + " = ( " + n + " == null ) ? "
						+ att.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

			} else {

				args += sc + "Object " + att.getName() + " = ( " + n + " != null && " + n + ".getId() != null) ? " + n
						+ ".getId() : String.class;";

			}
		}

		java += "\n";

		java += args;

		java += "\n";

		args = "";

		for (int i = 0; i < clazzX.getAtts().size(); i++) {

			args += ", ?";
		}

		java += "\n\t\tString sql = \"SELECT * FROM massoftware.i_" + clazzX.getName() + "(?" + args + ")\";";

		java += "\n";

		args = "id";

		for (int i = 0; i < clazzX.getAtts().size(); i++) {

			Att att = clazzX.getAtts().get(i);

			args += ", " + att.getName();
		}

		java += "\n\t\tObject[] args = new Object[] {" + args + "};";

		java += "\n\n\t\tObject[][] table = BackendContextPG.get().find(sql, args);";

		java += "\n\n\t\tif(table.length == 1){";

		java += "\n\n\t\t\tObject[] row = table[0];";

		java += "\n\n\t\t\tif(row.length == 1){";

		java += "\n\n\t\t\t\tBoolean ok = (Boolean) row[0];";

		java += "\n\n\t\t\t\tif(ok){";

		java += "\n\n\t\t\t\t\treturn id.toString();";

		java += "\n\n\t\t\t\t} else { ";

		java += "\n\n\t\t\t\t\tthrow new IllegalStateException(\"No se esperaba que la sentencia no insertara en la base de datos.\");";

		java += "\n\n\t\t\t\t}";

		java += "\n\n\t\t\t} else {";

		java += "\n\n\t\t\t\tthrow new IllegalStateException(\"No se esperaba que la consulta a la base de datos devuelva \" + row.length + \" columnas.\");";

		java += "\n\n\t\t\t}";

		java += "\n\n\t\t} else {";

		java += "\n\n\t\t\tthrow new IllegalStateException(\"No se esperaba que la consulta a la base de datos devuelva \" + table.length + \" filas.\");";

		java += "\n\n\t\t}";

		// java += "\n\n\t\treturn null;";

		java += "\n\n\t}";

		return java;
	}

	private static String toUpdate(Clazz clazzX) {
		String java = "";

		java += "\n\n\t// ---------------------------------------------------------------------------------------------------------------------------\n";

		java += "\n\n\tpublic String update(" + clazzX.getName() + " obj) throws Exception {";

		java += "\n\n\t\tif(obj == null){";

		java += "\n\n\t\t\tthrow new IllegalArgumentException(\"Se esperaba un objeto " + clazzX.getName()
				+ " no nulo.\");";

		java += "\n\n\t\t}";

		java += "\n";

		java += "\n\n\t\tif(obj.getId() == null || obj.getId().trim().length() == 0){";

		java += "\n\n\t\t\tthrow new IllegalArgumentException(\"Se esperaba un objeto " + clazzX.getName()
				+ " con id no nulo/vacio.\");";

		java += "\n\n\t\t}";

		java += "\n";

		String args = "\n\t\tObject id = ( obj.getId() == null ) ? String.class : obj.getId();";

		for (int i = 0; i < clazzX.getAtts().size(); i++) {

			Att att = clazzX.getAtts().get(i);

			String sc = "\n\t\t";

			String n = "obj.get" + toCamelStart(att.getName()) + "()";

			if (att.isSimple()) {

				args += sc + "Object " + att.getName() + " = ( " + n + " == null ) ? "
						+ att.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

			} else {

				args += sc + "Object " + att.getName() + " = ( " + n + " != null && " + n + ".getId() != null) ? " + n
						+ ".getId() : String.class;";

			}
		}

		java += "\n";

		java += args;

		java += "\n";

		args = "";

		for (int i = 0; i < clazzX.getAtts().size(); i++) {

			args += ", ?";
		}

		java += "\n\t\tString sql = \"SELECT * FROM massoftware.u_" + clazzX.getName() + "(?" + args + ")\";";

		java += "\n";

		args = "id";

		for (int i = 0; i < clazzX.getAtts().size(); i++) {

			Att att = clazzX.getAtts().get(i);

			args += ", " + att.getName();
		}

		java += "\n\t\tObject[] args = new Object[] {" + args + "};";

		java += "\n\n\t\tObject[][] table = BackendContextPG.get().find(sql, args);";

		java += "\n\n\t\tif(table.length == 1){";

		java += "\n\n\t\t\tObject[] row = table[0];";

		java += "\n\n\t\t\tif(row.length == 1){";

		java += "\n\n\t\t\t\tBoolean ok = (Boolean) row[0];";

		java += "\n\n\t\t\t\tif(ok){";

		java += "\n\n\t\t\t\t\treturn id.toString();";

		java += "\n\n\t\t\t\t} else { ";

		java += "\n\n\t\t\t\t\tthrow new IllegalStateException(\"No se esperaba que la sentencia no actualizara en la base de datos.\");";

		java += "\n\n\t\t\t\t}";

		java += "\n\n\t\t\t} else {";

		java += "\n\n\t\t\t\tthrow new IllegalStateException(\"No se esperaba que la consulta a la base de datos devuelva \" + row.length + \" columnas.\");";

		java += "\n\n\t\t\t}";

		java += "\n\n\t\t} else {";

		java += "\n\n\t\t\tthrow new IllegalStateException(\"No se esperaba que la consulta a la base de datos devuelva \" + table.length + \" filas.\");";

		java += "\n\n\t\t}";

		// java += "\n\n\t\treturn null;";

		java += "\n\n\t}";

		return java;
	}

	private static String toDelete(Clazz clazzX) {
		String java = "";

		java += "\n\n\t// ---------------------------------------------------------------------------------------------------------------------------\n";

		java += "\n\n\tpublic boolean deleteById(String id) throws Exception {";

		java += "\n";

		java += "\n\n\t\tif(id == null || id.trim().length() == 0){";

		java += "\n\n\t\t\tthrow new IllegalArgumentException(\"Se esperaba un id (" + clazzX.getName()
				+ ".id) no nulo/vacio.\");";

		java += "\n\n\t\t}";

		java += "\n";

		java += "\n\n\t\tid = id.trim();";

		java += "\n";

		java += "\n\t\tString sql = \"SELECT * FROM massoftware.d_" + clazzX.getName() + "ById(?)\";";

		java += "\n";

		java += "\n\t\tObject[] args = new Object[] {id};";

		java += "\n\n\t\tObject[][] table = BackendContextPG.get().find(sql, args);";

		java += "\n\n\t\tif(table.length == 1){";

		java += "\n\n\t\t\tObject[] row = table[0];";

		java += "\n\n\t\t\treturn row[0].equals(true);";

		java += "\n\n\t\t} else if(table.length > 1 ) {";

		java += "\n\n\t\t\tthrow new IllegalStateException(\"No se esperaba que la consulta a la base de datos devuelva \" + table.length + \" filas.\");";

		java += "\n\n\t\t}";

		java += "\n\n\t\treturn false;";

		java += "\n\n\t}";

		return java;
	}

	private static String toIfExits(Clazz clazzX) {
		String java = "";

		java += "\n\n\t// ---------------------------------------------------------------------------------------------------------------------------\n";

		for (Att att : clazzX.getAtts()) {

			if (att.isUnique()) {

				java += "\n\n\tpublic boolean isExists" + toCamelStart(att.getName()) + "("
						+ att.getDataType().getName().replace("java.lang.", "") + " arg) throws Exception {";

				java += "\n";

				java += "\n\n\t\tif(arg == null || arg.toString().trim().length() == 0){";

				java += "\n\n\t\t\tthrow new IllegalArgumentException(\"Se esperaba un arg (" + clazzX.getName() + "."
						+ att.getName() + ") no nulo/vacio.\");";

				java += "\n\n\t\t}";

				if (att.isString()) {
					java += "\n\n\t\targ = arg.trim();";
				}

				java += "\n";

				java += "\n\t\tString sql = \"SELECT * FROM massoftware.f_exists_" + clazzX.getName() + "_"
						+ att.getName() + "(?)\";";

				java += "\n";

				java += "\n\t\tObject[] args = new Object[] {arg};";

				java += "\n\n\t\tObject[][] table = BackendContextPG.get().find(sql, args);";

				java += "\n\n\t\tif(table.length == 1){";

				java += "\n\n\t\t\tObject[] row = table[0];";

				java += "\n\n\t\t\tif(row.length == 1){";

				// java += "\n\n\t\t\treturn (Long) row[0] > 0;";

				java += "\n\n\t\t\t\treturn (Boolean) row[0];";

				java += "\n\n\t\t\t} else { ";

				java += "\n\n\t\t\t\tthrow new IllegalStateException(\"No se esperaba que la consulta a la base de datos devuelva \" + row.length + \" columnas.\");";

				java += "\n\n\t\t\t}";

				// java += "\n\n\t\t} else if(table.length > 1 ) {";
				java += "\n\n\t\t} else {";

				java += "\n\n\t\t\tthrow new IllegalStateException(\"No se esperaba que la consulta a la base de datos devuelva \" + table.length + \" filas.\");";

				java += "\n\n\t\t}";

				// java += "\n\n\t\treturn false;";

				java += "\n\n\t}";

			}
		}

		return java;
	}

	private static String toNextValue(Clazz clazzX) {
		String java = "";

		java += "\n\n\t// ---------------------------------------------------------------------------------------------------------------------------\n";

		for (Att att : clazzX.getAtts()) {

			if (att.isNumber()) {

				java += "\n\n\tpublic " + att.getDataType().getName().replace("java.lang.", "") + " nextValue"
						+ toCamelStart(att.getName()) + "() throws Exception {";

				java += "\n";

				java += "\n\t\tString sql = \"SELECT * FROM massoftware.f_next_" + clazzX.getName() + "_"
						+ att.getName() + "()\";";

				java += "\n";

				java += "\n\t\tObject[] args = new Object[] {};";

				java += "\n\n\t\tObject[][] table = BackendContextPG.get().find(sql, args);";

				java += "\n\n\t\tif(table.length == 1){";

				java += "\n\n\t\t\tObject[] row = table[0];";

				java += "\n\n\t\t\treturn (" + att.getDataType().getName().replace("java.lang.", "") + ") row[0];";

				// java += "\n\n\t\t} else if(table.length > 1 ) {";
				java += "\n\n\t\t} else {";

				java += "\n\n\t\t\tthrow new IllegalStateException(\"No se esperaba que la consulta a la base de datos devuelva \" + table.length + \" filas.\");";

				java += "\n\n\t\t}";

				// java += "\n\n\t\treturn false;";

				java += "\n\n\t}";

			}
		}

		return java;
	}

	private static String toCount(Clazz clazzX) {
		String java = "";

		java += "\n\n\t// ---------------------------------------------------------------------------------------------------------------------------\n";

		java += "\n\n\tpublic Long count() throws Exception {";

		java += "\n";

		java += "\n\t\tString sql = \"SELECT COUNT(*) FROM massoftware." + clazzX.getName() + ";\";";

		java += "\n";

		java += "\n\t\tObject[] args = new Object[] {};";

		java += "\n\n\t\tObject[][] table = BackendContextPG.get().find(sql, args);";

		java += "\n\n\t\tif(table.length == 1){";

		java += "\n\n\t\t\tObject[] row = table[0];";

		java += "\n\n\t\t\treturn (Long) row[0];";

		java += "\n\n\t\t} else {";

		java += "\n\n\t\t\tthrow new IllegalStateException(\"No se esperaba que la consulta a la base de datos devuelva \" + table.length + \" filas.\");";

		java += "\n\n\t\t}";

		// java += "\n\n\t\treturn 0L;";

		java += "\n\n\t}";

		return java;
	}

	private static String toFindById(Clazz clazzX) {
		String java = "";

		java += "\n\n\t// ---------------------------------------------------------------------------------------------------------------------------\n";

		java += "\n\n\tpublic " + clazzX.getName() + " findById(String id) throws Exception {";

		java += "\n\n\t\treturn findById(id, levelDefault);";

		java += "\n\t}";

		java += "\n\n\t// ---------------------------------------------------------------------------------------------------------------------------\n";

		java += "\n\n\tpublic " + clazzX.getName() + " findById(String id, Integer level) throws Exception {";

		java += "\n";

		java += "\n\n\t\tif(id == null || id.trim().length() == 0){";

		java += "\n\n\t\t\tthrow new IllegalArgumentException(\"Se esperaba un id (" + clazzX.getName()
				+ ".id) no nulo/vacio.\");";

		java += "\n\n\t\t}";

		java += "\n";

		java += "\n\n\t\tid = id.trim();";

		java += "\n";

		java += "\n";
		java += "\n\t\t" + clazzX.getName() + " obj = null;";

		java += "\n";

		java += "\n\t\tlevel = (level == null || level < 0 || level > 3) ? levelDefault : level;";
		// java += "\n\t\tlevel = (level == null || level < 0) ? 4 : level;";
		// java += "\n\t\tlevel = (level != null && level > 3) ? levelDefault : level;";

		java += "\n";

		java += "\n\t\tString levelString = (level > 0) ? \"_\" + level : \"\";";

		java += "\n";

		java += "\n\t\tString sql = \"SELECT * FROM massoftware.f_" + clazzX.getName()
				+ "ById\" + levelString + \"(?)\";";

		java += "\n";

		java += "\n\t\tObject[] args = new Object[] {id};";

		java += "\n\n\t\tObject[][] table = BackendContextPG.get().find(sql, args);";

		java += "\n\n\t\tif(table.length == 1){";

		java += "\n\n\t\t\tObject[] row = table[0];";

		java += buildMapperIfById(clazzX);

		java += "\n\n\t\t} else if(table.length > 1 ) {";

		java += "\n\n\t\t\t\tthrow new IllegalStateException(\"No se esperaba que la consulta a la base de datos devuelva \" + table.length + \" filas.\");";

		java += "\n\n\t\t}";

		java += "\n\n\t\treturn null;";

		java += "\n\n\t}";

		return java;
	}

	private static String toFind(Clazz clazzX) {
		String java = "";

		java += "\n\n\t// ---------------------------------------------------------------------------------------------------------------------------\n";

		java += "\n\n\tpublic List<" + clazzX.getName() + "> find(" + clazzX.getName()
				+ "Filtro filtro) throws Exception {";

		java += "\n";
		java += "\n\t\tList<" + clazzX.getName() + "> listado = new ArrayList<" + clazzX.getName() + ">();";

		java += "\n";

		java += "\n\t\tString levelString = (filtro.getLevel() > 0) ? \"_\" + filtro.getLevel() : \"\";";

		/*
		 * // java += "\n\t\tString orderByString = (filtro.getOrderBy() == null) ? \"\"
		 * : // \"_\" + filtro.getOrderBy();"; java +=
		 * "\n\t\tString orderByString = (filtro.getOrderBy() == null || filtro.getOrderBy().equals(\"id\")) ? \"\" : \"_\" + filtro.getOrderBy();"
		 * ;
		 * 
		 * java += "\n\t\tString orderByASCString = \"\";"; java +=
		 * "\n\t\tif(orderByString != null && orderByString.trim().length() > 0) {";
		 * java += "\n"; java += "\n\t\t\torderByString = \"" + clazzX.getName() +
		 * "\" + orderByString;"; java += "\n\t\t\torderByASCString = \"_asc_\";"; java
		 * += "\n\t\t\tif(filtro.getOrderByDesc() == true) {"; java +=
		 * "\n\t\t\t\torderByASCString = \"_des_\";"; java += "\n\t\t\t}"; java +=
		 * "\n\t\t\torderByString = orderByASCString + orderByString;"; java +=
		 * "\n\t\t}";
		 */

		// java += "\n\t\t";

		// java += "\n\t\tString params = (filtro.getUnlimited() == true) ? \"\" : \"?,
		// ?, \";";
		// java += "\n\t\tString params = (filtro.getUnlimited() == true) ? \"\" : \"?,
		// ?";

		// boolean paramsCount = false;

		// for (int i = 0; i < clazzX.getArgs().size(); i++) {
		//
		// Argument arg = clazzX.getArgs().get(i);
		//
		// if (arg.getOnlyVisual() == true) {
		// continue;
		// }
		//
		// paramsCount = true;
		//
		// break;
		// }

		// if (paramsCount) {
		// java += ", \";";
		// } else {
		// java += "\";";
		// }

		java += "\n";

		java += "\n\t\tString sql = \"SELECT * FROM massoftware.f_" + clazzX.getName()
				+ "\" + levelString + \"(?, ?, ?, ?, ?, ";

		for (int i = 0; i < clazzX.getArgs().size(); i++) {

			Argument arg = clazzX.getArgs().get(i);

			if (arg.getOnlyVisual() == true) {
				continue;
			}

			if (arg.isNumber() || arg.isTimestamp() || arg.isDate()) {

				if (arg.getRange() == false) {

					java += (i == 0) ? "?" : ", ?";

				} else {
					java += (i == 0) ? "?" : ", ?";
					java += ", ?";
				}

			} else if (arg.isString()) {
				/////////////////////////////////////// **********************************************

				if (arg.getSearchOption().equals(Argument.EQUALS)) {

					java += (i == 0) ? "?" : ", ?";

				} else if (arg.getSearchOption().equals(Argument.EQUALS_TRASLATE)) {

					java += (i == 0) ? "?" : ", ?";

				} else if (arg.getSearchOption().equals(Argument.EQUALS_IGNORE_CASE)) {

					java += (i == 0) ? "?" : ", ?";

				} else if (arg.getSearchOption().equals(Argument.EQUALS_IGNORE_CASE_TRASLATE)) {

					java += (i == 0) ? "?" : ", ?";

				} else if (arg.getSearchOption().equals(Argument.STARTS_WITCH)) {

					java += (i == 0) ? "?" : ", ?";

				} else if (arg.getSearchOption().equals(Argument.STARTS_WITCH_TRASLATE)) {

					java += (i == 0) ? "?" : ", ?";

				} else if (arg.getSearchOption().equals(Argument.STARTS_WITCH_IGNORE_CASE)) {

					java += (i == 0) ? "?" : ", ?";

				} else if (arg.getSearchOption().equals(Argument.STARTS_WITCH_IGNORE_CASE_TRASLATE)) {

					java += (i == 0) ? "?" : ", ?";

				} else if (arg.getSearchOption().equals(Argument.ENDS_WITCH)) {

					java += (i == 0) ? "?" : ", ?";

				} else if (arg.getSearchOption().equals(Argument.ENDS_WITCH_TRASLATE)) {

					java += (i == 0) ? "?" : ", ?";

				} else if (arg.getSearchOption().equals(Argument.ENDS_WITCH_IGNORE_CASE)) {

					java += (i == 0) ? "?" : ", ?";

				} else if (arg.getSearchOption().equals(Argument.ENDS_WITCH_IGNORE_CASE_TRASLATE)) {

					java += (i == 0) ? "?" : ", ?";

				} else if (arg.getSearchOption().equals(Argument.CONTAINS)) {

					java += (i == 0) ? "?" : ", ?";

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_TRASLATE)) {

					java += (i == 0) ? "?" : ", ?";

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_IGNORE_CASE)) {

					java += (i == 0) ? "?" : ", ?";

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_IGNORE_CASE_TRASLATE)) {

					java += (i == 0) ? "?" : ", ?";

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_OR)) {

					java += (i == 0) ? "?" : ", ?";

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_OR_TRASLATE)) {

					java += (i == 0) ? "?" : ", ?";

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_OR_IGNORE_CASE)) {

					java += (i == 0) ? "?" : ", ?";

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_OR_IGNORE_CASE_TRASLATE)) {

					java += (i == 0) ? "?" : ", ?";

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_AND)) {

					java += (i == 0) ? "?" : ", ?";

					for (int j = 0; j < 4; j++) {

						// java += (i == 0) ? "?" : ", ?";
					}

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_AND_TRASLATE)) {

					java += (i == 0) ? "?" : ", ?";

					for (int j = 0; j < 4; j++) {

						java += (i == 0) ? "?" : ", ?";
					}

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_AND_IGNORE_CASE)) {

					java += (i == 0) ? "?" : ", ?";

					for (int j = 0; j < 4; j++) {

						// java += (i == 0) ? "?" : ", ?";
					}

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_AND_IGNORE_CASE_TRASLATE)) {

					java += (i == 0) ? "?" : ", ?";

					for (int j = 0; j < 4; j++) {

						// java += (i == 0) ? "?" : ", ?";
					}

				}

				/////////////////////////////////////// **********************************************
			} else {
				java += (i == 0) ? "?" : ", ?";
			}
		}

		java += ")\";";

		String args = "";

		for (int i = 0; i < clazzX.getArgs().size(); i++) {

			Argument arg = clazzX.getArgs().get(i);

			if (arg.getOnlyVisual() == true) {
				continue;
			}

			String sc = "\n\t\t";

			if (arg.isSimple()) {

				if (arg.isNumber() || arg.isTimestamp() || arg.isDate()) {

					if (arg.getRange() == false) {

						String n = "filtro.get" + toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

					} else {

						String n = "filtro.get" + toCamelStart(arg.getName()) + "From()";

						args += sc + "Object " + arg.getName() + "From = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

						n = "filtro.get" + toCamelStart(arg.getName()) + "To()";

						args += sc + "Object " + arg.getName() + "To = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";
					}

				} else if (arg.isString()) {

					/////////////////////////////////////// **********************************************

					if (arg.getSearchOption().equals(Argument.EQUALS)) {

						String n = "filtro.get" + toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

					} else if (arg.getSearchOption().equals(Argument.EQUALS_TRASLATE)) {

						String n = "filtro.get" + toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

					} else if (arg.getSearchOption().equals(Argument.EQUALS_IGNORE_CASE)) {

						String n = "filtro.get" + toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

					} else if (arg.getSearchOption().equals(Argument.EQUALS_IGNORE_CASE_TRASLATE)) {

						String n = "filtro.get" + toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

					} else if (arg.getSearchOption().equals(Argument.STARTS_WITCH)) {

						String n = "filtro.get" + toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

					} else if (arg.getSearchOption().equals(Argument.STARTS_WITCH_TRASLATE)) {

						String n = "filtro.get" + toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

					} else if (arg.getSearchOption().equals(Argument.STARTS_WITCH_IGNORE_CASE)) {

						String n = "filtro.get" + toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

					} else if (arg.getSearchOption().equals(Argument.STARTS_WITCH_IGNORE_CASE_TRASLATE)) {

						String n = "filtro.get" + toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

					} else if (arg.getSearchOption().equals(Argument.ENDS_WITCH)) {

						String n = "filtro.get" + toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

					} else if (arg.getSearchOption().equals(Argument.ENDS_WITCH_TRASLATE)) {

						String n = "filtro.get" + toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

					} else if (arg.getSearchOption().equals(Argument.ENDS_WITCH_IGNORE_CASE)) {

						String n = "filtro.get" + toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

					} else if (arg.getSearchOption().equals(Argument.ENDS_WITCH_IGNORE_CASE_TRASLATE)) {

						String n = "filtro.get" + toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

					} else if (arg.getSearchOption().equals(Argument.CONTAINS)) {

						String n = "filtro.get" + toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

					} else if (arg.getSearchOption().equals(Argument.CONTAINS_TRASLATE)) {

						String n = "filtro.get" + toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

					} else if (arg.getSearchOption().equals(Argument.CONTAINS_IGNORE_CASE)) {

						String n = "filtro.get" + toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

					} else if (arg.getSearchOption().equals(Argument.CONTAINS_IGNORE_CASE_TRASLATE)) {

						String n = "filtro.get" + toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

					} else if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_OR)) {

						String n = "filtro.get" + toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

					} else if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_OR_TRASLATE)) {

						String n = "filtro.get" + toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

					} else if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_OR_IGNORE_CASE)) {

						String n = "filtro.get" + toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

					} else if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_OR_IGNORE_CASE_TRASLATE)) {

						String n = "filtro.get" + toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

					} else if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_AND)) {

						String n = "filtro.get" + toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

						// String n = "filtro.get" + toCamelStart(arg.getName()) + "()";
						//
						// args += "\n" + sc + "String[] " + arg.getName() + "Words = ( " + n
						// + " == null ) ? new String[0] : " + n + ".split(\" \");";
						//
						// for (int j = 0; j < 5; j++) {
						//
						// args += sc + "Object " + arg.getName() + "Word" + j + " = ( " + arg.getName()
						// + "Words.length > " + j + " && " + arg.getName() + "Words[" + j
						// + "].trim().length() > 0) ? " + arg.getName() + "Words[" + j + "].trim() : "
						// + arg.getDataType().getName().replace("java.lang.", "") + ".class;";
						// }

					} else if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_AND_TRASLATE)) {

						String n = "filtro.get" + toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

						// String n = "filtro.get" + toCamelStart(arg.getName()) + "()";
						//
						// args += "\n" + sc + "String[] " + arg.getName() + "Words = ( " + n
						// + " == null ) ? new String[0] : " + n + ".split(\" \");";
						//
						// for (int j = 0; j < 5; j++) {
						//
						// args += sc + "Object " + arg.getName() + "Word" + j + " = ( " + arg.getName()
						// + "Words.length > " + j + " && " + arg.getName() + "Words[" + j
						// + "].trim().length() > 0) ? " + arg.getName() + "Words[" + j + "].trim() : "
						// + arg.getDataType().getName().replace("java.lang.", "") + ".class;";
						// }

					} else if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_AND_IGNORE_CASE)) {

						String n = "filtro.get" + toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

						// String n = "filtro.get" + toCamelStart(arg.getName()) + "()";
						//
						// args += "\n" + sc + "String[] " + arg.getName() + "Words = ( " + n
						// + " == null ) ? new String[0] : " + n + ".split(\" \");";
						//
						// for (int j = 0; j < 5; j++) {
						//
						// args += sc + "Object " + arg.getName() + "Word" + j + " = ( " + arg.getName()
						// + "Words.length > " + j + " && " + arg.getName() + "Words[" + j
						// + "].trim().length() > 0) ? " + arg.getName() + "Words[" + j + "].trim() : "
						// + arg.getDataType().getName().replace("java.lang.", "") + ".class;";
						// }

					} else if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_AND_IGNORE_CASE_TRASLATE)) {

						String n = "filtro.get" + toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

						// String n = "filtro.get" + toCamelStart(arg.getName()) + "()";
						//
						// args += "\n" + sc + "String[] " + arg.getName() + "Words = ( " + n
						// + " == null ) ? new String[0] : " + n + ".split(\" \");";
						//
						// for (int j = 0; j < 5; j++) {
						//
						// args += sc + "Object " + arg.getName() + "Word" + j + " = ( " + arg.getName()
						// + "Words.length > " + j + " && " + arg.getName() + "Words[" + j
						// + "].trim().length() > 0) ? " + arg.getName() + "Words[" + j + "].trim() : "
						// + arg.getDataType().getName().replace("java.lang.", "") + ".class;";
						// }

					}

					/////////////////////////////////////// **********************************************

				} else {

					String n = "filtro.get" + toCamelStart(arg.getName()) + "()";

					args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
							+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

				}

			} else {

				String n = "filtro.get" + toCamelStart(arg.getName()) + "()";

				args += sc + "Object " + arg.getName() + " = ( " + n + " != null && " + n + ".getId() != null) ? " + n
						+ ".getId() : String.class;";

			}
		}

		java += "\n";

		java += args;

		String javaArgs = "";

		for (int i = 0; i < clazzX.getArgs().size(); i++) {

			Argument arg = clazzX.getArgs().get(i);

			if (arg.getOnlyVisual() == true) {
				continue;
			}

			if (arg.isNumber() || arg.isTimestamp() || arg.isDate()) {

				if (arg.getRange() == false) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

				} else {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName() + "From";
					javaArgs += ", ";
					javaArgs += arg.getName() + "To";
				}

			} else if (arg.isString()) {

				/////////////////////////////////////// **********************************************

				if (arg.getSearchOption().equals(Argument.EQUALS)) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

				} else if (arg.getSearchOption().equals(Argument.EQUALS_TRASLATE)) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

				} else if (arg.getSearchOption().equals(Argument.EQUALS_IGNORE_CASE)) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

				} else if (arg.getSearchOption().equals(Argument.EQUALS_IGNORE_CASE_TRASLATE)) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

				} else if (arg.getSearchOption().equals(Argument.STARTS_WITCH)) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

				} else if (arg.getSearchOption().equals(Argument.STARTS_WITCH_TRASLATE)) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

				} else if (arg.getSearchOption().equals(Argument.STARTS_WITCH_IGNORE_CASE)) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

				} else if (arg.getSearchOption().equals(Argument.STARTS_WITCH_IGNORE_CASE_TRASLATE)) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

				} else if (arg.getSearchOption().equals(Argument.ENDS_WITCH)) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

				} else if (arg.getSearchOption().equals(Argument.ENDS_WITCH_TRASLATE)) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

				} else if (arg.getSearchOption().equals(Argument.ENDS_WITCH_IGNORE_CASE)) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

				} else if (arg.getSearchOption().equals(Argument.ENDS_WITCH_IGNORE_CASE_TRASLATE)) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

				} else if (arg.getSearchOption().equals(Argument.CONTAINS)) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_TRASLATE)) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_IGNORE_CASE)) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_IGNORE_CASE_TRASLATE)) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_OR)) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_OR_TRASLATE)) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_OR_IGNORE_CASE)) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_OR_IGNORE_CASE_TRASLATE)) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_AND)) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

					// for (int j = 0; j < 5; j++) {
					//
					// javaArgs += (i == 0) ? "" : ", ";
					// javaArgs += arg.getName() + "Word" + j;
					// }

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_AND_TRASLATE)) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

					// for (int j = 0; j < 5; j++) {
					//
					// javaArgs += (i == 0) ? "" : ", ";
					// javaArgs += arg.getName() + "Word" + j;
					// }

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_AND_IGNORE_CASE)) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

					// for (int j = 0; j < 5; j++) {
					//
					// javaArgs += (i == 0) ? "" : ", ";
					// javaArgs += arg.getName() + "Word" + j;
					// }

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_AND_IGNORE_CASE_TRASLATE)) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

					// for (int j = 0; j < 5; j++) {
					//
					// javaArgs += (i == 0) ? "" : ", ";
					// javaArgs += arg.getName() + "Word" + j;
					// }

				}

				/////////////////////////////////////// **********************************************
			} else {
				javaArgs += (i == 0) ? "" : ", ";
				javaArgs += arg.getName();
			}

		}

		////////////////////////////////////////////////////////

		java += "\n";

		java += "\n\t\tObject[] args = null;";

		java += "\n\t\tif(filtro.getUnlimited()){";

		java += "\n\t\t\targs = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), Long.class, Long.class";

		if (javaArgs != null && javaArgs.trim().length() > 0) {
			java += ", " + javaArgs + "};";
		} else {
			java += "};";
		}

		java += "\n\t\t} else {";

		java += "\n\t\t\targs = new Object[] {String.class, filtro.getOrderBy(), filtro.getOrderByDesc(), filtro.getLimit(), filtro.getOffset()";

		if (javaArgs != null && javaArgs.trim().length() > 0) {
			java += ", " + javaArgs + "};";
		} else {
			java += "};";
		}

		// if (paramsCount) {
		// java += ", " + javaArgs + "};";
		// } else {
		// java += javaArgs + "};";
		// }

		java += "\n\t\t}";

		// java += "};";

		java += "\n\n\t\tObject[][] table = BackendContextPG.get().find(sql, args);";

		java += "\n\n\t\tfor(int i = 0; i < table.length; i++){";

		java += "\n\n\t\t\tObject[] row = table[i];";

		java += buildMapperIf(clazzX);

		java += "\n\n\t\t}";

		java += "\n\n\t\treturn listado;";

		java += "\n\n\t}";

		return java;
	}

	private static String buildMapperIfById(Clazz clazzX) {

		int maxLevel = UtilJavaPOJO.getDefaultMaxLevel();
		int level = 0;

		String java = "";

		for (int i = 0; i <= maxLevel; i++) {
			String java2 = buildMapperIfById(clazzX, i, level);

			if (java.contains(java2.trim()) == false) {
				if (i == 0) {
					java += java2;
				} else {
					java += " else " + java2.trim();
				}

			}
		}

		java += " else {";

		java += "\n\n\t\t\t\tthrow new IllegalStateException(\"No se esperaba que la consulta a la base de datos devuelva una fila con  \" + row.length + \" columnas.\");";

		java += "\n\n\t\t\t}";

		return java;
	}

	private static String buildMapperIfById(Clazz clazzX, int maxLevel, int level) {

		String java = "";

		List<String> fieldsSQL = new ArrayList<String>();

		buildMapper(maxLevel, level, clazzX, fieldsSQL);

		java += "\n\n\t\t\tif(row.length == " + fieldsSQL.size() + ") {";

		java += "\n\n\t\t\t\tobj = mapper" + fieldsSQL.size() + "Fields(row);";

		java += "\n\n\t\t\t\tobj._originalDTO = (EntityId) obj.clone();";

		java += "\n\n\t\t\t\treturn obj;";

		java += "\n\n\t\t\t}";

		return java;
	}

	private static void buildMapper(int maxLevel, int level, Clazz clazz, List<String> fields) {

		String java = "";

		java = "String id" + clazz.getName() + "Arg" + fields.size() + " = (String) row[++c];";
		fields.add(java);

		for (int i = 0; i < clazz.getAtts().size(); i++) {

			Att att = clazz.getAtts().get(i);

			if (att.isSimple()) {

				java = att.getDataType().getName().replace("java.lang.", "") + " " + att.getName()
						+ att.getClazz().getName() + "Arg" + fields.size() + " = ("
						+ att.getDataType().getName().replace("java.lang.", "") + ") row[++c];";

				fields.add(java);

			} else {

				if (level < maxLevel) {
					DataTypeClazz dataTypeClazz = (DataTypeClazz) att.getDataType();
					buildMapper(maxLevel, (level + 1), dataTypeClazz.getClazz(), fields);
				} else {
					java = "String " + att.getName()
							+ att.getClazz().getName() + "Arg" + fields.size() + " = (String) row[++c]; // " + att.getDataType().getName().replace("java.lang.", "") + ".id";

					fields.add(java);
				}

			}

		}

	}

	private static String buildMapperIf(Clazz clazzX) {

		int maxLevel = UtilJavaPOJO.getDefaultMaxLevel();
		int level = 0;

		String java = "";

		for (int i = 0; i <= maxLevel; i++) {

			String java2 = buildMapperIf(clazzX, i, level);

			if (java.contains(java2.trim()) == false) {
				if (i == 0) {
					java += java2;
				} else {
					java += " else " + java2.trim();
				}

			}
		}

		java += " else {";

		java += "\n\n\t\t\t\tthrow new IllegalStateException(\"No se esperaba que la consulta a la base de datos devuelva una fila con  \" + row.length + \" columnas.\");";

		java += "\n\n\t\t\t}";

		return java;
	}

	private static String buildMapperIf(Clazz clazzX, int maxLevel, int level) {

		String java = "";

		List<String> fieldsSQL = new ArrayList<String>();

		buildMapper(maxLevel, level, clazzX, fieldsSQL);

		java += "\n\n\t\t\tif(row.length == " + (fieldsSQL.size() + 0) + ") {";

		java += "\n\n\t\t\t\t" + clazzX.getName() + " obj = mapper" + fieldsSQL.size() + "Fields(row);";
		java += "\n\n\t\t\t\tobj._originalDTO = (EntityId) obj.clone();";
		java += "\n\n\t\t\t\tlistado.add(obj);";

		java += "\n\n\t\t\t}";

		return java;
	}

	private static String buildMapper(Clazz clazzX) {

		int maxLevel = UtilJavaPOJO.getDefaultMaxLevel();
		int level = 0;

		String java = "";

		for (int i = 0; i <= maxLevel; i++) {
			String java2 = buildMapper(clazzX, i, level);

			if (java.contains(java2) == false) {
				java += java2;
			}
		}

		return java;
	}

	private static String buildMapper(Clazz clazzX, int maxLevel, int level) {

		String java = "";

		java += "\n\n\t// ---------------------------------------------------------------------------------------------------------------------------\n";

		List<String> fieldsSQL = new ArrayList<String>();

		buildMapper(maxLevel, level, clazzX, fieldsSQL);

		java += "\n\n\tprivate " + clazzX.getName() + " mapper" + fieldsSQL.size()
				+ "Fields(Object[] row) throws Exception {";

		java += "\n\n\t\tint c = -1;\n";

		for (int i = 0; i < fieldsSQL.size(); i++) {

			java += "\n\t\t" + fieldsSQL.get(i);

		}

		java += "\n\n\t\t" + clazzX.getName() + " obj = new " + clazzX.getName() + "(";

		fieldsSQL = new ArrayList<String>();

		buildMapperArgs(maxLevel, level, clazzX, fieldsSQL);

		for (int i = 0; i < fieldsSQL.size(); i++) {

			if (i == 0) {

				java += fieldsSQL.get(i);
			} else {
				java += ", " + fieldsSQL.get(i);
			}

		}

		java += ");";

		java += "\n\n\t\treturn obj;";

		java += "\n\n\t}";

		return java;
	}

	private static void buildMapperArgs(int maxLevel, int level, Clazz clazz, List<String> fields) {

		String java = "";

		java = "id" + clazz.getName() + "Arg" + fields.size();
		fields.add(java);

		for (int i = 0; i < clazz.getAtts().size(); i++) {

			Att att = clazz.getAtts().get(i);

			if (att.isSimple()) {

				java = att.getName() + att.getClazz().getName() + "Arg" + fields.size();

				fields.add(java);

			} else {

				if (level < maxLevel) {
					DataTypeClazz dataTypeClazz = (DataTypeClazz) att.getDataType();
					buildMapperArgs(maxLevel, (level + 1), dataTypeClazz.getClazz(), fields);
				} else {

					 java = att.getName() + att.getClazz().getName() + "Arg" + fields.size();

					 fields.add(java);

				}

			}

		}

	}

}
