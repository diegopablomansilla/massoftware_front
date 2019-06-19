package com.anthill.model.to_java;

import java.util.ArrayList;
import java.util.List;

import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeBigDecimal;
import com.anthill.model.DataTypeClazz;
import com.anthill.model.DataTypeDouble;
import com.anthill.model.DataTypeInteger;
import com.anthill.model.DataTypeLong;

public class UtilJavaPOJO {

	public static int getDefaultMaxLevel() {
		return 3;
	}

	private static String toCamelStart(String text) {
		if (text == null || text.isEmpty()) {
			return text;
		}

		return text.substring(0, 1).toUpperCase() + text.substring(1, text.length());
	}

	public static String toJava(Clazz clazzX) {

		String java = "package com.massoftware.model." + clazzX.getNamePackage() + ";";

		java += "\n\nimport com.massoftware.backend.annotation.ClassLabelAnont;";
		java += "\nimport com.massoftware.backend.annotation.FieldConfAnont;";
		java += "\nimport com.massoftware.model.EntityId;";

		java += buildImportAtts(clazzX);

		java += "\n\n@ClassLabelAnont(singular = \"" + clazzX.getSingular() + "\", plural = \"" + clazzX.getPlural()
				+ "\", singularPre = \"" + clazzX.getSingularPre() + "\", pluralPre = \"" + clazzX.getPluralPre()
				+ "\")";

		java += "\npublic class " + clazzX.getName() + " extends EntityId {";

		java += "\n\n\t// ---------------------------------------------------------------------------------------------------------------------------\n";

		java += "\n\n\t@FieldConfAnont(label = \"ID\")";
		java += "\n\tprivate String id;";

		for (Att att : clazzX.getAtts()) {

			java += "\n\n\t// " + att.getLabel();

			String label = "label = \"" + att.getLabel() + "\"";
			String labelError = "labelError = \"\"";
			String unique = "unique = " + att.isUnique();
			String readOnly = "readOnly = " + att.isReadOnlyGUI();
			String required = "required = " + ((att.isReadOnlyGUI() == true) ? false : att.isRequired());
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
						} else {
							maxLength = "maxLength = " + -1;
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
			} else if (att.isDate()) {
				minValue = "minValue = \"" + "" + "\"";
				maxValue = "maxValue = \"" + "" + "\"";
				maxLength = "maxLength = " + -1;
			} else if (att.isTimestamp()) {
				minValue = "minValue = \"" + "" + "\"";
				maxValue = "maxValue = \"" + "" + "\"";
				maxLength = "maxLength = " + -1;
			} else if (att.isSimple() == false) {
				minValue = "minValue = \"" + "" + "\"";
				maxValue = "maxValue = \"" + "" + "\"";
				maxLength = "maxLength = " + -1;
			}

			java += "\n\t@FieldConfAnont(" + label + ", " + labelError + ", " + unique + ", " + readOnly + ", "
					+ required + ", " + columns + ", " + maxLength + ", " + minValue + ", " + maxValue + ", " + mask
					+ ")";
			java += "\n\tprivate " + att.getDataType().getName().replace("java.lang.", "") + " " + att.getName() + "";

			if (att.isBoolean()) {
				java += " = false";
			}

			java += ";";

		}

		java += "\n\n\t// ---------------------------------------------------------------------------------------------------------------------------\n";

		java += "\n\n\tpublic " + clazzX.getName() + "() throws Exception {";
		// java += "\n\n\t\tthis._originalDTO = (EntityId) this.clone();";
		java += "\n\t}";

		java += buildConstructorAtts(clazzX);

		java += "\n\n\t// ---------------------------------------------------------------------------------------------------------------------------\n";

		java += "\n\n\t// GET ID";
		java += "\n\tpublic String getId() {";
		java += "\n\t\treturn this.id;";
		java += "\n\t}";

		java += "\n\t// SET ID";
		java += "\n\tpublic void setId(String id){";
		java += "\n\t\tid = (id != null) ? id.trim() : null;";
		java += "\n\t\tthis.id = (id != null && id.length() == 0) ? null : id;";
		java += "\n\t}";

