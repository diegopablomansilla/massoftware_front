package com.anthill.model.to_java;

import com.anthill.model.Argument;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeBigDecimal;
import com.anthill.model.DataTypeClazz;
import com.anthill.model.DataTypeDouble;
import com.anthill.model.DataTypeInteger;
import com.anthill.model.DataTypeLong;

public class UtilJavaPOJOFilter {

	private static String toCamelStart(String text) {
		if (text == null || text.isEmpty()) {
			return text;
		}

		return text.substring(0, 1).toUpperCase() + text.substring(1, text.length());
	}

	public static String toJavaFilter(Clazz clazzX) {

		String java = "package com.massoftware.service." + clazzX.getNamePackage() + ";";

		java += "\n\nimport com.massoftware.service.*;";

		java += buildImports(clazzX);

		java += "\n\npublic class " + clazzX.getNamePlural() + "Filtro extends GenericFilter implements Cloneable {";

		java += "\n\n\t// ---------------------------------------------------------------------------------------------------------------------------\n";

		for (Argument arg : clazzX.getArgs()) {

			if (arg.isNumber() || arg.isTimestamp() || arg.isDate()) {

				if (arg.getRange() == false) {
					java += buildAtt(arg);
				} else {

					String name = arg.getName();
					String label = arg.getLabel();
					String labelError = arg.getLabelError();

					arg.setName(name + "From");
					arg.setLabel(label + " (desde)");
					if (labelError != null && labelError.trim().length() > 0) {
						arg.setLabelError(labelError + " (desde)");
					}
					java += buildAtt(arg);
					arg.setName(name + "To");
					arg.setLabel(label + " (hasta)");
					if (labelError != null && labelError.trim().length() > 0) {
						arg.setLabelError(labelError + " (desde)");
					}
					java += buildAtt(arg);

					arg.setName(name);
					arg.setLabel(label);
					arg.setLabelError(labelError);

				}
			} else {
				java += buildAtt(arg);
			}

		}

		java += "\n\n\t// ---------------------------------------------------------------------------------------------------------------------------\n";

		for (Argument arg : clazzX.getArgs()) {

			if (arg.isNumber() || arg.isTimestamp() || arg.isDate()) {

				if (arg.getRange() == false) {
					java += buildGetSet(arg);
				} else {

					String name = arg.getName();
					String label = arg.getLabel();
					String labelError = arg.getLabelError();

					arg.setName(name + "From");
					arg.setLabel(label + " (desde)");
					if (labelError != null && labelError.trim().length() > 0) {
						arg.setLabelError(labelError + " (desde)");
					}
					java += buildGetSet(arg);
					arg.setName(name + "To");
					arg.setLabel(label + " (hasta)");
					if (labelError != null && labelError.trim().length() > 0) {
						arg.setLabelError(labelError + " (desde)");
					}
					java += buildGetSet(arg);

					arg.setName(name);
					arg.setLabel(label);
					arg.setLabelError(labelError);

				}
			} else {
				java += buildGetSet(arg);
			}

		}

		java += buildEquals(clazzX);
		java += buildClone(clazzX);

		java += "\n\n} // END CLASS ----------------------------------------------------------------------------------------------------------";

		return java;
	}

	private static String buildImports(Clazz clazz) {
		String java = "";

		for (Argument arg : clazz.getArgs()) {
			if (arg.isSimple() == false) {
				DataTypeClazz dt = (DataTypeClazz) arg.getDataType();

				String java1 = "\nimport com.massoftware.service." + dt.getClazz().getNamePackage() + "."
						+ dt.getClazz().getNamePlural() + ";";
				if (java.contains(java1) == false
						&& clazz.getNamePackage().equals(dt.getClazz().getNamePackage()) == false) {
					java += java1;
				}
			} else {

				if (arg.isDate()) {
					String java1 = "\nimport java.time.LocalDate;";
					if (java.contains(java1) == false) {
						java += java1;
					}
				} else if (arg.isTimestamp()) {
					String java1 = "\nimport java.time.LocalDateTime;";
					if (java.contains(java1) == false) {
						java += java1;
					}
				} else if (arg.isBigDecimal()) {
					String java1 = "\nimport java.math.BigDecimal;";
					if (java.contains(java1) == false) {
						java += java1;
					}
				}
			}
		}

		return java;
	}

