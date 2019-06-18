package com.massoftware.anthill;

public class UtilJavaPOJOFilter {

	private static String toCamelStart(String text) {
		if (text == null || text.isEmpty()) {
			return text;
		}

		return text.substring(0, 1).toUpperCase() + text.substring(1, text.length());
	}

	public static String toJavaFilter(Clazz clazzX) {

		String java = "package com.massoftware.service." + clazzX.getNamePackage() + ";";

		java += "\n\nimport com.massoftware.backend.annotation.FieldConfAnont;";
		java += "\nimport com.massoftware.service.AbstractFilter;";
		java += buildImports(clazzX);

		java += "\n\npublic class " + clazzX.getName() + "Filtro extends AbstractFilter {";

		java += "\n\n\t// ---------------------------------------------------------------------------------------------------------------------------\n";

		java += "\n\tpublic " + clazzX.getName() + "Filtro() {";
		java += "\n\t\t_levelDefault = " + UtilJavaPOJO.buildMapperDefaultLevel(clazzX) + ";";
		java += "\n\t}";

		// java += "\n\tprivate int _levelDefault = " +
		// UtilJavaPOJO.buildMapperDefaultLevel(clazzX) + ";";

		// java += "\n\n\t@FieldConfAnont(label = \"Unlimited\")";
		// java += "\n\tprivate Boolean unlimited = false;";
		//
		// java += "\n\n\t@FieldConfAnont(label = \"Limit\")";
		// java += "\n\tprivate Long limit;";
		//
		// java += "\n\n\t@FieldConfAnont(label = \"Offset\")";
		// java += "\n\tprivate Long offset;";
		//
		// java += "\n\n\t@FieldConfAnont(label = \"Order by att\")";
		// java += "\n\tprivate String orderBy;";
		//
		// java += "\n\n\t@FieldConfAnont(label = \"Order by desc\")";
		// java += "\n\tprivate Boolean orderByDesc = false;";
		//
		// java += "\n\n\t@FieldConfAnont(label = \"Level\")";
		// java += "\n\tprivate Integer level = _levelDefault;";

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

		// java += "\n\n\t// GET Unlimited";
		// java += "\n\tpublic Boolean getUnlimited() {";
		// java += "\n\t\treturn this.unlimited;";
		// java += "\n\t}";
		//
		// java += "\n\n\t// SET Unlimited";
		// java += "\n\tpublic void setUnlimited(Boolean unlimited){";
		// java += "\n\t\tunlimited = (unlimited == null) ? false : unlimited;";
		// java += "\n\t\tthis.unlimited = unlimited;";
		// java += "\n\t}";
		//
		// java += "\n\n\t// GET Limit";
		// java += "\n\tpublic Long getLimit() {";
		// java += "\n\t\treturn this.limit;";
		// java += "\n\t}";
		//
		// java += "\n\n\t// SET Limit";
		// java += "\n\tpublic void setLimit(Long limit){";
		// java += "\n\t\tlimit = (limit == null || limit < 1) ? 100 : limit;";
		// java += "\n\t\tthis.limit = limit;";
		// java += "\n\t}";
		//
		// java += "\n\n\t// GET Offset";
		// java += "\n\tpublic Long getOffset() {";
		// java += "\n\t\treturn this.offset;";
		// java += "\n\t}";
		//
		// java += "\n\n\t// SET Offset";
		// java += "\n\tpublic void setOffset(Long offset){";
		// java += "\n\t\toffset = (offset == null || offset < 0) ? 0 : offset;";
		// java += "\n\t\tthis.offset = offset;";
		// java += "\n\t}";
		//
		// java += "\n\n\t// GET Order by att";
		// java += "\n\tpublic String getOrderBy() {";
		// java += "\n\t\treturn this.orderBy;";
		// java += "\n\t}";
		//
		// java += "\n\n\t// SET Order by att";
		// java += "\n\tpublic void setOrderBy(String orderBy){";
		// // java += "\n\t\torderBy = (orderBy == null) ? \"1\" : orderBy;";
		// java += "\n\t\tthis.orderBy = orderBy;";
		// java += "\n\t}";
		//
		// java += "\n\n\t// GET Order by desc";
		// java += "\n\tpublic Boolean getOrderByDesc() {";
		// java += "\n\t\treturn this.orderByDesc;";
		// java += "\n\t}";
		//
		// java += "\n\n\t// SET Order by desc";
		// java += "\n\tpublic void setOrderByDesc(Boolean orderByDesc){";
		// java += "\n\t\torderByDesc = (orderByDesc == null) ? false : orderByDesc;";
		// java += "\n\t\tthis.orderByDesc = orderByDesc;";
		// java += "\n\t}";
		//
		// java += "\n\n\t// GET Level";
		// java += "\n\tpublic Integer getLevel() {";
		// java += "\n\t\treturn this.level;";
		// java += "\n\t}";
		//
		// java += "\n\n\t// SET Level";
		// java += "\n\tpublic void setLevel(Integer level){";
		// java += "\n\t\tlevel = (level == null || level < 0) ? _levelDefault :
		// level;";
		// java += "\n\t\tlevel = (level != null && level > 3) ? _levelDefault :
		// level;";
		// java += "\n\t\tthis.level = level;";
		// java += "\n\t}";

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

		java += "\n\n} // END CLASS ----------------------------------------------------------------------------------------------------------";

		return java;
	}