		for (Att att : clazzX.getAtts()) {

			if (att.isSimple() == false) {
				java += "\n\n\t// BUILD IF NULL AND GET " + att.getLabel();
				java += "\n\tpublic " + att.getDataType().getName().replace("java.lang.", "") + " build"
						+ att.getNameJavaUperCase() + "() throws Exception {";

				java += "\n\t\tthis." + att.getName() + " = (this." + att.getName() + " == null) ? new "
						+ att.getDataType().getName() + "() : this." + att.getName() + ";";
				java += "\n\t\treturn this." + att.getName() + ";";
				java += "\n\t}";
			}

			java += "\n\n\t// GET " + att.getLabel();
			java += "\n\tpublic " + att.getDataType().getName().replace("java.lang.", "") + " get"
					+ att.getNameJavaUperCase() + "() {";

			if (att.isSimple()) {
				java += "\n\t\treturn this." + att.getName() + ";";
			} else {
				java += "\n\t\tthis." + att.getName() + " = (this." + att.getName() + " != null && this."
						+ att.getName() + ".getId() == null) ? null : this." + att.getName() + " ;";
				java += "\n\t\treturn this." + att.getName() + ";";
			}

			java += "\n\t}";

			java += "\n\n\t// SET " + att.getLabel();
			java += "\n\tpublic void set" + att.getNameJavaUperCase() + "("
					+ att.getDataType().getName().replace("java.lang.", "") + " " + att.getName() + " ){";

			if (att.isBoolean()) {
				java += "\n\t\tthis." + att.getName() + " = (" + att.getName() + " == null) ? false : " + att.getName()
						+ ";";
			} else if (att.isString()) {
				java += "\n\t\t" + att.getName() + " = (" + att.getName() + " != null) ? " + att.getName()
						+ ".trim() : null;";
				java += "\n\t\tthis." + att.getName() + " = (" + att.getName() + " != null && " + att.getName()
						+ ".length() == 0) ? null : " + att.getName() + ";";
			} else {
				java += "\n\t\tthis." + att.getName() + " = " + att.getName() + ";";
			}

			java += "\n\t}";

		}

		java += buildSetter(clazzX);

		// java += "\n\n\t//
		// ---------------------------------------------------------------------------------------------------------------------------\n";
		//
		// java += "\n\n\tpublic String toString(){\n" + clazzX.getToString() + "\n\t}";
		// ---------------------------------------------------------------------------------------------------------------------------\n";
		//
		// java += "\n\n\t//
		// ---------------------------------------------------------------------------------------------------------------------------\n";

		java += toStringMethod(clazzX);

		java += "\n\n} // END CLASS ----------------------------------------------------------------------------------------------------------";