	private static String buildAtt(Argument att) {
		String java = "";

		java += "\n\n\t// " + att.getLabel();

		if (att.isNumber()) {
			if (att.isInteger()) {
				DataTypeInteger dt = (DataTypeInteger) att.getDataType();

				if (att.getMaxLength() == null) {

					int length = 0;

					if (dt.getMinValue() != null) {
						length = dt.getMinValue().toString().length();
					} else if (dt.getMinValue() == null) {
						length = (Integer.MIN_VALUE + "").length();
					}

					if (dt.getMaxValue() != null) {
						if (length < dt.getMaxValue().toString().length()) {
							length = dt.getMaxValue().toString().length();
						}
					} else if (dt.getMaxValue() == null) {
						if (length < (Integer.MAX_VALUE + "").length()) {
							length = (Integer.MAX_VALUE + "").length();
						}
					}

				}

			} else if (att.isLong()) {
				DataTypeLong dt = (DataTypeLong) att.getDataType();

				if (att.getMaxLength() == null) {

					int length = 0;

					if (dt.getMinValue() != null) {
						length = dt.getMinValue().toString().length();
					} else if (dt.getMinValue() == null) {
						length = (Long.MIN_VALUE + "").length();
					}

					if (dt.getMaxValue() != null) {
						if (length < dt.getMaxValue().toString().length()) {
							length = dt.getMaxValue().toString().length();
						}
					} else if (dt.getMaxValue() == null) {
						if (length < (Long.MAX_VALUE + "").length()) {
							length = (Long.MAX_VALUE + "").length();
						}
					}

				}

			} else if (att.isDouble()) {
				DataTypeDouble dt = (DataTypeDouble) att.getDataType();

				if (att.getMaxLength() == null) {

					int length = 0;

					if (dt.getMinValue() != null) {
						length = dt.getMinValue().toString().length();
					} else if (dt.getMinValue() == null) {
						length = (Double.MIN_VALUE + "").length();
					}

					if (dt.getMaxValue() != null) {
						if (length < dt.getMaxValue().toString().length()) {
							length = dt.getMaxValue().toString().length();
						}
					} else if (dt.getMaxValue() == null) {
						if (length < (Double.MAX_VALUE + "").length()) {
							length = (Double.MAX_VALUE + "").length();
						}
					}

				}

			} else if (att.isBigDecimal()) {
				DataTypeBigDecimal dt = (DataTypeBigDecimal) att.getDataType();

				if (att.getMaxLength() == null) {

					int length = 0;

					if (dt.getMinValue() != null) {
						length = dt.getMinValue().toString().length();
					}

					if (dt.getMaxValue() != null) {
						if (length < dt.getMaxValue().toString().length()) {
							length = dt.getMaxValue().toString().length();
						}
					}

				}

			}
		}

		if (att.isBoolean()) {

			java += "\n\tprivate " + att.getDataType().getName().replace("java.lang.", "") + " " + att.getName() + ";";

			java += "\n\tprivate FBoolean " + att.getName() + "X";

		} else if (att.isSimple() == false) {
			java += "\n\tprivate " + att.getDataType().getNamePlural() + " " + att.getName() + "";
		} else {
			java += "\n\tprivate " + att.getDataType().getName().replace("java.lang.", "").replace("java.math.", "")
					.replace("java.time.", "") + " " + att.getName() + "";
		}

		java += ";";

		return java;
	}