	private static String buildImports(Clazz clazz) {
		String java = "";

		for (Argument arg : clazz.getArgs()) {
			if (arg.isSimple() == false) {
				DataTypeClazz dt = (DataTypeClazz) arg.getDataType();

				String java1 = "\nimport com.massoftware.model." + dt.getClazz().getNamePackage() + "."
						+ dt.getClazz().getName() + ";";
				if (java.contains(java1) == false) {
					java += java1;
				}
			}
		}

		return java;
	}

	private static String buildAtt(Argument att) {
		String java = "";

		java += "\n\n\t// " + att.getLabel();

		String label = "label = \"" + att.getLabel() + "\"";
		String labelError = "labelError = \"\"";
		// String unique = "unique = " + att.isUnique();
		String readOnly = "readOnly = " + att.isReadOnlyGUI();
		String required = "required = " + att.isRequired();
		String columns = "columns = 20f";
		String maxLength = "maxLength = " + att.getMaxLength();
		String minValue = "minValue = \"" + "" + "\"";
		String maxValue = "maxValue = \"" + "" + "\"";
		String mask = "mask = \"\"";

		if (att.getLabelError() != null) {
			labelError = "labelError = \"" + att.getLabelError() + "\"";
		}

		if (att.getColumns() != null) {
			columns = "columns = " + att.getColumns() + "f";
		}

		if (att.getMask() != null) {
			mask = "mask = \"" + att.getMask() + "\"";
		}

		if (att.isNumber()) {
			if (att.isInteger()) {
				DataTypeInteger dt = (DataTypeInteger) att.getDataType();
				if (dt.getMinValue() != null) {
					minValue = "minValue = \"" + dt.getMinValue() + "\"";
				} else {
					minValue = "minValue = \"" + Integer.MIN_VALUE + "\"";
				}
				if (dt.getMaxValue() != null) {
					maxValue = "maxValue = \"" + dt.getMaxValue() + "\"";
				} else {
					maxValue = "maxValue = \"" + Integer.MAX_VALUE + "\"";
				}

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

					maxLength = "maxLength = " + length;

				}

			} else if (att.isLong()) {
				DataTypeLong dt = (DataTypeLong) att.getDataType();
				if (dt.getMinValue() != null) {
					minValue = "minValue = \"" + dt.getMinValue() + "\"";
				} else {
					minValue = "minValue = \"" + Long.MIN_VALUE + "\"";
				}
				if (dt.getMaxValue() != null) {
					maxValue = "maxValue = \"" + dt.getMaxValue() + "\"";
				} else {
					maxValue = "maxValue = \"" + Long.MAX_VALUE + "\"";
				}

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

					maxLength = "maxLength = " + length;

				}

			} else if (att.isDouble()) {
				DataTypeDouble dt = (DataTypeDouble) att.getDataType();
				if (dt.getMinValue() != null) {
					minValue = "minValue = \"" + dt.getMinValue() + "\"";
				} else {
					minValue = "minValue = \"" + Double.MIN_VALUE + "\"";
				}
				if (dt.getMaxValue() != null) {
					maxValue = "maxValue = \"" + dt.getMaxValue() + "\"";
				} else {
					maxValue = "maxValue = \"" + Double.MAX_VALUE + "\"";
				}

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

					maxLength = "maxLength = " + length;

				}

			} else if (att.isBigDecimal()) {
				DataTypeBigDecimal dt = (DataTypeBigDecimal) att.getDataType();
				if (dt.getMinValue() != null) {
					minValue = "minValue = \"" + dt.getMinValue() + "\"";
				}
				if (dt.getMaxValue() != null) {
					maxValue = "maxValue = \"" + dt.getMaxValue() + "\"";
				}

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

					if (length > 0) {
						maxLength = "maxLength = " + length;
					}

				}

			}
		} else if (att.isString()) {
			minValue = "minValue = \"" + "" + "\"";
			maxValue = "maxValue = \"" + "" + "\"";
		} else if (att.isBoolean()) {
			minValue = "minValue = \"" + "" + "\"";
			maxValue = "maxValue = \"" + "" + "\"";
			maxLength = "maxLength = " + -1;
		} else if (att.isTimestamp()) {
			minValue = "minValue = \"" + "" + "\"";
			maxValue = "maxValue = \"" + "" + "\"";
			maxLength = "maxLength = " + -1;
		} else if (att.isDate()) {
			minValue = "minValue = \"" + "" + "\"";
			maxValue = "maxValue = \"" + "" + "\"";
			maxLength = "maxLength = " + -1;
		} else if (att.isSimple() == false) {
			minValue = "minValue = \"" + "" + "\"";
			maxValue = "maxValue = \"" + "" + "\"";
			maxLength = "maxLength = " + -1;
		}

		java += "\n\t@FieldConfAnont(" + label + ", " + labelError + /* ", " + unique + */ ", " + readOnly + ", "
				+ required + ", " + columns + ", " + maxLength + ", " + minValue + ", " + maxValue + ", " + mask + ")";
		java += "\n\tprivate " + att.getDataType().getName().replace("java.lang.", "") + " " + att.getName() + "";

		if (att.isBoolean()) {
			java += " = false";
		}

		java += ";";

		return java;
	}

	private static String buildGetSet(Argument att) {
		String java = "";

		java += "\n\n\t// GET " + att.getLabel();
		java += "\n\tpublic " + att.getDataType().getName().replace("java.lang.", "") + " get"
				+ att.getNameJavaUperCase() + "() {";

		java += "\n\t\treturn this." + att.getName() + ";";

		java += "\n\t}";

		java += "\n\n\t// SET " + att.getLabel();
		java += "\n\tpublic void set" + att.getNameJavaUperCase() + "("
				+ att.getDataType().getName().replace("java.lang.", "") + " " + att.getName() + " ){";

		if (att.isBoolean()) {
			java += "\n\t\tthis." + att.getName() + " = (" + att.getName() + " == null) ? false : " + att.getName()
					+ ";";
		} else if (att.isString()) {
			java += "\n\t\tthis." + att.getName() + " = (" + att.getName() + " != null && " + att.getName()
					+ ".trim().length() == 0) ? null : " + att.getName() + ";";
		} else {
			java += "\n\t\tthis." + att.getName() + " = " + att.getName() + ";";
		}

		java += "\n\t}";

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
		java += t2 + clazz.getName() + "Filtro other = (" + clazz.getName() + "Filtro) obj;";
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

}