		return java;
	}

	private static String buildImportAtts(Clazz clazz) {

		String java = "";

		for (int i = 0; i < clazz.getAtts().size(); i++) {

			Att att = clazz.getAtts().get(i);

			if (att.isSimple() == false) {

				DataTypeClazz dataTypeClazz = (DataTypeClazz) att.getDataType();

				java += "\nimport com.massoftware.model." + dataTypeClazz.getClazz().getNamePackage() + "."
						+ dataTypeClazz.getClazz().getName() + ";";

			}
		}

		return java;

	}

	private static String buildConstructorAtts(Clazz clazzX) {

		int maxLevel = getDefaultMaxLevel();
		int level = 0;

		String java = "";

		for (int i = 0; i <= maxLevel; i++) {
			String java2 = buildConstructorAtts(clazzX, i, level);

			if (java.contains(java2) == false) {
				java += java2;
			}
		}

		return java;
	}

	private static String buildConstructorAtts(Clazz clazzX, int maxLevel, int level) {
		String java = "";

		java += "\n\n\tpublic " + clazzX.getName() + "(";

		List<String> fieldsSQL = new ArrayList<String>();

		buildConstructorArgs(maxLevel, level, clazzX, fieldsSQL);

		for (int i = 0; i < fieldsSQL.size(); i++) {

			if (i == 0) {
				java += fieldsSQL.get(i) + i;
			} else {
				java += ", " + fieldsSQL.get(i) + i;
			}

		}

		java += ") throws Exception {\n";

		///////////////////////////////////////////////////////

		java += "\n\t\tsetter(";

		fieldsSQL = new ArrayList<String>();

		buildSetterArgs(maxLevel, level, clazzX, fieldsSQL);

		for (int i = 0; i < fieldsSQL.size(); i++) {

			if (i == 0) {
				java += fieldsSQL.get(i) + i;
			} else {
				java += ", " + fieldsSQL.get(i) + i;
			}

		}

		java += ");";

		// java += "\n\n\t\tthis._originalDTO = (EntityId) this.clone();";

		java += "\n\n\t}";

		return java;
	}

	private static void buildConstructorArgs(int maxLevel, int level, Clazz clazz, List<String> fields) {

		String java = "";

		java = "String idArg";
		fields.add(java);

		for (int i = 0; i < clazz.getAtts().size(); i++) {

			Att att = clazz.getAtts().get(i);

			if (att.isSimple()) {

				java = att.getDataType().getName().replace("java.lang.", "") + " " + att.getName() + "Arg";

				fields.add(java);

			} else {

				if (level < maxLevel) {
					DataTypeClazz dataTypeClazz = (DataTypeClazz) att.getDataType();
					buildConstructorArgs(maxLevel, (level + 1), dataTypeClazz.getClazz(), fields);
				} else {

					DataTypeClazz dataTypeClazz = (DataTypeClazz) att.getDataType();

					java = "String " + "id" + dataTypeClazz.getName() + "Arg";

					fields.add(java);

				}

			}

		}

	}

	private static void buildSetterArgs(int maxLevel, int level, Clazz clazz, List<String> fields) {

		String java = "";

		java = "idArg";
		fields.add(java);

		for (int i = 0; i < clazz.getAtts().size(); i++) {

			Att att = clazz.getAtts().get(i);

			if (att.isSimple()) {

				java = att.getName() + "Arg";

				fields.add(java);

			} else {

				if (level < maxLevel) {
					DataTypeClazz dataTypeClazz = (DataTypeClazz) att.getDataType();
					buildSetterArgs(maxLevel, (level + 1), dataTypeClazz.getClazz(), fields);
				} else {

					DataTypeClazz dataTypeClazz = (DataTypeClazz) att.getDataType();

					java = "id" + dataTypeClazz.getName() + "Arg";

					fields.add(java);
				}

			}

		}

	}

	private static String buildSetter(Clazz clazzX) {
		int maxLevel = getDefaultMaxLevel();
		int level = 0;

		String java = "";

		for (int i = 0; i <= maxLevel; i++) {
			String java2 = buildSetter(clazzX, i, level);

			if (java.contains(java2) == false) {
				java += java2;
			}
		}

		return java;
	}

	private static String buildSetter(Clazz clazzX, int maxLevel, int level) {

		String java = "";

		java += "\n\n\t// ---------------------------------------------------------------------------------------------------------------------------\n";

		java += "\n\n\tpublic void setter(";

		List<String> fieldsSQL = new ArrayList<String>();

		buildConstructorArgs(maxLevel, level, clazzX, fieldsSQL);

		for (int i = 0; i < fieldsSQL.size(); i++) {

			if (i == 0) {
				java += fieldsSQL.get(i) + i;
			} else {
				java += ", " + fieldsSQL.get(i) + i;
			}

		}

		java += ") throws Exception {\n";

		///////////////////////////////////////////////////////

		fieldsSQL = new ArrayList<String>();

		buildConstructorAtts(maxLevel, level, "", clazzX, null, fieldsSQL);

		for (int i = 0; i < fieldsSQL.size(); i++) {

			String[] paths = fieldsSQL.get(i).split("[.]");
			String path = "";

			for (int j = 0; j < paths.length; j++) {

				if (j == 0) {
					path += "this";
				} else if (j == paths.length - 1) {
					if(fieldsSQL.get(i).endsWith("@@")) {
						path += ".setId(id" + paths[j].replace("@@", "") + "Arg" + i + ");";
					} else {
						path += ".set" + toCamelStart(paths[j]) + "(" + paths[j] + "Arg" + i + ");";	
					}
					
				} else {
					path += ".build" + toCamelStart(paths[j]) + "()";
				}

			}

			java += "\n\t\t" + path;
		}

		java += "\n\n\t}";

		return java;
	}

	private static void buildConstructorAtts(int maxLevel, int level, String source, Clazz clazz, Att attSource, List<String> fields) {

		String java = "";

		if (source.length() > 0) {
			
			if(attSource != null) {
				java = source + "." + attSource.getName() + ".id";	
			} else {
				java = source + "." + clazz.getName() + ".id";	
			}	
			
		} else {
			
			if(attSource != null) {
				java = attSource.getName() + ".id";	
			} else {
				java = clazz.getName() + ".id";	
			}
		}

		fields.add(java);

		for (int i = 0; i < clazz.getAtts().size(); i++) {

			Att att = clazz.getAtts().get(i);

			if (att.isSimple()) {

				if (source.length() > 0) {
					java = source + "." + attSource.getName() + "." + att.getName();
				} else {
					java = clazz.getName() + "." + att.getName();
				}

				fields.add(java);

			} else {

				if (level < maxLevel) {
					
					DataTypeClazz dataTypeClazz = (DataTypeClazz) att.getDataType();

					if (source.length() > 0) {
						
//						buildConstructorAtts(maxLevel, (level + 1), source + "." + clazz.getName(),
//								dataTypeClazz.getClazz(), att, fields);
						
						if(attSource != null) {
							buildConstructorAtts(maxLevel, (level + 1), source + "." + attSource.getName(),
									dataTypeClazz.getClazz(), att, fields);	
						} else {
							buildConstructorAtts(maxLevel, (level + 1), source + "." + clazz.getName(),
									dataTypeClazz.getClazz(), att, fields);	
						}	
						
						
					} else {
						
						if(attSource != null) {
							buildConstructorAtts(maxLevel, (level + 1), attSource.getName(), dataTypeClazz.getClazz(), att, fields);	
						} else {
							buildConstructorAtts(maxLevel, (level + 1), clazz.getName(), dataTypeClazz.getClazz(), att, fields);	
						}
						

					}
				} else {

					DataTypeClazz dataTypeClazz = (DataTypeClazz) att.getDataType();
					
					if(attSource != null) {
						if (source.length() > 0) {
							java = source + "." + attSource.getName() + "." + att.getName() + "." + dataTypeClazz.getName() + "@@";
						} else {
							java = attSource.getName() + "." + att.getName() + "." + dataTypeClazz.getName()+ "@@";
						}	
					} else {
						if (source.length() > 0) {
							java = source + "." + clazz.getName() + "." + att.getName() + "." + dataTypeClazz.getName() + "@@";
						} else {
							java = clazz.getName() + "." + att.getName() + "." + dataTypeClazz.getName()+ "@@";
						}		
					}

					

					fields.add(java);

				}

			}

		}

	}

	////////////////////////////////////////////

	public static int buildMapperDefaultLevel(Clazz clazzX) {

		int maxLevel = getDefaultMaxLevel();
		int level = 0;

		int levelCount = 0;

		for (int i = 0; i <= maxLevel; i++) {
			int levelReturn = buildMapperDefaultLevel(clazzX, i, level);

			if (levelReturn > levelCount) {
				levelCount = levelReturn;
			}
		}

		return levelCount;
	}

	private static int buildMapperDefaultLevel(Clazz clazzX, int maxLevel, int level) {

		int levelCount = buildMapperDefaultLevel(maxLevel, level, clazzX);

		return levelCount;
	}

	private static int buildMapperDefaultLevel(int maxLevel, int level, Clazz clazz) {

		int levelCount = level;

		for (int i = 0; i < clazz.getAtts().size(); i++) {

			Att att = clazz.getAtts().get(i);

			if (att.isSimple() == false) {

				if (level < maxLevel) {

					DataTypeClazz dataTypeClazz = (DataTypeClazz) att.getDataType();
					int levelReturn = buildMapperDefaultLevel(maxLevel, (level + 1), dataTypeClazz.getClazz());

					if (levelReturn > levelCount) {
						levelCount = levelReturn;
					}

				}

			}

		}

		return levelCount;

	}

	////////////////////////////////////////////

	private static String toStringMethod(Clazz clazz) {
		String java = "";

		String n = "\n";
		String t = "\t";

		java += "\n\n\t// ---------------------------------------------------------------------------------------------------------------------------\n";

		java += n + t + "public String toString() {";

		if (clazz.getAtts().size() > 1) {

			String n0 = toCamelStart(clazz.getAtts().get(0).getName()) + "()";
			String n1 = toCamelStart(clazz.getAtts().get(1).getName()) + "()";
			String n00 = n0;
			String n11 = n1;

			java += n + t + t + "if(this.get" + n0 + " != null && this.get" + n1 + " != null){";

			java += n + t + t + t + "return this.get" + n00 + " + \" - \" +  this.get" + n11 + ";";

			if (clazz.getAtts().get(0).isString() == false) {
				n00 += ".toString()";
			}
			if (clazz.getAtts().get(1).isString() == false) {
				n11 += ".toString()";
			}

			java += n + t + t + "} else if(this.get" + n0 + " != null && this.get" + n1 + " == null){";

			java += n + t + t + t + "return this.get" + n00 + ";";

			java += n + t + t + "} else if(this.get" + n0 + " == null && this.get" + n1 + " != null){";

			java += n + t + t + t + "return this.get" + n11 + ";";

			java += n + t + t + "} else {";

			java += n + t + t + t + "return super.toString();";

			java += n + t + t + "}";

		} else if (clazz.getAtts().size() > 0) {

			String n0 = toCamelStart(clazz.getAtts().get(0).getName()) + "()";
			String n00 = n0;

			java += n + t + t + "if(this.get" + n0 + " != null){";

			java += n + t + t + t + "return this.get" + n00 + ";";

			if (clazz.getAtts().get(0).isString() == false) {
				n00 += ".toString()";
			}

			java += n + t + t + "} else {";

			java += n + t + t + t + "return super.toString();";

			java += n + t + t + "}";

		} else {
			java += n + t + t + t + "return super.toString();";
		}
		java += n + t + "}";

		return java;
	}

}