	private static String buildGetSet(Argument att) {
		String java = "";

		if (att.isBoolean()) {

			java += "\n\n\t// GET " + att.getLabel();
			java += "\n\tpublic " + att.getDataType().getName().replace("java.lang.", "") + " get"
					+ att.getNameJavaUperCase() + "() {";
			// java += "\n\t\tthis." + att.getName() + " = ((this." + att.getName() + "Int
			// == null) ? null : ((this."
			// + att.getName() + "Int == 0) ? false : true));";
			java += "\n\t\treturn this." + att.getName() + ";";
			java += "\n\t}";

			java += "\n\n\t// GET " + att.getLabel();
			java += "\n\tpublic FBoolean get" + att.getNameJavaUperCase() + "X() {";
			java += "\n\t\treturn this." + att.getName() + "X;";
			java += "\n\t}";

		} else if (att.isSimple() == false) {

			java += "\n\n\t// GET " + att.getLabel();
			java += "\n\tpublic " + att.getDataType().getNamePlural() + " get" + att.getNameJavaUperCase() + "() {";
			java += "\n\t\treturn this." + att.getName() + ";";
			java += "\n\t}";

		} else {

			java += "\n\n\t// GET " + att.getLabel();
			java += "\n\tpublic " + att.getDataType().getName().replace("java.lang.", "").replace("java.math.", "")
					.replace("java.time.", "") + " get" + att.getNameJavaUperCase() + "() {";
			java += "\n\t\treturn this." + att.getName() + ";";
			java += "\n\t}";
		}

		if (att.isBoolean()) {

			java += "\n\n\t// SET " + att.getLabel();
			java += "\n\tpublic void set" + att.getNameJavaUperCase() + "("
					+ att.getDataType().getName().replace("java.lang.", "") + " " + att.getName() + " ){";
			java += "\n\t\tthis." + att.getName() + " = " + att.getName() + ";";
			java += "\n\t\tthis." + att.getName() + "X = new FBoolean(" + att.getName() + ");";
			java += "\n\t}";

			java += "\n\n\t// SET " + att.getLabel();
			java += "\n\tpublic void set" + att.getNameJavaUperCase() + "X(" + "FBoolean" + " " + att.getName() + "X){";
			java += "\n\t\tthis." + att.getName() + "X = " + att.getName() + "X;";
			java += "\n\t\tthis." + att.getName() + " = (this." + att.getName() + "X == null) ? null : this."
					+ att.getName() + "X.getValue();";
			java += "\n\t}";

		} else if (att.isString()) {

			java += "\n\n\t// SET " + att.getLabel();
			java += "\n\tpublic void set" + att.getNameJavaUperCase() + "("
					+ att.getDataType().getName().replace("java.lang.", "") + " " + att.getName() + "){";
			java += "\n\t\tthis." + att.getName() + " = (" + att.getName() + " == null || " + att.getName()
					+ ".trim().length() == 0) ? null : " + att.getName() + ".trim();";
			java += "\n\t}";

		} else if (att.isSimple() == false) {

			java += "\n\n\t// SET " + att.getLabel();
			java += "\n\tpublic void set" + att.getNameJavaUperCase() + "(" + att.getDataType().getNamePlural() + " "
					+ att.getName() + "){";
			java += "\n\t\tthis." + att.getName() + " = " + att.getName() + ";";
			java += "\n\t}";

		} else {

			java += "\n\n\t// SET " + att.getLabel();
			java += "\n\tpublic void set" + att.getNameJavaUperCase() + "(" + att.getDataType().getName()
					.replace("java.lang.", "").replace("java.math.", "").replace("java.time.", "") + " " + att.getName()
					+ "){";
			java += "\n\t\tthis." + att.getName() + " = " + att.getName() + ";";
			java += "\n\t}";
		}

		return java;
	}

	private static String buildEquals(Clazz clazz) {
		String java = "";

		String t1 = "\n\t";
		String t2 = "\n\t\t";
		String t3 = "\n\t\t\t";
		String t4 = "\n\t\t\t\t";

		java += t2 + "";

		java += t1 + "public boolean equals(Object obj) {";

		java += t2 + "";

		java += t2 + "if (super.equals(obj) == false) {";
		java += t3 + "return false;";
		java += t2 + "}";
		java += t2 + "";
		java += t2 + "if (obj == this) {";
		java += t3 + "return true;";
		java += t2 + "}";
		java += t2 + "";
		java += t2 + clazz.getNamePlural() + "Filtro other = (" + clazz.getNamePlural() + "Filtro) obj;";
		java += t2 + "";

		for (Argument arg : clazz.getArgs()) {

			String get = "get" + toCamelStart(arg.getName()) + "";

			if ((arg.isNumber() == true || arg.isDate() == true || arg.isTimestamp() == true)
					&& arg.getRange() == true) {

				get = "get" + toCamelStart(arg.getName()) + "From";

				java += t2 + "";
				java += t2 + "// -------------------------------------------------------------------";
				java += t2 + "";
				java += t2 + "if (other." + get + "() == null && this." + get + "() != null) {";
				java += t3 + "return false;";
				java += t2 + "}";
				java += t2 + "";
				java += t2 + "if (other." + get + "() != null && this." + get + "() == null) {";
				java += t3 + "return false;";
				java += t2 + "}";
				java += t2 + "";
				java += t2 + "if (other." + get + "() != null && this." + get + "() != null) {";
				java += t2 + "";
				java += t3 + "if (other." + get + "().equals(this." + get + "()) == false) {";
				java += t4 + "return false;";
				java += t3 + "}";
				java += t2 + "";
				java += t2 + "}";

				get = "get" + toCamelStart(arg.getName()) + "To";

				java += t2 + "";
				java += t2 + "// -------------------------------------------------------------------";
				java += t2 + "";
				java += t2 + "if (other." + get + "() == null && this." + get + "() != null) {";
				java += t3 + "return false;";
				java += t2 + "}";
				java += t2 + "";
				java += t2 + "if (other." + get + "() != null && this." + get + "() == null) {";
				java += t3 + "return false;";
				java += t2 + "}";
				java += t2 + "";
				java += t2 + "if (other." + get + "() != null && this." + get + "() != null) {";
				java += t2 + "";
				java += t3 + "if (other." + get + "().equals(this." + get + "()) == false) {";
				java += t4 + "return false;";
				java += t3 + "}";
				java += t2 + "";
				java += t2 + "}";

			} else {

				java += t2 + "";
				java += t2 + "// -------------------------------------------------------------------";
				java += t2 + "";
				java += t2 + "if (other." + get + "() == null && this." + get + "() != null) {";
				java += t3 + "return false;";
				java += t2 + "}";
				java += t2 + "";
				java += t2 + "if (other." + get + "() != null && this." + get + "() == null) {";
				java += t3 + "return false;";
				java += t2 + "}";
				java += t2 + "";
				java += t2 + "if (other." + get + "() != null && this." + get + "() != null) {";
				java += t2 + "";
				java += t3 + "if (other." + get + "().equals(this." + get + "()) == false) {";
				java += t4 + "return false;";
				java += t3 + "}";
				java += t2 + "";
				java += t2 + "}";

			}

		}

		java += t2 + "";

		java += t2 + "// -------------------------------------------------------------------";

		java += t2 + "";

		java += t2 + "return true;";

		java += t2 + "";

		java += t2 + "// -------------------------------------------------------------------";

		java += t1 + "}";

		return java;
	}

	private static String buildClone(Clazz clazz) {
		String java = "";

		String t1 = "\n\t";
		String t2 = "\n\t\t";
		String t3 = "\n\t\t\t";
		String t4 = "\n\t\t\t\t";

		java += t2 + "";

		java += t1 + "public " + clazz.getNamePlural() + "Filtro clone() {";

		java += t2 + "";

		java += t2 + clazz.getNamePlural() + "Filtro other = new " + clazz.getNamePlural() + "Filtro();";

		java += t2 + "";

		java += t2 + "other.setOffset(this.getOffset());";
		java += t2 + "other.setLimit(this.getLimit());";
		java += t2 + "other.setOrderBy(this.getOrderBy());";
		java += t2 + "other.setOrderByDesc(this.getOrderByDesc());";
		java += t2 + "other.setUnlimited(this.getUnlimited());";

		java += t2 + "";

		for (Argument arg : clazz.getArgs()) {

			String get = "get" + toCamelStart(arg.getName()) + "";
			String set = "set" + toCamelStart(arg.getName()) + "";

			if ((arg.isNumber() == true || arg.isDate() == true || arg.isTimestamp() == true)
					&& arg.getRange() == true) {

				String getFrom = get + "From";
				String setFrom = set + "From";
				String getTo = get + "To";
				String setTo = set + "To";

				java += t2 + "other." + setFrom + "(this." + getFrom + "());";
				java += t2 + "other." + setTo + "(this." + getTo + "());";

			} else if (arg.isSimple() == false) {

				java += t2 + "";
				java += t2 + "// -------------------------------------------------------------------";
				java += t2 + "";
				java += t2 + "if (this." + get + "() != null) {";
				java += t3 + "other." + set + "(this." + get + "().clone());";
				java += t2 + "}";

			} else {
				java += t2 + "other." + set + "(this." + get + "());";
			}

		}

		java += t2 + "";

		java += t2 + "// -------------------------------------------------------------------";

		java += t2 + "";

		java += t2 + "return other;";

		java += t2 + "";

		java += t2 + "// -------------------------------------------------------------------";

		java += t1 + "}";

		return java;
	}

}
